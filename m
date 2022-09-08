Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97065B27BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 22:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIHUbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 16:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIHUb3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1713D23BC3
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Sep 2022 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662669088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8xW/PUmCF7EBejEjlfKNcmSxgxp+ng+o6KaVNQoPyk=;
        b=SCyMqskUyeEDWG5oXrogmD84IXcTu4KlIOGwLiWqw2M0qdPKKLzIy4lZY+eJ4P4JX9DlgU
        d9ZEVM767L71OjlZYFAG0jJn0F3366SVnYzWTbVHx5r8dDjEjPAp6cny36Zxoz7btAgJD9
        yl+niKeQsvCBK+tFn8OhFpnJXiQT59Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-ZBRNITwkPmiBGip5fai_bQ-1; Thu, 08 Sep 2022 16:31:25 -0400
X-MC-Unique: ZBRNITwkPmiBGip5fai_bQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6011529DD9B4;
        Thu,  8 Sep 2022 20:31:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB1842166B26;
        Thu,  8 Sep 2022 20:31:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAFX2JfmoovJHUBRy6U=yKJt_pAEF0tLadSK+CFqabPcatXe6EQ@mail.gmail.com>
References: <CAFX2JfmoovJHUBRy6U=yKJt_pAEF0tLadSK+CFqabPcatXe6EQ@mail.gmail.com> <166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk>
To:     Anna Schumaker <anna@kernel.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3658627.1662669081.1@warthog.procyon.org.uk>
Date:   Thu, 08 Sep 2022 21:31:21 +0100
Message-ID: <3658630.1662669081@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Anna Schumaker <anna@kernel.org> wrote:

> > +       fc->lsm_set = true;
> 
> I was wondering if there is any way to have security_sb_set_mnt_opts()
> or security_sb_clone_mnt_opts() set this value automatically?  A quick
> "git-grep" for security_sb_set_mnt_opts() shows that it's also called
> by btrfs at some point, so having this done automatically feels less
> fragile to me than requiring individual filesystems to set it
> manually.

Hmmm... I wonder if cifs and afs should be calling
security_sb_clone_mnt_opts() also.

David

