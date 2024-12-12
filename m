Return-Path: <linux-fsdevel+bounces-37230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1D9EFD55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 21:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8667A1891396
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCAA1DE2A9;
	Thu, 12 Dec 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FTtJkKzc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8241C1F2F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034776; cv=none; b=nZ/JjuwXKJf+IdRw6qIGiy+s6EQx3ZV5d1zS/RbwFHad4k0m6ojSmuSaVQazQt7rS5oB5fjiztNTVHol972xwfHEegp11hT+D3Ti27WECqkBooMdojNogwY3BzQLvcLEdkvPaufu+uj7kXGw5hrzB/HrlG57/a5HstDiU96+tKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034776; c=relaxed/simple;
	bh=bxNToVr/eEUZvLdB9CPyWXMAoqLRgngI0FOKeD8wqT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pW3CELFXiqEvB1xzuAzNHaBTil3DoxaJnM6HEwiWwvDC7ztECW/VLVIyqfq7j4dKoUQjCWyjCrHjvKn+t5zyDeznomyaFZyGQOP5tQkQhvt/WV0mJqiuWCYqDWuyAeTfzLm5MhsYNTUNfhnaWkoLhFK1wSooAOXieq39jEZW+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FTtJkKzc; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844e39439abso20287239f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734034773; x=1734639573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amQilKkF88h59kyKbvwGPPw4Lr0cJFGcTEeJ1cmutA0=;
        b=FTtJkKzcDmaDlX65b0uV6iIotPhOKVWWNgKLqlcbJ3YC6LJfWlfcaR1cnJJd7FR7AY
         qf5i8g5N2Gb2vqKWG6IoZR11HT3J1oj68Jh6Idtq13vaFkNULlHHGEddKc7CLjpAV26l
         5OlrPJU8l1wxmkyHq/KCjfmdJ6Qkgcl1eFPpXmipkU7dG8P6pI4gb9xS48JtfMscVpQo
         Ru8oVSl22vBOSKAvI4CMLNhGzRrdL1Z6xWHgGVn3imXIkDeqQCh0si4yuO3Gl4zcUje4
         kdWn0/dYCa6fPTG4LegIQNW3IBIfY70vCF71fLRVtRkLdRACvY4i3rPLxTukvigCTaQ6
         dv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734034773; x=1734639573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amQilKkF88h59kyKbvwGPPw4Lr0cJFGcTEeJ1cmutA0=;
        b=oocRmlmhDgQM5faXS/10gZzZd4eLmHi1yQXfABWGWN43JB3ZyToSY8htLrHGpfgcMP
         fhY8kY5JrsDFFrqpS4eujhbla0tQeHBRNlXDvHvTbx/+MNJqRJ4NmfNDTeYsEOe42Nxz
         xnOQsivkf5ELjChqXMwFEkXn2WAoohMOnIpltQ+SKLbASdWEaHoLbj4UDi05esQgYNOg
         pMg6Gb3Ux04+dVpJJQhKEaJN0JWXaDr0+/62zKtRs+2rKRZesMZGPVPd/sgM0eljfK3v
         M2MoywjyKgCK8Hbko0RwVgx2lpIi5bqz2XE93dT8r+H1LiDGV5NBnR9vesEWIti26Pnh
         +MUA==
X-Forwarded-Encrypted: i=1; AJvYcCUAV6MZljRz1oarnt9E9QhLGkR6HhKcAY26xGH9bc1DmnkmHKFi+Yhr6hOkxgbe8D09ZH0UdGl4QKYvInNm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8V35tdbHU7asNR7wD1BiyrCpvRAw0Bn0D3HJUUGHnp8Y4EoRR
	PEDCkN4Hq+NOKh/EdiCFL12HV6TbZ3h3rmGsWbah2xlA9+5WiN7gw2Rzquvwq0M=
X-Gm-Gg: ASbGncs0PwKxWHpooAenDQykiD4AhmCqiDPTnM4121jCNOPFihCyr+3xHPe4POkvwNR
	t66ydmG3867OQ/gmm28gFgk/28Lgr2cKEX4kooTou+i+HcjgSt/elchhG0E+5F9SCANn4VRYdMP
	AWqC6vAoeW2nkmmtFoFE3MrRyTO4ua3/7CjoUtNO2+kE7xn/xSGheXqgyDGVCWe5G5XdYu3+jGy
	KmuqdPafok2hrrF3ncGRXdlsnezKNxjeLDCMAnA5jqFusaxaZw2
X-Google-Smtp-Source: AGHT+IFYch7UbRH6nqpKWr2p6Fzhmge00pAqGBgdIHbczzkzMGdbctA/OntbbR3AfoqtbufuALu+LA==
X-Received: by 2002:a05:6e02:1d03:b0:3a7:c3aa:a82b with SMTP id e9e14a558f8ab-3aff62132bcmr2335035ab.1.1734034773169;
        Thu, 12 Dec 2024 12:19:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm31018885ab.41.2024.12.12.12.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 12:19:32 -0800 (PST)
Message-ID: <c0fe9c00-f9da-44ce-a339-c36dbab25c46@kernel.dk>
Date: Thu, 12 Dec 2024 13:19:31 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] mm/truncate: add folio_unmap_invalidate() helper
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-8-axboe@kernel.dk> <Z1gkNiD2wJbAdOfr@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z1gkNiD2wJbAdOfr@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 4:21 AM, Christoph Hellwig wrote:
> On Tue, Dec 03, 2024 at 08:31:42AM -0700, Jens Axboe wrote:
>> Add a folio_unmap_invalidate() helper, which unmaps and invalidates a
>> given folio. The caller must already have locked the folio. Use this
>> new helper in invalidate_inode_pages2_range(), rather than duplicate
>> the code there.
> 
> This new helper ends up the only caller of invalidate_complete_folio2,
> so you might as well merge the two instead of having yet another
> invalidate/unmap helper, which are getting impossible to track of.

Sure, missed that it's the only caller now.

> Also it is only used in mm/, so add the prototype to mm/internal.h
> insead of the public pagemap.h.  And a little comment what the function
> does would be pretty useful as well.

Good point, moved to internal.h instead.

>> In preparation for using this elsewhere as well, have it take a gfp_t
>> mask rather than assume GFP_KERNEL is the right choice. This bubbles
>> back to invalidate_complete_folio2() as well.
> 
> Looking at the callers the gfp_t looks a bit odd to me, as it is
> either GFP_KERNEL or 0 which is a valid but rather unusuable gfp_t
> value, but I guess this comes form filemap_release_folio which
> works similarly.

Indeed

-- 
Jens Axboe

