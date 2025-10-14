Return-Path: <linux-fsdevel+bounces-64169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003B4BDBD4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7F23BA69B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 23:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4042E5B11;
	Tue, 14 Oct 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+sdaSm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120A18A921
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 23:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760485603; cv=none; b=C5ZxBQSKTzuOVsBkLO+uV+KCRoo1bB4i5s+pdhVf2cvTQBPuh5HbBN9SzpeVqgCCQz9KdjQ5ZpHj2y4WeqRlaIVy8UkNG0Q4aNUtqC/xVC5ZEvoiPunqAK8009QFYFeVdDnfnbSNEMrPEWy0E6mdKq9YD+1NWUQdtroJBxLu7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760485603; c=relaxed/simple;
	bh=LYVfye+2jfXWF34eSuJa02pO1di01Vh1l2AkQHnLeTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYExNpbbKQ8FMmJg46eYh1LOPjvxr13h9RGZ2pB04X+0R9Md/I6xtkogv1P/l53dSTRzqddF5dCmqeoLJ7N9zHRE11NQ8qcxLBOgc2Vz4ZgqsgsdK13x7ZpOf2Ce7XHH7whlqlsWQbBcpZbJStYmLTAdvX6t4RX3yPUkVYTDLug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+sdaSm6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-78125ed4052so6882442b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760485601; x=1761090401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vakVPAnhG+s33WW+yk2avQxhwmCtmmfNm1U+3y8SU9U=;
        b=M+sdaSm6ikHxiCKxEBWa65a6P8lemsSNKSOMi3m+0ZRisQaZJiyqX/fUsgE0fJGv5D
         wiMJRAwf2vPV8RMQH4oqsDGzlgIlpDrVdDwU7FkdBAJmwcCluNGuSbE7/axF2PYXI8AO
         2mbkqC8p1vd1bG93X4/p4yr9vf/Ohiks7HtjgODatTjWKt4VQffDTCTqQiILRJ+Hb//3
         q+sl3HYekmYEqIC1yPjcDvP/kc0+RydoUjD6NTMDGYHtgzNKnqXZVX96MCOJ+87O0xxf
         hf/CNyQHZIRYGMzpj3iVxsWMdOBr2fhP55RHxhSWVN8rQ6IekB56Jai55Ei47DoDA0cw
         jP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760485601; x=1761090401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vakVPAnhG+s33WW+yk2avQxhwmCtmmfNm1U+3y8SU9U=;
        b=GZZGSSB+Lt5SsvRJtbFzARhmYGIUB01aSg+uWgL0UP/DCjB1JRLC2vBf/qjLF+6h1s
         +pdVHWw7iWZN++MwcwnETx/Fjf80nEZ9K+R2nMllK6MgzXbiBEAhq2XKagC3hh6uBRcR
         dQ+Btvl2Dluz9BjefXm/BNK4U9CVL5gm1R/gYFDlHAP1bWfclKlU6JXn6KF5C7g5jcwO
         chRZmYEyfLk2NQmDdKJMZsOv9fr5h6HD5xmhcz6QC/Y95647s0zADU1mqSKb5AufsDbd
         OI1u4ohVN1T8L5Tbu0zp9BWY3a0fca5PbPILG5Fx2TjZYm6wW0PoQUIqbzs/Wumg67KP
         b5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCW0tgAHFM9Fb9/ciC5fGG6tEoA+/adFUiOncI+4BU1ZvYh8jHggfmqWf2yHFtcqdq9X7Za/0W3fvc2w9xHd@vger.kernel.org
X-Gm-Message-State: AOJu0YxNcRpVx0CFO2FFTma4tSwb1IB0q2EOkDIojsyvpyHv2+VPnVsK
	ELl50xrOnwTzG3nl0QPgYvVyEzTf7Rki85XqHbp4sw6NICI1hoNWj0XG
X-Gm-Gg: ASbGnctR3I2FREHYO/OWMB4I+NjyqZ0z90aRS54Ug3oRJLnky54kBRqEDCbmjBhJl6E
	8kdpl5SQZnIyj2kImGzRAKJ8byFe0Tf09PdfNFnTdroIwM9GNka3JWbuuwfurWBkjSTLgPmk+i7
	s3Hp2/qEYVLimZ4qoqprjW7oxeish9CEJL3jkK8dfEZKiaPnplHuGUb33yN1IoHJWrVYTNqduQg
	1U1BnWNu3Eb5j1tdSACXT3jvbhpIn2YHAwazj8NvzPqmLmnuSeZ/3bXUG/l1YTTAjNGAiPKy1XU
	0LUI9KygcALQtlKIEBpslCinOpflyBP/huSvP3Jv0Twfuz7lNMri5tKBqmfQ85MRMZOjydWBDEL
	vB8ZSgI8qqeFfPrPV/Fo4A/MJHcqR2TcR4e/JrBJgmxqM8FnUYcEGAeWJVk7JAeYQi0yksthdOF
	VwSwKB/qyIEi0Cx+mByNfWQQ==
X-Google-Smtp-Source: AGHT+IECtas5D0AKF7k+YfLgDtLgwNAopAU187v8QEFHEo1/tzXFB8c6NJkc8BI7xOANIs0x94HcQg==
X-Received: by 2002:a17:90b:1d85:b0:335:28ee:eebe with SMTP id 98e67ed59e1d1-33b5138e625mr35422665a91.30.1760485600940;
        Tue, 14 Oct 2025 16:46:40 -0700 (PDT)
Received: from [10.130.1.37] ([118.200.221.61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df2799esm12802604a12.29.2025.10.14.16.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 16:46:40 -0700 (PDT)
Message-ID: <5137ce36-c3b4-4a0a-83af-e00892feaf43@gmail.com>
Date: Wed, 15 Oct 2025 07:46:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] ovl: Use fsid as unique identifier for trusted
 origin
Content-Language: en-GB
To: Christoph Hellwig <hch@infradead.org>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014015707.129013-2-andrealmeid@igalia.com>
 <aO3T8BGM6djYFyrz@infradead.org>
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <aO3T8BGM6djYFyrz@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14-Oct-25 12:39 PM, Christoph Hellwig wrote:
> On Mon, Oct 13, 2025 at 10:57:07PM -0300, André Almeida wrote:
>> Some filesystem have non-persistent UUIDs, that can change between
>> mounting, even if the filesystem is not modified. To prevent
>> false-positives when mounting overlayfs with index enabled, use the fsid
>> reported from statfs that is persistent across mounts.
> 
> Please fix btrfs to not change uuids, as that completely defeats the
> point of uuids.

We needed cloned device mount support for an A/B testing
use case, but changing the on-disk UUID defeats the purpose.

Right now, ext4 and Btrfs can mount identical devices,
but XFS can't. How about extending this to the common
VFS layer and adding a parameter to tell apart a cloned
device from the same device accessed through multiple
paths? I haven't looked into the details yet, but I can
dig it further.

