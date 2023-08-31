Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C530D78EA2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbjHaK30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjHaK3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FA2C5;
        Thu, 31 Aug 2023 03:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FE526264F;
        Thu, 31 Aug 2023 10:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6958C433C7;
        Thu, 31 Aug 2023 10:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693477762;
        bh=qFrUjga7zFiJnDdj3g/wc5+Eq1FXVtXe0tkhwpI7QQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUq4GJsccfOR05SPSnyMyAN3qE02/2AS7Qzec8yZUD0g6yjqbdG1TVxFjrCKBA/Mh
         Pedw/ShzpNrm+XUCZ0vbf9kmqFIcj1kBIbleQxOQNfdOHpznAJLw3pJZ20UZc1D6l0
         iRWctifKSneHjKP9AZMEJFI1gJxQynGt0c+90DL81Dj3D64yprG1tHXna8ttJ7WlTi
         CzeGVIJg3t4ZXf6F8K9TnK0BeqXUnK/X7PfvMSPIt9Pvi/lmfEjcuteKjQzQ3sehgN
         JzkBLS60mhtOLUXqBOG+D2hsKsQH+HafDWaGqlhawLVlCq3bML0EP2r9eZP8ZhxMOJ
         gkvZdWWnMjzpA==
Date:   Thu, 31 Aug 2023 12:29:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: sb->s_fs_info freeing fixes
Message-ID: <20230831-tiefbau-freuden-3e8225acc81d@brauner>
References: <20230831053157.256319-1-hch@lst.de>
 <20230831-dazulernen-gepflanzt-8a64056bf362@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831-dazulernen-gepflanzt-8a64056bf362@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:20:32PM +0200, Christian Brauner wrote:
> On Thu, Aug 31, 2023 at 07:31:53AM +0200, Christoph Hellwig wrote:
> > sb->s_fs_info should only be freed after the superblock has been marked
> > inactive in generic_shutdown_super, which means either in ->put_super or
> > in ->kill_sb after generic_shutdown_super has returned.  Fix the
> > instances where that is not the case.
> 
> Funny, I had looked at all those filesystems a while back to
> double-check that things are sane and that's why I didn't change them.
> 
> >  arch/s390/hypfs/inode.c      |    3 +--
> 
> get_tree_single() -> single instance
> => doesn't match on sb->s_fs_info
> 
> >  fs/devpts/inode.c            |    2 +-
> 
> get_tree_nodev() -> each mount is a new instance
> => We don't match on sb->s_fs_info
> 
> >  fs/ramfs/inode.c             |    2 +-
> 
> get_tree_nodev() -> each mount is a new instance
> => We don't match on sb->s_fs_info
> 
> >  security/selinux/selinuxfs.c |    5 +----
> 
> get_tree_single() -> single instance
> => doesn't match on sb->s_fs_info
> 
> Al roughly said the same thing afaict.
> 
> I still think that there's no need to deviate from the basic logic:
> 
> (1) call generic kill_*() helper
> (2) wipe sb->s_fs_info
> 
> So I think that's a cleanup we should do. Just change the rationale to
> say that this deviation is pointless and just means the reader of the
> code has to sanity check against the superblock helper that's used.

I changed the commit messages to say:

"Since ramfs/devpts uses get_tree_nodev() it doesn't rely on
sb->s_fs_info. So there's no use after free risk as with other
filesystems.

But there's no need to deviate from the standard cleanup logic and cause
reviewers to verify whether that is safe or not."

and similar for the other two:

"Since hypfs/selinuxfs uses get_tree_single() it doesn't rely on
sb->s_fs_info. So there's no use after free risk as with other
filesystems.

But there's no need to deviate from the standard cleanup logic and cause
reviewers to verify whether that is safe or not."

If that is good enough for people then I can grab it.
