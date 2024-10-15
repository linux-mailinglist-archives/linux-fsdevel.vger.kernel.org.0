Return-Path: <linux-fsdevel+bounces-31955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E5099E306
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249991C21B58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E420C1DF970;
	Tue, 15 Oct 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OMakYtPW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAD175A6;
	Tue, 15 Oct 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985619; cv=none; b=DCLRRLFxq8FQMz18YgrecOpDqB5FK/dTLb0fwmFy7D7Q9UIj9qW1qF15KdibKuoA1UwK1En0vmKLgMXQgcWTbwiEkZA8M3l/AO34+bafCjlF5/TDYCZSvRTuoMHTm7PsHrDg47hRPNeKhhk6zg7ASkaPyhgI1WCVPrZYghNYNAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985619; c=relaxed/simple;
	bh=lUDOiYXC1OtSoLrZWAkKNcP23YcMApgq7JF0NZ2HrtY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Q+6oLpmFYMXdFhrPawn1/iP2zsPL04ENXLG3OZLQPf6jJJJB+vZaMdQq9sbk4zZIRauB3D70r94MoYACRXCWy54N6BPuuRjBkKQ1/4AvQt3qVD3P/td6JirLYt74jrCBskvg7G/wBqdy5mHKy0Bh+BQ9ftGRIitpVn61ZMJkTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OMakYtPW; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728985608; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=lUDOiYXC1OtSoLrZWAkKNcP23YcMApgq7JF0NZ2HrtY=;
	b=OMakYtPWpqEiyBQT2zI2oD/wEiBwsnu6gosEqwv+E5JCxpanoGkE8dpbSdu4t5s5vTAI6xVaX1zBgMBAM9fpG74zFbPE984x0ebmDzPvNHpvluwRjGBVcwlNax2V2phL1AmWGDagDa/hHvgN/v4T+uNxGS6XP7TvaYp3m+Q1UKg=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHDE26t_1728985606 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 17:46:47 +0800
Message-ID: <120ff6bf-3607-4f6b-9ec4-f1af9bdbdbd0@linux.alibaba.com>
Date: Tue, 15 Oct 2024 17:46:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
To: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Gao Xiang <xiang@kernel.org>
References: <670e2fe1.050a0220.d5849.0004.GAE@google.com>
 <5f85c28d-5d06-4639-9453-41c38854173e@linux.alibaba.com>
In-Reply-To: <5f85c28d-5d06-4639-9453-41c38854173e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

another one:
#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git erofs-for-6.12-rc4-fixes

