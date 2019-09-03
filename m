Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81EA6DED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 18:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfICQS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 12:18:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40531 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfICQS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:18:59 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so21876980iof.7;
        Tue, 03 Sep 2019 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pp01NtxEqI+2kM6nVF0jDiUSE89C7b7YSX4QsBfMeT8=;
        b=YlmjOT9n5WT8rrPSGjRTHpNKlD6lJEG32gtAJ7xdOz1s5QK2SyVvIkxhCpuoJK+Vql
         SAj76CAAF+0iYalIpH36R80L6UzapzYnkddqy2KhPwAfIIcbwQwKaHewy0mq1Xf5GXRY
         +BgCtMp4c7AT6FY3w4vNEpN5YALVguMf7chzM6WQOx1Cb/bPH5Rd2YQqJkKcTuMcKnQG
         Q+ix4MSM56+iboFcH/Xx10INgNleWTbXhGAMcI24SkG+9R0I4h/7FXE2ZSm75VfvHSJw
         pjyCiY2fu/RpezAz0Wo0IrSvSVxxMN+9TJSuIIzciLQks6pR9rhfaNEp637DToC6q1iZ
         upvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pp01NtxEqI+2kM6nVF0jDiUSE89C7b7YSX4QsBfMeT8=;
        b=tqMVdNy3seRPKcAatnOMROmOK/M4kmyTGK3b09Z00oG5+AiLbLqFkPh6OLhLrGLif0
         pDyehZ+vycy7KcmEtCAvdNqYq4HHNftQ3hX+EmEyrycCOfcqn7LTpoocWxYgxhxYlyiy
         8z5jkpuD3A9Azu/h/QyAy40YuPgwYvw1dJnWdxpbYAKd/BkGmRIh2mVouiQJIchrcUb8
         w4GW62wyG+4sj1nnAQQxH+rQZJt15+YvoSELIbdYclsXUogOhSsW6iQhLF7LopC5lsiT
         Cud1WCsSAGveaqY6DGKAQmdXDPvRA09aIvs2Eragpixsn9tj9U8ZhqZ3hDFV7R6B2gKs
         CpiA==
X-Gm-Message-State: APjAAAUr6IMGVIiDzrRn2ZoEywK8T5kIIGGzbHCbQ5u74le3R46oH8P2
        /wlA8IbVov5bjemm/f0B5GmSBkrG6SV8a0UXU5w=
X-Google-Smtp-Source: APXvYqwIcY9WKYRVUG+7biN1UvYNAksGXR4TXcBpgpU1RUy16A/yeBrAjvNPn0uGPzC66eWB3Uj8v+M/Zq2oSV6YPHM=
X-Received: by 2002:a5d:8599:: with SMTP id f25mr15377335ioj.265.1567527536751;
 Tue, 03 Sep 2019 09:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <1567523922.5576.57.camel@lca.pw>
In-Reply-To: <1567523922.5576.57.camel@lca.pw>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 3 Sep 2019 09:18:44 -0700
Message-ID: <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
To:     Qian Cai <cai@lca.pw>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Actually this warning is coming from this patch:
https://lore.kernel.org/linux-fsdevel/20190818165817.32634-10-deepa.kernel@gmail.com/
([PATCH v8 09/20] ext4: Initialize timestamps limits).

This is the code generating the warning:

 diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
 index 9c7f4036021b..ae5d0c86aba2 100644
 --- a/fs/ext4/ext4.h
 +++ b/fs/ext4/ext4.h
 @@ -832,11 +832,15 @@ static inline void
ext4_decode_extra_time(struct timespec64 *time,

  #define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)
          \
  do {
          \
  -       (raw_inode)->xtime = cpu_to_le32((inode)->xtime.tv_sec);
           \
          if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ##
_extra))     {\
  +               (raw_inode)->xtime =
cpu_to_le32((inode)->xtime.tv_sec);        \
                  (raw_inode)->xtime ## _extra =
           \

ext4_encode_extra_time(&(inode)->xtime);        \
                  }
           \
  +       else    {\
  +               (raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t,
(inode)->xtime.tv_sec, S32_MIN, S32_MAX));    \
  +               ext4_warning_inode(inode, "inode does not support
timestamps beyond 2038"); \
  +       } \
   } while (0)

This prints a warning for each inode that doesn't extend limits beyond
2038. It is rate limited by the ext4_warning_inode().
Looks like your filesystem has inodes that cannot be extended.
We could use a different rate limit or ignore this corner case. Do the
maintainers have a preference?

-Deepa

On Tue, Sep 3, 2019 at 8:18 AM Qian Cai <cai@lca.pw> wrote:
>
> https://lore.kernel.org/linux-fsdevel/20190818165817.32634-5-deepa.kernel@gmail.
> com/
>
> Running only a subset of the LTP testsuite on today's linux-next with the above
> commit is now generating ~800 warnings on this machine which seems a bit crazy.
>
> [ 2130.970782] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
> #40961: comm statx04: inode does not support timestamps beyond 2038
> [ 2130.970808] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
> #40961: comm statx04: inode does not support timestamps beyond 2038
> [ 2130.970838] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
> #40961: comm statx04: inode does not support timestamps beyond 2038
> [ 2130.971440] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
> #40961: comm statx04: inode does not support timestamps beyond 2038
> [ 2131.847613] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
> #32769: comm statx04: inode does not support timestamps beyond 2038
> [ 2131.847647] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
> #32769: comm statx04: inode does not support timestamps beyond 2038
> [ 2131.847681] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
> #32769: comm statx04: inode does not support timestamps beyond 2038
> [ 2131.847717] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
> #32769: comm statx04: inode does not support timestamps beyond 2038
> [ 2131.847774] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
> #32769: comm statx04: inode does not support timestamps beyond 2038
> [ 2131.847817] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
> #32769: comm statx04: inode does not support timestamps beyond 2038
> [ 2131.847909] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
> #32769: comm statx04: inode does not support timestamps beyond 2038
> [ 2131.847970] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
> #32769: comm statx04: inode does not support timestamps beyond 2038
> [ 2131.848004] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
> #32769: comm statx04: inode does not support timestamps beyond 2038
> [ 2131.848415] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
> #32769: comm statx04: inode does not support timestamps beyond 2038
> [ 2134.753752] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
> #12: comm statx05: inode does not support timestamps beyond 2038
> [ 2134.753783] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
> #12: comm statx05: inode does not support timestamps beyond 2038
> [ 2134.753814] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
> #12: comm statx05: inode does not support timestamps beyond 2038
> [ 2134.753847] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
> #12: comm statx05: inode does not support timestamps beyond 2038
> [ 2134.753889] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
> #12: comm statx05: inode does not support timestamps beyond 2038
> [ 2134.753929] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
> #12: comm statx05: inode does not support timestamps beyond 2038
> [ 2134.754021] EXT4-fs warning (device loop0): ext4_do_update_inode:5261: inode
> #12: comm statx05: inode does not support timestamps beyond 2038
> [ 2134.754064] EXT4-fs warning (device loop0): ext4_do_update_inode:5262: inode
> #12: comm statx05: inode does not support timestamps beyond 2038
> [ 2134.754105] EXT4-fs warning (device loop0): ext4_do_update_inode:5263: inode
> #12: comm statx05: inode does not support timestamps beyond 2038
