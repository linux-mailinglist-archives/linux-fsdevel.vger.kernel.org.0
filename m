Return-Path: <linux-fsdevel+bounces-16389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B36689D000
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195281F23175
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 01:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AFE4EB23;
	Tue,  9 Apr 2024 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O1JD9hbX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2058B8F59;
	Tue,  9 Apr 2024 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627285; cv=none; b=edP2i8nKhovoZ0jfJv0y5qnBpR8Sz9EDFccGPHBitWqEW3Hl4HmYfg53JKLh0Q0HFKEP7QghGN+yaZCwRxdbTN1ZVvvVO3xd62gL2NH7VhVwGsUmOx3rOeZriwcm9IGqBBPRgbowmJ+17CntHyn+vCxH28kmm549Wss9wdrcgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627285; c=relaxed/simple;
	bh=2xUwOxokMZcO0aIfTzGCvhfphl2NUW66BLFA0zELaKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C51bUnzOdEc7iXK4YOcSYxyRSIUBPmw6WV/xfeWRGFLOxLz4o17+7DcCb0YMUwG/KtqeOJnkRZM6JF4h9J5D7AATTA0xrFcw9QsvrgojTu/YWPol6piUdGxfJUW7fl17ba/+Xytj3H3gEdE9pa5CMf1pmINTITS36z8Bm2iVTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O1JD9hbX; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712627280; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2xUwOxokMZcO0aIfTzGCvhfphl2NUW66BLFA0zELaKM=;
	b=O1JD9hbXxR4yKBGX5OfSv0L5i6pQG8e4NPcHFcTFJIOD2aevY2bUdUXB2uBensVAZVMrHtwxxOeckcTDfhuSndLJe1Ba+5sP9vXWb2r+E0GVC7lo2DSrBNpX+Usb4RcwgFdlxx0fJ3TtIxwVFR2YrH+W9Z7LFaXe6/W1nWi5tUQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W4Ci6VR_1712627279;
Received: from 30.97.48.141(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4Ci6VR_1712627279)
          by smtp.aliyun-inc.com;
          Tue, 09 Apr 2024 09:48:00 +0800
Message-ID: <8b9e2dc7-adef-4a2a-8284-f4885d3361bb@linux.alibaba.com>
Date: Tue, 9 Apr 2024 09:47:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] BUG: using smp_processor_id() in preemptible
 code in z_erofs_get_gbuf
To: syzbot <syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com>,
 chao@kernel.org, dhavale@google.com, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <00000000000084b9dd061599e789@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <00000000000084b9dd061599e789@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev

