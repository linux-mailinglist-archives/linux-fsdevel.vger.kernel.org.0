Return-Path: <linux-fsdevel+bounces-28577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237BB96C2B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E7D1F26322
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8311DEFE2;
	Wed,  4 Sep 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0R6aH00f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A433FC1D
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464598; cv=none; b=BEsELp0JIwvSsHEWpwihCi+2U8EnJXBfCry0V1Uhj5Z5ohOyJjSAcCGsAVwLagWXtAyahIH18DNvWt7TRxx2VPniKnzwMnwe64yJw3AD1gY/AYNPcDHjJTMSSYd6imcAVe9ZqIBiz3KpedVK2ff10v5fu3fqUbEsGXi0xfNo+Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464598; c=relaxed/simple;
	bh=y8oCjSRwq5azPrK9b5HeKhzvB9Oh+V114LQhRFsewUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IleReYp1RtnBocYyeaIe8BH/S45M9e6xoR5OdeKEANPRE6w5j3d4Lj6sORKX4evmSWFsNx60Yzgv6MZCT0xZ0ndQWIconBVn0PXYQkQ4meuPh+Z7udi+ZlJAndFd7uawQ34uIH2A8L1whLhN2Pcoaeo3rhqLquEMRZAYGUOVb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0R6aH00f; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a20593e53so38785339f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725464596; x=1726069396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ORx8ZBUsnYsPsxVlFFo76DEuANyTgK053IRRgOjq/w=;
        b=0R6aH00fONbZ6xXjqm+ar0FM28HDi1tZuCp9bjcG7W8eEKYZfaXGuFslHXTxk38zf4
         L4Arg86+V9IQsyy3MhCa3UhnshmKpXXzhBXhJH0nnw60ox50GdOJBnUdQvMvvYKERjga
         /1iaG7qZu8RFKrDqAq0ZA6NOEzp6KuzXWmncZcmQgW2prlG8d2xjG+P1mPxL/5lwMj9V
         bQLzLMQj2otV5olrWIK0a8VxgIH0kwZ7qRnKO7eGKHD005CDSiEjN7uSF517XPRTYF4B
         tYML+GU6IqP1eszKaoUyVool6GomAt2VXRDDZuEKlNPIkBn4yfoIQAzFMeMONQ8LHrHk
         lxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725464596; x=1726069396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ORx8ZBUsnYsPsxVlFFo76DEuANyTgK053IRRgOjq/w=;
        b=Pthzq7l4hsrQ0AYMUpyA5d4mFuA4E9NCqAWhud3wRCdRu2YG11i9KCGJ8pKxeY9FAS
         s+eBRzMm49QmycHtHdiZy8a6wr5E1Ess9VN12bn86O4Tcpsk+EHeVDf8CjBpz+v02AKh
         VCz1z5d5aWw0AParNdnoF0jtO8CO6gWLwiXewR65UdypU4EL5pwUls5L4YbLg5ZMsKSh
         9bGh+QmOIsTl6mlPLv7kk4e+GpqJzHGZaDoUQCzSfbjACmCLJs49RQOQeAfARZ0aUhYa
         xIJu4zyKTwRDfFo0lq+iOCLVEmmgnT1GscPNL0TbiVA1Tcoe2DAyTjVMypehGMQ04tSz
         K+0w==
X-Gm-Message-State: AOJu0Yyjk/xJDcxH2IIXqOKbFI2NURlZvglUzdujTq4He4d70uM9OFh/
	vm7c2BQMyFIcFkfwDj01zeaWhl3T6MpaoFQy2E1QDbrAWZcvrerYHzsoQL79DmU=
X-Google-Smtp-Source: AGHT+IHhydrFZM5uRo6BDjNDHX6kRtWAhN2r4HJW/chMn06GH3nalvsCd44mmg2zk7QBMFUiPdAVvw==
X-Received: by 2002:a05:6e02:1fc1:b0:3a0:43f7:9437 with SMTP id e9e14a558f8ab-3a043f79596mr11756145ab.28.1725464596217;
        Wed, 04 Sep 2024 08:43:16 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2eaba03sm3162684173.145.2024.09.04.08.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 08:43:15 -0700 (PDT)
Message-ID: <58ace88b-2046-41cd-891f-88a331a84eeb@kernel.dk>
Date: Wed, 4 Sep 2024 09:43:14 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 15/17] ate: 2024-08-30 15:43:32 +0100
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Pavel Begunkov <asml.silence@gmail.com>, bernd@fastmail.fm
Cc: linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Amir Goldstein <amir73il@gmail.com>
References: <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-0-9207f7391444@ddn.com>
 <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-15-9207f7391444@ddn.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240901-b4-fuse-uring-rfcv3-without-mmap-v3-15-9207f7391444@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Something went wrong with the subject line in this one.

-- 
Jens Axboe


