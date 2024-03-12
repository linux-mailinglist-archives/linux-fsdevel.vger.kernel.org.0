Return-Path: <linux-fsdevel+bounces-14244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5E7879CF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 21:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8347BB23346
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BAE13B2BF;
	Tue, 12 Mar 2024 20:35:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C913382
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275717; cv=none; b=TQAVetqmROAJEwKV6TKEJ3ivzoDrm0K1ZSp7tsxbtWJ7LoDNL1Yev/P2rc680IPg30ELuIv7T6OPf20qguZPwocFreGob6txntKWQLKAR1tjpREWSyBIH6kgb/+pf2FIAzhxugU6aS4Nt9rfJo3kGnMox5Y7FW3XM1ttChodhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275717; c=relaxed/simple;
	bh=nO6UzmIBCneL/D7j54kWuHvZ2dHximnzM7nuCPGkSQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UMdmGs7JUyMnlMf6aMofRKltkN03wgAxyYGU1XHK2qNJxMD28Lw5SEXKWjvsj2M1IEdkkgGca8de66XPX9IKeI6U7l3hwE8bFxxwoyWkscvMH9xVibLtpo1fdco8D0ZyHc4Br5ChAjddWQ4N1OLlxlaZmDNwZNqBShnICqfskMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 36414295BD; Tue, 12 Mar 2024 16:35:09 -0400 (EDT)
From: Phillip Susi <phill@thesusis.net>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Uneccesary flushes waking up suspended disks
In-Reply-To: <20240309173700.GB143836@mit.edu>
References: <877cieqhaw.fsf@vps.thesusis.net>
 <20240307153756.GB26301@mit.edu> <87jzmcwijz.fsf@vps.thesusis.net>
 <20240309173700.GB143836@mit.edu>
Date: Tue, 12 Mar 2024 16:35:09 -0400
Message-ID: <87a5n3dw8y.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Theodore Ts'o" <tytso@mit.edu> writes:

> In an earlier message from you upthread, you had stated "Since the
> disk is suspended however, there is nothing in the cache to flush, so
> this is wasteful."  So that sounded like the flush was happening at
> the wrong time, after the disk has already been suspended?

At some point the disk goes idle.  After some time, runtime pm suspends
the disk, which, if there was anything in its write cache, is flushed.
Later, you shutdown or suspend the whole system, and the filesystem sync
issues another flush, just in case, even though there is no need for one
at this point.  This causes runtime_pm to wake te disk for no reason.

With an ATA disk that is in ATA standby mode, it happily remains in
standby mode and ignores the flush request, since it knows it has
nothing in its write cache.  With runtime pm, the kernel MUST wake the
drive for any request.  Thus, in order to make runtime pm work at least
as well as the legacy ATA disk standby, I'm trying to eliminate this
flush command on sync, when there has in fact, been no writes to the
disk either since the last transaction committed and flushed the disk's
write cache, or since the disk was runtime suspended ( which flushed the
write cache ).  In other words, if nothing has been written since the
last flush, don't flush again when tne fs is sycned.


