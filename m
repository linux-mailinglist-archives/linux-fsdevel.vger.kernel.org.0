Return-Path: <linux-fsdevel+bounces-44098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39AFA6209A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B451B632BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE27204C18;
	Fri, 14 Mar 2025 22:39:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ida.uls.co.za (ida.uls.co.za [154.73.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923862046AF;
	Fri, 14 Mar 2025 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.73.32.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991971; cv=none; b=cJa/PVkUdaXRU45TVBW5zbFMphZ+Pr3/kvPE4ZnlVLWX0ckLRefheVwgCQiCnNTvIumBajmV5HVCfbrmvdyBcu/P5MedSks9z5PAnkfkc4uGowB1wTlxbVw/lsssIVRx9edSm82KqCubXUTXBiTp9gRmkrldPr1F6jldl5DkJEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991971; c=relaxed/simple;
	bh=enX3BKgBPbznwP1Q8EVY+z08xiZnaUPXsr0MrYjgP/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO8NvXyWLkKmHOkoEr/CPaEDNWPV+xukD3frIGorYvbTBcFIEIA4e3LWf/d8+FPb1d9dW5gkG914gn5YSshCzyK0mj3Dg5IcovnvFcH18TWZMkTcjN8UfFDO5NYlRgPQfqwoC8LmZeGaFT2fbWEaNd20/arw2RiQ/N5j2XhUbRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za; spf=pass smtp.mailfrom=uls.co.za; arc=none smtp.client-ip=154.73.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uls.co.za
Received: from [192.168.1.104] (helo=plastiekpoot)
	by ida.uls.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <jkroon@uls.co.za>)
	id 1ttDKz-000000005qd-2pBk;
	Sat, 15 Mar 2025 00:17:05 +0200
Received: from jkroon by plastiekpoot with local (Exim 4.97.1)
	(envelope-from <jkroon@uls.co.za>)
	id 1ttDKx-000000003kg-0TFA;
	Sat, 15 Mar 2025 00:17:03 +0200
From: Jaco Kroon <jaco@uls.co.za>
To: jaco@uls.co.za
Cc: bernd.schubert@fastmail.fm,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	rdunlap@infradead.org,
	trapexit@spawn.link
Subject: fuse: increase readdir() buffer size
Date: Sat, 15 Mar 2025 00:16:26 +0200
Message-ID: <20250314221701.12509-1-jaco@uls.co.za>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20230727081237.18217-1-jaco@uls.co.za>
References: <20230727081237.18217-1-jaco@uls.co.za>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-report: Relay access (ida.uls.co.za).

This is a follow up to the attempt made a while ago.

Whist the patch worked, newer kernels have moved from pages to folios,
which gave me the motivation to implement the mechanism based on the
userspace buffer size patch that Miklos supplied.

That patch works as is, but I note there are changes to components
(overlayfs and exportfs) that I've got very little experience with, and
have not tested specifically here.  They do look logical.  I've marked
Miklos as the Author: here, and added my own Signed-off-by - I hope this
is correct.

The second patch in the series implements the changes to fuse's readdir
in order to utilize the first to enable reading more than one page of
dent structures at a time from userspace, I've included a strace from
before and after this patch in the commit to illustrate the difference.

To get the relevant performance on glusterfs improved (which was
mentioned elsewhere in the thread) changes to glusterfs to increase the
number of cached dentries is also required (these are pushed to github
but not yet merged, because similar to this patch, got stalled before
getting to the "ready for merge" phase even though it's operational).

Please advise if these two patches looks good (I've only done relatively
basic testing now, and it's not running on production systems yet)

Kind regards,
Jaco


