Return-Path: <linux-fsdevel+bounces-68347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31FC592BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB333BAA4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7980345CC5;
	Thu, 13 Nov 2025 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ecY8Hi2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DCF26980F
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053782; cv=none; b=DXIU1VwIxT1N7mQrBUTOED2j4aycNWvZNmSmnRVb3Qt6A51kZM3HNrd41GLo+Mo7UfajCeNPMAlEwN4mOZkU6+PGxAM5IntTIgwmGNHXO6gxSDWmjXPySkLuEyG2wu0qrChjgs77bLVu8CjohA4wGXhBbG9StxePA63JFvxuR7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053782; c=relaxed/simple;
	bh=zWvynoWdw7wHKkRFjD6Lw7oxikjttuJ++aEakU34N9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zfj1NW37UuODaPTwao5FVJyDUkSZQsyf9VqNcNKcgt+ABZyMHLWwvrHz0yg34ZsYJe5eDg2Sz7aT3x65P8r4oIrHpR+XFZ8Q4zVDt8+k0PZ5v7SfT5yIEZLypvCjwpfth2Co2xvDEIMc7IRk/K5chDhjWV0mf3r24lCU44ZUKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ecY8Hi2v; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4331d3eea61so8637725ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 09:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763053779; x=1763658579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZBaFvCucR+JNZ72iqSisLCQ+iCppiPliY7657kFDp4=;
        b=ecY8Hi2vSgwEuTOeLxduHUGbbcHl9irSx6/HbCNAyOeopGNC59qFVza/jzmi3KtKRD
         yrFMgwt6CbNTtAOZelsNF5bAxJJKB21D6pamrHF3vjBCaoKu8E/jdCJcRpZ8Q9j95u4R
         LPtbmz5SjoPdxFAqDbNSv/fOH72CjtLCt5UD+H80TdpmKl4lTTK7Bx3vQNME7ftf6crZ
         XX7wg+in4gdNca6KyraP4O498ih0rI2qAPZg3N4VIt+w/mmnvbADApVgiZT78QuxgKaV
         LFvJKKsIyc34bd+aq71/DM2IrWqlHOSTkdIO61nKGekus8T5DUlxUa71OheAJhimTye2
         aZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053779; x=1763658579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZBaFvCucR+JNZ72iqSisLCQ+iCppiPliY7657kFDp4=;
        b=LEvhqFQcUDusti7A8q4Ybaog6G4eo6CG3uldzw3ZhAusn/WyRqBIxzNlOkzFWQ4j2o
         Kd/24yPbTpKGMtBwd+aKC+uQxR/gKUS5CSHmKYh24dZ2z1RnMj9eJAxqHft1TJp3py/D
         +0v0Bdqxpffgl+UIyS9lspy1NVpPpGDwLLfCyQNHofSuFDmTagNQ8u4n83drORynhrDL
         tDJHrp9H5hoce2gFvt0CEPsviZ7MjRowou6beEvOUjVoKfZF2YKfkcIcwyWI2P08eXfn
         CFiWDHIVzOmVeWzVC8YUDeNXfROBfA+ubvCjVPdzECZEBKD8X0SGgzpF/Esbr/1bri2q
         7MTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp1TyK5AOhBz+Q88jafWSe0nOwGOLu3AIcOoUy/fuFW+je58hD9wGdiYJk8zAlDmx/wvga2KbduRqJybFo@vger.kernel.org
X-Gm-Message-State: AOJu0YyrEUlw0C4ErBnuSqTD5IXIA5786V6hMoCzVq02jSPUdxN7mhmK
	ZbXcpIbvVB7XXP7eZlf1IP4ztXgP1N8LFi+j3pd84DNNxcPX7z+I6FVLaHs7OZhcbSQ=
X-Gm-Gg: ASbGncva8UQ/dTjfXUvpTBxBqK4WXoRxw0ktGYmbaIMSaoB62YaLgcSOJ0t5kaE0KGb
	fvu1S6KOXMvfHpdDQdaBvv3qgtCITJXpRugcU5cInxTeDTf0c8e8av0SnActNOqnClJM2wUupLj
	QGdQIk+9ccuHxRgO9dVTzSj5gAJchXVEg4mcM2EndMg61f+sRM7VF8Rmxu7Emts+sXOYEcHSBlW
	BG988jkWDGKuJGCKEEHabQDbvbIZZzRohz1rYSaXyfE7dCCjhZMMm7Br/fTgMOju6D4oEh7bKUS
	dsOWt3/aOa5lqDPrjyYm0qWPLe8sl8/hBH0+Cku9MwcZQebS2pGyE3z35Fngx0DPU7owv4GDp24
	dkfuL/eYpLmK4SLi+wqJ4+vA0uWjmz7mG55f2M2yl0DuhRXDOYmSVwfq2ZkjckOPJ1HrssWjc
X-Google-Smtp-Source: AGHT+IHUj8FD9xehxpeszXbRgt8Dc9jtfpmge16x+sbjsSz4SJis1QNpqJZseiw30qoDqxfBrlrydw==
X-Received: by 2002:a05:6e02:1aa5:b0:433:28c7:6d7c with SMTP id e9e14a558f8ab-4348c8cfac3mr4356185ab.12.1763053778646;
        Thu, 13 Nov 2025 09:09:38 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd3113c3sm891476173.34.2025.11.13.09.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 09:09:38 -0800 (PST)
Message-ID: <87dfae96-6041-47e3-84ec-643e3aef3dc6@kernel.dk>
Date: Thu, 13 Nov 2025 10:09:37 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fs, iomap: remove IOCB_DIO_CALLER_COMP
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
 Avi Kivity <avi@scylladb.com>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20251113170633.1453259-1-hch@lst.de>
 <20251113170633.1453259-2-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251113170633.1453259-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 10:06 AM, Christoph Hellwig wrote:
> This was added by commit 099ada2c8726 ("io_uring/rw: add write support
> for IOCB_DIO_CALLER_COMP") and disabled a little later by commit
> 838b35bb6a89 ("io_uring/rw: disable IOCB_DIO_CALLER_COMP") because it
> didn't work.  Remove all the related code that sat unused for 2 years.

Fine with me! Still planning on resurrecting this in the future,
but just never got around to it so far.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


