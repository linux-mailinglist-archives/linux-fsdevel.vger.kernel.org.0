Return-Path: <linux-fsdevel+bounces-55155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA989B07606
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A85A7BA5DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2002F50AC;
	Wed, 16 Jul 2025 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wzxEgpbs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649342F50A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669771; cv=none; b=chQpB/VSJ3CDWsJhQwtFgj6gL+U5KUx5Gmr33xWHtvdREz4vXCqBMkdKGyfNLyKD3FJmKpZ3JtpqMwgMQ5z798hrrfzrv0QvbdXS9GQTxeOapANluXGKDHgMzGKTbRcgaOC2KSqdcQ6HHg9/BO2eTcK5UWNmcMvgH9XMRfsnPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669771; c=relaxed/simple;
	bh=PQrBkQTNit79aY5TWiavj2p46R9zRBWMt92Hr4xcPoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1Ci1gpwrJBniwATmRnZ+8edz/2wrJzFL9VhUO4ALWgDBZ74SXnyjGKapN7CODMVfjafgKKBtNVcY4rgjKir2/Wv1MAb63stZxC1o95JZSYaLkLjqf6SRlyLVS97lMFYqQPALyDbjsPBZ/r7M3QFX1wZm85p9HHDDbY8csFx58c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wzxEgpbs; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3df2e7cdc64so49759025ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752669767; x=1753274567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRTgLvIeTVdmv5gEosjnjFza6w+DF31dimbJth+OV18=;
        b=wzxEgpbsd01cvjqtmmcJ/6mcHSQQJwZIi3+RzJyEVY8KPabh3ZgNXI8qv4YYKRvwL5
         Y0+HFx6aKo3XzJBA4mcpE+oFoIi5X9YVKA17j6jYym8CMFbVaHlvhuISAB/Z+GiBkEw4
         YogxjPIilzGpOpv14gaNWjMtwnWzUOH4GqM0EiSOO3gfHhlYMYZw7Cyv36MdOhuE+INr
         XOJaHa+sPYSiSr1vxbnXf+A2RVrggj6SW4O1L9Cjv7DxSi2hf8Zbsa5khwyapmBQYrwf
         z2L0FRQi7qpC6LsJxvAzXPMm8yXFNeJIf81r+uTtSsjdLhyDx/QdvSmL4z3In5KkP1so
         sw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669767; x=1753274567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRTgLvIeTVdmv5gEosjnjFza6w+DF31dimbJth+OV18=;
        b=iguJGkh5XsmoP27rFOI2UbyKVozy8vfFS1HJ2XmTjt3cymAdPxfvVXv63h49YaAowO
         U8h86rYPkbrCo1wwHbyvEzdb4MUgWXXS9GHf1t22j4eLggi3S07G4YI7ps59Gi7nU9Cz
         K2TQL/bZCYq7/yjVWoBinsv3IuJwSTaKmbPBxSfqloClp7BukRSynwEj5D8dpVSMEyJ2
         ByUp+JlJ0S6QQ87fdUXEDQzFMZ4v6+Ldgn8ky9HhSXxxBHr22SnIncB12JDudOuzEdmq
         1MIx5XffYXjzVLoN4SQV8RnLk5gN2ozOakU3p9TPAyD59DhcLXVXV2uDEiaVCUyYtmsP
         sE2w==
X-Forwarded-Encrypted: i=1; AJvYcCWgw6PkwUpQMg3jCnKMzgeB20tBa083TVArFJh6uhrIkXsf78Pa841w1eFhaokLCBe2y7SFnhFj6zZqOa0f@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi424zfJtJfTgeN8qjQQYK8y2mzTrzBbCatEzCJXf2P17S6RyO
	Tugw04RjY+QROLEkSoxrnS2PJbeSuU/oy1JoKbY3hmK8qrLJfT/kqnPIgdsVhLgPdoc=
X-Gm-Gg: ASbGnct5TP/SP2Y04cwUWfzzfHcrZ0Tupgzh7xukfWkL3wtI35ipfRvpbGhmNOY/Lxp
	gmeWUqno4NZdk5uu6Ldb//QCPzhqGnFYG91xJGdvBM5v5lGq4ZC4mSIHFL0sZr7dezk6JDB9n1s
	FwcD5CArZmavSvxljsM0JMCOfLAkvKL5fQRMGakQDoEGX5vAIncypbUMFw2jtiJGPDFFuKsCqSQ
	8tUYDghzeI3Utbefa5A5lRdTLvMdlM4j24zyEElgkqA4lZLgd2G6CpbVHamj4DsbQWNt6EBjaQS
	2NDiwQV+DD/LHQ6P1wtT1XyyzvuVFtV66uJRUqhzfT10WDCPrrENsxndRs0ldNyMU4DtaZ3ihc1
	L6feNXuvtC7WEjEHgGR8=
X-Google-Smtp-Source: AGHT+IF+LJcfBS/2chcoB9A3s2CNXd8k4vYJsnjyO8+5SgFhywXDKW10w3meCXUDwX+iqpDHnDeQXA==
X-Received: by 2002:a05:6e02:1a45:b0:3dc:79e5:e6a8 with SMTP id e9e14a558f8ab-3e2824e7123mr31224415ab.15.1752669767387;
        Wed, 16 Jul 2025 05:42:47 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24620ab8dsm44372355ab.43.2025.07.16.05.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 05:42:45 -0700 (PDT)
Message-ID: <165c8823-ab20-4f1f-91eb-3712824f9e02@kernel.dk>
Date: Wed, 16 Jul 2025 06:42:45 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add block and fsdevel lists to iov_iter
To: Christian Brauner <brauner@kernel.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>
References: <20250716-eklig-rasten-ec8c4dc05a1e@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250716-eklig-rasten-ec8c4dc05a1e@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/25 2:40 AM, Christian Brauner wrote:
> We've had multiple instances where people didn't Cc fsdevel or block
> which are easily the most affected subsystems by iov_iter changes.
> Put a stop to that and make sure both lists are Cced so we can catch
> stuff like [1] early.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


