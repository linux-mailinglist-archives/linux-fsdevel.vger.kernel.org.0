Return-Path: <linux-fsdevel+bounces-40621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8E9A25E9B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9785162B89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B14209663;
	Mon,  3 Feb 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa6JwDdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115362036ED
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596194; cv=none; b=UNVXel4Pyso/0R45IA4i7S9w1IO16DmZdeBlyMhj41+vRbUYAMoCiyJqGNx+45uYxtH0rEHprk0GyGX4YZAzG5S5701dcuDRiPLVMOmzNXcFFnR4y9PJZIDUGwCIeBs77yxM6+J9cNL137P5f0dudvaTrO4NzqRoefXUXtOzLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596194; c=relaxed/simple;
	bh=2YRMnMKmdVYR9ktb1coIzuh+2N5q6gp0sbpOX7Dbl4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQhBndT8RgONMjQBVaOzDBwXiG9nRGSPyu5JyLnF9QJWnEegSxgewmd0q/J31hcX1keYn1T78FkApbBBAvs+i806sThpBaP+nopo5uPOVtqReoSTXkiF3L/6oMOv2y1yZcqyuYjRf+/Wy+fHEmkFUQ/YIrQTUYwv9xVBlk7hlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa6JwDdZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so9737077a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 07:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738596191; x=1739200991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBTGFYaaFYTgGrtvWe7tp0tXxIeSgFHjp1Bp2NUczq8=;
        b=fa6JwDdZvBs0ObhCNkhjweAu5LkNvJzT7uIV7n8pVNnXWzo7mfCcgLw4acgVAV0fRJ
         G8RUDmv0doZClcMRUbWIbfiflUK/ikQQfybft6wCf+obYhIiJPGYxKB/M5+AQ4MwU8Fa
         LD0Nc8rMyFYd3Ip/RFsU7uUUzp9tZxWWCCYlZzj2r8t4cyHcXcm0e58yEe2NXeMn+MaW
         GtANtJDcaVurgDkjyl36zgrlMFjPrc/30Qm8Yy2rVQMXgIQuQrpESuHzcknNiwqcB4OS
         hVuCqjMs1Od3UjNi+3n/7hDUb1c38eLPnhbNpigYAaOUDwMqWTM6VHQbu1JnYnS1mL17
         35ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738596191; x=1739200991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBTGFYaaFYTgGrtvWe7tp0tXxIeSgFHjp1Bp2NUczq8=;
        b=n0udR2yesFwGRVARrZmfh31x/nzAn3V4+IpfWF/M938DFrbjKVs9Jo88GKSF+aSlGW
         zwZ9p+24qBdV1uoFGKhiTGrtx3e9c1A2/epg5RwGP7sARWlp1784QpugLZFLSO1Xn9TX
         GweQTl6BwsygIpbW/U+d3LCHg8KLUCiKtolJA9154XwTlx2mTt2C7/5J6ERsVuBwPwJv
         +tN6u+qsRpmUFcUJInsgRmtxfsK3SlmaYgh8G8X6RZAkOen2cSYqjFt1r9hcY8XG/2Nr
         Oq4nksy9z/twM8N0DU5XwEIY3EeKn9jMxfOyyXI+9pvqVHtWwcPwOaJ/2U9+jPOGlL6X
         gaRw==
X-Forwarded-Encrypted: i=1; AJvYcCXWd+ewfqqP/D612rwT7VvdUnUlbzzi0v8vZ8jUyy5YrICY1bPkSf8r8rtezsMmRu49rGW/xuvEO4+7RGb9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv4r7Ga7THJs7kCPRMZ7KzEMBVHoipWJuCEDGsQr2gZ42V1kgW
	68+DeaYRRjU4EMUzLyy4cusPhKGnmO0E3m0aE52N6CoAvV58xFpaxH36c3tCejdKURVXbthiOBR
	pQqSqeKPj3ZkA+pyyUUec3EFWlv0=
X-Gm-Gg: ASbGnct95LMc/Pqp6tbSvEyyq87dxVqbZRim9YO9UAwqvsOFv5DDygzU9TWMQFWljcn
	WMauyRzR8+zuQP/EKSgYCeDJkyhZ/oor/nRlrfaIsz5L6AuFP7eLdv4U3B5MzyPxhCciZhu6N
X-Google-Smtp-Source: AGHT+IHIIlutHe50VN0mBVCai09P7LhimLdMn2KTfGXISmfyPHfxSqFzSujjwUZPvxBD/iQpM0gAGOUP3FujtKEIrgs=
X-Received: by 2002:a05:6402:50d3:b0:5dc:1239:1e40 with SMTP id
 4fb4d7f45d1cf-5dc5f00851bmr21981763a12.31.1738596190922; Mon, 03 Feb 2025
 07:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <048dc2db-3d1f-4ada-ac4b-b54bf7080275@gmail.com>
In-Reply-To: <048dc2db-3d1f-4ada-ac4b-b54bf7080275@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 3 Feb 2025 16:22:59 +0100
X-Gm-Features: AWEUYZny4N3Ne3FU96rQ57ttP8wygcMqU8WJPN9fyAlUTNpd3qgqK6kJE-bgWRA
Message-ID: <CAOQ4uxjN5oedNhZ2kCJC2XLncdkSFMYJOWmSEC3=a-uGjd=w7Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Design challenges for a new file system that
 needs to support multiple billions of file
To: RIc Wheeler <ricwheeler@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	Zach Brown <zab@zabbo.net>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 10:40=E2=80=AFPM RIc Wheeler <ricwheeler@gmail.com> =
wrote:
>
>
> I have always been super interested in how much we can push the
> scalability limits of file systems and for the workloads we need to
> support, we need to scale up to supporting absolutely ridiculously large
> numbers of files (a few billion files doesn't meet the need of the
> largest customers we support).
>

Hi Ric,

Since LSFMM is not about presentations, it would be better if the topic to
discuss was trying to address specific technical questions that developers
could discuss.

If a topic cannot generate a discussion on the list, it is not very
likely that it will
generate a discussion on-prem.

Where does the scaling with the number of files in a filesystem affect exis=
ting
filesystems? What are the limitations that you need to overcome?

> Zach Brown is leading a new project on ngnfs (FOSDEM talk this year gave
> a good background on this -
> https://www.fosdem.org/2025/schedule/speaker/zach_brown/).  We are
> looking at taking advantage of modern low latency NVME devices and
> today's networks to implement a distributed file system that provides
> better concurrency that high object counts need and still have the
> bandwidth needed to support the backend archival systems we feed.
>

I heard this talk and it was very interesting.
Here's a direct link to slides from people who may be too lazy to
follow 3 clicks:
https://www.fosdem.org/2025/events/attachments/fosdem-2025-5471-ngnfs-a-dis=
tributed-file-system-using-block-granular-consistency/slides/236150/zach-br=
ow_aqVkVuI.pdf

I was both very impressed by the cache coherent rename example
and very puzzled - I do not know any filesystem where rename can be
synchronized on a single block io, and looking up ancestors is usually
done on in-memory dentries, so I may not have understood the example.

> ngnfs as a topic would go into the coherence design (and code) that
> underpins the increased concurrency it aims to deliver.
>
> Clear that the project is in early days compared to most of the proposed
> content, but it can be useful to spend some of the time on new ideas.
>

This sounds like an interesting topic to discuss.
I would love it if you or Zach could share more details on the list so that=
 more
people could participate in the discussion leading to LSFMM.

Also, I think it is important to mention, as you told me, that the
server implementation
of ngnfs is GPL and to provide some pointers, because IMO this is very impo=
rtant
when requesting community feedback on a new filesystem.

Thanks,
Amir.

