Return-Path: <linux-fsdevel+bounces-22520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234A5918522
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 17:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE44289174
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BD71891BD;
	Wed, 26 Jun 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bXchXX1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0241891A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414151; cv=none; b=pNLmyxcNNypBpxHBq4XIraD6Mem3ZoThk2qdcpgblnGieOMFVyJUN6zo1RJ+nEMIup9evJnAiAI8MhBYIsxd425JXsOa95hQzULqk6hV+V4NV2syB6pDg9FMQPR42D7WVpys11gMggXQ+4JBW78JCwA7n4r8HeB9y2Qc5F0FEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414151; c=relaxed/simple;
	bh=IgNBlbOpf1DxNT0twqhMkos/RJG5o9tckGzN741UmLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkkQ5WXlDMnWqCK5I4Rhtq3c4cMRy3zuSkJXd/kUwajS/kaFSmRzuQ3kbbCih5JfMF9+uUcET4U6qHbp2NsywvCFnh/587/jO5ZVrea4RUedM+bEqBlcXj713M0TDFnVRD/qh08AVa4rn16XiSmYNIRuvZquIAqYq8RuIx0YziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bXchXX1Z; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9c4ec8e04so3077415ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719414148; x=1720018948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtL2/RZ3d00iaa623m8Saevl3iucbD0YDNmUEjoIQNA=;
        b=bXchXX1Zl4sAmDe606RFshQr0LgsIiT1q3WtHbBNA+8jV2Seqw56ICEH/1Vv56pyww
         L1tLWtH3MUTLt4w4U5QSN4pfG+t8DqizqTW4Pkb+CE7xLMRg/HB7WFEOoNbEPbTgQKvD
         zk4r6yB7u2gGGXdTuxeghO/nZ4J/9HJDG/iOfYJURpmZlGUjePCAaixQ4rJ6RqNAES/y
         tE172yrHiiX8D+pCQYHO+JPCmaWh0r0WmY1Vjw5ZEyQmE0LsSYnZ+qMOrAirkuhPosWU
         1pU7gdj1LlkWDgHLF5ta3WnpBilf0KXEI4mwg+U0Icanta6WZU7td7cOWpcxUjF9z5LV
         0Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414148; x=1720018948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtL2/RZ3d00iaa623m8Saevl3iucbD0YDNmUEjoIQNA=;
        b=n3QxwZ0ChOWAbimqKMAzxvDYRapeycUrG41RehQQsh2V95J82I4ajDAytoXA6ZlCvj
         sfTtAuyqbpcxZdJfl7upuNvweR0zHjvchScs2PSlx5uS8CR5/IZBHpNcDyfJNfGAecvz
         Hulp8UH2xKu5HoI9MpXDX5vwNbOGFTNxiAr1UIMEEPSFLNgOIRMspRdNV39Lh4mkvPdF
         OUUgZ1FrJGUUoU3GpuOYEutm5TAeAOVXmR80sDaazeAWYCUbd529cUEWie3E0ZgGzE3G
         MQBnq94pHS5MZgpeXuihYp48w4yHiUpEAUAkNZwvSk3lNmZEAqynzhjDDJEUNgGzfZt8
         8Qdw==
X-Forwarded-Encrypted: i=1; AJvYcCWEgKt35aiQs3yi3RBzjdmou7RK3pkWcjVAxoqYyHWWVnO4ezBzP//wJ7jrT7K7Q7E81KPKHIewll7BilW+94w+KmZfXYlvAamPLllVCw==
X-Gm-Message-State: AOJu0Yy+nwyyykksr6qZ39yvYSgLF3d6rR/QfdAmz/HtM+3ZGhdgDgCy
	NCgSbYxH2AHgomi9SgQXRymM/bUUSl4rXPEikbZ6uWh8hxb0KAZKd1Kgt4W1UnVuvhAHJj9SmlH
	JHZE=
X-Google-Smtp-Source: AGHT+IES7/6m+LnbNG2Wez/0xukcHO3azrcRyMBPgOedLXHcq7TetakMG8dgyHzp5CKg6I5TQ+b1+Q==
X-Received: by 2002:a17:903:94:b0:1fa:1a7c:9a05 with SMTP id d9443c01a7336-1fa1a7c9d36mr124122535ad.6.1719414148374;
        Wed, 26 Jun 2024 08:02:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb32b9edsm100519705ad.118.2024.06.26.08.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 08:02:27 -0700 (PDT)
Message-ID: <0e2da871-7e28-4660-a9d4-4fbf6bfe24cd@kernel.dk>
Date: Wed, 26 Jun 2024 09:02:26 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
To: Mateusz Guzik <mjguzik@gmail.com>, Xi Ruoyao <xry111@xry111.site>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, torvalds@linux-foundation.org,
 loongarch@lists.linux.dev
References: <20240625151807.620812-1-mjguzik@gmail.com>
 <0763d386dfd0d4b4a28744bac744b5e823144f0b.camel@xry111.site>
 <CAGudoHH4LORQUXp18s8CPPLHQMi=qG9aHsCXTp2cXuT6J9PK6A@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGudoHH4LORQUXp18s8CPPLHQMi=qG9aHsCXTp2cXuT6J9PK6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/24 7:39 AM, Mateusz Guzik wrote:
> I am going to fix this up and write a io_uring testcase, then submit a
> v4. Maybe today or tomorrow.

Sounds good, on both incremental and test case. I can just stage it
separately in a branch with Christian's branch pulled in.

Thanks!

-- 
Jens Axboe


