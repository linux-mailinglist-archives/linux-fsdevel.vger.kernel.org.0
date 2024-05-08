Return-Path: <linux-fsdevel+bounces-19077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7A98BFB0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6548E281941
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FD480C13;
	Wed,  8 May 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfkT6Uq0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC167818
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164344; cv=none; b=rNIC3+wiIXSBgFNEA+PmKQIfliT9cLPwOoszZHTai1UHT5UgK/Y8pqMq+/8G08zLX3NaYuUDCMvhcPftoxS8Yft/awEilgtj3Gw/D2YlBhyoOgzVQuPtkRvdd3PRPELrswlwz5iKTix8bQqAr0aAJtEgxMuDzxL0oOmeXpjd2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164344; c=relaxed/simple;
	bh=x/TMU/+oJRKgBPsJbNge/8QHIm1vyybob7mF2k8kJbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qsp/8WVfxqTVuzAiF16y8432iaGTfR2ziqqsPBYOJdDtly70leNOLtmG0cKBJrnOOgunEkU4PAehueT/+rNPeTT+PiP/lJLW+RltvjJOtgsDrKAi3E09BEzSu2dwadcMWaaXbohJBPQZ+/Z2ryms4zf+0lmsqdfPX1OFfqJ+MkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfkT6Uq0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b24162dd6so20984906d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 03:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715164342; x=1715769142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/TMU/+oJRKgBPsJbNge/8QHIm1vyybob7mF2k8kJbo=;
        b=KfkT6Uq006rYcl6fVmafeHhINaH3A800msxD3Dtq7WyxjErbufU4csyzPGBv0fby/9
         oCsV+FeAmHqe4bYOwS8uJ5rMIH+aIOxuR//aUauZtqNMbOoBOPMZw/tq9Kuz4FZL7lXb
         qAKSmyTikPQXvMLwBGs3196/cHgFdjOIG7pHoMDtu3i4q1FaiLZGLqSJeY1HPu9MtSCE
         rPy3r/lFJ/VYbc017ujOLhfviGceu5XxXassp2BgYc0iKuPn0giGKNYU3fs3wzl9kQdW
         kvOUIczap7UDZaxN5nQWuCWCUKdeBpV3cdPKm0Na68giGdqWZiu6bcbKIBmF7HeV/mYD
         2PVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715164342; x=1715769142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/TMU/+oJRKgBPsJbNge/8QHIm1vyybob7mF2k8kJbo=;
        b=X2xyO7bv3HxbnJrh02AvhayqHYZKrd/F0KVBzyegDPm0Tyl483lwy/UjhxYeLvX78U
         /by4SKnj4yx5Nd9ZlKgdwyll7FgGPKuL67Jlyaqow7Om/jjaO3gwT3GRrY0Pv/Ta21WC
         G9dCjdLIKpVgedEUX+GHOQ7b8ig5sSKefhAEp0/GAD4NzGfAKNVNr29oQSTPToTiXhrE
         zDq4K4Xh2Zp1SReiUEKOKOG8tGhBUkYw34tn0WRPCJSNv9lSyqI++RgShKaGNiBzjO9g
         RmoG81qsdXHAbW/ttBGCHSeZzPmZMER8BcmKN/VmqUgWvyBk5A6euOMXd8jEbfsLtxG+
         IcrQ==
X-Gm-Message-State: AOJu0Ywci6cT2mGUEzpOpJQxHSU23UIzT9iwgk8kQk98AcpFzP6UCnMI
	Z95NU+xkdbI05Q9JrEJB5OwTCa+o9WA9IvbujDB8nGpBRZM+osCC3sjqs0yEgZvUu3e9VXDCiBd
	AGq1uP+n+Qi8ezSwRWjfjnH6tGX8=
X-Google-Smtp-Source: AGHT+IFNEDqDXVT2kTc6MRsF7ywIlgR9i3ziXPv5d0i7vudO3TfA9QCtskquMvl7Zw7tBPrSpHUyBBa6tMKRIvo5sTY=
X-Received: by 2002:a05:6214:124c:b0:699:1f50:706 with SMTP id
 6a1803df08f44-6a151453383mr26598446d6.20.1715164341868; Wed, 08 May 2024
 03:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12d50bb6-7238-466b-8b67-c4ae42586818@redhat.com>
In-Reply-To: <12d50bb6-7238-466b-8b67-c4ae42586818@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 May 2024 13:32:10 +0300
Message-ID: <CAOQ4uxiXrSaDg40hpU=ZDpH3DQ3dbJ1XT_77EmM8_K704PyVCg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] finishing up mount API conversions;
 consistency & logging
To: Eric Sandeen <sandeen@redhat.com>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:59=E2=80=AFPM Eric Sandeen <sandeen@redhat.com> w=
rote:
>
> In case this is of interest to anyone I'll propose it.
>
> The "new" mount API was merged about 5 years ago, but not all filesystems
> were converted, so we still have the legacy helpers in place. There has b=
een
> a slow trickle of conversions, with a renewed interest in completing this
> task.
>
> The remaining conversions are of varying complexity (bcachefs might
> be "fun!") but other questions remain around how userspace expects to use
> the informational messages the API provides, what types of messages those
> should be, and whether those messages should also go to the kernel dmesg.
> Last I checked, userspace is not yet doing anything with those messages,
> so any inconsistencies probably aren't yet apparent.
>
> There's also the remaining task of getting the man pages completed.
>
> There were also some recent questions and suggestions about how to handle
> unknown mount options, see Miklos' FSOPEN_REJECT_UNKNOWN suggestion. [1]
>
> I'm not sure if this warrants a full session, as it's actually quite
> an old topic. If nothing else, a BOF for those interested might be
> worthwhile.
>

Christian,

I scheduled a slot for your talk on "Mount API extensions" on Tue 11:30
before Eric's Mount API conversions session.

Do you think this is the right order or do you prefer these sessions
to be swapped?

Also, this seems like a large topic, so I could try to clear more than
30min in the
schedule for it if you like. the buffer_heads session after your talks
will probably
be removed from there anyway.

I was thinking that we need a followup session for statmount/listmount [1]
What's still missing (mount change notifications, fsinfo) and what are
the next steps.
Are you planning to address those in your session?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20240105-vfs-mount-5e94596bd1d1@b=
rauner/

