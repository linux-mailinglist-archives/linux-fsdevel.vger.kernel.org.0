Return-Path: <linux-fsdevel+bounces-51826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF86ADBE1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 02:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E6118902BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 00:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C7C14EC46;
	Tue, 17 Jun 2025 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZUwHBri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405A1DA53;
	Tue, 17 Jun 2025 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120081; cv=none; b=m7mVpls3aChDbHFpwpLflDuFEyA0ZOc4e5lAM3c5m2N0YxO+w8Ars1v6qpSxGTboh9+THx3QyQ/v7riJxwGwTr0wYbniskcvRvWszK92EDDkRIjnNGXdYC5hCDJ9rGcCWqV46eTXpp1BKGBjqjd2bJN9YyMtvGsFNsqBl3bva0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120081; c=relaxed/simple;
	bh=7Qxx2Bv9Tqez0tLC1L/y7o/+duyJt0x0aAbD9+t4eFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJI+GKC7BJa6E3ZS03agUf0vWCEPMbcoAfuqJ61E98dbaFLKt+dwNzRwBwHd5si136hLtGri/zUQV7ulqsOLe59LxYyHc7TVehAU1PUAvklb97B5yUEGOKZ204XZgHtIc+QMJlPqx3eLBgmajT8NpGdaVLWRQa3ZgiwPakpUMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZUwHBri; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236192f8770so35278575ad.0;
        Mon, 16 Jun 2025 17:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750120079; x=1750724879; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Qxx2Bv9Tqez0tLC1L/y7o/+duyJt0x0aAbD9+t4eFk=;
        b=BZUwHBritNC384ilG/q5FQHL+iow3S9TDrEyBcsnpYZO4N+TpE/+uuK7QW4ziNqQ4l
         3fuHLh/63A9ACEyTtXegDt2zbD9utHkHJ+2R3SqxCSXUTVIygsKsYNM5P0ARHsJXorZr
         +W64WFMnA2KdPRccTkpQy2iNsjp0XZh9jv1dhRSgUiHCWWgbEoNzjimTzfzShajRuZaa
         lgUHKMCuzMW6XktVlqvnimU3yt89DVhpxIjUECvfNJtHRhENYV9Z8nkITn+1f5lJX5nc
         kvEbwL5Gu4n+72CSkrdvYemYeXvaK40n+ayaNZ9xv7JxPDxZUmh2cQQ7WNaUsS4z0dVa
         w6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750120079; x=1750724879;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qxx2Bv9Tqez0tLC1L/y7o/+duyJt0x0aAbD9+t4eFk=;
        b=sFnpcnZ3LAnliWrlxjvkAURSDbLpx7DpeqRhz0v6MNIQa94jtnL3sZ/dvrPgkyfb8/
         qbKAcVk+UvQY1hnknweodlGor3CVOXoz2VmW0kIfi9JWOwXWizSArRT9j9UfiBfOJoj7
         +zMPRebDeqfMHBFbPNsbpMhUChuLy4PjNzxEbUapmBoSNyvchtm106nWPDXB3NfeGEqd
         6XTmEhjjA03MC8wraHNdEheqaBITPcppt/Dx+DEaaFVoGA36bwHDJ7dlYh8t2rbnll50
         xIURiDrM+MYfpkXN/T2rdTUGs4vdTwOpsq/fRXjq0w1XRTlM9YWWB60jRDpAAsQK6ztD
         jx8w==
X-Forwarded-Encrypted: i=1; AJvYcCUjYj0c3f4vcxRqK02SREL3KuSAqDdmOI25yRUQ8vXxgju+hkI2AtFsy/SFIz1NBZbBVt24OPdhjb2MqzDT@vger.kernel.org, AJvYcCWXersz9nPRSK4K34kXJTQ4xOQJMtPXpCdWZrz89aMMQHy7/rUGdhmpN6/QYMrkQfHAM/3mo4cogA==@vger.kernel.org, AJvYcCXQYfQ0sZOzTbk7PP1tfWZFGZLg3S6aw+AumLu1I8VekqNaTq17FCEIdeP1piKErpOL8sLn1ZmTD34Iyf/m@vger.kernel.org
X-Gm-Message-State: AOJu0YwRMIMKgmj4VuBnE0hz+WIK9sBNjSGDittQYSk2Ynu6PoLeTFwp
	rueKNNyV7Ni3qjGRq4olfEbytf0ffaXJD1huDW/IfATl0t3fLjgmWZbMaKWGOg==
X-Gm-Gg: ASbGncsiZ8vFexyB5/FHyoG9Bxc3fRuiCcdv+ORAbMOTnELOpv1sE32A72gMjuD9f3V
	1PPSPMK/mqacxneTUKmAugR6D7xBp52oSytQi8eHcXNKDFc+evpUkXcIkkmhjQPlyRpn25s4/v3
	BJGM7tnASjrAwmZjLmp5IsI73yTKcdw3Dq5bqmhboTSBJNroAM+A/OnrhC+n+kf2bo64zoJbhn2
	kBIpcgv86YY0DpNCRNNYHLrPJ6R83XiBIbMR//xf4wuCfA2jEw1oqPeGv0yLwaaTGg7PVF10JaF
	wDn0kwNLAVHeKTWnZHqew2L1eL/lmKg8WR8NTdYoVeU=
X-Google-Smtp-Source: AGHT+IHelUh3WFlejZF7FApK98bY1gYlu3NcEbElM+plWTe4NQvabgGXhG3ngjrjYNHoyOxKKaXCpQ==
X-Received: by 2002:a17:903:1d0:b0:215:6c5f:d142 with SMTP id d9443c01a7336-2366ae55273mr158256785ad.20.1750120079276;
        Mon, 16 Jun 2025 17:27:59 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::de7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88d921sm67694385ad.40.2025.06.16.17.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 17:27:58 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,  linux-fsdevel@vger.kernel.org,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Stephen Smalley
 <stephen.smalley.work@gmail.com>,  linux-kernel@vger.kernel.org,
  selinux@vger.kernel.org,  eggert@cs.ucla.edu,  bug-gnulib@gnu.org
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
In-Reply-To: <20250616-flitzen-barmherzigen-e30c63f9e8ba@brauner>
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
	<CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
	<CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com>
	<87plfhsa2r.fsf@gmail.com>
	<CAHC9VhRSAaENMnEYXrPTY4Z4sPO_s4fSXF=rEUFuEEUg6Lz21Q@mail.gmail.com>
	<20250611-gepunktet-umkurven-5482b6f39958@brauner>
	<CAHC9VhTWEWq_rzZnjbYrS6MCb5_gSBDAjUoYQY4htQ5MaY2o_w@mail.gmail.com>
	<20250616-flitzen-barmherzigen-e30c63f9e8ba@brauner>
Date: Mon, 16 Jun 2025 17:27:57 -0700
Message-ID: <875xgv6wky.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

>> Checking on the status of this patch as we are at -rc2 and I don't see
>> it in Linus' tree?
>
> Sent this morning with some other fixes.

I see it merged now [1].

Thanks for the help all.

Collin

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe78e02600f83d81e55f6fc352d82c4f264a2901

