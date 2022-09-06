Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9544B5AF064
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 18:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiIFQbR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 12:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiIFQbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9FA90836
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662480118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r1ECInH9l5hHSYuBPQXMovo4JVv9CbvTfByNoEFXbjY=;
        b=hPUtt0Vc4LTM6E4kvWOKRQwCl6k5TUxEUYQNLEUOZqrYDL5kqrna+vtzmsNoXvW5y7wRgJ
        xeIdW2d7pQRH4PX4WhnK0UaMYf6DaMKhK4r9ap1/Lbt8RGHSl1L4AMp0JolAFYzeYJMCor
        OQL6u8pNLxAu7yzxPbaS6kFPh7dv2q8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-1OLXvOMMOFypIeCm05EdrA-1; Tue, 06 Sep 2022 12:01:54 -0400
X-MC-Unique: 1OLXvOMMOFypIeCm05EdrA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31B5985A58F;
        Tue,  6 Sep 2022 16:01:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BBD44010D2A;
        Tue,  6 Sep 2022 16:01:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <7a154687f8be9d7a2365ae4a93f2b7f734002904.camel@kernel.org>
References: <7a154687f8be9d7a2365ae4a93f2b7f734002904.camel@kernel.org> <217595.1662033775@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3349243.1662480110.1@warthog.procyon.org.uk>
Date:   Tue, 06 Sep 2022 17:01:50 +0100
Message-ID: <3349244.1662480110@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> If this or the other allocations below fail, do you need to free the
> prior ones here? Or do they automagically get cleaned up somehow?

Once the fs_context is allocated, it will always get cleaned up with
put_fs_context(), which will dispose of the partially constructed
smack_mnt_opts struct.

David

