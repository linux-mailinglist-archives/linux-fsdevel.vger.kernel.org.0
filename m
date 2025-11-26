Return-Path: <linux-fsdevel+bounces-69863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F481C88AE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 09:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357E03AA1DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97D5313542;
	Wed, 26 Nov 2025 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RS4bYDxJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7C308F3E;
	Wed, 26 Nov 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146247; cv=none; b=t8lWpClKXBObVTyKay9GbP4i3qlOZ0YSjHjpW9dMy+xiGNjHsptM4zxofWtLwu3kSyaPuCSoY+u2yx0GmoG8tYrAhH/0hmh/eDZ2rEOtptn8v772Sk/0IX3QTsMzXD7biH9s7G02qpjYnHMouCTKw59DLXA7ukF8pCYR/GuWQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146247; c=relaxed/simple;
	bh=kdL5GXxA8d/1lTHQiJOF2Hmnt6vti6OveT6ZVvaO7PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZfUiI6QZvNjQeWMQSsKqzxhefOaTfiIP0C3hyEkbzhALBXdPP0Gh5nVBLq9nDraaFVLLvlV/Npn9SjEZGkA01PvNbgailqN478Km3bFXy6/wwpmlZnFqyQUdtmEg5ekTG0QPtZASOicXCR+fQwmTnWG0c6GidBxe8SCPFlUq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RS4bYDxJ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ND
	hmB35WSgBHHK66MLjL9pu1guLQN75fkmegsP4puwk=; b=RS4bYDxJfE0uXEYpkd
	r6B+itUhX3TvW8bQ3CxjXNobyUi9C9PqxLB7fM9yObBLFRyIeDAOJeXUfS81KBHl
	ipgIv1p2U9UhZrUlsVtSHmBj7BjpJIQde8aWgNv6reyXgqPPxIPIGGnBGVeYU25a
	nJsiMGdFl2miHoaxBprMLhfIo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD309UgvCZp9VhHFg--.42007S2;
	Wed, 26 Nov 2025 16:36:49 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	gregkh@linuxfoundation.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	r4o5m6e8o@163.com,
	stable@vger.kernel.org,
	wangyufeng@kylinos.cn
Subject: Re: Re: [PATCH] libfs: Fix NULL pointer access in simple_recursive_removal
Date: Wed, 26 Nov 2025 16:36:48 +0800
Message-Id: <20251126083648.50513-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118170450.GG2441659@ZenIV>
References: <20251118170450.GG2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD309UgvCZp9VhHFg--.42007S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4Uur1UGr4rtFWxJFy8uFg_yoWDZrgEyr
	y3ta9xG3y2kFW5Jr45G39Iva13Wan3AFy7XF1fXrZFqa48JwsxJFWfWr9xZ3W5Was09FyD
	ur9xZrWfJw1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjqXHtUUUUU==
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzgIbkGkmvCKZmwAA3U

	Yes, thank you, i aggree with your suggest dentry has already beed freed, and i can got the dentry.d_name.name info is "vcpu126" from debug vmcore, and it's parent dentry is "xxxpid_xx" which's d_inode is NULL too., but the parent of "xxxpid_xx" dentry is "kvm" which's d_inode is not NULL. and after checking the source, i guest the root reason is kvm->debugfs_dentry has been freed before freeing vcpu->debugfs_dentry. and the vmcore kernel version is 4.19. 

[Patch that introduced the issue]
In commit 3d75b8aa5c2 ("KVM: Always flush async #PF workqueue when vCPU is being destroyed"),
the kvm_get_kvm(work->vcpu->kvm) call was removed from kvm_setup_async_pf,
but the corresponding kvm_put_kvm(work->vcpu->kvm) call was not removed.

[Patch that fixes the issue]
Commit 7863e346e108 ("KVM: async_pf: Cleanup kvm_setup_async_pf()") 
will remove the kvm_put_kvm(work->vcpu->kvm) call.

if cherry-pick Commit 7863e346e108 ("KVM: async_pf: Cleanup kvm_setup_async_pf()") to 4.19 brach can fix this issue. 


