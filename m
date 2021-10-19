Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350C6432D86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 07:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhJSF65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 01:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSF64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:58:56 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711ABC06161C;
        Mon, 18 Oct 2021 22:56:44 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i6so75210ila.12;
        Mon, 18 Oct 2021 22:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3yNLbDICfeua/LhdwVtVCVMzajs527DpJFcM6F62K0=;
        b=TmZKZKP+GyBB0U025hqaZsQ/0b3+1pPZwrBdu2jTXTIRdW8XDVFf08N5cYy6tVU9PJ
         8UsPWywvpJEGBHRBekH2IaEE3BX6eD4YyJZSfMI3Csan9K3HNp8cF+64qMJjWW+hSp2D
         nFlHS7O0zz1e7Ep/9T3xkwHdRtWkdgpWdkx3oeLsH7ob5H6w8yhXLJYiPYIGmQATBAbl
         LaipfK9qAiYy5od0oXGZeTEanCAh6EhADkH3XKsB87Oy6BTDYPWSHjwX7WG0fsEF0nMz
         JMHwIP431h2sNfFTK9DK9v+0bnRVFyrftmPY59qwyT48Efb/wQPWqcUqIr1hSomnemto
         KTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3yNLbDICfeua/LhdwVtVCVMzajs527DpJFcM6F62K0=;
        b=391BGXkYJE0Sl+hKpm8IOODDsmyaV5u3stylLqWpAkUoqGvI376AGLtRiDbKkK/xre
         OZtSUr+MHFcNOFsWWGXazHjXsvkxX+yBN2/J7iTR5CAbdeNBU3inmUGt3oiCxgcHVq1l
         cpqefw2JfbQfqfBuWc69JAKsXEi632qHCj1/6EjV3qPtlAT7wVW7c93txlLh2NUDqUvj
         s1tvXJxQOl1BnfwtiWWBm49d9RmEEs6Lh0yunOlTGeccrIMKQbdcL8BvSZR4f4/8CK7l
         GLGbq2rFBoRKFopyvNozvbLuXIj/X55Ex6qTfbJxe/bwhW7HCQimVHndIOaSN/isBL5G
         grXA==
X-Gm-Message-State: AOAM531oUeLh3BFc0tFs/oc8bY3rfzF+7gJBQU8VF5ZmyTc+ubQ5H25e
        hPqmejEkCLcwmMEXSvWo7o+MJk2j283gINjS/98=
X-Google-Smtp-Source: ABdhPJziM9iXhRB0QxQk6cDlyqZhj7aL696borMxECPr+XBv6lpUf5iQD8cgXCMfP7CFQZ8G6+8hYcxHMXACHbcvBrk=
X-Received: by 2002:a05:6e02:160e:: with SMTP id t14mr17794948ilu.107.1634623003861;
 Mon, 18 Oct 2021 22:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211019000015.1666608-1-krisman@collabora.com> <20211019000015.1666608-23-krisman@collabora.com>
In-Reply-To: <20211019000015.1666608-23-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Oct 2021 08:56:32 +0300
Message-ID: <CAOQ4uxi2D_X1TwajwEUuKz8AzeWyphQTAMZ1S=zioQkLPkUcMA@mail.gmail.com>
Subject: Re: [PATCH v8 22/32] fanotify: Support merging of error events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 3:03 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Error events (FAN_FS_ERROR) against the same file system can be merged
> by simply iterating the error count.  The hash is taken from the fsid,
> without considering the FH.  This means that only the first error object
> is reported.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v7:
>   - Move fee->fsid assignment here (Amir)
>   - Open code error event merge logic in fanotify_merge (Jan)
> ---
>  fs/notify/fanotify/fanotify.c | 26 ++++++++++++++++++++++++--
>  fs/notify/fanotify/fanotify.h |  4 +++-
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 1f195c95dfcd..cedcb1546804 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -111,6 +111,16 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
>         return fanotify_info_equal(info1, info2);
>  }
>
> +static bool fanotify_error_event_equal(struct fanotify_error_event *fee1,
> +                                      struct fanotify_error_event *fee2)
> +{
> +       /* Error events against the same file system are always merged. */
> +       if (!fanotify_fsid_equal(&fee1->fsid, &fee2->fsid))
> +               return false;
> +
> +       return true;
> +}
> +
>  static bool fanotify_should_merge(struct fanotify_event *old,
>                                   struct fanotify_event *new)
>  {
> @@ -141,6 +151,9 @@ static bool fanotify_should_merge(struct fanotify_event *old,
>         case FANOTIFY_EVENT_TYPE_FID_NAME:
>                 return fanotify_name_event_equal(FANOTIFY_NE(old),
>                                                  FANOTIFY_NE(new));
> +       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> +               return fanotify_error_event_equal(FANOTIFY_EE(old),
> +                                                 FANOTIFY_EE(new));
>         default:
>                 WARN_ON_ONCE(1);
>         }
> @@ -176,6 +189,10 @@ static int fanotify_merge(struct fsnotify_group *group,
>                         break;
>                 if (fanotify_should_merge(old, new)) {
>                         old->mask |= new->mask;
> +
> +                       if (fanotify_is_error_event(old->mask))
> +                               FANOTIFY_EE(old)->err_count++;
> +
>                         return 1;
>                 }
>         }
> @@ -577,7 +594,8 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>  static struct fanotify_event *fanotify_alloc_error_event(
>                                                 struct fsnotify_group *group,
>                                                 __kernel_fsid_t *fsid,
> -                                               const void *data, int data_type)
> +                                               const void *data, int data_type,
> +                                               unsigned int *hash)
>  {
>         struct fs_error_report *report =
>                         fsnotify_data_error_report(data, data_type);
> @@ -591,6 +609,10 @@ static struct fanotify_event *fanotify_alloc_error_event(
>                 return NULL;
>
>         fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +       fee->err_count = 1;
> +       fee->fsid = *fsid;
> +
> +       *hash ^= fanotify_hash_fsid(fsid);
>
>         return &fee->fae;
>  }
> @@ -664,7 +686,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>                 event = fanotify_alloc_perm_event(path, gfp);
>         } else if (fanotify_is_error_event(mask)) {
>                 event = fanotify_alloc_error_event(group, fsid, data,
> -                                                  data_type);
> +                                                  data_type, &hash);
>         } else if (name_event && (file_name || child)) {
>                 event = fanotify_alloc_name_event(id, fsid, file_name, child,
>                                                   &hash, gfp);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index ebef952481fa..2b032b79d5b0 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -199,6 +199,9 @@ FANOTIFY_NE(struct fanotify_event *event)
>
>  struct fanotify_error_event {
>         struct fanotify_event fae;
> +       u32 err_count; /* Suppressed errors count */
> +
> +       __kernel_fsid_t fsid; /* FSID this error refers to. */
>  };
>
>  static inline struct fanotify_error_event *
> @@ -332,7 +335,6 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
>  static inline bool fanotify_is_hashed_event(u32 mask)
>  {
>         return !(fanotify_is_perm_event(mask) ||
> -                fanotify_is_error_event(mask) ||
>                  fsnotify_is_overflow_event(mask));
>  }
>
> --
> 2.33.0
>
