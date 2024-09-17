Return-Path: <linux-fsdevel+bounces-29541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22F597AA6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 05:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67AF31F286CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 03:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F22C18C;
	Tue, 17 Sep 2024 03:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KEmhaphZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51F1DFE1
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 03:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726542727; cv=none; b=B+V9qyTX95dO3ddun8ZnJM8a/J8jWgUEK37nW+QDiXhYc0OIDjDdz2IzsWjSLFSGlMX6mKetH1i5LA2r7HulgMUhL5QL3/5skp8dPbrv+UzEPO/2xzQAxrEkjuI0ZBUnFt/jv8vFF7tw3BzKJCn7wTWf3Tuuwt9mArYBf9kZ60E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726542727; c=relaxed/simple;
	bh=d6RUdXmX65JlV4ifds0THcuSzXzdxdkkt/pSJg4W0v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvckCHihnr/XVdO/Azzvb7fQtSrOt6RiWfHKWINtH7mrpxcT65hjJe0CZTp2t6dDr1EM7j0W/1LezLDXHslZHd1ZEHjdmwpLY7b7vIaeQJSGzW/CfZARVUFiuzuPrDihEKAwRYD4qys8PGihI6LMD8YxoNGokrdMzRFLIO4gd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KEmhaphZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cba8340beso38101945e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 20:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726542724; x=1727147524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pndO79yIEXi5D/T5Hiw5+hSCMV+JnoiyMVBfXesV0SY=;
        b=KEmhaphZtzMaBqdSlrH8S0d/XBDTrJ4JN0dEaado+hNrdc0aPYTs0foGkxuY+hW75c
         CWsy/v6tfXPujmLeWwJea1enao+wbWLTwWkJq96z1beLoQhPxRyV69j8c9TlmQXscMbZ
         iRJHOoxbrgVO9eF1kOjIokqR7JBPqD/vRNltZm3m/BPh18E4ldd0iU1OfH0lJ4+0sHhB
         wtufrHs546NX5zVUBZwXxWUYy4jYgYWJ9sPH2bMHANNjiH49GYqhNLi0DtcX70dhMkbv
         f1eSzeoVVALcszgoQFYmS+PU2FFmHD64fakEJRkjTUnZihd7lr/94KfqqaKRmLVMO+vv
         6whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726542724; x=1727147524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pndO79yIEXi5D/T5Hiw5+hSCMV+JnoiyMVBfXesV0SY=;
        b=RRSU5LzDTICLa/QwdVA+7L5Ow09IlHBfQZHCNYgcEwdVgLPseoYasFEkXMt1035WtX
         VepaiIJyFIPwNJfXHJclDQ9A6mPlSSycX8JXsB5EjJAz4NoCgieit7FEGr7ByDmLikvK
         agrZ55OekARpNGIe73Zcou4FzLwA60UCoQOv9TN17wBDe5Adkx8u0lSQXB052HQcIonV
         MtBW1QzRrP9zcdaRecA9EUGjcySExHglQN6lE2CpBW+drtHZj2Ce17hxvx+XcMp7Eemc
         e+pwgi8bSZwsjIjETd4eaYxFRm/E4zAohIiRP3VkGtOG+p+NjZeLo9jyy9V2HmUy2vBj
         G3WA==
X-Forwarded-Encrypted: i=1; AJvYcCUc/NVEHhfJn2Mfg51cAVymBVhuH5Wr7ck0IItl+PM+JL1UEQs5smd35eLK70bEjyiDfKVCycx9AaESgeln@vger.kernel.org
X-Gm-Message-State: AOJu0YxJOIA5UUU+fWTF/Lf8aGljMENkCw4vWj6MlvrVql6tLiZUo0Rn
	lwPe7gQuBJro5gw+kPeKdIrWze7wCXKbgS9xRDzTOiDResjJq4/IQ7eNCSoDDT0=
X-Google-Smtp-Source: AGHT+IE3x6M8kqDP9HN0dSWPfZr9uevVahP/pokENG4Q7OcHHF7RCwUkr3dTJyAmWCiqUjtzbd6T6w==
X-Received: by 2002:adf:b50a:0:b0:374:d130:a43b with SMTP id ffacd0b85a97d-378c27a12cdmr10392856f8f.4.1726542723772;
        Mon, 16 Sep 2024 20:12:03 -0700 (PDT)
Received: from [192.168.0.216] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805185sm8417966f8f.96.2024.09.16.20.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 20:12:03 -0700 (PDT)
Message-ID: <68e8c574-1266-42e1-9d0d-ed837c7105b6@kernel.dk>
Date: Mon, 16 Sep 2024 21:12:02 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] block: change wait on bd_claiming to use a
 var_waitqueue, not a bit_waitqueue
To: NeilBrown <neilb@suse.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20240826063659.15327-1-neilb@suse.de>
 <20240826063659.15327-2-neilb@suse.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240826063659.15327-2-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/24 12:30 AM, NeilBrown wrote:
> bd_prepare_to_claim() waits for a var to change, not for a bit to be
> cleared.
> So change from bit_waitqueue() to __var_waitqueue() and correspondingly
> use wake_up_var().
> This will allow a future patch which change the "bit" function to expect
> an "unsigned long *" instead of "void *".

Looks fine to me - since this one is separate from the series, I can snag
it and shove it into the block side so it'll make 6.12-rc1. Then at least
it won't be a dependency for the rest of the series post that.

-- 
Jens Axboe


