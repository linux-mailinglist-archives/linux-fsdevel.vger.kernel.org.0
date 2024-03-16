Return-Path: <linux-fsdevel+bounces-14560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D35BA87DB3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 19:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8087E1F217F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 18:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44521525D;
	Sat, 16 Mar 2024 18:35:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0BF4431
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Mar 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710614114; cv=none; b=fBpbFHYqGNGoewrL5wmiXu1CyDYWLmeIusDit7k27NV421NqMqXZgHkIGhRPBd/gFRFOAxmNV0aikPJhVxg5YgPrDPxpR+0kTuIw+gFXmNOKQiz/0sB8s5dE1KDpl4MnE5QTnWzoPMiUWBo5uACIzY7/osVsphK/i+PuYncUi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710614114; c=relaxed/simple;
	bh=aPaNh/jYhxbNzRe10ioSw4QUz6chxlRpyHs6wJ7Jngs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fu6kz8MLCF4RUBPNRwuexJ8d1wCLQztyEmQ1DVM5hgjxLFVYlLTQh6eo2HihPSCyZXUAefNCZ53772BLmeF+YOaiaPDXE6dLAG3Z5aLdmMCYHTmz/908iFPlWdec25fy+LFpFwx0k0BEtmmKCck8bdLAYE8jyb7ezba0grVUruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 15D4E2A05B; Sat, 16 Mar 2024 14:35:06 -0400 (EDT)
From: Phillip Susi <phill@thesusis.net>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Uneccesary flushes waking up suspended disks
In-Reply-To: <87h6h78uar.fsf@vps.thesusis.net>
References: <877cieqhaw.fsf@vps.thesusis.net>
 <Ze5fOTojI+BhgXOW@dread.disaster.area> <87h6h78uar.fsf@vps.thesusis.net>
Date: Sat, 16 Mar 2024 14:35:06 -0400
Message-ID: <8734sqnhyd.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Susi <phill@thesusis.net> writes:

> I just formatted a clean fs, synced, and ran blktrace, then synced
> again, and only ext4 emits a flush on the second sync.

Just to clarify, I waited for the ext4 lazy itable init to finish, then
after that, every time you sync, you get another flush, even though
there has been no write.  That's what I'm trying to get rid of.  This
flush with no writes keeps waking up my media/archive disks when I
shutdown or suspend to ram.  At least it does now that I am trying to
use runtime_pm instead of hdparm -y or hdparm -S.


