Return-Path: <linux-fsdevel+bounces-72568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A94ACFBC3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 03:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E68343059680
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 02:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F571940A1;
	Wed,  7 Jan 2026 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dzris56S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CC1A256B
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767753805; cv=none; b=JRAnwVH6n2VcKrQSrme+AnJrglo0M7ewym1VGIL4h6H5cSLj1crCrX0gIEVcD46e/qbHamdoqnpIC7KJ0tHtXJOTH4+rpsOWtMe1s0YgIXkjYxMob07DyaZORk8m6Uy51XaGwROqRdIm8sXp3EdvWnMTLeyrshwH5vabBX7WYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767753805; c=relaxed/simple;
	bh=drOHgT8EVLwGZalTAFzzBlRGx5099uF+mFLLEuqeE38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwrYigWmCafUlJEP8bEN1AROXbOnSkZ/xU5Flbu5ZGpZsuPyi55MwdJgMbsEg/3HFe3bwaFVkaZGRzt31Fak9MfCj4xAnx6ynoHcZ9UA+pXY/LQ+3UZq1+FLXCUA0FB85+6iFYsQpVxQqB7wBZgxXk00VDtaKKQWLJUwVqA9u4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dzris56S; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34f63ad6f51so417868a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 18:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1767753803; x=1768358603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drOHgT8EVLwGZalTAFzzBlRGx5099uF+mFLLEuqeE38=;
        b=Dzris56SzSmXNR7hjk6ao3AyA9eS1dQLgebJbU3DOu39PcuYvNqRlSEEazV7ly25TT
         fKm4a8WOluON1PC7A/9b3hCqqn7lT/tjMCYWX791zYMO9qRxyi527pLrBslefRkSnakE
         nOnzORg0vyYGhFxDVw3XaIpkt7iFvHMy5bFrIN1++8baztRDUosUUMCDrxjx1DV6ziHg
         ENcYzgmOS7CcLA7xJcYlDhABliwiLW9Ej22jcCCVoPgJQ6Vtmr0rayeAfsjR8r6p2xAP
         EKPoEIqxiXXEe5bwRbOXFWIKr2BIdWkwqz/nPssaNC/McIg3GnfL/MJYQ9pXj7vYmazQ
         kgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767753803; x=1768358603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=drOHgT8EVLwGZalTAFzzBlRGx5099uF+mFLLEuqeE38=;
        b=GTGyS33NejA8jT/vmahIA5OzaWYbq8PL6dM20yQyaT91Bh3sQUdZSo04qfazXvC4DO
         cQbQZG+SqKdkyE3yEOFF1RSuZhY3IQ5N6ZTDmHxU8SRXL79CbM8fONp/Kca626biG0DL
         zatsmixePUNLy/lQynYUjKmqi1y1BjH1Pqv/1FkakIl4lgdLi46FNcHjqeP83RT0t6D0
         cRNxAI2JyZILd6B6L4ssR1bBaq6ZyyvBMUuhmwPO4yVWDHiZztbDS8HWBsvnstti19Bd
         6F1BT/QQLJfNNEnV0HDgBBpwRsLDSah3bymAit5fQ83BKggxtXoKbjZu2vHBPlpMzCCJ
         sMdg==
X-Forwarded-Encrypted: i=1; AJvYcCU92Vktw3wyFDSnChKr2y+IFyxmLh/QeVTHJOeEDxeIfvJBtIIjpmsxU/w6kmPGJUvQs+YzO2MV2uv4j4E7@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeprwF9AeyBWEa0A5ZNe//mNBQGXsyi9zSWNUiMtaUTelfwbP
	1qTDxF6OeeMJht0EtXsHOq7Z0XDTnOzQRYDfoUgrWqUdpJ3XwksjVlyLqKyS2skZCQ4oWU/ISC5
	xDtjAxw9cBkNyReIfqtT7Vxt9HlAggnScqR53u9GKBQ==
X-Gm-Gg: AY/fxX4XZBFZ1cWg4oIj1/5WNr3W++34Myhqq+mVQGKeLbS/NDeqQPn1XeXyP6YsJAz
	MfHnVxISaS8uh9BcJceFDZp3b2wJLKNjq5EYXej3s844maC/Qug6yeS9DG2CMOqQjAwcJkdWr0L
	nWU2hAYxBOLrdAlYim4gdxRkw/Wyh8+3iYquiHLaDyXyRvLidHIw1+AsumdXzHqIbQJn05x/oP7
	bcUm29C15NOwn3RKL+dcGRGWUSeNkCv2Gf0dJDDGh5bfhHsAVkU7Bd0n7Uy6G8jbJNWubkgPp5j
	ORtvDzk2
X-Google-Smtp-Source: AGHT+IFAOzJ39Prd4LsKQCIvTA5Pl6anG1dVhfCx6QT7++UKrk8hshccTcwev/xGxSDkiK0bLyYedW+bi4EkL14wbmU=
X-Received: by 2002:a17:90a:e703:b0:340:ad5e:cd with SMTP id
 98e67ed59e1d1-34f68b4e666mr1055299a91.5.1767753803276; Tue, 06 Jan 2026
 18:43:23 -0800 (PST)
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
 <CAP4dvseWhaeu08NR-q=F5pRyMN5BnmWXHZi4i1L+utdjJTECaQ@mail.gmail.com> <CAJnrk1a2-HS6cqthfcU5hxBi7Rinwh8MpYggNtOg6P256aW0zw@mail.gmail.com>
In-Reply-To: <CAJnrk1a2-HS6cqthfcU5hxBi7Rinwh8MpYggNtOg6P256aW0zw@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 7 Jan 2026 10:43:12 +0800
X-Gm-Features: AQt7F2p7_lt8ZIOCbnhv6PSBnj5ju4ST5q9D6euYKmeRPVjpei_sPxkqoV4A4aM
Message-ID: <CAP4dvsdRtO6BX6A-LdJDyakVucLskTvOViZRGonoMsK0eNtM1g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: add hang check in request_wait_answer()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xieyongji@bytedance.com, 
	zhujia.zj@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne=EF=BC=8C

> imo it's possible to check whether the kernel itself is affected just
> purely through libfuse changes to fuse_lowlevel.c where the request
> communication with the kernel happens. The number of requests ready by
> the kernel is exposed to userspace through sysfs, so if the daemon is
> deadlocked or cannot read fuse requests, that scenario is detectable
> by userspace.

Yes, checking in libfuse/fuse_lowlevel.c is feasible, but it depends on
the running state of FUSEDaemon(if FUSEDaemon is in a process exit state,
this check cannot be performed), I think we do need this approach,
but it cannot fully cover all scenarios. Therefore, I believe it
should coexist with this patch.

The content of the /sys/fs/fuse/connections/${devid}/waiting interface
is inaccurate;
it cannot distinguish between normal waiting and requests that have been ha=
nging
for a period of time.

Thanks,
Tianci

