Return-Path: <linux-fsdevel+bounces-13883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5720D8750FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 14:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E04B1F25623
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFEA12D768;
	Thu,  7 Mar 2024 13:53:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F912D762
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819625; cv=none; b=pJr9MnNnUKQVzRTQAsR0LW+NJDITC2iwI96PBejkaVg3jNu0l7udtBUF94fcNVHDQSnt+odEmvDYcBCkH0rhZmDpZzVsFQnii/CIR/CqbVTcaclkGZKGeTALLj+gZxP6W161N//fF/7Xe6N8plqpdDV5N9o5EDV8zZENBHsAHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819625; c=relaxed/simple;
	bh=Yvs52MYa8MLfb2Av5Pte8d54GzjV6ML5mhnnsmwufyg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sqev/0Zuz1pJMJPvDi2UF7KtCMik2klkEjlrZWGnnS2dXPxJlc5wdw/heiFJQZloGLBzxVwavQKZSKwyx9DipMRXT3MW0ODrdsxQdKSigu9ujH4lq/x6sye31cEI54YzFVK8XwVr77oZjBYt+2VPFk+ifT4wR1hxHYSGD75I6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 462CD289AF; Thu,  7 Mar 2024 08:53:43 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: linux-fsdevel@vger.kernel.org
Subject: Uneccesary flushes waking up suspended disks
Date: Thu, 07 Mar 2024 08:53:43 -0500
Message-ID: <877cieqhaw.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I have noticed that whenever you suspend to ram or shutdown the system,
runtime pm suspended disks are woken up only to be spun right back down
again.  This is because the kernel syncs all filesystems, and they issue
a cache flush.  Since the disk is suspended however, there is nothing in
the cache to flush, so this is wasteful.

Should this be solved in the filesystems, or the block layer?

I first started trying to fix this in ext4, but now I am thinking this
is more of a generic issue that should be solved in the block layer.  I
am thinking that the block layer could keep a dirty flag that is set by
any write request, and cleared by a flush, or when the disk is
suspended.  As long as the dirty flag is not set, any flush requests can
just be discarded.

Thoughts?


