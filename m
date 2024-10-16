Return-Path: <linux-fsdevel+bounces-32061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CB299FEFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 04:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2711C1F217E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 02:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3981C1531CC;
	Wed, 16 Oct 2024 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1AlJ8Rx2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xr0UxZNX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1AlJ8Rx2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xr0UxZNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971FF41C7F
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046545; cv=none; b=euLlU3urrfn8/KF5fi/D8pNYfRA2crYp7EBNw/iQXu28o874KvTdpDp+A5v/bh7ns3Q66nAFhtG7uOhlckYMfUWv5/5iVKNhUw4Y6FClKErIyqL4phK+ILw7sBphtVNAHSFtCpuvdsnb3Sq4f5ox1vdszpAGQMAyZJZq+ITp5rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046545; c=relaxed/simple;
	bh=cpM3aSQ0RvZU8nmkOjMT23zDTfOaqoUUH8hEUlKRwcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiGw9lnCjPx3q7Q346BKfnkj4WSfEFAW36YyOHR0h423hECHP3tzM6dqsNeSSue2q4xrMyAP51eROXDynYY7YnNx+q8mr3dP8RJcFFqovsC0mItvQA3hZ7B6Zzgu9NuQItbmSaHVc4d/yqDT0bkMvLiWBkOdilvAYCS8HIdiiak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1AlJ8Rx2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xr0UxZNX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1AlJ8Rx2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xr0UxZNX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55C3E21C81;
	Wed, 16 Oct 2024 02:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729046541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cosjhMTKHzVGhz7EjHSrKLAqwY66XQB74V+XgfGbd8=;
	b=1AlJ8Rx2Yuf1vHBmp3WpJo7s4LX0Qhv2LOZEw5ICN5oCAxKYq902FUj8EkAkq6fE1taHLy
	arM101bcFKcsR43PUB8iOsnnexFDa9m1IuzyCYm0/Du/X+ly5bfLGzvFEWVcGz13KSym8j
	Z3t58t3IjYoWx7MzThqUJlap/PWvuFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729046541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cosjhMTKHzVGhz7EjHSrKLAqwY66XQB74V+XgfGbd8=;
	b=xr0UxZNXYfnOORFyRCPN6Ie6cveOcTPLSSUkT2dGXoERyZpCIhqAKvysMYBXquoqMmrNLi
	Mkl6OUJY2xcxF3Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1AlJ8Rx2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xr0UxZNX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729046541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cosjhMTKHzVGhz7EjHSrKLAqwY66XQB74V+XgfGbd8=;
	b=1AlJ8Rx2Yuf1vHBmp3WpJo7s4LX0Qhv2LOZEw5ICN5oCAxKYq902FUj8EkAkq6fE1taHLy
	arM101bcFKcsR43PUB8iOsnnexFDa9m1IuzyCYm0/Du/X+ly5bfLGzvFEWVcGz13KSym8j
	Z3t58t3IjYoWx7MzThqUJlap/PWvuFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729046541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cosjhMTKHzVGhz7EjHSrKLAqwY66XQB74V+XgfGbd8=;
	b=xr0UxZNXYfnOORFyRCPN6Ie6cveOcTPLSSUkT2dGXoERyZpCIhqAKvysMYBXquoqMmrNLi
	Mkl6OUJY2xcxF3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D708913433;
	Wed, 16 Oct 2024 02:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dnwJIwsoD2fkSQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 16 Oct 2024 02:42:19 +0000
Date: Wed, 16 Oct 2024 02:42:09 +0000
From: David Disseldorp <ddiss@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/6] initramfs: reduce buffer footprint
Message-ID: <20241016024209.7c655763.ddiss@suse.de>
In-Reply-To: <20241015233415.GG4017910@ZenIV>
References: <20241015133016.23468-1-ddiss@suse.de>
	<20241015233415.GG4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 55C3E21C81
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 16 Oct 2024 00:34:15 +0100, Al Viro wrote:

> On Tue, Oct 15, 2024 at 01:11:57PM +0000, David Disseldorp wrote:
> > There are a number of stack, heap and data-segment buffers which are
> > unnecessary for initramfs unpacking. This patchset attempts to remove
> > them by:
> > - parsing cpio hex strings in place, instead of copying them for
> >   nul-termination. (Patches 1 & 2).
> > - reusing a single heap buffer for cpio header, file and symlink paths,
> >   instead of three separate buffers. (Patches 3 & 4).
> > - reusing the heap-allocated cpio buffer across both builtin and
> >   bootloader-provided unpack attempts. (Patch 5).
> > - reusing the heap-allocated cpio buffer for error messages on
> >   FSM-exit, instead of a data-segment buffer. (Patch 6).
> > 
> > I've flagged this as an RFC as I'd like to improve the commit messages
> > and also provide more thorough testing, likely via kunit / kselftest
> > integration.  
> 
> Umm...  An obvious question: what's the point?  Reducing the amount of
> temporary allocations (and not particularly large ones, at that) done
> during early boot and freed before we run anything in user mode?

"reduce buffer footprint" is a bad title... My initial motivation was to
improve initramfs unpack error reporting (still WIP), following a
downstream bug report.
Patches 1 & 2 avoid 13 memcpy() calls for every initramfs entry and IMO
leave the code more readable, so should be justified once I have
profiling data.
Patches 3-5 remove five extra kmalloc() calls when booting with built-in
and bootloader initramfses. I doubt it'll be visible in profiling, but
they allow for buffer reuse for dynamic error messages instead of
sprinkling data-segment buffers around, like the one removed in patch 6.

