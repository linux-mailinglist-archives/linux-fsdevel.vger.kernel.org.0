Return-Path: <linux-fsdevel+bounces-50370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5AEACB8E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 17:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E951164111
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18822258C;
	Mon,  2 Jun 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Z6OMPFZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA451DA21
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879401; cv=none; b=iHGxRBeKo73Fbwi7EzXlNtlSmL6zRYKSj5s75g8uKOyNpLAbPhCYpCzCyu96bsF9vvq3xN5RDS7uEH0fqqUAtWfk4Wi75ClJXvnDncFOE5kr9ZQWFx5sncCZKEFXmeonSH6WiFeiX81AJmDVl6Zv3vGsWBPGKint5Zo/Wa3LLR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879401; c=relaxed/simple;
	bh=tczUiRjlTp3RwmOBy9AYBDcovS65UpjfipjjReW8rfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxBdkbv7HbhnkJ54ghzVXpemmJASQpLWL0zykwqosZB70+x08tZ945ioHJNcBLvtcNcWIbQSpp1FubF84VaDVWxd4srE/pOqWW5R6S1zP7Sd+gKcQ8XM2WNdg9cgXjzuSpURu0z5zAoxwmsQv8VYWbTJpREUhlvB8oT2CaOyZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Z6OMPFZp; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86d00ae076dso81665239f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748879399; x=1749484199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H6v19i7kKfVrC2Xhb2Emo+ZHvGgRU1zTVb1f0prv7kE=;
        b=Z6OMPFZpJ3Ae6Rh52A7ay0iMKw/lsHeXUKHoK/LtPV5LeP83kVSo7l3gPg8znQTJa3
         6v6XAw5NFt5Ari5U4sDWqeC8VIV9mmsddxEAubohQb/ahXUxVhIU8eTK/A/QK8dKwKZz
         qXRZoIaNitvfN4H+uiBJZcbSq9v1YSsK3rXjWPbuWCinnn+Oejvn96QWDXXYf53FRMq1
         kxSkSKMaK3xsfAmznVEZgPpXgRhwrT0fI59Fft+o5jtSNCn7G64TG2sTLtNJzs7lpU03
         1XPczlONo7qGf9N0Wf+Hm+yalYonk/Gytmhn7Yr/EZP+aK/TjPVByXfrdFXKl5ZOzn/d
         Cwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748879399; x=1749484199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6v19i7kKfVrC2Xhb2Emo+ZHvGgRU1zTVb1f0prv7kE=;
        b=iypa4X57BO7fpxtDgp1ogN+HYJekG+11iI8UyG/XnchYRv0+tXyWXMQUVdFCAJTeRV
         uMzbFlmWI7GHGTz4XHU4jO/Ga8y7mj/gY7sQU/2tkgEXpUqUH+FfhsrUBz50QcZn/EV3
         95c0ma25ak0fxKnZ259NydmSgXau5oqLncazo3oW2vcryySvT63XwbjOYBcuxPBIhwsj
         ylfMAMy9vAEB5GYIkHTn92pZff4Qq/eM7kiS6X7NpQDVd0FQ9okg4PYliTH29pcHLRPD
         bDhPfRHKyusrR9YqxFaI4huENJsozixHyuQAPQsVzOLmsGdVk9tC9M1z7WWAiVx8MAu/
         HhYw==
X-Gm-Message-State: AOJu0Yyh16kKuy9mLsqTwMO7IHnIXIfMBMW0z9E+PwMwNynWmNqYLkem
	hwgV/F7rvkJ7C1Tg64dsHn7g2L/NT+J7cZBO0jgCh4UxVx8j0tRCANrNiqTmxf56+Q6URDRSUgW
	/rx1P
X-Gm-Gg: ASbGnctziSCW+o2rEZoTY+pTbeZgqPpf+o4v+V0HJZP7uw+C+4E95vyhfhGHaqNynEx
	vWL9uYCQU7IEVuzmImdhkZrUh6JkE0JvZypZQPR1k3eascoRyV7c2eYo66DTbIBF7ynL3Fdyttz
	CbUW5+ECFKSVzgKbwG8S6+00JBAHZmownqL8e6jwCL/PUhpcIRDTcq94OrubFGLshzEIHmf22xy
	KH/owCS1L8dI1RkpOIZjjzI/q//tS5fGbfmfbGzoBRD0b03cSRdxwYxBdNkdEz3wMLFOu+n2j/D
	z6DJEB3SpgIdxqM3HPL8U8sekL5v21qVgyFIDItAlT8GulU=
X-Google-Smtp-Source: AGHT+IF73EFj0E6muJqVVBpCdPYgNfFOqoHv1N+n+Y6GwW8hBHOYnaxhGyPNCoPnXXSLVoPDytP+mw==
X-Received: by 2002:a05:6e02:378b:b0:3dc:8682:39ca with SMTP id e9e14a558f8ab-3dd90b97d98mr188316955ab.0.1748879398620;
        Mon, 02 Jun 2025 08:49:58 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd93546383sm21728465ab.34.2025.06.02.08.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 08:49:57 -0700 (PDT)
Message-ID: <cb062be5-04e4-4131-94cc-6a8d90a809ac@kernel.dk>
Date: Mon, 2 Jun 2025 09:49:57 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RWF_DONTCACHE documentation
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
References: <aD28onWyzS-HgNcB@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aD28onWyzS-HgNcB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/25 9:00 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> I just tried to reference RWF_DONTCACHE semantics in a standards
> discussion, but it doesn't seem to be documented in the man pages
> or in fact anywhere else I could easily find.  Could you please write
> up the semantics for the preadv2/pwritev2 man page?

Sure, I can write up something for the man page.

-- 
Jens Axboe


