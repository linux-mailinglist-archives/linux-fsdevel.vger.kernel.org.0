Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E398116433E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 12:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgBSLXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 06:23:02 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39068 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgBSLXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:23:01 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so138991ioh.6;
        Wed, 19 Feb 2020 03:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5L5sWTTrZ8wRnU/gy8xHm/c059safDgzJAFGus5OBsE=;
        b=Q6SaYbVMYY3YOLYKvGdY1N8Mn5Anz+kGLhlnE74xemF53LIVpuKoJYBML9BgbWjHtn
         7NPk32U7yNgoIwHPpe7s9CW7f3wmip3zqmdtFoJ5OipmQWRJcwRNtPxIFfg7el/3wBNz
         xSA+5EpKtHxsh42FwuKMc7pijGewjyAz3trqTnJUjE8Kk3LAzwIRMcqQLftTdy0cLMYD
         yEtjtUEpHhEku6BJe+CyBzQy1tE+REOVicmM80tTNhcHelF6ZYtpdcC4WitKOkmm0c4B
         qR4e62iFdarqOp2S3fbBWXhDGdvPq1PWJXHBXe0krAlqIJGSXViVXBLy/VIdMW9YDaX8
         VT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5L5sWTTrZ8wRnU/gy8xHm/c059safDgzJAFGus5OBsE=;
        b=U3xbjFPLkhba3hc6GHdaybjnMJBB0TnU/epmwNNp+/LLa92agRd6LXByunxrcqqKA+
         J/70TdisZyUP6p4AnprVnE6NzqUt/9jPFo/mC8+P8fp2OMvXW1WXsGR8VL4IFwNFt0E9
         TigkFuPF+zeuCaa8+VOkytcrd2BB6gz0P3ikP+z+vXzDWI02XEf5cVIUmSJ74UiqyqiY
         aupCFs9y/9dA5KQGPsBFNFTzmJ3wVIklcggKShr4Gk/+66j4E9OhaKFMFw94soXMz5fF
         5NWwJ/k7RVtmLWfL9YAEoZ0b+2LsbDeuuwUWDd2QJoAa0OZN7VNvtN4+A2B5wYne2DXn
         HxqA==
X-Gm-Message-State: APjAAAX8XhE9TaaJUqtfslYIkMOPqvjGYDn6ysFQomRfnXW7A/KfGi7t
        HInijoZd5Pmltebalso7RNb/ATk9T2U/uAS040Umgg==
X-Google-Smtp-Source: APXvYqxNt6ItIaOSBpi7Y6ue/GG+pGKTBHlsENpdVXtm1U0ZAg5utV/ehJqXRybLxRv+RCGmTU523pHQIpMzEPiGvEU=
X-Received: by 2002:a02:8817:: with SMTP id r23mr20735647jai.120.1582111380779;
 Wed, 19 Feb 2020 03:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-14-amir73il@gmail.com>
In-Reply-To: <20200217131455.31107-14-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Feb 2020 13:22:49 +0200
Message-ID: <CAOQ4uxiMTn6SN-L-2TOFRmV+AU=Of-Jnk=TKtDnkaEVqEnv0Yg@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] fanotify: report name info for FAN_DIR_MODIFY event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 3:15 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Report event FAN_DIR_MODIFY with name in a variable length record similar
> to how fid's are reported.  With name info reporting implemented, setting
> FAN_DIR_MODIFY in mark mask is now allowed.
>
> When events are reported with name, the reported fid identifies the
> directory and the name follows the fid. The info record type for this
> event info is FAN_EVENT_INFO_TYPE_DFID_NAME.
>
> For now, all reported events have at most one info record which is
> either FAN_EVENT_INFO_TYPE_FID or FAN_EVENT_INFO_TYPE_DFID_NAME (for
> FAN_DIR_MODIFY).  Later on, events "on child" will report both records.
>
> There are several ways that an application can use this information:
>
> 1. When watching a single directory, the name is always relative to
> the watched directory, so application need to fstatat(2) the name
> relative to the watched directory.
>
> 2. When watching a set of directories, the application could keep a map
> of dirfd for all watched directories and hash the map by fid obtained
> with name_to_handle_at(2).  When getting a name event, the fid in the
> event info could be used to lookup the base dirfd in the map and then
> call fstatat(2) with that dirfd.
>
> 3. When watching a filesystem (FAN_MARK_FILESYSTEM) or a large set of
> directories, the application could use open_by_handle_at(2) with the fid
> in event info to obtain dirfd for the directory where event happened and
> call fstatat(2) with this dirfd.
>
> The last option scales better for a large number of watched directories.
> The first two options may be available in the future also for non
> privileged fanotify watchers, because open_by_handle_at(2) requires
> the CAP_DAC_READ_SEARCH capability.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c      |   2 +-
>  fs/notify/fanotify/fanotify_user.c | 120 ++++++++++++++++++++++-------
>  include/linux/fanotify.h           |   3 +-
>  include/uapi/linux/fanotify.h      |   1 +
>  4 files changed, 98 insertions(+), 28 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index fc75dc53a218..b651c18d3a93 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -478,7 +478,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
>         BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
>         BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
>
> -       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
> +       BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
>
>         mask = fanotify_group_event_mask(group, iter_info, mask, data,
>                                          data_type);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 284f3548bb79..a1bafc21ebbb 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -51,20 +51,32 @@ struct kmem_cache *fanotify_name_event_cachep __read_mostly;
>  struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
>
>  #define FANOTIFY_EVENT_ALIGN 4
> +#define FANOTIFY_INFO_HDR_LEN \
> +       (sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
>
> -static int fanotify_fid_info_len(struct fanotify_fid_hdr *fh)
> +static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> -       return roundup(sizeof(struct fanotify_event_info_fid) +
> -                      sizeof(struct file_handle) + fh->len,
> -                      FANOTIFY_EVENT_ALIGN);
> +       int info_len = fh_len;
> +
> +       if (name_len)
> +               info_len += name_len + 1;
> +
> +       return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
>  }
>
>  static int fanotify_event_info_len(struct fanotify_event *event)
>  {
> -       if (!fanotify_event_has_fid(event))
> -               return 0;
> +       int info_len = 0;
> +
> +       if (fanotify_event_has_fid(event))
> +               info_len += fanotify_fid_info_len(event->fh.len, 0);
> +
> +       if (fanotify_event_has_dfid_name(event)) {
> +               info_len += fanotify_fid_info_len(event->dfh.len,
> +                                       fanotify_event_name_len(event));
> +       }
>
> -       return fanotify_fid_info_len(&event->fh);
> +       return info_len;
>  }
>
>  /*
> @@ -210,23 +222,34 @@ static int process_access_response(struct fsnotify_group *group,
>         return -ENOENT;
>  }
>
> -static int copy_fid_to_user(__kernel_fsid_t *fsid, struct fanotify_fid_hdr *fh,
> -                           struct fanotify_fid *fid, char __user *buf)
> +static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fid_hdr *fh,
> +                            struct fanotify_fid *fid, const struct qstr *name,
> +                            char __user *buf, size_t count)
>  {
>         struct fanotify_event_info_fid info = { };
>         struct file_handle handle = { };
> -       unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *data;
> +       unsigned char bounce[max(FANOTIFY_INLINE_FH_LEN, DNAME_INLINE_LEN)];
> +       const unsigned char *data;
>         size_t fh_len = fh->len;
> -       size_t len = fanotify_fid_info_len(fh);
> +       size_t name_len = name ? name->len : 0;
> +       size_t info_len = fanotify_fid_info_len(fh_len, name_len);
> +       size_t len = info_len;
> +
> +       pr_debug("%s: fh_len=%lu name_len=%lu, info_len=%lu, count=%lu\n",
> +                __func__, fh_len, name_len, info_len, count);
>

Changed all %lu above to %zu to print size_t without a warning.

Thanks kbuild test robot,
Amir.
