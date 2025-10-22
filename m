Return-Path: <linux-fsdevel+bounces-65192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8AFBFD521
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786661881AD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2072E203706;
	Wed, 22 Oct 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kWAVClMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0373935B120
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150793; cv=none; b=akkVb4AgjqrT/1sJLmXW1SvGduAAswOOVA/7DiQWtRjV6gTKYTYXznIvn+q00WTXSroE6hH9j77WIlPuRQXgoysQ2LUIgHSNTtMcdKvvmUtuXDOcvB0cp04aXSgsVxJBwgMffzsVtTL9mnsOhJOCaWO7nhwN5kXnWHTANUQiH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150793; c=relaxed/simple;
	bh=E6RCTKW47ipGGb84adNktUnAjoSlq99ffGTznqkY3RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8DfjwxRnv84EBvrivnPGNdil6rQcJHANDCEnSiaFq4HXBmdf90GERhrDTKGGHqDcHBK2qxc2vpmRmaK0+RhwzNBXrb8O45o8Nve7LldBsw0dpk7bptP8s0oCmhbShTDBCjR7nhllHb9bba6LiLHTPhUkI2NXvAHmbPjfqfE0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kWAVClMQ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-891667bcd82so168770385a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1761150789; x=1761755589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E6RCTKW47ipGGb84adNktUnAjoSlq99ffGTznqkY3RQ=;
        b=kWAVClMQOUMycll/sjczbCYwuYptP2uOUdqWJw5nT+/RXlaiiQlQ79/z5jmdo99UsT
         vAqv9gxWHChQ4HyY+Edgbvdj8HIJWehPQaNcWF4bGmf/NndADnYZXGkp7ljK/poiNN66
         BFlBuLGjxUEOiCUzyMwvil4ri9uwdEZDpEaeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150789; x=1761755589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6RCTKW47ipGGb84adNktUnAjoSlq99ffGTznqkY3RQ=;
        b=J9UkZOaxoiLyzfQrd/XXEMNzKhfh40I8TmIysAoJAN0n74FHIQ3LROydYAZRmeUlA+
         pfltZ0mXRUqs6+bkdV97tWgInMq12YhEzQJJXQQMK26i83ZATe0xzptj2nrp4k5RlmQZ
         FX8I84sueEEjFAC6IIuj3B6bNJggebkRjLWKFFZasNsxWo6K1Y35XqK15LyI62AeJG0z
         7zBzauCORwct1PC7hI27QqXgYTAJsNGY0GRDBoElVwrRaDqDxs+GFsmaATGboeC2PS+T
         2AohhEUn/pRQ4WAzUmXIdxe4o6aTTZB7i3XTTiqeG9GzkVRCOL5Lyr7F9gXvEnLAf5cM
         jT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKZePATijuZGmgQ0vp9N9CpCU5srs9ASI0T06DFsgPngkczdEMZd3YRQBIHiZl0LhtiYf+eY7CGRCzcvuP@vger.kernel.org
X-Gm-Message-State: AOJu0YyWL/9JemPGon5E6NGfiYmxS6cKvEFJQll9RgVU0p2bYWBJIHwN
	vU/72LSffy+wCRgL38I9DexKT/vMfUj1gXJmUG7lv3EBOtAkj7a7fTdV3YMphLVddN1tzhRY7Q0
	Kk6UjJbYoG+4uRTtprx7/YVSaznwq2/Q2KVyGiFTmfA==
X-Gm-Gg: ASbGnctFNb+QuV1paRqgsOjE1E1mMiUdNFxkqKXKyZifcncS+5+zZRu3nEsq0wSzc7k
	gKNrmslodftWx15shM59rP0uqNtkeD1jrYNKeb/QpfUQuVm28S7/HvrQTI4zze3pDgiLpDqbxMe
	K8hwaboR/7NC369e4gNBk1kfBWeJujyS82NQ7B5J3yFd7TegHOM/9SW3al66Yqc+0CKFJ1Q3Wgx
	wm8rJY3vaFDkPU+7eFs6ab3xhSEaskQBhekBcK/+vl5hlIrl+rMsn3VpdwCG524ippZmMbvWLKh
	jZxGJfsCbC83d13jQBY4xUWw
X-Google-Smtp-Source: AGHT+IHetFuQbcZ9sjeq1LfiwewhKOyzVgvyfZaoCwvZtpuzT0xhYxgjtjZJzL7XAL6bFknweJbXWrduyMZYn0Iipq8=
X-Received: by 2002:a05:620a:29cb:b0:890:e60c:de2c with SMTP id
 af79cd13be357-89adfa0210fmr257643185a.14.1761150789598; Wed, 22 Oct 2025
 09:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011124753.1820802-1-b.sachdev1904@gmail.com> <20251011124753.1820802-2-b.sachdev1904@gmail.com>
In-Reply-To: <20251011124753.1820802-2-b.sachdev1904@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Oct 2025 18:32:58 +0200
X-Gm-Features: AS18NWBpOtFOj38mwb2zwp85aespn4SrliR7HP6OAG5Pp6lvNUwpX1kQdf_Iz04
Message-ID: <CAJfpegtW_qR2+5hKPoaQnPRPixFUnL3t8XpcByKxLRJvkroP5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] statmount: accept fd as a parameter
To: Bhavik Sachdev <b.sachdev1904@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aleksa Sarai <cyphar@cyphar.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Jan Kara <jack@suse.cz>, 
	John Garry <john.g.garry@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Andrei Vagin <avagin@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Oct 2025 at 14:48, Bhavik Sachdev <b.sachdev1904@gmail.com> wrote:
>
> Extend `struct mnt_id_req` to take in a fd and introduce STATMOUNT_FD
> flag. When a valid fd is provided and STATMOUNT_FD is set, statmount
> will return mountinfo about the mount the fd is on.

What's wrong with statx + statmount?

Thanks,
Miklos

