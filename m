Return-Path: <linux-fsdevel+bounces-15233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED4A88B365
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 23:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F09EC22399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF89745C4;
	Mon, 25 Mar 2024 17:09:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2147317C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386575; cv=none; b=j5AH8c+gSTl75JafaGEat8oNK1W2ZnQ2lClQRmSjIpfnOI6EmcBoMPATBz15+dL3gFEf0fs57Fq7mtSIYxvgTIwF3bfxofwcaePBvnfkHWEUAuFChG4CiANH55/7+7LQQe0sc50FaYJYwTEg8Nb5doI1YAuLAXkEIg2oLb7dTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386575; c=relaxed/simple;
	bh=AvlVwKt6ju/ivTvx8stGWAg5C6o9KOhHL6LWHRMTVm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bX+sOhPA20iJwvAmdzuaTBS6w0xgvm5TTM2KmlBjC4kvml/7O8kr3UczSjFQ60GcC8PIhMeP/tEZeSMO4r2BhjYmXVLJIEMyWb2fWpV+caYGhNsWtMKdE5HZcLcXa+xW3LkbBCuEQ9VblHUhJdlduwTZ26oKQCGHC8Du1+Y0Nzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 29CA52B3EC; Mon, 25 Mar 2024 13:09:27 -0400 (EDT)
From: Phillip Susi <phill@thesusis.net>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Uneccesary flushes waking up suspended disks
In-Reply-To: <Zftb+PwS3GkKbCAv@dread.disaster.area>
References: <877cieqhaw.fsf@vps.thesusis.net>
 <Ze5fOTojI+BhgXOW@dread.disaster.area> <87h6h78uar.fsf@vps.thesusis.net>
 <ZfdyoJ90mxRLzELg@dread.disaster.area> <87r0g5ulgj.fsf@vps.thesusis.net>
 <Zftb+PwS3GkKbCAv@dread.disaster.area>
Date: Mon, 25 Mar 2024 13:09:27 -0400
Message-ID: <87le66nsqg.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Chinner <david@fromorbit.com> writes:

> Now the filesystem is idle, with no dirty data or metadata.
>
> In the case of XFS, this will begin the process of "covering the
> log". This takes 60-90s (3 consecutive log sync worker executions),
> and it involves the journal updating and logging the superblock and
> writing it back to mark the journal as empty.

Apparently ext4 only bothers journaling metadata updates.  If part of a
regular file data is overwritten, it does not trigger a transaction.
Are you saying that XFS does commit a transaction and therefore flush
after just overwriting an existing block in a file, with no metadata
being changed?


