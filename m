Return-Path: <linux-fsdevel+bounces-12197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0F585CD16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 01:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A641F219CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 00:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A124694;
	Wed, 21 Feb 2024 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H49M547S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E879D0
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476679; cv=none; b=ZXHda4m4ahEZoNAFdCxuvXXBTGJ5PoPI/IXpP9DClCCMCYgen3TjU8bf+6eipSCUXqkcmOvhJOuaAGmjs7J4keXwdTvLqnQ8uD+uECeL5/0ZAXiPUoc6EifNQQXkJfKv28ASGTghevHKqVOJ/IW1PCj9AG+FZdAjcZvYCjqGmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476679; c=relaxed/simple;
	bh=stATvioqgFcpP44fARa+DA0/yEMWLxbE0aX+P6PdUJM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QzrF8QAxsT0NGpBMKaFt0RbeFmNzkFVDYiu1K/gpEiq1CYZx66IDbTvnzu7aP0rYtnXrbuyru8QbrwqdOaGPjI9sAYb+GAfcYtioOhkkJpUtusskh73WVCf4RFJiB2+pE8ksAyaRlHFSG4egeYUAkb0KCnGstuhwA1qgaGt1z3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H49M547S; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 19:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708476675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=QeQZ62U0IKUFM2/iWIPLRfQY3JNRod8vep+oIzxq5XM=;
	b=H49M547SbZDrey/P4MRGbFmwnRNkdWS6zYfMsBC22/Zw8gQnBv0Wu8wa+4/vkIUqmgoZR7
	pK9foFV5w4uxp/sgVb5yPeMTpeBKOloiwygyaQPgb+QvJsmL17Y1MIp+pbi7WrrM5uC28g
	TSrptTxnV5pv7xPBU+Q5tDfFA2fZpcg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Subject: [LSF TOPIC] statx extensions for subvol/snapshot filesystems & more
Message-ID: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Recently we had a pretty long discussion on statx extensions, which
eventually got a bit offtopic but nevertheless hashed out all the major
issues.

To summarize:
 - guaranteeing inode number uniqueness is becoming increasingly
   infeasible, we need a bit to tell userspace "inode number is not
   unique, use filehandle instead"
 - we need a new field (st_vol, volume ID) for subvolumes - subvolumes
   aren't filesystems and st_dev is problematic too
 - I'd like a bit for flagging subvolume roots, as well

That's basic stuff. Beyond that, it would be useful to standardize APIs
for
 - recursively enumerating subvolumes (without walking full fs
   heirarchy), and translating from volume IDs to paths
 - exposing snapshot tree structure - which is yet another tree
   structure we need to expose, completely unrelated to normal fs path
   tree structure
 - snapshot recovery - i.e. atomically replacing one subvolume with
   another subvolume that was a snapshot
 - setting default subvolume root
 - exposing disk usage of snapshots

& probably more.

Hoping to get some real participation from the btrfs crew - if they
could talk about what they've done and what else they see a need for,
that would be wonderful. Additionally, we tend to not have a lot of
userspace people at LSF, but standardizing and improving these APIs is
something userspace would _very_ much like us to do, so in addition to
the usual crew I'm hoping to bring Neal Gompa to share that perspective.

Cheers,
Kent

