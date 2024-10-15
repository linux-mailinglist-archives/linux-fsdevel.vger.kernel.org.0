Return-Path: <linux-fsdevel+bounces-31952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B45499E2B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CACD2B2487D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED571DD88B;
	Tue, 15 Oct 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TO55TnGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083F1BE854;
	Tue, 15 Oct 2024 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984190; cv=none; b=iFX8PESlEMxMIB1dLY08/vsIpqPdEtJ/Mil1i1Kgp9Rw/rvXL0SG+E9ToTU51VN/+gack7BXXBH08+Iw+Aa7Z8AtBwPGIli2sfBTVItL/lrlSy72icFfkfLxPZTjwhoRauCUxwQ5Q/1LQG3y6pu4TkYvdtSZEPgF3oyYf2i69f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984190; c=relaxed/simple;
	bh=thvKDbHAVI3x7P3AOF8YpfHXmW9FfZUNQ8Uvg2B8yAE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CirgrgceSC3/y9xrxDBKrHgZh99wZ5yTFKsJK1/dXsBlwOa1l1Y7QczQveoPYAq9wjNiIeyYKEIPvQB+lZXp88dMi78czMsjXkfllW8I8F5KrAVer74PHN5aToS96mMhBJZ9IdmNuDJ/sMdpqVNmZ4tininUsn6w55OnZ31y20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TO55TnGL; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728984184; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=thvKDbHAVI3x7P3AOF8YpfHXmW9FfZUNQ8Uvg2B8yAE=;
	b=TO55TnGLDZzFSRzQNivoD1flDnfRKHQFKuA2ZWK844054/y7+AXHO9ouJMUcjYXy8jNUGy7t6D0kBDVyTHmKTUiHfveJx8vQIwsEDw3+tks/CrW2Cf8Ue+2MqO5dNSsyEymWgGW1jJH9jhJ3bHCsCtDU1WlPPg/DzSJaUVXB7bE=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHD3Y7g_1728984182 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 17:23:03 +0800
Message-ID: <d38ebf68-46c7-443a-8771-3dbd835a17fd@linux.alibaba.com>
Date: Tue, 15 Oct 2024 17:23:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: Gao Xiang <hsiangkao@linux.alibaba.com>
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20241014

