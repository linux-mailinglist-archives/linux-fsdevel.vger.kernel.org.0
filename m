Return-Path: <linux-fsdevel+bounces-58356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55277B2D1C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 04:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD757ADBCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 02:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D3E2BE7DB;
	Wed, 20 Aug 2025 02:11:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677CF25F780;
	Wed, 20 Aug 2025 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755655913; cv=none; b=fBhmpItNqT9ijWbzo6v3qw/xPeut/EWLfJB95jDwi8QJ51ETt/Myzm8ndsPkTBEg8Al3Kx65SIAQ3nb7ehlS/dK/p3jgpctgaJ7xc/N531TuIiAqUnayuGo4ziGq2/pg3FsQej8VcwuI6VO3o92YUyGdZ0EaL39VLEpYxXZk13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755655913; c=relaxed/simple;
	bh=vceE1EFYnjzv1SwTVXgJX/uu02veZVA2y2yxNYwS0ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUZb+G9GSJtSZO7qnTcO7GxSzpJ6KUVhnZWecXm/5uflb6Ifj2h0qEvQeUA2xFMel5hfnmdrLT1FlpYUI9bCJRrskGHywSOKv+JIFKGxB9xMcRGKASGuNU97fxaTFpAvcMLPjhzkoA7pEQt12J4k3K8P7LPdqVuattcqdferziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.36])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ff0f20cd;
	Wed, 20 Aug 2025 10:11:44 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luochunsheng@ustc.edu
Subject: Re: [PATCH] fuse: clarify extending writes handling
Date: Wed, 20 Aug 2025 10:11:43 +0800
Message-ID: <20250820021143.1069-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJfpegsz3fScMWh4BVuzax1ovVN5qEm1yr8g=XEU0DnsHbXCvQ@mail.gmail.com>
References: <CAJfpegsz3fScMWh4BVuzax1ovVN5qEm1yr8g=XEU0DnsHbXCvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98c53f1bfd03a2kunma82445d6437b68
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSU5JVkxPGE5CGEgaH00eSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhNWVdZFhoPEhUdFFlBWU9LSFVCQklOS1VKS0tVSkJLQl
	kG

Tue, 19 Aug 2025 16:07:19 Miklos Szeredi wrote:

>>
>> Only flush extending writes (up to LLONG_MAX) for files with upcoming
>> write operations, and Fix confusing 'end' parameter usage.
>
> Patch looks correct, but it changes behavior on input file of
> copy_file_range(), which is not explained here.

Thank you for your review.

For the copy_file_range input file, since it only involves read operations,
I think it is not necessary to flush to LLONG_MAX. Therefore, for the input file, 
flushing to the end is sufficient.

If you think my understanding is correct, I can resend a revised version of
the patch to update the commit log and include a clear explanation regarding
the behavior changes in 'fuse_copy_file_range' and 'fuse_file_fallocate' operations.

Thanks
Chunsheng Luo

