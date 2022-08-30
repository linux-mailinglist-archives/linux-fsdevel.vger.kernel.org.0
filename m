Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B735A5E81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 10:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiH3ItO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 04:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiH3ItN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:49:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791E1B99D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661849351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rO4FZd8DM43FaK8mkRxXV5H/hvjL5yUM5ZIt/9HgsK0=;
        b=LN2TCqZXjxzLeEH0xabSp08IHcFUnsuixjYfnsUSeMaetq7OkOzYALMDibwZ2TUagUr1I1
        wtPFffGmkVjkGEnGsRAejbUIhYWRX1EjJkTrp7tZRh7CVfAEV1QxlQih6qZ7y3+5WDxlGP
        QwWw7zkejONzzJltyMYjeLHJANmnoa0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-VRXojYk8POGrzp5byeD5Jg-1; Tue, 30 Aug 2022 04:49:08 -0400
X-MC-Unique: VRXojYk8POGrzp5byeD5Jg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0F06380390A;
        Tue, 30 Aug 2022 08:49:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D748FC15BB3;
        Tue, 30 Aug 2022 08:49:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <c648aa7c-a49c-a7e2-6a05-d1dfe44b8fdb@schaufler-ca.com>
References: <c648aa7c-a49c-a7e2-6a05-d1dfe44b8fdb@schaufler-ca.com> <166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk> <20220826082439.wdestxwkeccsyqtp@wittgenstein>
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
Content-ID: <1903708.1661849345.1@warthog.procyon.org.uk>
Date:   Tue, 30 Aug 2022 09:49:05 +0100
Message-ID: <1903709.1661849345@warthog.procyon.org.uk>
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

> The authors of this version of the mount code failed to look
> especially closely at how Smack maintains label names. Once a
> label name is used in the kernel it is kept on a list forever.
> All the copies of smk_known here and in the rest of the mount
> infrastructure are unnecessary and wasteful. The entire set of
> Smack hooks that deal with mounting need to be reworked to remove
> that waste. It's on my list of Smack cleanups, but I'd be happy
> if someone else wanted a go at it.

I don't have time to overhaul Smack right now.  Should I drop the Smack part
of the patch?

David

