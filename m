Return-Path: <linux-fsdevel+bounces-34095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0F9C25AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 20:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B7283C0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE0D1AA1FD;
	Fri,  8 Nov 2024 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FQWfElQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A998515C0
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094793; cv=none; b=cqpFFmnXvHfiVtLzzB1QfIMpVMAXo8zLDhO9vcWoEgFa+OjhkwC/lY+Oq0i09diyT3HVlXbcWJ0zoN6IR8NwjJGVKKfH7mEXMjmSyuyE59AsGZNyoMLh2MwxY1ivvbI/Jz7TP+oEO1W2VqduLfcD72rO9bO6Z+GMPP/uBDG1fhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094793; c=relaxed/simple;
	bh=ACJIA0sqIQ9XQMuUSUlwosVy00j65iH755TUdVJPLpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k167zdvw3BxXZ5ie3kLn+brfOlKruaS3LvOx9BlSWf4UgLTqN3Qquy7aZiRIDc4bRBOBXReLTXZFt4C+lvFaE7atdrYtsxH3z1F8RAsSyG8Pca1Ivv1Ix5o6fFIbxJ/Ns8TfSPjB1Qn8RCB9a+rqRvDo5/b9cEO5GdgKmb5vXFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FQWfElQA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7f43259d220so794388a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 11:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731094790; x=1731699590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwmZsfFFbi7cobcL9jxcusnRbLSuEsEWqsjcIRuLUfM=;
        b=FQWfElQA9p7/ow6WMB+aBCPUHuSyz8omKO1Pfh+rvlRD7I6DP2q0SzETz2xylCe3gf
         cynAZk66rA5AYkvuI/QC8F2h5rFQBFw3/J28i7lDdy9cGagYXSWzylriFvVgmPeFlFuF
         Rc0PhAJV3q2zcNeu+t/m3AKqVjwDMmYJEx42rX+AuukFj0QvC5d4kmFVLuIlSUlOFO/D
         baz88p8Oa3ZAX+2KwHPo88ZdO19sx6i/uPAeOAQLh+kr+i9h1tgPz4YdHBEu2AQxNlMd
         dBkdinxTL/8391IzdvtzNSxXv84ndULdza97k3/T4PcrscYM59Vy+3TnuzM1kxb5xhH9
         TsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731094790; x=1731699590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwmZsfFFbi7cobcL9jxcusnRbLSuEsEWqsjcIRuLUfM=;
        b=O4Y8uK1S7PwEwSLgus7QW/oYp34bl23Fj0rVGH00v3c3QqxyndmzA9yu82ZAgU13HI
         N7Ig576ZqL71T1K88f6drK8h7awS9KcVOx4os6nOT1yrEOsZ4GV1cv+OR23FJKudwuu5
         khpaR1tpy2TXtX1Gx4C6eoPpNcbNYs5sgqmkeaISc6QMBg6b3ER9OJ59ZByTsm7q1zyX
         54MCTguuATVUYXHv2OKSRHLJgZM18H0bLNwPx19D68JsoAwoG4amK1OWJZaPiL0EGU7h
         zic4JJGsfdtqzbAupNj2OLY+UR/P86rKRNeBCjc9ZJRw2i8NSLuZ8XoJPEvh0LHCzSP9
         Y8aA==
X-Forwarded-Encrypted: i=1; AJvYcCUWjJDurDX12ZQxN9ZIacsnI4bFf1G24S2SNa1aL8tYaNDCyLZK9f6GUfC0uBsQ50r4QFw6A+42lgE5q5Oo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57r2ofU7yshr8ZaqHZhn9eCcpWJle705FaCnrUBCRaJ+0aYd4
	1yckE8sxFaMtfxll5V1nSC6ErjUhVEi436kulyHrEkR9OOlugYf+iz5Nrp9zSsA=
X-Google-Smtp-Source: AGHT+IHcBRCBpDW3TBXViEBFHUC8FpAPlT1eul9WqJ4zQOOWKW0wvckZZYCnbg3TRo+l3/XzG/VGIQ==
X-Received: by 2002:a17:90b:4ac9:b0:2e9:4967:244 with SMTP id 98e67ed59e1d1-2e9b177352fmr5324433a91.24.1731094789997;
        Fri, 08 Nov 2024 11:39:49 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a348dd6sm6081261a91.0.2024.11.08.11.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:39:49 -0800 (PST)
Message-ID: <75bf5237-efc4-4fb7-9e24-061354bff9ac@kernel.dk>
Date: Fri, 8 Nov 2024 12:39:48 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] mm: add PG_uncached page flag
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-4-axboe@kernel.dk>
 <u5ug67m23arro2zlpr4c6sy3xivqpuvxosflfsdhed4ssjui3x@4br4puj5ckjs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <u5ug67m23arro2zlpr4c6sy3xivqpuvxosflfsdhed4ssjui3x@4br4puj5ckjs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 12:25 PM, Kirill A. Shutemov wrote:
> On Fri, Nov 08, 2024 at 10:43:26AM -0700, Jens Axboe wrote:
>> Add a page flag that file IO can use to indicate that the IO being done
>> is uncached, as in it should not persist in the page cache after the IO
>> has been completed.
> 
> Flag bits are precious resource. It would be nice to re-use an existing
> bit if possible.

I knoew, like I mentioned in the reply to willy, I knew this one would
be an interesting discussion in and of itself.

> PG_reclaim description looks suspiciously close to what you want.
> I wounder if it would be valid to re-define PG_reclaim behaviour to drop
> the page after writeback instead of moving to the tail of inactive list.

You're the mm expert - I added the flag since then it has a clearly
defined meaning, and I would not need to worry about any kind of odd
overlap in paths I didn't know about. Would definitely entertain reusing
something else, but I'll leave that in the hands of the people that know
this code and the various intricacies and assumptions a lot better than
I do.

-- 
Jens Axboe

