Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7076F3D38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 08:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjEBGNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 02:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjEBGN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 02:13:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C3358A
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 23:13:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4edc63e066fso880e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 23:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683008005; x=1685600005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9RYJXTMkjo99MefNou3S1yVA+HChQgATz9a2fAIHiP8=;
        b=bzmj3yLEyq0mWdrrOr3ckfZxQGE8s63aQMw7tSPRlIX3cg01ZPk2knJNSXH2OYS0Z0
         uZu/VVlbhluOQlTEKbeJ7BA7ewRn2lOpLuH0C/QvLglT1kVBqHUoEa015ILPYhnQj2i8
         KwaJ8g71x1sb/prCyMopEciQmDQ4zXFRjr6/IYbWXCHeRCwqSKxTj1NghVpZVbWl5y53
         21xTodb/6coSFGdQDh6eHgoGrqCFNFLBefhluXglk9NdMYg5iPawOsJRp/VcOUtt2+H8
         iCMu04mrClFJ3sxcppmUb4pYbs/AdOQ/s8tsfNo2iK7u/fEvy1CKDZopAz425iiu4WQX
         aXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683008005; x=1685600005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RYJXTMkjo99MefNou3S1yVA+HChQgATz9a2fAIHiP8=;
        b=BwYpkuQ4HfOR8FHMKIUyZJhInAJEFzcBic85kmM45joHx/qge9egJbrJ9MUC9wi3iP
         q0A2RBeBUrgwlMp3+2mc9WbjQUsEqsCNut2zD43hPna/P+ZYf+NJ2jISPhdMpaXI63yw
         fjFLD4EkLjpeGXYB2PvHQRYj3p8UspsiKm41jfCAeufh2rupQmY0T0I2kf0Gj+WEXFnq
         AcIC3hGmai/LNy/R/BZbeezIZzlGX0tSFlEVkmDlWxz72Ri3HPgRGRfO2VR5YMdMLDgH
         8j4y4gtnh4zwjX+FbbG4kzJ7qPL3yn+2HZDgnTPqjUQUPcz+8DqxOsc0wyKPx8d77YIU
         9p2w==
X-Gm-Message-State: AC+VfDwHWtPCyakdgX+ZNL4tnJn+4ZHYcWW//HBrAHsiHVCqAlQKsQmJ
        9MsFoDe3R5JuMHzZebKG8eP5syVcjVvDetqjkCKsHOK8dOEFxnP0otNgzA==
X-Google-Smtp-Source: ACHHUZ7q2XyFfQBq2zl1Oop/t0Vfx9oeA1lce6FEy5SaCdIxYMRSYq/PIxn3sg1WawZ0EpFcNf6c5Xk6XkJvWSinwWY=
X-Received: by 2002:a05:6512:239a:b0:4ed:b131:3449 with SMTP id
 c26-20020a056512239a00b004edb1313449mr99041lfv.7.1683008005115; Mon, 01 May
 2023 23:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007337c705fa1060e2@google.com> <CACT4Y+a=xWkNGw_iKibRp4ivSE8OJkWWT0VPQ4N4d1+vj0FMdg@mail.gmail.com>
 <bdb1fe2d-f904-78f0-d287-5e601f789862@I-love.SAKURA.ne.jp>
In-Reply-To: <bdb1fe2d-f904-78f0-d287-5e601f789862@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 May 2023 08:13:11 +0200
Message-ID: <CACT4Y+YtOXNPJSrmvs=O5UvFPjUQdnSHGhuE_kiLkxzJjH=DNQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 1 May 2023 at 07:16, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/04/24 17:26, Dmitry Vyukov wrote:
> >> HEAD commit:    457391b03803 Linux 6.3
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=13226cf0280000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c81c9a3d360ebcf
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
> >> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > I think shmem_mknod() needs to use i_size_write() to update the size.
> > Writes to i_size are not assumed to be atomic throughout the kernel
> > code.
> >
>
> I don't think that using i_size_{read,write}() alone is sufficient,
> for I think that i_size_{read,write}() needs data_race() annotation.

Agree. Or better proper READ/WRITE_ONCE.
data_race() is just an annotation, it does not fix the actual data
race bug that is present there.
I see there are lots of uses of i_size_read() in complex scenarios
that involve comparisons of the size. All such racy uses are subject
to the TOCTOU bug at least.


>  include/linux/fs.h |   13 +++++++++++--
>  mm/shmem.c         |   12 ++++++------
>  2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 21a981680856..0d067bbe3ee9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -860,6 +860,13 @@ void filemap_invalidate_unlock_two(struct address_space *mapping1,
>   * the read or for example on x86 they can be still implemented as a
>   * cmpxchg8b without the need of the lock prefix). For SMP compiles
>   * and 64bit archs it makes no difference if preempt is enabled or not.
> + *
> + * However, when KCSAN is enabled, CPU being capable of reading/updating
> + * naturally aligned 8 bytes of memory atomically is not sufficient for
> + * avoiding KCSAN warning, for KCSAN checks whether value has changed between
> + * before and after of a read operation. But since we don't want to introduce
> + * seqcount overhead only for suppressing KCSAN warning, tell KCSAN that data
> + * race on accessing i_size field is acceptable.
>   */
>  static inline loff_t i_size_read(const struct inode *inode)
>  {
> @@ -880,7 +887,8 @@ static inline loff_t i_size_read(const struct inode *inode)
>         preempt_enable();
>         return i_size;
>  #else
> -       return inode->i_size;
> +       /* See comment above. */
> +       return data_race(inode->i_size);
>  #endif
>  }
>
> @@ -902,7 +910,8 @@ static inline void i_size_write(struct inode *inode, loff_t i_size)
>         inode->i_size = i_size;
>         preempt_enable();
>  #else
> -       inode->i_size = i_size;
> +       /* See comment above. */
> +       data_race(inode->i_size = i_size);
>  #endif
>  }
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e40a08c5c6d7..a2f20297fb59 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2951,7 +2951,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
>                         goto out_iput;
>
>                 error = 0;
> -               dir->i_size += BOGO_DIRENT_SIZE;
> +               i_size_write(dir, i_size_read(dir) + BOGO_DIRENT_SIZE);
>                 dir->i_ctime = dir->i_mtime = current_time(dir);
>                 inode_inc_iversion(dir);
>                 d_instantiate(dentry, inode);
> @@ -3027,7 +3027,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
>                         goto out;
>         }
>
> -       dir->i_size += BOGO_DIRENT_SIZE;
> +       i_size_write(dir, i_size_read(dir) + BOGO_DIRENT_SIZE);
>         inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
>         inode_inc_iversion(dir);
>         inc_nlink(inode);
> @@ -3045,7 +3045,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
>         if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
>                 shmem_free_inode(inode->i_sb);
>
> -       dir->i_size -= BOGO_DIRENT_SIZE;
> +       i_size_write(dir, i_size_read(dir) - BOGO_DIRENT_SIZE);
>         inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
>         inode_inc_iversion(dir);
>         drop_nlink(inode);
> @@ -3132,8 +3132,8 @@ static int shmem_rename2(struct mnt_idmap *idmap,
>                 inc_nlink(new_dir);
>         }
>
> -       old_dir->i_size -= BOGO_DIRENT_SIZE;
> -       new_dir->i_size += BOGO_DIRENT_SIZE;
> +       i_size_write(old_dir, i_size_read(old_dir) - BOGO_DIRENT_SIZE);
> +       i_size_write(new_dir, i_size_read(new_dir) + BOGO_DIRENT_SIZE);
>         old_dir->i_ctime = old_dir->i_mtime =
>         new_dir->i_ctime = new_dir->i_mtime =
>         inode->i_ctime = current_time(old_dir);
> @@ -3189,7 +3189,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>                 folio_unlock(folio);
>                 folio_put(folio);
>         }
> -       dir->i_size += BOGO_DIRENT_SIZE;
> +       i_size_write(dir, i_size_read(dir) + BOGO_DIRENT_SIZE);
>         dir->i_ctime = dir->i_mtime = current_time(dir);
>         inode_inc_iversion(dir);
>         d_instantiate(dentry, inode);
>
> Maybe we want i_size_add() ?
>
> Also, there was a similar report on updating i_{ctime,mtime} to current_time()
> which means that i_size is not the only field that is causing data race.
> https://syzkaller.appspot.com/bug?id=067d40ab9ab23a6fa0a8156857ed54e295062a29
>
> Hmm, where is the serialization that avoids concurrent
> shmem_mknod()/shmem_mknod() or shmem_mknod()/shmem_unlink() ?
> i_size_write() says "need locking around it (normally i_mutex)"...
>
