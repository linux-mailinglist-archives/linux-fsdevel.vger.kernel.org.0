Return-Path: <linux-fsdevel+bounces-14027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09407876C0D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 21:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB6E1F21C53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 20:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B605E090;
	Fri,  8 Mar 2024 20:54:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3065B20C
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931288; cv=none; b=TpMakVf4K1KlWnZMGHuQYmR/yTwXmISOykWwK5SqGcp0zQ6141Z60Z9pz3gqWXUIdrXoACvVitxJNMLfNUm6za4YIleEVX3w1r89wJbwyJwGdUVAwG5UC/xcRm1YnJIFASbTDbmMSfQkmmtA0DoqAmK6U+pL5Gu2QEOBZ3WQA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931288; c=relaxed/simple;
	bh=lpwTPmk9V6S4tujGIEfglZ7taPVukXFD6fq4aYTuWE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GK9TvkR/Zbwj/pKyo0epx8IKVZDFavRPjhLFRjMTLTUyCQgct3PjFo2kfQTC5S0K1Bs4abYdoDfPpIlu9Hm0V/lTDyMZG5LbfwE9HMKpP0A0v1YwkrRBnk4kkUDVWAdqeYtXwVG31/lZUcMCYeMcFoBSt04eQGoIbBe6jApm2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 16AD928E10; Fri,  8 Mar 2024 15:54:40 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Uneccesary flushes waking up suspended disks
In-Reply-To: <20240307153756.GB26301@mit.edu>
References: <877cieqhaw.fsf@vps.thesusis.net> <20240307153756.GB26301@mit.edu>
Date: Fri, 08 Mar 2024 15:54:40 -0500
Message-ID: <87jzmcwijz.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Theodore Ts'o" <tytso@mit.edu> writes:

> Another fix would be making sure that the kernel isues the file system
> syncs, and waits for them to be completed, *before* we freeze the
> disk.  That way, if there are any dirty pages, they can be flushed to
> stable store so that if the battery runs down while the laptop is
> suspended, the user won't see data loss.

That's exactly how it works now.  The kernel syncs the fs before
suspending, but during that sync, even though there were no dirty pages
and so nothing has been written to the disk and it has been runtime
suspended, the fs issues a flush, which wakes the disk up, only to be
put right back to sleep so the system can transition to S3.

