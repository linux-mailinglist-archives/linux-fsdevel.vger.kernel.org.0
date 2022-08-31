Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FF95A7F36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiHaNtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiHaNs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329F5D3ECF
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 06:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661953729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MHgckLY1k0e6IPDOoXCSz/obpbHVtMPSQg5MXk7HP0o=;
        b=SyTM/8fi7MM3l6h/fypIpyoDEjurb8fnINKrVz086B7tJ/T0/CIYfWEqWRH7HHgMoK/rbS
        FImdzoY3YxvsWbLmJkV2IKlC7DLVc75INqF2PEWCUc6YLQg4dV19k3D6ag0GT6QjIiloZE
        f1bLvXUchqzfweqdiFFmJJe8BWR6j6c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-yerZESZVNty5lBMkSHHD1w-1; Wed, 31 Aug 2022 09:48:43 -0400
X-MC-Unique: yerZESZVNty5lBMkSHHD1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72F50811E83;
        Wed, 31 Aug 2022 13:48:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA6B1C15BB3;
        Wed, 31 Aug 2022 13:48:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <89548338-f716-c110-0f85-3ef880bbd723@schaufler-ca.com>
References: <89548338-f716-c110-0f85-3ef880bbd723@schaufler-ca.com> <c648aa7c-a49c-a7e2-6a05-d1dfe44b8fdb@schaufler-ca.com> <166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk> <20220826082439.wdestxwkeccsyqtp@wittgenstein> <1903709.1661849345@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
        viro@zeniv.linux.org.uk, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>, linux-nfs@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1535494.1661953720.1@warthog.procyon.org.uk>
Date:   Wed, 31 Aug 2022 14:48:40 +0100
Message-ID: <1535495.1661953720@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> No. I appreciate that you're including Smack as part of the effort.
> I would much rather have the code working as you have it than have
> to go in later and do it all from scratch. With luck I should be able
> to get someone with a considerably lower level of expertise to work
> on it.

Can I put you down as a Reviewed-by, then?

David

