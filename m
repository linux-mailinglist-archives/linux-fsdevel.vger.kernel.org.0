Return-Path: <linux-fsdevel+bounces-72960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0092D067DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 23:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E35703029575
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 22:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699733AD9E;
	Thu,  8 Jan 2026 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyYM7Faa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800A2D6E68
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913089; cv=none; b=JalmoTZ0G69yEEMTq6KTY4pn6R+pVjV+pyLE2D1470JqqcF8YYryVRHG+oAMOGwZJtt6Enfm96uU0NpRLqmfb7Xm4LOumY/zhF1Oq/TiQWaEgug9zJsmI5UAICskt7fA87JkjB5z8XATgba9T4yvuh7BC5ZCalK/kKZykoY9w1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913089; c=relaxed/simple;
	bh=zsGdotmJj3SGWtFjV0IvJbc5TSqzL9rYJYY/AOcpK4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwaAV2xMAGIuP3+Pzst6j4ZpPCTgchYx8fB6zU6xe+ZujQWdyokzXJG2afG8fHnTRJ/CYNwrW32IBzHaSWD/0NXyoATsUacdZycThV2mZrDyoLrtXSb4bOrMjhvLgvg7OUQLxa00XZhtozCpfmRcSVoTgWwGNxIX+tTOnMlwLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyYM7Faa; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4f1aecac2c9so29291721cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 14:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767913085; x=1768517885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FInlMTmFOCTa5acQAqk8DHKAVtppOtoX0IKDbfVhflI=;
        b=ZyYM7Faa7qIcc8AL1qoOSAUjbUUzmiklyWJ93vEEUFizMCvxJK9ZjAUXVSJuaL62dp
         aN7m83n59Wzk1pS4wxZdRx5DP353TYLI7m/k50vCNFSjnBrTbAJjC42xPATI5ZhIu8km
         768pjK5mJAj7otdQ+vo4Y0RO/GAwldHgPrxmvrE+IJ+wwuZpIfKhIHDOn8UMIr0g6ZDl
         947yBF2EdfHKBWQVtq7CR8Gtm1wL70BnazoIn1AU/0sFXZVf1jGPwF44TXNYRkLHno09
         C+BBxMRc130WRlPDPPblWAlF5yEobGsg0pYNjVN8agwg8n+53R1RGtWA2CwsLWAd5P7u
         WiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767913085; x=1768517885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FInlMTmFOCTa5acQAqk8DHKAVtppOtoX0IKDbfVhflI=;
        b=sITJVc4iC+gKzXQEXyrTghDNWwnUAQ42jVn8PP6uOKHxkf6aJX6KbcZWzl530lGUqt
         M9+rHqlexdInGbnOItnRj2JDbowPDYbUPtYM8QrPTtr/AarHSrU1/JbCMbQ8HJJQBuPm
         iLxtEnQ6GjKQoO37Y9FXSpo9Oo8c/bhTQs0w/zD6vayj/nh8D1mXbAcuKYB3Ep+AKUp3
         J9lneiLFx7v9YM3NY3VRNHdW4wHgemYtdEv9k/3nMqPQ6nEU04fgT71e3jdLXL9t2eQg
         4VX/iRO77Jh58GkQEJJ4ZqBbhmVGvBBxniNLQPIyko9hSFeofi8J0vIM6fa8VCSj1LBN
         K1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRB1kvlwg9myzjHeNB8nUf/yTjU+sqVvw/moeMXe+cg2/2hAjB9jd/FfdNV9RmQj88XLOIVKcIakrxyHPz@vger.kernel.org
X-Gm-Message-State: AOJu0YydEA0sblhPVs47wgBl3h3Kn9lyyWUl0yehQ1C7uLSOgoeH+7mu
	ksFRCabmy8BJresyknDkYIu4ffb58kyiBhb9Y6Wl+4i6UNRtvFF29xQpdnNbuwcqU2xw5++FNe+
	TqmSMHkI0owz6GDvH46TpIrt33RaZe0g=
X-Gm-Gg: AY/fxX4Cdj8A+5blo1gFDcS82Cp2+6GlyS3bncB2BAY2kOMyo+X1WVWlB0vT4Jaqbj4
	vt8DvkeAOIBMKHmothOfaictUlexfY5qHzMiybLG35sto+wKy44SoMMPbXoflTmlLopfAXcqdhy
	hNNm2T4FQitSBXmkIWfHj7scpMUzVsmNpPEyWV2cUeA+iP2I/UJ9qMp5gqCyb+9xMbSKNCgK/nx
	b1nItC1p79HW+LqZAJ4uFbjsF5HDuX+2a1pf6EJiWBc6Q+7UMEbPoHR+y/KltXM+av3og==
X-Google-Smtp-Source: AGHT+IFLz4/PRMWMxCfwjIzCXMEZLyIhHB1fJEwXD93vZJEFJosRvuph30viy7wBT+pP0XgUDuMSi/GOlzBvZwhie3I=
X-Received: by 2002:ac8:7c4e:0:b0:4ed:a6b0:5c14 with SMTP id
 d75a77b69052e-4ffa84d4aa6mr169561811cf.23.1767913085233; Thu, 08 Jan 2026
 14:58:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223062113.52477-1-zhangtianci.1997@bytedance.com>
 <CAJnrk1aR=fPSXPuTBytnOPtE-0zuxfjMmFyug7fjsDa5T1djRA@mail.gmail.com>
 <CAP4dvsf+XGJQFk_UrGFmgTPfkbchm_izjO31M9rQN+wYU=8zMA@mail.gmail.com>
 <CAJnrk1Y0+j2xyko83s=b5Jw=maDKp3=HMYbLrVT5S+fJ1e2BNg@mail.gmail.com>
 <CAP4dvseWhaeu08NR-q=F5pRyMN5BnmWXHZi4i1L+utdjJTECaQ@mail.gmail.com>
 <CAJnrk1a2-HS6cqthfcU5hxBi7Rinwh8MpYggNtOg6P256aW0zw@mail.gmail.com>
 <CAP4dvsdRtO6BX6A-LdJDyakVucLskTvOViZRGonoMsK0eNtM1g@mail.gmail.com>
 <CAJnrk1Zt=zS7UYbryE0S+-1qBqYaowgCGa5Eq=gK7ynnk+ybTA@mail.gmail.com> <CAP4dvseEksJNZf-sUVZj_x97v8=tCDh2dECRMynuYtYfmsw=uw@mail.gmail.com>
In-Reply-To: <CAP4dvseEksJNZf-sUVZj_x97v8=tCDh2dECRMynuYtYfmsw=uw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 8 Jan 2026 14:57:54 -0800
X-Gm-Features: AQt7F2qqSYtvF7p8_2700VPtW9PNE10d_EMJd7oNSM_1fMss3d6U1P1vj0FmPc8
Message-ID: <CAJnrk1Yq5qQmCKw8rFYC=7mgBMf1+6P8c6HYKiunA88ZXNwNgg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: add hang check in request_wait_answer()
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xieyongji@bytedance.com, 
	zhujia.zj@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:25=E2=80=AFPM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Hi Joanne,
>
> > I think if the fusedaemon is in a process exit state (by "process exit
> > state", I think you're talking about the state where
> > fuse_session_exit() has been called but the daemon is stuck/hanging
> > before actual process exit?), this can still be detected in libfuse.
> > For example one idea could be libfuse spinning up a watchdog monitor
> > thread that has logic checking if the session's mt_exited has been set
> > with no progress on /sys/fs/fuse/.../waiting requests being fulfilled.
>
> The process exit state I referred to is a more severe scenario:
> the FUSEDaemon may be killed abruptly due to bugs or OOM.
> In such an unexpected exit, no userspace threads can run normally.
> However, some threads may remain stuck in the kernel and fail to exit pro=
perly.

Hmm, doesn't the CONFIG_DETECT_HUNG_TASK config already detect this?
The summary of it [1] says:

"Say Y here to enable the kernel to detect "hung tasks",
which are bugs that cause the task to be stuck in
uninterruptible "D" state indefinitely.

When a hung task is detected, the kernel will print the
current stack trace (which you should report), but the
task will stay in uninterruptible state. If lockdep is
enabled then all held locks will also be reported. This
feature has negligible overhead."

[1] https://www.kernelconfig.io/config_detect_hung_task

Another idea maybe is having some sort of system script that runs post
daemon process exit that checks if there's still any lingering d-state
children threads hanging around.

Thanks,
Joanne

>
> We have encountered at least two such cases:
>
> 1. The mount system call of the FUSEDaemon is blocked by other threads
>     and cannot acquire the super_block_list lock.(Our FUSEDaemon supports
>     multiple mount points, so this mount operation will affect the
> other mount points
>     within the FUSEDaemon process.)
> 2. The jbd2 subsystem of the ext4 filesystem, which the FUSEDaemon
>      logging system depends on, triggers a logical deadlock caused by
>      priority inversion.
>
> In these instances, a userspace watchdog would be ineffective.
>
> Thanks,
> Tianci

