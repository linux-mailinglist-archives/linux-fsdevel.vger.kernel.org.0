Return-Path: <linux-fsdevel+bounces-34730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016309C8265
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 06:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A27283FF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 05:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C2A1E7C2D;
	Thu, 14 Nov 2024 05:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MtReQjGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B733FE;
	Thu, 14 Nov 2024 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731562437; cv=none; b=Lx5Mbi9lVMIkp9zxI2rEOjETjPB1hX6GXN9vM1GlRgAmcrJHAG9pwZmINbRd077dF13f9ydIO4dIg7B3o9jZLlXL3G8KKz7ymI29RNn8of5jQMYT+exs+yL1Ky4MWk0xjzXIgA2mxZanZxZQUtwa+2lLU/PP6jZmBrHBL6JAtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731562437; c=relaxed/simple;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oUJ4qd1DK9z7SL0R3X++ykf+UEhaUJ+JeH5eSBQc91k3qhNKKNyFOCQmYH6GNOc/SB4JYIa+iqYYRzC/Erpbjzrv8NrHV+819kgQiXRoQD7ISQh1NQi1FcNtBXH/R41JPNXCPczbrbSU9Gzi47Pp0rRUEt3mzykXUpZ9p9qIpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MtReQjGg; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731562431; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ydOvMSYGLBPG/Sw3HqmtS98YZtsA/FvEeL+izFPO4Ak=;
	b=MtReQjGgGqvuMwPsgn2AoGkT4FE/KVNCOWhYoxKu7GYxgfTC3hngL79+yQ0rJlcfA/ErwYWVasWIRlhCBTaTRniQh6mEikEHLpwFfZXeeS7Kyaz/eiwjHw1vtksCdasuEikMgnmHmNqgqe4kq0QavcyldQYKNm66qLnRHSiB7v0=
Received: from 30.221.128.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJNGWNH_1731562429 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 13:33:50 +0800
Message-ID: <e22f5b69-0462-41c6-b7a9-b3ae10fa6992@linux.alibaba.com>
Date: Thu, 14 Nov 2024 13:33:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fuse?] general protection fault in fuse_do_readpage
To: syzbot <syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6727bbdf.050a0220.3c8d68.0a7e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test

