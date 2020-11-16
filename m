Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D7A2B3C51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 06:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKPFIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 00:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgKPFIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 00:08:19 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B093C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2020 21:08:19 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id l5so17356224edq.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2020 21:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSADVCrwuW6pljevvcMQIsFsXVk+O5kueFxo5o6oC2U=;
        b=Kjx6CArvtgoTb5cyfQ6FW3Kqfuqw16Cy4185JE92p8KAoyLxdIhPsivEB4Yvw2olBe
         awl9bIyCyt3Qo6ElD/B07owFpy8Q0SoGclEMCRSzXokKzv1q0/+r46IpE8rBoIvS6bue
         tBHkl2n+8FhDDjEt0tivyW+1XrIC0fqxPSj1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSADVCrwuW6pljevvcMQIsFsXVk+O5kueFxo5o6oC2U=;
        b=kiB3HbCNdOQ5g3lvKoIJCb4zZ4PxvA90AejN5hhXPv8cBFtvojE1kChJUk9ttIBdKP
         CmBs4Mm0QnHVXPvhbmy7q0/VaVZ8QsUP0iLiUA13LIAlCTEfQ4cIWCh1O7Q54rvpgAG+
         EN4mtLUvL/8zlLzjVLtZW/fqLDbkvC7BFc6XYdNRVl+ZzI/ME8Ak+DBec2uPVybyMM1K
         KE5Y7BX4HA3+zPekOE34rNNq1FSotdd/OhZwBG5Tbmy7RWCFiuoGtSKPpBfKZNwag3lI
         Anv4QcCbmTtDJkavJ0XSyYfMnmRkL1fTyuv6fcdNXeXU3C9HTMhJDBodgMQEU6rIyG61
         E3Mg==
X-Gm-Message-State: AOAM53080k0xMGVwzQVA2Yt4/b7FKpoXXe0j+jOesGCanxoq09v69E6q
        QjTOe93kM6+U6BsYKk8nkX1aCEfCmsx+kef5iSTi6Q==
X-Google-Smtp-Source: ABdhPJz27VjxU1Y/RsC+srSnav3shAf1hUwEEUva0AB7XJzwN8AzkRknK5xznyNSo+DD/2o/HvQ/jRNh7/UIds/7kxU=
X-Received: by 2002:a50:cd09:: with SMTP id z9mr14409916edi.152.1605503297860;
 Sun, 15 Nov 2020 21:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20201116045758.21774-1-sargun@sargun.me> <20201116045758.21774-2-sargun@sargun.me>
In-Reply-To: <20201116045758.21774-2-sargun@sargun.me>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sun, 15 Nov 2020 21:07:42 -0800
Message-ID: <CAMp4zn88ggSTdaAA=Nj9xMDNbQVHXg1BPyZwO6g22TuMqhodog@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] fs: Add s_instance_id field to superblock for
 unique identification
To:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 15, 2020 at 8:58 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> This assigns a per-boot unique number to each superblock. This allows
> other components to know whether a filesystem has been remounted
> since they last interacted with it.
>
> At every boot it is reset to 0. There is no specific reason it is set to 0,
> other than repeatability versus using some random starting number. Because
> of this, you must store it along some other piece of data which is
> initialized at boot time.
>
> This doesn't have any of the overhead of idr, and a u64 wont wrap any time
> soon. There is no forward lookup requirement, so an idr is not needed.
>
> In the future, we may want to expose this to userspace. Userspace programs
> can benefit from this if they have large chunks of dirty or mmaped memory
> that they're interacting with, and they want to see if that volume has been
> unmounted, and remounted. Along with this, and a mechanism to inspect the
> superblock's errseq a user can determine whether they need to throw away
> their cache or similar. This is another benefit in comparison to just
> using a pointer to the superblock to uniquely identify it.
>
> Although this doesn't expose an ioctl or similar yet, in the future we
> could add an ioctl that allows for fetching the s_instance_id for a given
> cache, and inspection of the errseq associated with that.
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> ---
>  fs/super.c              | 3 +++
>  include/linux/fs.h      | 7 +++++++
>  include/uapi/linux/fs.h | 2 ++
>  3 files changed, 12 insertions(+)
>
> diff --git a/fs/super.c b/fs/super.c
> index 904459b35119..e47ace7f8c3d 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -42,6 +42,7 @@
>
>  static int thaw_super_locked(struct super_block *sb);
>
> +static u64 s_instance_id_counter;
>  static LIST_HEAD(super_blocks);
>  static DEFINE_SPINLOCK(sb_lock);
>
> @@ -546,6 +547,7 @@ struct super_block *sget_fc(struct fs_context *fc,
>         s->s_iflags |= fc->s_iflags;
>         strlcpy(s->s_id, s->s_type->name, sizeof(s->s_id));
>         list_add_tail(&s->s_list, &super_blocks);
> +       s->s_instance_id = s_instance_id_counter++;
>         hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
>         spin_unlock(&sb_lock);
>         get_filesystem(s->s_type);
> @@ -625,6 +627,7 @@ struct super_block *sget(struct file_system_type *type,
>         s->s_type = type;
>         strlcpy(s->s_id, type->name, sizeof(s->s_id));
>         list_add_tail(&s->s_list, &super_blocks);
> +       s->s_instance_id = s_instance_id_counter++;
>         hlist_add_head(&s->s_instances, &type->fs_supers);
>         spin_unlock(&sb_lock);
>         get_filesystem(type);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dbbeb52ce5f3..642847c3673f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1472,6 +1472,13 @@ struct super_block {
>         char                    s_id[32];       /* Informational name */
>         uuid_t                  s_uuid;         /* UUID */
>
> +       /*
> +        * ID identifying this particular instance of the superblock. It can
> +        * be used to determine if a particular filesystem has been remounted.
> +        * It may be exposed to userspace.
> +        */
> +       u64                     s_instance_id;
> +
>         unsigned int            s_max_links;
>         fmode_t                 s_mode;
>

Hit send a little too quickly. Please ignore this hunk as part of the RFC.
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index f44eb0a04afd..f2b126656c22 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -13,6 +13,7 @@
>  #include <linux/limits.h>
>  #include <linux/ioctl.h>
>  #include <linux/types.h>
> +#include <linux/uuid.h>
>  #ifndef __KERNEL__
>  #include <linux/fscrypt.h>
>  #endif
> @@ -203,6 +204,7 @@ struct fsxattr {
>
>  #define        FS_IOC_GETFLAGS                 _IOR('f', 1, long)
>  #define        FS_IOC_SETFLAGS                 _IOW('f', 2, long)
> +#define FS_IOC_GET_SB_INSTANCE         _IOR('f', 3, uuid_t)
>  #define        FS_IOC_GETVERSION               _IOR('v', 1, long)
>  #define        FS_IOC_SETVERSION               _IOW('v', 2, long)
>  #define FS_IOC_FIEMAP                  _IOWR('f', 11, struct fiemap)
> --
> 2.25.1
>
