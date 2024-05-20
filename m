Return-Path: <linux-fsdevel+bounces-19799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329F68C9D82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 14:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631FC1C22494
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB155E45;
	Mon, 20 May 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IhqlqkS6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A455C29
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208754; cv=none; b=kyG6bz+DRb5nSUBxobDtg2i1POX6Dq+sgsTV531U4NZm4juwujgd/6NGshNqhiQ288ZbwujRq4xJcnldM4E3PK1XGmRmWmNKHx+MQqiXywbm1s5cqW5LTkI6HUo/3kJojeEVy3fcaDXrp2pLmkjl/JQFrHhSrNSFQaosKgQga2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208754; c=relaxed/simple;
	bh=hiqO6nf/twieLGm1SVLytWK3tuB7lTlsoCNchPnguGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOlnL/8F0GpWlblCCTi+Ke/CF3Qn6a26QA0v+GD1hIx8WgR2lcJjttwIQcC1aQjQpNHdh6+6b0OAtzJ1S7FEz9t7/vocEDkknVGWEKHq3F8kqjtRBoqUhsEeKEcmem5dOxwCN6IcngCnVLKXQMcj+z+PNv0bm1vYlvUwvz6o//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IhqlqkS6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f30a419500so405855ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716208752; x=1716813552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6+9qvcDGnLQuaFAHT2Q0e0l4H4wa+c0ZJfQCfwsSgQ=;
        b=IhqlqkS6QvSIgnh5lQM7ljtxt/tX+NoudSd9uraOVsg7a9XN2OhxBeLW6ou9Xz8ALk
         cbCffwCGaVjXDj7lmxVytFlGHzeQeGBd90ocSudcXcMB2IaSqPT0D8barRFKOdiTOSQm
         TjBz1Hzmj2Wzdhmv9ZXG96RQo4dHROUgvvCpMNhn49An8jUfPJILC+vsMaTj2IePcSbb
         gtftKeTNXMp5ESPlmoL7SVvk1aiURNeSUFJRz/kebczx5puYVWyO5bNPkN0J7nYI/fuK
         BnBXoIklYIicjSGNSX/6NhE/NZjiEBMC3V0G1I1Vnzy0StqHrp+ZYRv8HVD5yl+Wurj6
         zuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716208752; x=1716813552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6+9qvcDGnLQuaFAHT2Q0e0l4H4wa+c0ZJfQCfwsSgQ=;
        b=fJ2mHg6omJGvBD21ULtN081Prb7u9fG7RVV/hwHyu8JSgC6K4+bMEtynF8eoK6mtXz
         aaKN4d6/aGiS3dnYnXyV96DQN9M/sHwn2KfXarcCV8fQ/hig1LqgqjZ0X0NZ4EVfDJYn
         RBTvIelgE2cKfyaDnaF0SffRXDuyATXqAxEqkYO0fJDMqjfqeqQ39NDTyvxkWWrMmcvA
         FErJfqatTgBYLEcEQIDHvwRviQnQWsCsKvCgYXftYV8OMKN48RQ65pMh2tyMT1kcs7dR
         kHBPw6Pmf961Lc07WAriNXhmVzVOhB2EDxYSd0GIW9pI99B8L3xXQZ0MW3iYmVVdH65E
         VTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/WvKc1UHbhSpNgqsbCp5Q4AkbKydlfTJBFP6Wk7SwxSyvNL+oL7ahJwaym09dTEBkQbPf/hGt3ycSSHvbFrzNgvTYZYIIyKDCWvMDWg==
X-Gm-Message-State: AOJu0YzYweCY/oKpzEI4wiJqoAVtpemdXZ37AYD1KYfZt1ewMfNi3k05
	armI+cIhS/R42J7LSol9LkL2GKG3fq06Rdb+YC2LQw0wReNpgfUfl6TCegw7cC8=
X-Google-Smtp-Source: AGHT+IFivsbHG0Dck0MMJAGm8ba5y8fLUVV51yB1TyTyn81YB70LrOSYRibqbo5nvALQ6RKSYbGo6Q==
X-Received: by 2002:a17:902:ea0f:b0:1f2:f12e:27f6 with SMTP id d9443c01a7336-1f2f12e3103mr60545005ad.0.1716208752241;
        Mon, 20 May 2024 05:39:12 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f30664fe46sm11260135ad.225.2024.05.20.05.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 05:39:11 -0700 (PDT)
Message-ID: <a9ebbe74-11e3-45b8-8b40-6be78c2d9bbf@kernel.dk>
Date: Mon, 20 May 2024 06:39:10 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] signalfd: drop an obsolete comment
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org
References: <20240520090819.76342-1-pchelkin@ispras.ru>
 <20240520090819.76342-2-pchelkin@ispras.ru>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240520090819.76342-2-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 3:08 AM, Fedor Pchelkin wrote:
> Commit fbe38120eb1d ("signalfd: convert to ->read_iter()") removed the
> call to anon_inode_getfd() by splitting fd setup into two parts. Drop the
> comment referencing the internal details of that function.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



