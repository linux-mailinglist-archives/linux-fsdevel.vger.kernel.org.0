Return-Path: <linux-fsdevel+bounces-59608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6FFB3B220
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 06:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39C41C213F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 04:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F51D5CD7;
	Fri, 29 Aug 2025 04:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FkayMsRw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC48635B
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756441601; cv=none; b=EjdLwsqjMEGons1h0DABCQbu3kL0PjvBXtT0w86X+DubTBRwy6SAEj76NH5EcdephdIBZRwIIpXUz/1EPW/qsBW1Ba/ik9yWtzKaiT0oJFRYvry0tPdVTD/G0/6NEbeeHDLzHg26gB3vV08zk+Bl0X8T/8TSdaKPdVXsA8rUI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756441601; c=relaxed/simple;
	bh=EkoqvOV7dM9ZRk2hSBU1HXFUVM807mm71e5eGg2wvoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFXqmBxLiK2RNlkaF16zSdEcMNHBvr94//lDpPgQJAeLYmE27CGhVeNKFyLM0tOhs46BsZkvTUHc5ELYaUkMaCZ9wFvtOF1gw7Up0zaUcNFrQ38TvsTgMSErWE0NrR4sP8LGvGp4M8VdSEZn4Dx0fVb7QDjMZ2GANZtQ1vBdAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FkayMsRw; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30cce5da315so602723fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 21:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756441599; x=1757046399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4MHI2CvzdDIWL3MJRQiUQ6XLwUHQ6bTI5Rtl+9YzQg=;
        b=FkayMsRw1nhaL5c6tizQXkoEh7yrCFhYpojD0dnfln4mlh6vSh1D+pWbFkkmFdtMoG
         m35gUDjc41GX/9BxBDcCME/hu++HvndCyTt2sx9TmEVV6H71+0jUKIKAe2HdMiIw+v9K
         T9cbP6mnO/1MDFCFo8PNY9Ae6cRS6dyNcN0uLqFmnhcVWo8PV/VIJoPbc5+G3+IEJ3t/
         2GAgdgRC/QaFUQDYXEPIoKZfMKul4jpG6O7vQq10DthshgsYwjwlbO2dCUSclc9FVQTE
         Cb42uJxzFXx0PzCOUn822Zbnna0YWgDJODPf6sJuqeBir4yLTfbrowUvIXL4jpDbXooV
         Rybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756441599; x=1757046399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4MHI2CvzdDIWL3MJRQiUQ6XLwUHQ6bTI5Rtl+9YzQg=;
        b=ip0g0r/jkHyjyROcA+Q3YQJhxk8kZrr9bnq0Y6xhf/Nec5I1YdrPUrRFXw9oPsqXYZ
         AFFrmZOyT0C2pKOcxzfCBGgOvkqiZOuADuEfWnmStQM/nhwDqovxMhhbEY3d1f/CQ+c+
         t5cqX1EFFN+Wyl9kds21nYttyhKbd4jmdLY7v6PZ6+72lUwvTTP6NKtaYf61JStkfbCP
         ct60vBGaDjIgJCPjaLqNklO3tr+Oo+ZYgHzzIuKvDrdMXJNh59XkxU1wSf0SPeG0AXF0
         2jCLc2EiJNNmgUOx4R9//vrH9Xwjj1Q9uM86O16zJqPw6wd9GmPcIFopbgx6jDN8T4Dw
         eX7w==
X-Forwarded-Encrypted: i=1; AJvYcCXjAhar8TzTTKcJ5+iG9FvBNBPOx+Vys/GjfR6VC1pWtzJFY3HAaYOPdXx/7vCOxgx3sySx5dc0NvVRX1V6@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQvnfXoXrnZzlwcz1rIpJJHK9Fh5D4zcyL3bu4mU8k/Rjtvje
	2TG4HVjDX9B9Gc+Co2TNTXkPpdt2JLUje525Ewh50ncG2ch2vKAcTar9eK8gw4HHa7uGLBlUoRZ
	buIIszme2vlo4EMrMBV4EM/wA5naDtiYac3yGLk/UzA==
X-Gm-Gg: ASbGncsKF+XxATyru3wGn2OkHeMOzJChP8g77JF2b/4+ZNHrjTmzceOupL4C3egqq0U
	/CqliCVRHWCChh6PpXNUDRXp0bFsebnjcm3Fyh39tf7ZjIpSuwh+izgDtk2HJdHJJ9P199PDej5
	nntTzSGVDk4t9EbQiwaysjtaE2M8E/q59cXi4xkE8HCj08I3doNnq6bCZL8cYkwoKMsGPkOJPP5
	aBWyPyD71Bc9kS9kxe4
X-Google-Smtp-Source: AGHT+IFf4FjrlA+yJNoGwfHCxy5AzxXYoQmbOwMzox76J9uWS3VmXyQrRB8vf/VsxwQIM47CtDWnG0sD/EIc57wMe1I=
X-Received: by 2002:a05:6808:640b:b0:437:e919:7c69 with SMTP id
 5614622812f47-437e9198366mr694154b6e.28.1756441598826; Thu, 28 Aug 2025
 21:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com> <aKif_644529sRXhN@casper.infradead.org>
 <874ityad1d.fsf@gmail.com> <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com>
 <aKwq_QoiEvtK89vY@infradead.org> <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com>
 <878qj6qb2m.fsf@gmail.com>
In-Reply-To: <878qj6qb2m.fsf@gmail.com>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Fri, 29 Aug 2025 12:26:27 +0800
X-Gm-Features: Ac12FXzlKhRKFlcX7iMwV0JQwPE6st56qbCxyRHYK6cyh9oqTXOg70UqWcq9vqw
Message-ID: <CAPFOzZuLQK-2fKHsy79MyeKeUSNRU2YR-o48w4Qj1rfLAMcR4A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, Need to wait a few more days for this, too busy recently.

Ritesh Harjani <ritesh.list@gmail.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=B8=89 01:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Fengnan Chang <changfengnan@bytedance.com> writes:
>
> > Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=882=
5=E6=97=A5=E5=91=A8=E4=B8=80 17:21=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Mon, Aug 25, 2025 at 04:51:27PM +0800, Fengnan Chang wrote:
> >> > No restrictions for now, I think we can enable this by default.
> >> > Maybe better solution is modify in bio.c?  Let me do some test first=
.
>
> If there are other implications to consider, for using per-cpu bio cache
> by default, then maybe we can first get the optimizations for iomap in
> for at least REQ_ALLOC_CACHE users and later work on to see if this
> can be enabled by default for other users too.
> Unless someone else thinks otherwise.
>
> Why I am thinking this is - due to limited per-cpu bio cache if everyone
> uses it for their bio submission, we may not get the best performance
> where needed. So that might require us to come up with a different
> approach.
>
> >>
> >> Any kind of numbers you see where this makes a different, including
> >> the workloads would also be very valuable here.
> > I'm test random direct read performance on  io_uring+ext4, and try
> > compare to io_uring+ raw blkdev,  io_uring+ext4 is quite poor, I'm try =
to
> > improve this, I found ext4 is quite different with blkdev when run
> > bio_alloc_bioset. It's beacuse blkdev ext4  use percpu bio cache, but e=
xt4
> > path not. So I make this modify.
>
> I am assuming you meant to say - DIO with iouring+raw_blkdev uses
> per-cpu bio cache where as iouring+(ext4/xfs) does not use it.
> Hence you added this patch which will enable the use of it - which
> should also improve the performance of iouring+(ext4/xfs).
>
> That make sense to me.
>
> > My test command is:
> > /fio/t/io_uring -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1 -X1 -n1 -P1 -t0
> > /data01/testfile
> > Without this patch:
> > BW is 1950MB
> > with this patch
> > BW is 2001MB.
>
> Ok. That's around 2.6% improvement.. Is that what you were expecting to
> see too? Is that because you were testing with -p0 (non-polled I/O)?
>
> Looking at the numbers here [1] & [2], I was hoping this could give
> maybe around 5-6% improvement ;)
>
> [1]: https://lore.kernel.org/io-uring/cover.1666347703.git.asml.silence@g=
mail.com/
> [2]: https://lore.kernel.org/all/20220806152004.382170-3-axboe@kernel.dk/
>
>
> -ritesh

