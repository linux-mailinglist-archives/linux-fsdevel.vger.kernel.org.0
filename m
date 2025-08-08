Return-Path: <linux-fsdevel+bounces-57102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A8B1EB5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0F63ABB6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD408281520;
	Fri,  8 Aug 2025 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8mGyadO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073E28137A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666078; cv=none; b=CJme600OOMRIbSol0vqdC8ILSD4sAHL9JfhqrAPf/4Dqa6Z7v5E0AuG3VR/XbEJC0APih4Uzd8FtDtDEsvxFHccXGHvZ83T+VTziYKSLSFSi44Z26IzX3T5kZjYQpUeK6GlHGOk7qTGiozxlWdzJoR0P44ctzfxWYLxlZR3euYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666078; c=relaxed/simple;
	bh=7r/QLjV9hPRuz+DbdM5NY1WLZu4kyYIt9Thz70vrlAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhqBEEtouUEplJcRplyMiayEOFfWEsG+ja58ZE93EIoQWMNQMxrBzV777+IWydQ/3AOS4MXNj+KCeVcptHhakQuxvX/VurKVYknANXsnJLpQGfATUBgYz4XhLn/4ipcs9YS3+muFsw9Byb2l/KMKatmyNNoDedzibmRi9MGf+BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8mGyadO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af95b919093so345711466b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754666075; x=1755270875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSixpwtVSv3c542cVqNmnRiORegvqseVWcZ0hA0T4OA=;
        b=A8mGyadOsza4nU1i5QBl1cBRvBJOqzl3jnF7XDVqgd6F9lS57Hdp1OQia/kSBFFLPJ
         QA14iKsS8bDzAJqdYa2ypPCGyk1nY9EaBMN6XAOJDRKojLC74iL4+zlrRzoTNKqPEl/j
         LcpJ7xaEOxNQPLJWvGkAjgVV+DdEsTpuY28+Sr8vrh4Mn5wmdtgaLzA8jM68lYU6AwdM
         cBfSCEo77AaI3BhnTrELEDMUr4GwSYU2hr5BkhQPMkp5Rabmi8nuCaYoRI3Pd+ZxjDPp
         cf2MVZvamH5DvKykIlCwOQwEOQPSsLqCiEOt57r2uCurfVqulTNZh1fdMzJLBtuntru2
         pcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666075; x=1755270875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSixpwtVSv3c542cVqNmnRiORegvqseVWcZ0hA0T4OA=;
        b=XRACAV9JbV5jkS1YGqKbHczlV4FTQMLju8dUfPj2u5NEl6J63RHfuuQcpNqs7NIb7U
         AVe8jU5Nqncib7dU1Wk9z8ZTd8DS5RLd2rAzJgcXrIEteCmTrFFkzCFF/HiMByK63qu4
         zvhl+nvfL26/3V7iPt1x+RMGXtH3mH3qSQCTHPGSdgAgtfn1vojw171BAv0THWSVLuQX
         dlrXlxe/y0WbOm+0IWgm1w/eH3AJ16s2IiH91omAKTxFHUEtZ5a/FUi/7uApYYWKaYD4
         ArbE9S4Kx9mwluDvIX+UpRYyM4+dTXlYOs1Jbj9ZOYWprKDT1q4EsGMhZRenVYjXvnE6
         X82g==
X-Forwarded-Encrypted: i=1; AJvYcCWpLgl0VejE7gMpT8ihXu4jfh0OLMNQs9zULY7A8HY/XbiKAe5V4OybDlqb5de6bF9vEfaxae2sBb+3+s0F@vger.kernel.org
X-Gm-Message-State: AOJu0YzdrZFkAPXvvRTvjmE1LLWNBOkywZ71Uhq35QlXMviNIGXim4JY
	onoArDZxKs7vzyq/OiZtD4Z6DopcIkdIdqJexHCf5O+MIFbjxlWTKc1iKpsLvx1iGj58s1nmQAL
	Tx4ATUC5svggM3sNx2peEP7XLzOJSogE=
X-Gm-Gg: ASbGncsOBSr/QNpSw/hxTAJQ6h89ij2rDSgSU8iphh+LOeLu8v/xYbsjILKttRKlh9+
	VvhUEUEbOO6x0asCubTZv8MG5+IIHF2GOjT74Q6LVLURRxHbX0Uh5pVozabkhobTig1whE7zxab
	jghA4wEswlJJp3Lx/GKTvm4ulboJ7EOxWg5lis+27unKGUo1AMFNg6RyueH45cnUDC9r/rN0+FT
	IqGC2A3VRdhnZF6/g==
X-Google-Smtp-Source: AGHT+IE2SD4xy6SkSds+3CMX1D582W+myOQw3IfAXponVUuGt3yOlZQQts4DKaodMiq1a1wyc6lJTXRFbiz4FSVKUHw=
X-Received: by 2002:a17:907:25c7:b0:ad2:425c:27ce with SMTP id
 a640c23a62f3a-af9c640f866mr310030166b.2.1754666074375; Fri, 08 Aug 2025
 08:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806220516.953114-1-ibrahimjirdeh@meta.com> <20250806220516.953114-2-ibrahimjirdeh@meta.com>
In-Reply-To: <20250806220516.953114-2-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 8 Aug 2025 17:14:22 +0200
X-Gm-Features: Ac12FXzZi8GGv4mmjgyeNsrBp1I35tkYJFjo-s_FG1yIBwE6ZlHibtDhzYS-buw
Message-ID: <CAOQ4uxjOn=pnnxmKZWeTg_eOiAV9Tbc0yc10JxuB2Zf=hkxTxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fanotify: create helper for clearing pending events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 12:06=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> This adds logic in order to support restarting pending permission
> events. In terms of implementation, we reinsert events into
> notification queue so they can be reprocessed on subsequent read
> ops (an alternative is restarting fsnotify call [1]).
> Restart will be triggered upon queue fd release.
>
> [1] https://lore.kernel.org/linux-fsdevel/2ogjwnem7o3jwukzoq2ywnxha5ljiqn=
jnr4o4b5xvdvwpbyeac@v4i7jygvk7fj/2-0001-fanotify-Add-support-for-resending-=
unanswered-permis.patch
>
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/linux-fsdevel/sx5g7pmkchjqucfbzi77xh7wx4wua=
5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn/
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> ---
>  fs/notify/fanotify/fanotify.c      |  4 +--
>  fs/notify/fanotify/fanotify.h      |  6 ++++
>  fs/notify/fanotify/fanotify_user.c | 57 ++++++++++++++++++++++++------
>  3 files changed, 55 insertions(+), 12 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index bfe884d624e7..6f5f43a3e6bd 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -179,7 +179,7 @@ static bool fanotify_should_merge(struct fanotify_eve=
nt *old,
>  #define FANOTIFY_MAX_MERGE_EVENTS 128
>
>  /* and the list better be locked by something too! */
> -static int fanotify_merge(struct fsnotify_group *group,
> +int fanotify_merge(struct fsnotify_group *group,
>                           struct fsnotify_event *event)

fanotify_merge is not for permission events, its irrelevant

>  {
>         struct fanotify_event *old, *new =3D FANOTIFY_E(event);
> @@ -904,7 +904,7 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnot=
ify_iter_info *iter_info)
>  /*
>   * Add an event to hash table for faster merge.
>   */
> -static void fanotify_insert_event(struct fsnotify_group *group,
> +void fanotify_insert_event(struct fsnotify_group *group,
>                                   struct fsnotify_event *fsn_event)

You should not use fanotify_insert_event callback because it is
irrelevant for permission events.

>  {
>         struct fanotify_event *event =3D FANOTIFY_E(fsn_event);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index b78308975082..c0dffbc3370d 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -550,3 +550,9 @@ static inline u32 fanotify_get_response_errno(int res=
)
>  {
>         return (res >> FAN_ERRNO_SHIFT) & FAN_ERRNO_MASK;
>  }
> +
> +extern void fanotify_insert_event(struct fsnotify_group *group,
> +       struct fsnotify_event *fsn_event);
> +
> +extern int fanotify_merge(struct fsnotify_group *group,
> +       struct fsnotify_event *event);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index b192ee068a7a..01d273d35936 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1000,6 +1000,51 @@ static ssize_t fanotify_write(struct file *file, c=
onst char __user *buf, size_t
>         return count;
>  }
>
> +static void clear_queue(struct file *file, bool restart_events)
> +{
> +       struct fsnotify_group *group =3D file->private_data;
> +       struct fsnotify_event *fsn_event;
> +       int insert_ret;
> +
> +       /*
> +        * Clear all pending permission events from the access_list. If
> +        * restart is requested, move them back into the notification que=
ue
> +        * for reprocessing, otherwise simulate a reply from userspace.
> +        */
> +       spin_lock(&group->notification_lock);
> +       while (!list_empty(&group->fanotify_data.access_list)) {
> +               struct fanotify_perm_event *event;
> +
> +               event =3D list_first_entry(&group->fanotify_data.access_l=
ist,
> +                                        struct fanotify_perm_event,
> +                                        fae.fse.list);
> +               list_del_init(&event->fae.fse.list);
> +
> +               if (restart_events) {
> +                       // requeue the event
> +                       spin_unlock(&group->notification_lock);
> +                       fsn_event =3D &event->fae.fse;
> +
> +                       insert_ret =3D fsnotify_insert_event(
> +                               group, fsn_event, fanotify_merge,
> +                               fanotify_insert_event);

1. Restarted events should be inserted to the head of queue
2. merge and insert callbacks are irrelevant
3. I don't think we should deal with overflow for restarted events.
    (possibly, we can count pending events in group->q_len)

IOW, a dedicated fsnotify_restart_event() is probably in order

> +                       if (insert_ret) {
> +                               /*
> +                                * insertion for permission events can fa=
il if group itself
> +                                * is being shutdown. In this case, simpl=
y reply ALLOW for
> +                                * the event.
> +                                */
> +                               spin_lock(&group->notification_lock);
> +                               finish_permission_event(group, event, FAN=
_ALLOW, NULL);
> +                       }
> +               } else {
> +                       finish_permission_event(group, event, FAN_ALLOW, =
NULL);
> +               }
> +               spin_lock(&group->notification_lock);
> +       }
> +       spin_unlock(&group->notification_lock);
> +}
> +


I find very little value (negative value in fact) in this
clear-or-restart helper.
The two cases are almost completely different code paths and the helper
looks complex and overly nested.

Thanks,
Amir.

