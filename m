Return-Path: <linux-fsdevel+bounces-61306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFBAB57652
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EAB31A223EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3E52FC890;
	Mon, 15 Sep 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V1BHcmxb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E722FA0FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932238; cv=none; b=D107dFYAYHphJpRV3R5VZAgQ5Lpgw5s86Z+2xm0Gc8i6KpLbUcf3K8vfepYkAtA0Ad7xfchPUymIXoubb65Qvajz1AgROkA+Yx+iJB03UZ9vPVSiKnLS/0bp7A6jGRYwwnNN7ilUKoYpglQNbzZlLmER4FuT9Vuom7Kg+y6t6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932238; c=relaxed/simple;
	bh=zY7JI7hDmtHnYscMcs6+BbCMIvxvauO2CVcScH3sN0Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p80+iT+lKug9/pAXeQyyMvzGEbzUbaskBMQSNd3NhkH70V8wKAnfnj+r6UcrA7qWsU69r1YfcFVWBwyKdwcuinax/hIkIIHhn4Y1RsTrlxR4Alr4NhPnX6mchOQQI0H21wmUbGmzm6hAFKB4Nfy2dq484pEp4fqTtaS7+kfWU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V1BHcmxb; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757932233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jdb8MAzJ69Crza7fkEstwRRVIV34/bxmK/xuu8MGxcM=;
	b=V1BHcmxbOiJwcyYkyAvWjYh61UIhQSWPQHb1XMLdUh2Z096n8Ayr8bciUQia4p7btjsitU
	QgDBXE+e6aLAf14xunvHlLUfCGEqsVI7Fpsnhkyn/QMlhJrphce486mjVIkmijWJwu/8NU
	g5sKmtSkEPaIqtkoPmj7tAjULe6keb0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] initrd: Fix logged Minix/Ext2 block numbers in
 identify_ramdisk_image()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250915043141.GM1587915@frogsfrogsfrogs>
Date: Mon, 15 Sep 2025 12:30:20 +0200
Cc: David Disseldorp <ddiss@suse.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9FA25B6B-4B04-4A35-90E2-8537C1E228E6@linux.dev>
References: <20250913103959.1788193-1-thorsten.blum@linux.dev>
 <20250915122146.56f66eb2.ddiss@suse.de>
 <20250915043141.GM1587915@frogsfrogsfrogs>
To: "Darrick J. Wong" <djwong@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 15. Sep 2025, at 06:31, Darrick J. Wong wrote:
> On Mon, Sep 15, 2025 at 12:21:46PM +1000, David Disseldorp wrote:
>> Hi Thorsten,
>> 
>> On Sat, 13 Sep 2025 12:39:54 +0200, Thorsten Blum wrote:
>> 
>>> Both Minix and Ext2 filesystems are located at 'start_block + 1'. Update
>>> the log messages to report the correct block numbers.
>> 
>> I don't think this change is worthwhile. The offset of the superblock
>> within the filesystem image is an implementation detail.
> 
> ...and even if logging the detail is useful, for ext* the superblock is
> always at byte offset 1024, no matter which block (0 or 1) that is.

All logs ignore the individual filesystem offsets and only print the
starting block. This may not be particularly useful information, but the
printed starting blocks for minix/ext2 are off by one compared to the
others, which is at least confusing.

Since initrd seems to be on its way out anyway, it's probably not worth
changing this.

Thanks,
Thorsten


