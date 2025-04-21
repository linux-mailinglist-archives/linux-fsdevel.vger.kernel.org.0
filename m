Return-Path: <linux-fsdevel+bounces-46845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD494A95755
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 22:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCC51895B05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 20:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0901F099A;
	Mon, 21 Apr 2025 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="prawIjD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCE1F03FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745267218; cv=none; b=smLgEA1n5ds2KN4vWDdLXohNM4C4sAkWfdTLSBN+6xplLU+umfR8BNc46b2Nik250E8blvZENgyWER7G9FiBEenKye1VimHXIF0XRXgKR/qhPEmLXBBOXqA6c6J2u9FBsWG0yHpQzYU58u/JyZb9L88PhrCtuGCFrfzPRrEWFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745267218; c=relaxed/simple;
	bh=0Il5DIxkHUlQAJ02+NZuaa0zOFehAsnBIIGXY+F0YoM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c7V0Ol8cYzoIKXnCL+wWuJGpCRKR03DsdgP4GSyECnN7bheQc/Grb1Q3Yq+bb5hvxsCKsUWgC+mnpwW118Y2KaekvH5bPIQxVWPQgANFcVKAJ930H75KCNfXgcWzZOC7UleQcNF/WiL9AztOwx5QIYa4MxeWh7IvaI5UqlKcb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=prawIjD1; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85da5a3667bso102133839f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745267216; x=1745872016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27BMHCOECTISQknfVB21+aP50fShNvTjKGAStee4Ri8=;
        b=prawIjD1QVwewF3haWXcCJzV1SNsDVPJgLXIJOmBmF6upuJ9LBSqTFJuMGvY7ngfkf
         +cpMFn7WCUzE0maX5kY9ty3gnowQgAhZG8LMi8//9YoDnBdaOM31m20QwzOItkrsxe/l
         OlwjFi1NR+uXI9k5NRWRZsqXSqyhZUyMsdLcThubgZvPT9dh7C8Uw6LED6fOQhw1FtfM
         j6joe5ZRRHUdTAa7l+BXeiQ+qPapIf52AB1I1njrpZ2CbpA15dcHk3y67gAIYiLbi27Q
         xOw6Lkw9bS4/eGGUZUGaDQQ0VonLtwuJw7IM5mCnAQ8Q5Sdp2aqWX2bybNwwh7PnsxLl
         UYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745267216; x=1745872016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27BMHCOECTISQknfVB21+aP50fShNvTjKGAStee4Ri8=;
        b=isYPlSuBvZm/61YXRZkegBjmLi038awlWNcDMX/akHdHZzcJYIeonka9kcwJ9ENPCB
         DCfc2OQnuGN7PoEbce2zz8w5EdxClc4OMw9DCYT1FmRtkyoRpQw/cKYPckefqU8U7nUJ
         hfaTwR8pCs4E+DpbsRRRlixYFxo/V1i7WJ0eWM681F9pI5lFsQb8BmF1d0iEOA9TK8xd
         FdamcbMD2MHs54bAg//ceLTQ+j9lcYUSYJHze94WGltNeUea09URrQtLuSgtUFtED1m6
         MOd+RpOJ8VHeNqluenAZV1yCFyOMk8kY3a4rY53ol1YVtMglKf+B7WsoixFq5qvUHwSi
         xhJA==
X-Forwarded-Encrypted: i=1; AJvYcCWugJsGLrQZYGtSp53NMFzRlIhKTAhUnIm1NdHO7gEATfdDdS/tCKQA3C3zYRTvwmygv/O8Pf7gBaJFKQ02@vger.kernel.org
X-Gm-Message-State: AOJu0YxuxWMLJhYILGMZCC2qqDa1eX0wDYRq26snxeuo6PS5pnIfMpdi
	Mi1ivTg0lahjsQnynMF27svNnc5n0pKeOF2+GUC/vqqIEM4wgmkvmT776TgT3r4=
X-Gm-Gg: ASbGncuAvH2MF5MXdmC3QFlO/pBupaYgU5xofTLFsu+sUU8V5aQ7BvZb5EXUPwK8HtE
	VT2DXQCLVJLCBBMKXKbB+eYxGYOML3aD9lXKtZC19md2HnuX2JiLtWjKl8frasAbCCwdkL7kTnD
	xX5S9p2zHlNzmhvFnh8sRzOlFw5TJK1GKNFw7qCs/C8zLevTm1FudGyUw9WJ6TihN5xomBKaFYK
	7gHJI+DDT3Z5H2djmMIXzJYZKowiUElUAtfUuZ37/MehXMTz9yTGUXVe9y1aZTlIfvWJJu15q1l
	sfn244vh9eZrwVWmFSm+g9xRn8w2I6nyHsUe
X-Google-Smtp-Source: AGHT+IE7KKLn+SFyCY+1IEN5a7afRu8xJmsf5Z2+0F8SZS3ynBRzsQqJHYmOIZ2M/pTqQteS9q/67Q==
X-Received: by 2002:a6b:f106:0:b0:85b:4afc:11d1 with SMTP id ca18e2360f4ac-861dbdfa62emr897863439f.5.1745267216383;
        Mon, 21 Apr 2025 13:26:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3933d67sm1928559173.86.2025.04.21.13.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 13:26:55 -0700 (PDT)
Message-ID: <98e7e90e-0ebe-4cbc-96f3-ce7f536d8884@kernel.dk>
Date: Mon, 21 Apr 2025 14:26:54 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET V2] block/xfs: bdev page cache bug fixes for 6.15
From: Jens Axboe <axboe@kernel.dk>
To: "Darrick J. Wong" <djwong@kernel.org>, cem@kernel.org
Cc: hch@lst.de, shinichiro.kawasaki@wdc.com, linux-mm@kvack.org,
 mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 willy@infradead.org, hch@infradead.org, linux-block@vger.kernel.org
References: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
 <8cb99c46-d362-4158-aa1e-882f7e0c304a@kernel.dk>
Content-Language: en-US
In-Reply-To: <8cb99c46-d362-4158-aa1e-882f7e0c304a@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 2:24 PM, Jens Axboe wrote:
> On 4/21/25 11:18 AM, Darrick J. Wong wrote:
>> Hi all,
>>
>> Here are a handful of bugfixes for 6.15.  The first patch fixes a race
>> between set_blocksize and block device pagecache manipulation; the rest
>> removes XFS' usage of set_blocksize since it's unnecessary.
>>
>> If you're going to start using this code, I strongly recommend pulling
>> from my git trees, which are linked below.
>>
>> With a bit of luck, this should all go splendidly.
>> Comments and questions are, as always, welcome.
> 
> block changes look good to me - I'll tentatively queue those up.

Hmm looks like it's built on top of other changes in your branch,
doesn't apply cleanly.

-- 
Jens Axboe

