Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4A42E9A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 09:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhJOHGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 03:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhJOHGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:06:19 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62EDC061570;
        Fri, 15 Oct 2021 00:04:12 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y67so6610964iof.10;
        Fri, 15 Oct 2021 00:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+hAqbWu2mfa+qe+Vt0ceTiplNgxQ0O07PtIOcUZqjc=;
        b=nkieqHNuB9ycF4I91rX5y21L57X9eEZXB497pbVwMsmhIxmznd0TElDoC7KlJ9KbKC
         Mh8j1nhuf4q9yofTCpigMQUKHaWTvOO2iIJyTOnXbGeSjpKOb3L5o5ipC+kxE/dLJATY
         Rql1XidXx4UUrkMlJLtfOIqZ1KdYaEw3v0ElPjuKig+98OO+mOrEDwLzdXb9bxSzWGEF
         pe7degHcj70i8Nnj/E6BYf5WAPnccAnE7jz9BRZ3P6qNwDGn0iFpkKKrEOVI0KtNnSGk
         OOFlZKQtLgCZDYspNot0q4EGWc+Djio2u39iJD/n5ASR5SlEtA/jMMQuLKSaYlGy4+nx
         BKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+hAqbWu2mfa+qe+Vt0ceTiplNgxQ0O07PtIOcUZqjc=;
        b=z9qXJB6eajRhHMUYEkR/GP1mUIXgwoxgYAl8TjImxSrWhW6Jay4bsVzz7Qojav3Tkh
         9dYmhQTJ2vYu3ALNXH/sszgO3PnywG+tjVWiJ5Cm/xCTN31/O6iXhW177ghyutyu7Nil
         b8C8vXDjs3XSjuKnmVFPzynRrmzwvBKCrR0p5MJZCXW4NCQIu2VrIuPRilCSw3Uagibo
         KgCov8UMahKoNasAGWwRnUZLjWAZsLvDr95tdqULAGeUcRFarnQMVTLQETQV6kzEnYXS
         AGVV913JjfFk/C+7Yn+7rX0GqHiBaoSAl5mPyZHpGUg2tGhpQPc7sM8Z614h2T81cQvJ
         pAjw==
X-Gm-Message-State: AOAM533tnFcgv9hSmuz8/zy0TvORVFCCMRHnBw+5VZowTlI9KPwV2ESh
        8dhA6PO76U1+bcq8rT1TrLVdr384uQDpIkP6lJ4=
X-Google-Smtp-Source: ABdhPJwr8IXg5WIX8fKwSqnexqFTk7YLdf5pDPEmi33jsbk5aRJDisrn6IT7QVFUGLM1SGtVkOziEzhkuUyfvXr6DW0=
X-Received: by 2002:a02:6987:: with SMTP id e129mr7299481jac.136.1634281452402;
 Fri, 15 Oct 2021 00:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211014213646.1139469-1-krisman@collabora.com> <20211014213646.1139469-21-krisman@collabora.com>
In-Reply-To: <20211014213646.1139469-21-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Oct 2021 10:04:01 +0300
Message-ID: <CAOQ4uxh91CD1x3WXpV3q-Ct40v7gSrr7bAZ8jKjUyPcQ81Eeqw@mail.gmail.com>
Subject: Re: [PATCH v7 20/28] fanotify: Support enqueueing of error events
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 12:39 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Once an error event is triggered, collect the data from the fs error
> report and enqueue it in the notification group, similarly to what is
> done for other events.  FAN_FS_ERROR is no longer handled specially,
> since the memory is now handled by a preallocated mempool.
>
> For now, make the event unhashed.  A future patch implements merging for
> these kinds of events.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c | 35 +++++++++++++++++++++++++++++++++++
>  fs/notify/fanotify/fanotify.h |  6 ++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 01d68dfc74aa..9b970359570a 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -574,6 +574,27 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>         return &fne->fae;
>  }
>
> +static struct fanotify_event *fanotify_alloc_error_event(
> +                                               struct fsnotify_group *group,
> +                                               __kernel_fsid_t *fsid,
> +                                               const void *data, int data_type)
> +{
> +       struct fs_error_report *report =
> +                       fsnotify_data_error_report(data, data_type);
> +       struct fanotify_error_event *fee;
> +
> +       if (WARN_ON(!report))

WARN_ON_ONCE please.

Commit message claims to collect the data from the report,
but this commit does nothing with the report??

Thanks,
Amir.
