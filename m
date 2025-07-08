Return-Path: <linux-fsdevel+bounces-54221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8D1AFC3F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6833A9BC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B6E298993;
	Tue,  8 Jul 2025 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pDaru0nC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053B188006;
	Tue,  8 Jul 2025 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959539; cv=none; b=PlbmWwpsibhzKrWhgYhuaATkGLCwoT59CN2TbWHDe1elxI5B2V4HviGzds5fC6VX2DVNlqQL7DxcV+1CjRyKmLkxtbNp+Qt3ld5b9SIeqjjIybR2xJO6huk6v6qo1fzBcPLiPSt3GQ18bZqqzByB8a6bdopJaEIHsuQHuf375XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959539; c=relaxed/simple;
	bh=hTsxhYYXUNl6kQHXHKWGlxUMQwI6ZkobTMVeUv0I7ts=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=A0IYEFUet+2SmoDYncQKInVIhHtLUMBa2hrDLaI9MsTqkbW8beyn3wysPw9JRI6ShWgZMrKCipw3M27zVO9lbeOOygXSte9BXtPsqM7Hgxd5OfwyWJRqqQoEMYuEfUMkFfzVRKsD7p/7Hp8EqurLiE7MEKjuy6b0djYQG0Qi3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=pDaru0nC; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1751959525;
	bh=rgW1EbDqX+O9wPlMcm457ujwjBjyq0KCUjbW0ywG0Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pDaru0nC1KxIf9pkQH+aM7Vs806suMvDW37K8eJfLGZM0AQuEhqmjw8pUGYI8c23i
	 kD90a8o/QWIApQHp6lcwRjVqHSCyHUXMoVg8ntc2DvHIZm5GTqrsMTRHfvVtdkZrcF
	 +2ByYUcLJbEgVxqWqOG0Qf0uxTXXBtU3DdKpFdnk=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.73])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 2E92B483; Tue, 08 Jul 2025 15:11:41 +0800
X-QQ-mid: xmsmtpt1751958701tlp273eg5
Message-ID: <tencent_19ABF292BF48BBA08B98B8C3C7BD5D19CE09@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmawRpms6Ue/39BQQ1SRHowQpkx27lg4qRnEyrDKufpEe6JoiwE0s
	 X4bUjYFCuqPdCbfYYIFhf9vrdN+PzxNOI/ByibxMc60LKkq1AUMsXP/6AcJrxdtQqAq5Q0a0IJkx
	 NaTDDt2HEJ8CiHe9EOdkaQg5CO1oeqX3d919iGGttuQi7kXVNaq9YNMNQ8QXTsnTq7WOsCx3sF/Y
	 2iqJm8SS8Hw7wbvdprC6vq2zA/oLeCyS0WpPYfjqEHYSRnrARSXp4ou+eQ+RdvvXG7BuYMHpA/d/
	 vOYjXICj+D7IVgOL2xnAhpj4gc+zyJPFU8DK7Y4ULYekU378T+x9eye4cRdZrdZ8R86F4PC0Yxf0
	 GUHK845Y8M/BURpKI/ERfIIxgcHgmceJwZSGud2LahiyT+1kKHg4Lixl0QTrxsZYYssTUi+1olqt
	 TFm1jgsn0Kq+08J3hM1y2wIYvC0KGnmxG+fbtZ8bbmKCNATl4haAHgSQO8gpVNZnyBCe18tCQqW4
	 AQf1teH5Q+FQ5osKuP4hCzjXCFSXNcnv+VUcQMZMwryTkz9N7dq3vb4cguh3Kf8L0WVzuuay3BTL
	 5M/oIIOhYTSwSg2nOISpNaW04R+vvzqb+Ht59wY01WZdkI4uOjdLYcTc61uNs5j+gvURqYiwdFpU
	 /gip+yblaxFsKwc1I6S9xMpA9YDONR0wB9yAFCFSh1IjwqRALZHRgp/67oasvkvNY8PzV6ilcdwO
	 idNafDhJ2l94tg95QKmw0SSpxxWfeAZmXyEbhepumU3g6W+POnW59tFGNo2fkyMHwWaA9PVedHsq
	 ZDO3wxqRQA+Mfb29a3P8Qjx35mO1lMoXbvFcBrTblRVvDdWgKxRL36jD+zJFx4jmD0PP9+hJvspG
	 U+0K2myUpjwLv6S8iJrwTgWC2l+sW6WIhM4U5ihg4jY4U6VfB9UAURSuVgZxOXgSZ0VZYncVzH8b
	 wcAj7s5h0lyB4CG3vj/gVRCxQHgaDqtXJYBN9aF1cN0+6fngS+YeK9VhrVR//z5HlizyVog2WO80
	 fJOz+hfQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: hch@infradead.org
Cc: adilger.kernel@dilger.ca,
	brauner@kernel.org,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	ywen.chen@foxmail.com
Subject: Re: [PATCH v3 1/2] libfs: reduce the number of memory allocations in generic_ci_match
Date: Tue,  8 Jul 2025 15:11:41 +0800
X-OQ-MSGID: <20250708071141.847557-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aGtatW8g2fV6bFkm@infradead.org>
References: <aGtatW8g2fV6bFkm@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 6 Jul 2025 22:27:17 -0700 Christoph Hellwig wrote:
> But I wonder why generic_ci_match is even called that often.  Both ext4
> and f2fs support hashed lookups, so you should usually only see it called
> for the main match, plus the occasional hash false positive, which should
> be rate if the hash works.

At present, in the latest version of Linux, in some scenarios,
f2fs still uses linear search.

The logic of linear search was introduced by Commit 91b587ba79e1
(f2fs: Introduce linear search for dentries). Commit 91b587ba79e1
was designed to solve the problem of inconsistent hashes before
and after the rollback of Commit 5c26d2f1d3f5
("unicode: Don't special case ignorable code points"),
which led to files being inaccessible.

In order to reduce the impact of linear search, in relatively new
versions, the logic of turning off linear search has also been
introduced. However, the triggering conditions for this
turn - off logic on f2fs are rather strict:

1. Use the latest version of the fsck.f2fs tool to correct
the file system.
2. Use a relatively new version of the kernel. (For example,
linear search cannot be turned off in v6.6)

The performance gain of this commit is very obvious in scenarios
where linear search is not turned off. In scenarios where linear
search is turned off, no performance problems will be introduced
either.


