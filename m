Return-Path: <linux-fsdevel+bounces-35037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E3B9D03D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 13:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C03B25707
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 12:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0F418FC79;
	Sun, 17 Nov 2024 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I9cbCjTS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAF13A26F;
	Sun, 17 Nov 2024 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846751; cv=none; b=lSx7093FSL8A7Nj6SR42/s7DO0kYgs4nC7pEunQcU/WRdeZuyUOGrmaAyLMj5NeiGiTK5UvVJXVhFSsC2tNpn9zOYswTKAE+ZHsMGxqCDzI+VP3VIAHk+mTlHb8EQDa2vFfQl1+5nu1VHiQc4SiVOsWPJdUV+h6awES/kNRbELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846751; c=relaxed/simple;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oC2ZLHMF3eQBPyEqDKI073raIZg/2LymI+wUP0f/eJn09uAY3zIj11GYnZQH0rgfGHTgbnU1Nz+SkJei1kLu740eq4XPoJVK/p5IilUzuvgJpwTchp/JofVfvxjUWFyz0eQY09w5XRF02bApuAKCi1CipLq4/XkVkdA7QFWmAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I9cbCjTS; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731846740; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=I9cbCjTSyhNZ7Bq08Lmoiw1pyeRPLEm7EUWrIK2LM6monkPRYRM7PMHA0XEVUEsQ5H05cLcb3t7P3OhzpxFAYKQdM3YSuqYI6rrEZI03Az2obfnDBjR8F7B5/KP3cyARCtcxYBtpuufoxgRaLoAPHVkPBuuqQmnlNf1teeYU7n4=
Received: from 30.27.77.84(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJZQd4p_1731846737 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 Nov 2024 20:32:19 +0800
Message-ID: <79b938a8-ecb9-4d3a-b1a3-76f1a9c9f351@linux.alibaba.com>
Date: Sun, 17 Nov 2024 20:32:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iomap?] [erofs?] WARNING in iomap_iter (4)
To: syzbot <syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com>,
 brauner@kernel.org, chao@kernel.org, djwong@kernel.org, hch@infradead.org,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <67373c0c.050a0220.2a2fcc.0079.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <67373c0c.050a0220.2a2fcc.0079.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

