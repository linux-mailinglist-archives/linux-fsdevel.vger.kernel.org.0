Return-Path: <linux-fsdevel+bounces-11726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB7F8566E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 16:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95E1282082
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F0012B162;
	Thu, 15 Feb 2024 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="I1HZDUa4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9D433B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009657; cv=none; b=JQzCXqa9xPMytus5vy5Jg8kCEFY26Rrv2R5/O+QNh36sna7O7uYg3cvTmjAmifuLkgYpQAp+a1HvGbPes40CfGmotlpyOSX6bvFMUVUh94gk5qs6lwTmeOc8vfwXrtSSEAcMUwInOOnzVzGudDwDVxcCTnwOBZiMfx24v/b3DDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009657; c=relaxed/simple;
	bh=cRacR++6eUGNFvAKBSQHTjAAf3Wu/sgwr0dbk8qZRpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLt2y8qmhJDCxJGpsy7mikR3gJh0blZ/w5BW06PHnFrxZ8oN3UVLJj6mCiSAulxFbnSqDOXgKkk5g5vUf0pU14lRtZNeXE8aKFnAiRELLimfav3CeiJAz0tDE7ngN1R2WxG5BMCilm2rbHB87IbR0JZa2Lm0FCnen3sj8HksauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=I1HZDUa4; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c3d923f7cbso11915839f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 07:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708009653; x=1708614453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mP6xTDJRHtWvOnRg4qKbStjPt6sXfc6RQpLPzn7y+as=;
        b=I1HZDUa45tYBxl1XYqmdfP8IedJpGu7pjcIaIycdKjYbGbEQA4r0k5+g8zfGpoI3Zt
         L4qEocIYygZqKbLpi7UPNPU72PMvZ7Z3eDk4NYmdKneA80Uo+mAjZQAWJrxKFx6JgMdb
         qkEt8w8ZZuXs+g7UI6F283xhxYv12So5BD2mzzowtszKQkLiQsCuUcnpDmnAZsfoiBuw
         8K4geSNba4purIHAuBByHNLLrCV0Qa4CZLQj6lxIygWbEdWyn4eCfPiGg2QjD9awcZ2M
         6rswGqj+IGPupFznIi1rskyHali/e7ZpDL/AS2GYmVfRPN1FsU9qs0fYuvcntuBg+Dxd
         YKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708009653; x=1708614453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mP6xTDJRHtWvOnRg4qKbStjPt6sXfc6RQpLPzn7y+as=;
        b=mHC3j/G7rqAbKoBh8V4i1Y6xnKimkEC2mZIbHLSUfiUl1TCBznuOzPvT9MKvLbPIKj
         gsTIezm4tRNq7V4PndhkICBEWGInFTxRxV/O3IMUb4m30dChX6HGRp3a8nfnpRUmTWl4
         ayD6RD5fvbZAJib71/KKGqnrmhLqy/tklh8rH5Ba8DyCP1Ftvi/6PP7RKIrhOCgXD6Kz
         3YRgAWp76uRmgJW+6PLrAYD+yO7biG5mzXWjnG0jL62f2KRUMxothCUmDDihlaIadS5D
         4VOpwapk/JWB7CWQeCiSRcyyJG00hDoa9Uz/Lx571FC9tuKFloGpbxJXZ86g2muzpxCq
         pOuw==
X-Forwarded-Encrypted: i=1; AJvYcCVU+CPkiEWDydWwFu5Exe6gbE9yF7xZnHhO0e01oZ5mqIhUxXXZbKyNgsoYA+zCHJks2N1aFzBfy4efcs6mrcaFZQUGG3oQKBStmUvQRQ==
X-Gm-Message-State: AOJu0YxxzB6NXJjm8b2F7X69s3+TcxUKJMxoFFJLU+7lPCyYjqpRgg/D
	6uMbGYdv1n9O401mYuFWZpdAmkP4Hqs4zDnMQsEDAjZi32fkvuq8rW9IDAl8FhA=
X-Google-Smtp-Source: AGHT+IEB1UAvJyDfkPWfJJYC4nXIFiELWe9Ifq9L00EZt3WDDgpy+sqEhjIwwLffZZJ+Lto5yDnPrQ==
X-Received: by 2002:a5e:9801:0:b0:7c4:6163:e62e with SMTP id s1-20020a5e9801000000b007c46163e62emr1891233ioj.1.1708009653268;
        Thu, 15 Feb 2024 07:07:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z12-20020a6b0a0c000000b007c469824bdasm369575ioi.9.2024.02.15.07.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 07:07:32 -0800 (PST)
Message-ID: <fcb62332-4e11-4c73-8984-a7f7353fea4e@kernel.dk>
Date: Thu, 15 Feb 2024 08:07:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20240116113247.758848-1-amir73il@gmail.com>
 <20240116120434.gsdg7lhb4pkcppfk@quack3>
 <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com>
 <20240124160758.zodsoxuzfjoancly@quack3>
 <CAOQ4uxiDyULTaJcBsYy_GLu8=DVSRzmntGR2VOyuOLsiRDZPhw@mail.gmail.com>
 <CAOQ4uxj-waY5KZ20-=F4Gb3F196P-2bc4Q1EDcr_GDraLZHsKQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOQ4uxj-waY5KZ20-=F4Gb3F196P-2bc4Q1EDcr_GDraLZHsKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 12:45 PM, Amir Goldstein wrote:
> Jens,
> 
> If you feel like it, you can see if this branch further improves your
> workloads:
> 
> https://github.com/amir73il/linux/commits/fsnotify-perf/

Baseline is current -git with changes I have for 6.9, so not with the
previous patch. 4 optanes, usually random reads, and being run on a dual
socket Intel(R) Xeon(R) Platinum 8458P  CPU @ 2.7GHz.

IOPS=16.20M, BW=7.91GiB/s, IOS/call=32/31
IOPS=16.20M, BW=7.91GiB/s, IOS/call=32/32
IOPS=16.20M, BW=7.91GiB/s, IOS/call=32/31

and in perf profile, we see:

+    3.16%  io_uring  [kernel.kallsyms]  [k] fsnotify
+    2.04%  io_uring  [kernel.kallsyms]  [k] __fsnotify_parent

with this branch pulled in:

IOPS=17.44M, BW=8.52GiB/s, IOS/call=32/31
IOPS=17.45M, BW=8.52GiB/s, IOS/call=32/31
IOPS=17.45M, BW=8.52GiB/s, IOS/call=32/31

and perf diff shows:

     2.04%     -1.15%  [kernel.kallsyms]  [k] __fsnotify_parent
     3.16%             [kernel.kallsyms]  [k] fsnotify

with a big reduction for __fsnotify_parent() and fsnotify() being
totally gone. In absolute terms, this is all we see in perf profile with
the patch:

+    0.89%  io_uring  [kernel.kallsyms]  [k] __fsnotify_parent

iow, we went from over 5% of added overhead to less than 1%.

-- 
Jens Axboe


