Return-Path: <linux-fsdevel+bounces-24935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90570946C1D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 06:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2527B2160C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 04:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7028475;
	Sun,  4 Aug 2024 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="P6gAixAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66A963CB
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722745058; cv=none; b=UwXTj9/g8n5+9IHK9T+jZTW+CWLyPru9Ss8nk/Xo2smZ11iwdXEpP/V6z5S+DpVBwkRxhxrSIySrX/tcQZ2a7DaS/apIu78zxl8pXSoWIx7W373tWNwUmKp0TrSRNR3ndTNqAKiA7w7wAK/tZlshiRGnzBqinhVwk5T/VXlrzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722745058; c=relaxed/simple;
	bh=dgho+EvjWPRVod6KiiTyj9Kd0HdH+i8GEhGHKqXkdX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2mlOU0uogjUoddxG0p271WiT7UgA2GXyWQXRJFBNGkx6Yl7qeL4Yg0Rw666DCxV+/u7d31EMKKsnKTL7BQP+5LY0BHVeiBbFaq5usxyUA1nVxKRoU1zkZs5wzhh87ZeOrQu9w16Cwjrw6tPHj/CqBt/r1KbsiHcOfH5+EsLwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=P6gAixAb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aPLoRyUfm5kae09J2oEg1v8A/gmS/PHSkS94D8Yoqg0=; b=P6gAixAbReN3QeO6GvzYjyfwgw
	4Imx9zVJCbqrdX0/npk9Ien92l62ydonZm5isSrwJGwh9uvamb/bSSmHgUNBPkO+DGouXUDXdofUg
	SmBVAb77ImES4bMg0DZTW0aCyf2zqr8ybXAdHsf+WPNBSSJIbKKFy5SYRNbfG5YJ0KFLMtBRcNc20
	6ZCFQVLsbfqsGCZoisucB7dvOzwsXFeXaXJpX6GM9F2TNPhWrsd1uViHmNWANwc+bTBjm4RDIMHei
	pyTmm2+DiLs0i+91cf8Zo5W4806hURPAQ4MR/fYjfoFfGg/Meh0ibBzZSNoL703gQOr01+Y6PHd/e
	LNBGHVqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1saSgX-00000001SnL-2FL5;
	Sun, 04 Aug 2024 04:17:33 +0000
Date: Sun, 4 Aug 2024 05:17:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240804041733.GC5334@ZenIV>
References: <20240803225054.GY5334@ZenIV>
 <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
 <20240804003405.GA5334@ZenIV>
 <20240804034739.GB5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804034739.GB5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

BTW, the current description I've got next to struct fdtable definition:

/*
 * fdtable's capacity is stored in ->max_fds; it is set when instance is
 * created and never changed after that.  It is always a positive multiple
 * of BITS_PER_LONG (i.e. no less than BITS_PER_LONG).  It can't exceed
 * MAX_INT - userland often stores descriptors as int, treating anything
 * negative as an error, so the numbers past MAX_INT are definitely
 * not usable as descriptors.
 *
 * if fdt->max_fds is equal to N, fdt can hold descriptors in range 0..N-1.
 *
 * ->fd points to an N-element array of file pointers.  If descriptor #k is
 * open, ->fd[k] points to the file associated it; otherwise it's NULL.
 *
 * both ->open_fds and ->close_on_exec point to N-bit bitmaps.
 * Since N is a multiple of BITS_PER_LONG, those are arrays of unsigned long
 * with N / BITS_PER_LONG elements and all bits are in use.
 * Bit #k in ->open_fds is set iff descriptor #k has been claimed.
 * In that case the corresponding bit in ->close_on_exec determines whether
 * it should be closed on execve().  If descriptor is *not* claimed, the
 * value of corresponding bit in ->close_on_exec is undetermined.
 *
 * ->full_fds_bits points to a N/BITS_PER_LONG-bit bitmap, i.e. to an array of
 * unsigned long with BITS_TO_LONGS(N / BITS_PER_LONG) elements.  Note that
 * N is *not* promised to be a multiple of BITS_PER_LONG^2, so there may be
 * unused bits in the last word.  Its contents is a function of ->open_fds -
 * bit #k is set in it iff all bits stored in ->open_fds[k] are set (i.e. if
 * ->open_fds[k] == ~0ul).  All unused bits in the last word must be clear.
 * That bitmap is used for cheaper search for unclaimed descriptors.
 *
 * Note that all of those are pointers - arrays themselves are elsewhere.
 * The whole thing is reached from a files_struct instance; the reason
 * we do not keep those pointers in files_struct itself is that on resize
 * we want to flip all of them at once *and* we want the readers to be
 * able to work locklessly.  This is a device for switching all of those
 * in one store operation.  Freeing the replaced instance is RCU-delayed;
 * ->rcu is used to do that.
 */

