Return-Path: <linux-fsdevel+bounces-70429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C510DC9A0E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 06:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A9C3A511A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 05:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F22F6565;
	Tue,  2 Dec 2025 05:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0zNoxUm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSOOA/u2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD81CD2C
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 05:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764652334; cv=none; b=YCfXYYCpNyqmJjNoM3KcD+jvqm6emQATPuY4+PmxG7gn4uUIiW42TMBw8JSDOUMIATxnWRJ2++q6x9fTnUXahmr2K+ASl7irMKPsMarnZCUkVZ3wV+Oc54n7Ed2PKS+swRAXtXCDdZnpJ4S/ive/rn8f0H4MwSLdJGEH7kWS94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764652334; c=relaxed/simple;
	bh=ihMRFFibkx4iZAo+T769NF0X6xtfec6KCzeaiEyNtFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kj2b3H74mfhxvbDMBtbEYW/Iu+cRPMw5jK2tbz6i6g1+VK5WxNe65oldFp6fMvPbUWiMoSjIN4RzYggLwiErD7gmxAO4U49GDua3Kcsscd6M3rNCpZ5MJ5UTiTUjaVJ81I8ku7jfQgOvtnXc2ElyiSAMuz4pTVkiouv/YLc1hPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0zNoxUm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSOOA/u2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764652332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vk+CkeVt6vIORHD5FrSK0jxLpo6cDXbgc2E73tBRSUI=;
	b=O0zNoxUmKkSIhFEzrThAfFgrb3ll6BpKe+MtoORZfoyDvPuRphnUx3pxWSY4v+T5Ske1Dy
	jXKCi0y8CAa48isCSK89lYYvgSQBl7F3v1BBO07vniE3PIayRWyKl+itLnEDeK+rK565iZ
	Fjt7ZcO31p+iQmZC1ifQzmwHl+NRwLg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-bVhS-XpHM-a6S9GLSxiy1Q-1; Tue, 02 Dec 2025 00:12:10 -0500
X-MC-Unique: bVhS-XpHM-a6S9GLSxiy1Q-1
X-Mimecast-MFC-AGG-ID: bVhS-XpHM-a6S9GLSxiy1Q_1764652330
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3438b1220bcso5028598a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 21:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764652329; x=1765257129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk+CkeVt6vIORHD5FrSK0jxLpo6cDXbgc2E73tBRSUI=;
        b=CSOOA/u2DlQ+D7YPrFrnNkfvzey/AK/swv1xixLaivSGNde71xStTioyMgyfsPuipE
         B7tkIsVMkgEQ9c0HX6gMfL0Nv7YadmjuXqP6CWUdUGEcsoHA8ScJARzoWcfQJnqRsu4p
         hp3ALUOkP5ulPrXVAucuWFZeX+edrR0sKwACnUf0m6Rh1XsGNZvS8oetGjYQjrNU2e55
         2rOnIva1939iUMcZOSe1qO6TifUzCf0erLV4Tzq/ZbIlffUQ3bXr2AOCLdijWD2o8mc5
         +bqHBdjkwaXUxgm9UDvV+aNAhb3o0PtE4HBQDQKdqShX5KOtLq2etvcwKDkU46KxB7gQ
         Fz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764652329; x=1765257129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk+CkeVt6vIORHD5FrSK0jxLpo6cDXbgc2E73tBRSUI=;
        b=ncr6DvAKWm+LC6OyAJcPd6Rar3V571FUa62ckwpAxTC9ftBKEsi2HYynXu6RcNASWb
         QDL9ff8lNgqs1AheeE7mKcd0ossCdRNcF/fLfBp4x7iHqphTGCKQTGPBkwVM80EGNnwu
         8RtaJ18F3xjqLLDsOgZ1bWQvrquEmnuM7cdC9qvoR49U23n5RqLaxL1nVpWKlyR+fQ1L
         teScYlRVKrycRCk1Pkza3nCKvChUNQxgWLU5ZzW6hBcOAoC5WHYiVnEX0+WwvyowAvYa
         Pqw580DzFlxByTER4n6B5aFPJ4fIOS/SL96wn1ppj1kGNeItiyQtdaoimjbqbsIpWBOw
         Gapg==
X-Forwarded-Encrypted: i=1; AJvYcCXARQNPhqk7jF9eM9xlkbVqN8t6HEEfSt7HLCoI6qvjtjfxNh8261Zdu8CTCXqNjBNOXgVfq1XYFjZXNQy5@vger.kernel.org
X-Gm-Message-State: AOJu0YzkcnKuRrjvJ7gig1aQNsm6b2zuhan9MnZoc3P7Fp5xR8ITnpKQ
	KLkT25MWIBhhwKQrLRnqvVtBrWAcnX5E47hSX8+7taRzpQ2wt/adIE54ZxIYMliJqcGDfFFnJYR
	E8ltbsWzrsEg+kymHnjKotyRCO/Vbv8zQ11fxe7Uwq7JEwI2L8dT6AKEW+Jo4eCcQwtE/b6p28j
	c=
X-Gm-Gg: ASbGncsgFmALXLl4IcIrxG8cucLGlKG/P1uJYGwPvCLzirwjA9wjMd3Wx5NzzVgRym7
	Ppc0fXZDMxlDJRy+3d9Jtcu2FrMwGgt/FYXd0NXWmZ/Qgho80EKwy6tyPYcfDqKAnFwMzXcO5+K
	qgatLr3fylrOIE0oZRkqlexUe818TUzwlnTA1+4NCwZNHci+YX2osBbQR4qHTTJnMEO1JJcI+u6
	Qz/hK60edn9VsNUarJJR4NBzhJyAuTxDbQKDTF1qIiHniaQXHSy1xKrdpiTWgP+PwsLePjclrNf
	XeU3nJNmkN/FBGgJHH+aPnDAxxfzio+AbOe86RuaeAYyFSEO+Ly0iUDi4JE/t1NsvKM7MFXZxil
	bGVmuqhzdpIywy0rOT9kuPnyq0TfAeiJuYEb0+MF4tOA751cQ8A==
X-Received: by 2002:a17:90b:4a4e:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-3475ed515cfmr26384116a91.23.1764652329130;
        Mon, 01 Dec 2025 21:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHux/qd0DXAzACnKqI92pLYuMfCCxCYJaKOo2Zi7xT1CdUkxKWNgLE3HB77yVmOBRmOe+dtew==
X-Received: by 2002:a17:90b:4a4e:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-3475ed515cfmr26384080a91.23.1764652328684;
        Mon, 01 Dec 2025 21:12:08 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a7e8b65sm18598669a91.17.2025.12.01.21.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 21:12:08 -0800 (PST)
Date: Tue, 2 Dec 2025 13:12:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v2 3/3] generic: add tests for file delegations
Message-ID: <20251202051204.nm2oplwits7lfq6z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251119-dir-deleg-v2-0-f952ba272384@kernel.org>
 <20251119-dir-deleg-v2-3-f952ba272384@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-dir-deleg-v2-3-f952ba272384@kernel.org>

On Wed, Nov 19, 2025 at 10:43:05AM -0500, Jeff Layton wrote:
> Mostly the same ones as leases, but some additional tests to validate
> that they are broken on metadata changes.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/locktest       |   5 ++
>  src/locktest.c        | 202 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  tests/generic/998     |  22 ++++++
>  tests/generic/998.out |   2 +
>  4 files changed, 229 insertions(+), 2 deletions(-)
> 

[snip]

> diff --git a/tests/generic/998 b/tests/generic/998
> new file mode 100755
> index 0000000000000000000000000000000000000000..5e7e62137ba3a52c62718f9f674094a107e3edca
> --- /dev/null
> +++ b/tests/generic/998
> @@ -0,0 +1,22 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Intel, Corp.  All Rights Reserved.
> +#
> +# FSQA Test No. XXX
> +#
> +# file delegation test
> +#
> +. ./common/preamble
> +_begin_fstest auto quick

Same review points with patch 2/3. And I'm wondering if we these common/locktest
related test cases should be in "locks" (refer to doc/group-names.txt) group.

Thanks,
Zorro

> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/locktest
> +
> +_require_test
> +_require_test_fcntl_advisory_locks
> +_require_test_fcntl_setdeleg
> +
> +_run_filedelegtest
> +
> +exit
> diff --git a/tests/generic/998.out b/tests/generic/998.out
> new file mode 100644
> index 0000000000000000000000000000000000000000..b65a7660fea895dc4d60cec8fabe7be1695beabe
> --- /dev/null
> +++ b/tests/generic/998.out
> @@ -0,0 +1,2 @@
> +QA output created by 998
> +success!
> 
> -- 
> 2.51.1
> 
> 


