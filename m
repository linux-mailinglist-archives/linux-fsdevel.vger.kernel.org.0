Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8F58E511
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 05:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiHJDBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 23:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiHJDAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:00:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7132BAE;
        Tue,  9 Aug 2022 20:00:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f22so17354049edc.7;
        Tue, 09 Aug 2022 20:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=z5mO8eCC7wjKXoln2FTDk1zyeO6qt82drxAxpYfwgGE=;
        b=Y+F8grh9nY6VQl/s15hngaJhSwOTQWLCz4swEh893UmCKziFHaaSoVWEgUH6R9076i
         tNNIYSHEB1iKELYA1OSebXGo04kmhvGgm6+zBLMymH1ZpZHugsxCTtCpgl7uyPRKBQPJ
         uzZt92pZZftmtZraZ909wgPRW8MMJ3MPqaXcpLsHouHV1vAoD0h/jbXUClXsoM2QWECI
         LDNlKa+e9SPOwaII7vfTVgesBCuDvdVDeeI+dJOwZ5mInsgi7uURcIYP2Z6eZyT2tDea
         wykDADHlzZK1w+8k+vH/Ltwp9v4SNHLs2N46vkDz7026AtUj2Om51qLiJ1hrTPbZN71v
         ox7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=z5mO8eCC7wjKXoln2FTDk1zyeO6qt82drxAxpYfwgGE=;
        b=JSyuJPMwg/DwHlnwrK0Lj9Dy7aFEHbuBl2Z9J4hAJxWX07IpqF29aQo026xUk8ge5z
         lF2oGqim7PDQklenLRviOooGfB71wmdywtlfzorIOPDkQEmac1UeXX0pxT8Ga2EWSee9
         53KGQ5m1zFVwe2ZqA2nJdTifxi5aqPNj/Z+T1lXPlr4ATiW9ZyWSWapuU974jOV1gkkY
         JQTDPgom4HFOCY1oTBE0xu/iDDVrviGsD83Clq3T/uYjzVZ/6wNrbZsjrBwr8xPssjt7
         NSdRVwOMOuY0QSoNGn8TwnO66kGwjCOIhVDbgjaI55wk1SrQj9yqysFCT1MHPz4gX4XF
         Nl+A==
X-Gm-Message-State: ACgBeo2CYaqXhckkShEJExE04bk6Ew/LtUN9X3s6Fhu9eeCUcEYDx267
        i9Esc3kEafjaqe5bDuShOcEQV/Kyx/E1Fsm4yNCfj9E4vURTwA==
X-Google-Smtp-Source: AA6agR4zUpTJLcfCgjcUBmtnUSRTBlsACTacJVVYqw5uEoOW00guz7VrkGSvwxUcaCtact4XulZd+0P8i9dG2c6Zil0=
X-Received: by 2002:a05:6402:2499:b0:440:942a:40c2 with SMTP id
 q25-20020a056402249900b00440942a40c2mr12684283eda.37.1660100433653; Tue, 09
 Aug 2022 20:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220805183543.274352-1-jlayton@kernel.org> <20220805183543.274352-2-jlayton@kernel.org>
In-Reply-To: <20220805183543.274352-2-jlayton@kernel.org>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Wed, 10 Aug 2022 11:00:22 +0800
Message-ID: <CAHB1Nah5ttUCuUUdPZjb9n_1uDTh_-J_N6JaJiwY+oZj7atJeg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        lczerner@redhat.com, bxue@redhat.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 6, 2022 at 2:37 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> From: Jeff Layton <jlayton@redhat.com>
>
> Claim one of the spare fields in struct statx to hold a 64-bit change
>>
>> attribute. When statx requests this attribute, do an
>> inode_query_iversion and fill the result in the field.

I guess, is it better to update the corresponding part of the man-pages...?
>
>
> Also update the test-statx.c program to fetch the change attribute as
> well.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/stat.c                 | 7 +++++++
>  include/linux/stat.h      | 1 +
>  include/uapi/linux/stat.h | 3 ++-
>  samples/vfs/test-statx.c  | 4 +++-
>  4 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/fs/stat.c b/fs/stat.c
> index 9ced8860e0f3..976e0a59ab23 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -17,6 +17,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/pagemap.h>
>  #include <linux/compat.h>
> +#include <linux/iversion.h>
>
>  #include <linux/uaccess.h>
>  #include <asm/unistd.h>
> @@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>         stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
>                                   STATX_ATTR_DAX);
>
> +       if ((request_mask & STATX_CHGATTR) && IS_I_VERSION(inode)) {
> +               stat->result_mask |= STATX_CHGATTR;
> +               stat->chgattr = inode_query_iversion(inode);
> +       }
> +
>         mnt_userns = mnt_user_ns(path->mnt);
>         if (inode->i_op->getattr)
>                 return inode->i_op->getattr(mnt_userns, path, stat,
> @@ -611,6 +617,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>         tmp.stx_dev_major = MAJOR(stat->dev);
>         tmp.stx_dev_minor = MINOR(stat->dev);
>         tmp.stx_mnt_id = stat->mnt_id;
> +       tmp.stx_chgattr = stat->chgattr;
>
>         return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>  }
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 7df06931f25d..4a17887472f6 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -50,6 +50,7 @@ struct kstat {
>         struct timespec64 btime;                        /* File creation time */
>         u64             blocks;
>         u64             mnt_id;
> +       u64             chgattr;
>  };
>
>  #endif
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 1500a0f58041..b45243a0fbc5 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -124,7 +124,7 @@ struct statx {
>         __u32   stx_dev_minor;
>         /* 0x90 */
>         __u64   stx_mnt_id;
> -       __u64   __spare2;
> +       __u64   stx_chgattr;    /* Inode change attribute */
>         /* 0xa0 */
>         __u64   __spare3[12];   /* Spare space for future expansion */
>         /* 0x100 */
> @@ -152,6 +152,7 @@ struct statx {
>  #define STATX_BASIC_STATS      0x000007ffU     /* The stuff in the normal stat struct */
>  #define STATX_BTIME            0x00000800U     /* Want/got stx_btime */
>  #define STATX_MNT_ID           0x00001000U     /* Got stx_mnt_id */
> +#define STATX_CHGATTR          0x00002000U     /* Want/git stx_chgattr */
>
>  #define STATX__RESERVED                0x80000000U     /* Reserved for future struct statx expansion */
>
> diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
> index 49c7a46cee07..767208d2f564 100644
> --- a/samples/vfs/test-statx.c
> +++ b/samples/vfs/test-statx.c
> @@ -109,6 +109,8 @@ static void dump_statx(struct statx *stx)
>                 printf(" Inode: %-11llu", (unsigned long long) stx->stx_ino);
>         if (stx->stx_mask & STATX_NLINK)
>                 printf(" Links: %-5u", stx->stx_nlink);
> +       if (stx->stx_mask & STATX_CHGATTR)
> +               printf(" Change Attr: 0x%llx", stx->stx_chgattr);
>         if (stx->stx_mask & STATX_TYPE) {
>                 switch (stx->stx_mode & S_IFMT) {
>                 case S_IFBLK:
> @@ -218,7 +220,7 @@ int main(int argc, char **argv)
>         struct statx stx;
>         int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
>
> -       unsigned int mask = STATX_BASIC_STATS | STATX_BTIME;
> +       unsigned int mask = STATX_BASIC_STATS | STATX_BTIME | STATX_CHGATTR;
>
>         for (argv++; *argv; argv++) {
>                 if (strcmp(*argv, "-F") == 0) {
> --
> 2.37.1
>
