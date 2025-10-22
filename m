Return-Path: <linux-fsdevel+bounces-65127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF0BFCF4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 17:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC043B236F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13073502A0;
	Wed, 22 Oct 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD/bZN1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919834C986
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147597; cv=none; b=WY/D10Rt3taxJYmYQZk9m0RhRue9kNdtKJ/95FASGLAoyPtdOELRjh1Yk6MR0XI+/iiAT1qdiJR2O5bm6mMsuH2w+YH0L4Txwn4czJMEji5MdBzQrQL4253E1asnsVm45Q7HaVIBY9Ri5k9dygufOpV9RLyKPzngXqemSB67sdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147597; c=relaxed/simple;
	bh=Y7nRwgNuEoRlNNpluhXoG5akVg94Zwfd3+z5MLrputQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=deIX0sX1+jcIRIP9XvvEsQhbyG9Vfec2F/dEnEmTIyRWElcygFePE1JU9RfZu8MUZdPbdlfqGn0AQfLT+Ksrx6S5aO8f4/jw9Mts0tUk5HEsEo8AsA9Tt5yoSQamgTUL2i622fq5s3iugjxDUAhe5FAXmI+cGKbNAR0r8xP/XdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD/bZN1l; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78125ed4052so8473805b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761147589; x=1761752389; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7nRwgNuEoRlNNpluhXoG5akVg94Zwfd3+z5MLrputQ=;
        b=YD/bZN1lpZAcn1WKVcNW96Hxla7lkRfvHfVjlgjE4NgmR5JI4g5iO7vItrERVOedCU
         EJM6RtMCiHGSCCqScQT+UWJ5y77IFninYRLbLlIsorT8B1tN6OuEgJAmsviXjC2c5XL+
         /KKz1JDLIUsek5QIEo/AnZ+QB1z6aekNIq8Gyu9XihN3krO2594xVQCyJzybkDKkm+ns
         nuJN6LQDa0Qk3TLxt8zyQs9CaSaiz3e/0sRLw2G66+yUpYGFsu4yvHN7C81xX+9a1ip9
         W8uG9U6NjxJ3sCq2uMqVuW2NNoNnphc1AvaIH06qEIPICnZtXzTS1yruI95bMsiu9F3V
         xiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147589; x=1761752389;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y7nRwgNuEoRlNNpluhXoG5akVg94Zwfd3+z5MLrputQ=;
        b=xB9d/dbLjj1f4B5oAq6XxfV4athfYJLhvZ/Wj76m4/yQPKvhlk3E0WUVWYLRFoEE06
         uAIm8XSYmO1crsy0nVO706OkchLChXmo1sjjDvziQyVsNL+RqL0CD39mvV54HK6D3G3b
         GrTedkJU4ZcJ06fRfwqN46YCtszoQNa7ZR93C6rCcDZ/5jLBZpXAyelb+5AI+3Sd5kqE
         4xVEm4BE2GukODsk9CvZ1XclBRspotk1iXoyUqx5aTB5n+yyaGT9Go5gIvXQBM6pHt94
         791quBQW13axbImKm7hZGJzcmvY0hCM84eOLBgUzIJsjoToe/uElhy2+z8lZ1zkhwHvN
         ygKw==
X-Forwarded-Encrypted: i=1; AJvYcCUFhWoWhto8UUb+/+xIANSqnRMuKfeS/T6wJ5zBM57T2bXn2jJFq8yASxioGqTzgZKgaGAeho5nnaHDVfvt@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJQRoq7cl8Ap8gLcHTA00jyhpLmGYeunEny/mGlmEkhvSwSPd
	leSwu7MqykPF6E5afqwpTiMmtX/3ROx9GJr9shzoNXvGxksTkJ+cOEUF
X-Gm-Gg: ASbGncvxbhatazSOjWiWGGshUGCva2MiFFZt9MOoxLWfDRF8piPqCnxw0Buln94sQsU
	XYYAGbltJmm7nMge0aStpEbeJr1ZECyMgLo7vbeu/LH14NFYNx+kFsZVqsCS+3xX52NM2+R2pLX
	uuwnNo96zAoxzMwE5jZ/1JjODLpy+0iqVBrw5TzMZ8DOgmwTmnrKVilpHR5NCaKLShB+eRgJYe5
	T8Qw1wWMvVf95DGpmE8ncgx/+Iq7ZMfjqzvMjYXmXKU1AEhFTCpJJURYfeOSDCADP9NflgsCYe1
	AZr977f7meayHP6rz3LbR16c8O/d7bPPzcgMCB7o+G9gQBQ0D0zams0ZtgDyZVPocUAf+DEyhtm
	qukTLpcYkYJXe1XLanCOuPTYNx/vD46iSC3yDAZUvwhtcbJ3dzqLsSJY1JbSUAXcKvFHcFKRHMo
	g1JRHs75y91EIZn08=
X-Google-Smtp-Source: AGHT+IHA8x16qnReEkx7tom3/OFAd7P+EdqEKlOFfN8xi5QWb1VTjZPUHlGnrwAgma8aqZe+Er/QzA==
X-Received: by 2002:a05:6a20:6a1b:b0:319:fc6f:8adf with SMTP id adf61e73a8af0-334a85340b4mr28440226637.12.1761147589058;
        Wed, 22 Oct 2025 08:39:49 -0700 (PDT)
Received: from localhost ([2405:201:3017:184:d484:e840:6844:1f7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b35dadsm13987935a12.26.2025.10.22.08.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 21:09:42 +0530
Message-Id: <DDOYPQ2FG2ZF.2RO4YIQ0TRKJA@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Aleksa
 Sarai" <cyphar@cyphar.com>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Jan Kara" <jack@suse.cz>, "John Garry" <john.g.garry@oracle.com>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, "Darrick J . Wong"
 <djwong@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Ingo Molnar"
 <mingo@kernel.org>, "Andrei Vagin" <avagin@gmail.com>, "Alexander
 Mikhalitsyn" <alexander@mihalicyn.com>
Subject: Re: [PATCH v2 1/1] statmount: accept fd as a parameter
From: "Bhavik Sachdev" <b.sachdev1904@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>
X-Mailer: aerc 0.20.1
References: <20251011124753.1820802-1-b.sachdev1904@gmail.com>
 <20251011124753.1820802-2-b.sachdev1904@gmail.com>
 <20251021-blaumeise-verfassen-b8361569b6aa@brauner>
In-Reply-To: <20251021-blaumeise-verfassen-b8361569b6aa@brauner>

On Tue Oct 21, 2025 at 5:41 PM IST, Christian Brauner wrote:
> Hm, do you really need a new field? You could just use the @spare
> parameter in struct mnt_id_req. It's currently validated of not being
> allowed to be non-zero in copy_mnt_id_req() which is used by both
> statmount() and listmount().
>
> I think you could just reuse it for this purpose in statmount(). And
> then maybe the flag should be STATMOUNT_BY_FD?
>
We made a new field because we thought @spare is already being used (or
will have a future use?). grab_requested_mnt_ns uses @spare as a mount
namespace fd [1], but we also only allow @spare to be 0, so I don't
really understand whats happening here, is this functionality disabled?
> Otherwise I think this could work.
>
Thanks, Christian! I will send a new patch with all your requested
changes.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D7b9d14af8777ac439bbfa9ac73a12a6d85289e7e

