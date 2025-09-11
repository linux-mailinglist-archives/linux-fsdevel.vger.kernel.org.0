Return-Path: <linux-fsdevel+bounces-60920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE8B52F9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9011480E43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C410246BA9;
	Thu, 11 Sep 2025 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8cP+JHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F953101C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588943; cv=none; b=Ad1JKfuZ69p17JiixwFhmWe5nsqvdPFdJicVy7bK/TwlGOjTEg8ocUmT19zaNTi107XhTIyuUxE6EQ/2qd4bUHEII6a68XBeGaf5N636ZxhGY1ashfo8jqwM3lqYkfrqREt0V1FkKx72eVaDsPvng/BGcJ+zNnLeQ+R2+0ljNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588943; c=relaxed/simple;
	bh=ctpXRPp8ld46rMarISQluqYatBB1oJVf7jRKIOm4ePY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTTQHUO4RiKI838p/oRq2yxJ/nHSKKoOPbkJaqdcp9mIR246xHBg2KpvpelDCIYb3IXHWAIFZxPtSB0OBaQh4EkKR8iA3lcdbn0p8mydGJQskOoXU04hH82r8mM2uybl7dd/y7bCPVUbPUNm52UD3QceZlzi6dr4plV9Nl4PnRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8cP+JHc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757588938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xp+5AwzeF+JZvsrl86RnGoAwRi/V2fJ3cA0yQ7TjcLU=;
	b=Z8cP+JHcxOp+a+gyg1qayGTGXRBomhRVVGUM5FJy1rZzS160lbDvusnz1tR7+Sr1ZTcH+d
	q0HaTcJvGWt5zYwp9tIaCd1BeNeKmISud5nxV2k/A0lvO6BCp7BnMZQ6dQMoaae7qFg4fM
	mJWqEJjlod3rO0m1Lx2R25GzwcUbFCI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-3pU5aNRIM9mexE1QE5gFyQ-1; Thu, 11 Sep 2025 07:08:53 -0400
X-MC-Unique: 3pU5aNRIM9mexE1QE5gFyQ-1
X-Mimecast-MFC-AGG-ID: 3pU5aNRIM9mexE1QE5gFyQ_1757588933
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e9fbb71253bso614038276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 04:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757588933; x=1758193733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xp+5AwzeF+JZvsrl86RnGoAwRi/V2fJ3cA0yQ7TjcLU=;
        b=mquxYwp4HDSYWAh8Qt4Sck0I9oyJacah/cXtykbeBEnQ995I6EDSaSqWQpZaQt670X
         H2rxvrd6P0D3+Erejcbhd8hBd1zdiaCm/YJGJjcJ3JE8p1/t2e64XLOkvE7cMPqq3Z+V
         3I5sGE4Fw0eSUEZiggWYzp0eVROYjgu3EMWz2/cw3fKE4iQfNg3GF0BQ21tFzh17+VkX
         wUVrFRA3uy4AVO1guouYCXWGKIZnTC3DDW6fCVWzNDA0sd9r7pu13f8DuLe11lXcFW3u
         sbVYpzq7/07JTvsWAVwPbmEPRNlRWkpxHXLui2EAZhUn3jva5cY5ZCzGDPwENf1StbvD
         2usw==
X-Gm-Message-State: AOJu0YwoqiyS3vbNGTC8G+TUjKpSOHyYUyt1j/oNZ5f2g76QbPPelcdb
	WHgTT/27UIBvsA50TkEARO7GzKtPT/jeTdFTH+wWU86v0lhpICzAz9PmPd3E1ASRydJfMXxUH04
	W0rEvgrPbX80qmJm8r/0zX3aoRW4OlZSL9pD7SKmLYu7NkSfY1+mWVHhmBSLKVNpzIibERFtxMl
	sBEmkMM9NTu6IO+I0lcERLGppUPBSJ0xZ9ErvCFY/t6A==
X-Gm-Gg: ASbGnctDhRDPXJeqwbwA0f+6sbTfsk4sPEtlaUJwkU6I5uIetbar0tLGvUwayRf/6Us
	jpXZQzUh220oL4lt7a77e9ni9mV4EIFt//4haxPi/kWjgFYnlas+q/MoS7Cd0qGujLlJebZOflc
	VUW+7gJkaYRBomF7G7AQ==
X-Received: by 2002:a25:b19e:0:b0:e98:9996:8f69 with SMTP id 3f1490d57ef6-e9f65e12486mr14424622276.12.1757588932627;
        Thu, 11 Sep 2025 04:08:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOFATwIWHs7+yYYFQW49kI3Zroo2SGCpXUoxXWrukDPRqktdccQKL5+TcmzlaRpUZg4CnhdAy8TZRIKeEX3Ok=
X-Received: by 2002:a25:b19e:0:b0:e98:9996:8f69 with SMTP id
 3f1490d57ef6-e9f65e12486mr14424598276.12.1757588932108; Thu, 11 Sep 2025
 04:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909143053.112171-1-mszeredi@redhat.com> <fyvzypw7ywz4mmqd7vtw34wa7k6gsicvtsjro5mnu6uggy2aeg@3e4p7l3q6gfm>
In-Reply-To: <fyvzypw7ywz4mmqd7vtw34wa7k6gsicvtsjro5mnu6uggy2aeg@3e4p7l3q6gfm>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 11 Sep 2025 13:08:41 +0200
X-Gm-Features: AS18NWAf5dXAZlRDHAQ_911HGUqcDENkQ7rN-bF9xXovtqPyyekFv0fI68XxeUU
Message-ID: <CAOssrKdgWF_uxYJTzzJsqKEZgUiixzn=SSL=H0e5XPG3sj23EA@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: add watchdog for permission events
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:12=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:

> > +             scoped_guard(spinlock, &group->notification_lock) {
>
> Frankly, I don't see the scoped guard bringing benefit here. It just shif=
ts
> indentation level by 1 which makes some of the lines below longer than I
> like :)

No strong arguments.  The scoped guard is safe against goto/return,
but there are none here, so...

> > +                                     pr_warn_ratelimited("PID %u (%s) =
failed to respond to fanotify queue for more than %i seconds\n",
>
> Use %d instead of %i here? IMHO we use %d everywhere in the kernel. I had
> to look up whether %i is really signed int.

Fine.  I haven't noticed that convention yet, will keep it in mind.

> > +                                                         event->recv_p=
id, task ? task->comm : NULL, perm_group_timeout);
> > +                                     rcu_read_unlock();
> > +                             }
> > +                     }
>
> I'm wondering if we should cond_resched() somewhere in these loops. There
> could be *many* events pending... OTOH continuing the iteration afterward=
s
> would be non-trivial so probably let's keep our fingers crossed that
> softlockups won't trigger...

Yeah, I think this won't be an issue in practice because

a) the loop is very tight for the first iteration case (which is the likely=
 one)

b) my gut feel about the number of perf events generated and being
simultaneously processed by the server should normally be less than a
hundred.

> > +static void fanotify_perm_watchdog_group_remove(struct fsnotify_group =
*group)
> > +{
> > +     if (!list_empty(&group->fanotify_data.perm_group)) {
> > +             /* Perm event watchdog can no longer scan this group. */
> > +             spin_lock(&perm_group_lock);
> > +             list_del(&group->fanotify_data.perm_group);
>
> list_del_init() here would give me a better peace of mind... It's not lik=
e
> the performance matters here.

Agreed.

> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_=
backend.h
> > index d4034ddaf392..7f7fe4f3aa34 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -273,6 +273,8 @@ struct fsnotify_group {
> >                       int f_flags; /* event_f_flags from fanotify_init(=
) */
> >                       struct ucounts *ucounts;
> >                       mempool_t error_events_pool;
> > +                     /* chained on perm_group_list */
> > +                     struct list_head perm_group;
>
> Can we call this perm_group_list, perm_list or simply something with 'lis=
t'
> in the name, please? We follow this naming convention throughout the
> fsnotify subsystem.

Okay.

Thanks,
Miklos


