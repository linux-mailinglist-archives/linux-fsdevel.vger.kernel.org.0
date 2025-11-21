Return-Path: <linux-fsdevel+bounces-69337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6647EC76E1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 02:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1BDB42C314
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 01:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E0B26FDA5;
	Fri, 21 Nov 2025 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yOFGw2vp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6F276050;
	Fri, 21 Nov 2025 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763689499; cv=none; b=th2q/RNXhTSHH8fkGh4IGVpBxlBlyX/jgL09kamooU5icfCfw9+7yayO6+dR1nuNWnh0jhbrzgRI0itP0Z0y6rgxbYJk0fPWuc9obQKeXFfUI+x7nIRxX3RcoCDWxpTCALvunzBkqm+wFaf1P064k3MP9I2nFgyZoH9Hgq+I+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763689499; c=relaxed/simple;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=cQah0FBB/d6dLUqYGbfSFoE5p8y8LkVLe4fYZyL3xcKp8m3cgbvk3Y024q/JND+yaMBGeQFiqPuanuxZQtB/B7RfgjLOhqhBeGTcgGGtPurB1T32kirOuJPj2od7/mmOsTD4i7crZUda545IsZCwboRDq3rRRx/EC+5n90QHhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yOFGw2vp; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763689493; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=yOFGw2vpw/5XZjYzs6kDlcFj1TXl7wsFNAYMW49yUbAMhXQkaqOyRmPc+aIfdLg3+1FFPDh+2+/QvFkmP2frH49xfdiwtlN0D7Xl02EFzv+ksW0ng+8IEGeur6ozTkOqQMcanK92vp0OxTweMkY3CwtSxcWzrPjRTjdevx7krwU=
Received: from 30.221.131.79(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsyfYXS_1763689492 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 09:44:52 +0800
Message-ID: <1939a99d-c1d2-4b98-93c3-1951db367b3f@linux.alibaba.com>
Date: Fri, 21 Nov 2025 09:44:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [erofs?] WARNING in get_next_unlocked_entry
To: syzbot <syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com
References: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, nvdimm@lists.linux.dev,
 Gao Xiang <xiang@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <691af9f6.a70a0220.3124cb.0097.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

