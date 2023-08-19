Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA658781944
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 13:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjHSLfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Aug 2023 07:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjHSLfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Aug 2023 07:35:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1826F344E1;
        Sat, 19 Aug 2023 04:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7804D60281;
        Sat, 19 Aug 2023 11:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92281C433C7;
        Sat, 19 Aug 2023 11:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692444883;
        bh=z2ItxS/SqaayhDwGXDrxPezXvq3GP/mVQb6VL9p4QH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/Y6OMmRzyS4tWEsZPyJFvcwqJezrNUqIZg+EX23Cg2LgrJApl9RfxivzPEVFp+tZ
         +QLmootmB73clf6IhAOmk1ZkeHtZ9tyoS3sgA915BWNCcpsKeL/4qbj2Of+icLorGc
         y8lezKCp8dqqeX2kOWS5RMX2njz0xrElMUDim39048oNlafa7MTbe/F0SwPyJC0qE1
         rAM9nDH/Tk+kJG/UnNzcf59wnzZgelFTKmfMSM2HHstFXqkgU9h/PP7kTRryIGGUSQ
         VTAW/sXA6RwfAZFtzBe11LEnYeQRKPy/W6lJfWFxoiVIpBEaGUYlRXm05AAdvPpQNM
         icc7hQBb0msEA==
Date:   Sat, 19 Aug 2023 13:34:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+6ec38f7a8db3b3fb1002@syzkaller.appspotmail.com>,
        anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs?] WARNING in do_open_execat
Message-ID: <20230819-geblendet-energetisch-a90a2886216c@brauner>
References: <000000000000c74d44060334d476@google.com>
 <87o7j471v8.fsf@email.froward.int.ebiederm.org>
 <202308181030.0DA3FD14@keescook>
 <20230818191239.3cprv2wncyyy5yxj@f>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818191239.3cprv2wncyyy5yxj@f>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 09:12:39PM +0200, Mateusz Guzik wrote:
> On Fri, Aug 18, 2023 at 10:33:26AM -0700, Kees Cook wrote:
> > This is a double-check I left in place, since it shouldn't have been reachable:
> > 
> >         /*
> >          * may_open() has already checked for this, so it should be
> >          * impossible to trip now. But we need to be extra cautious
> >          * and check again at the very end too.
> >          */
> >         err = -EACCES;
> >         if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
> >                          path_noexec(&file->f_path)))
> >                 goto exit;
> > 
> 
> As I mentioned in my other e-mail, the check is racy -- an unlucky
> enough remounting with noexec should trip over it, and probably a chmod
> too.
> 
> However, that's not what triggers the warn in this case.
> 
> The ntfs image used here is intentionally corrupted and the inode at
> hand has a mode of 777 (as in type not specified).
> 
> Then the type check in may_open():
>         switch (inode->i_mode & S_IFMT) {
> 
> fails to match anything.
> 
> This debug printk:
> diff --git a/fs/namei.c b/fs/namei.c
> index e56ff39a79bc..05652e8a1069 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3259,6 +3259,10 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
>                 if ((acc_mode & MAY_EXEC) && path_noexec(path))
>                         return -EACCES;
>                 break;
> +       default:
> +               /* bogus mode! */
> +               printk(KERN_EMERG "got bogus mode inode!\n");
> +               return -EACCES;
>         }
> 
>         error = inode_permission(idmap, inode, MAY_OPEN | acc_mode);
> 
> catches it.
> 
> All that said, I think adding a WARN_ONCE here is prudent, but I
> don't know if denying literally all opts is the way to go.
> 
> Do other filesystems have provisions to prevent inodes like this from
> getting here?

Bugs reported against the VFS from ntfs/ntfs3 are to be treated with
extreme caution. Frankly, if it isn't reproducible without a corrupted
ntfs/ntfs3 image it is to be dismissed until further notice.

In this case it simply seems that ntfs is failing at ensuring that its
own inodes it reads from disk have a well-defined type.

If ntfs fails to validate that its own inodes it puts into the icache
are correctly initialized then the vfs doesn't need to try and taper
over this.

If ntfs fails at that, there's no guarantee that it doesn't also fail at
setting the correct i_ops for that inode. At which point we can check
the type in may_open() but we already used bogus i_ops the whole time on
some other inodes.

We're not here to make up for silly bugs like this. That WARN belongs
into ntfs not the vfs.
