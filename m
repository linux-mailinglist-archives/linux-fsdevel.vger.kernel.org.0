Return-Path: <linux-fsdevel+bounces-44233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF4A664C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 02:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6122717D59F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 01:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4114A0B7;
	Tue, 18 Mar 2025 01:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WZNH9c04";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g81lNsWx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WZNH9c04";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g81lNsWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C913D891
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260478; cv=none; b=g3WiZlZkQdKZqVDqEEYlIVCQvKOPZSrd40e1aFthc6k+EP0bYCgYpUIT3NE9LyPJfxuI8ksMJcw+o+XBN8J1C/0pGTGzBNvNMCV8xyWrl4Y4cfrNO1g1puw8CsG8SyQ4NPtUjBmsnL48V10bvavqV+tcN6+bIHCzdU18hMk0RKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260478; c=relaxed/simple;
	bh=xSj40BbHmDdg0wjOaoxV3IAxz8W8piz7XYcG1WqT8Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFGLUTz4HByvnPiSuvOZ7mkQKFesi7Q97Q+A9N7DrZJ5JliTtAHLvVV0PwGZLzZfh2bDhkj3nTH68VF1U4ERAh9lBxVqebA4WgCkmr+JG+UKBaLO1DtNk3HXSCOjHJNoIrtBJDfxofBVL26bmI0y3rufFaiIy0XgJ++9Q8fdfZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WZNH9c04; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g81lNsWx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WZNH9c04; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g81lNsWx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC62121D28;
	Tue, 18 Mar 2025 01:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742260474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUGeCMcO6sAX6QYQ3Gxmvzt9f9j7wj/VBO8lpxh+YeE=;
	b=WZNH9c04XAYdpgwwio5s0/IwR6Xq58WuveOeDvLDS+ATx0RjR5QsxgPt3UbNb3ZI0TtYuh
	boIvqhAi5irWNk8nbIAUJYwTzH/UU1G8LJUaiS2gvfOsH9+3Cu1ok5Vdr+S6fjjN1132kT
	hGNfO+KxX8ucz2aSi5OfLtILY0hwaR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742260474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUGeCMcO6sAX6QYQ3Gxmvzt9f9j7wj/VBO8lpxh+YeE=;
	b=g81lNsWxGcqPeIyDW41of8u7PSbvVZ+iauGryMlbVyX1VhXPvSqDDR5AjiLxCwqmHSL0ah
	rM0av090mkN6FcCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742260474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUGeCMcO6sAX6QYQ3Gxmvzt9f9j7wj/VBO8lpxh+YeE=;
	b=WZNH9c04XAYdpgwwio5s0/IwR6Xq58WuveOeDvLDS+ATx0RjR5QsxgPt3UbNb3ZI0TtYuh
	boIvqhAi5irWNk8nbIAUJYwTzH/UU1G8LJUaiS2gvfOsH9+3Cu1ok5Vdr+S6fjjN1132kT
	hGNfO+KxX8ucz2aSi5OfLtILY0hwaR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742260474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUGeCMcO6sAX6QYQ3Gxmvzt9f9j7wj/VBO8lpxh+YeE=;
	b=g81lNsWxGcqPeIyDW41of8u7PSbvVZ+iauGryMlbVyX1VhXPvSqDDR5AjiLxCwqmHSL0ah
	rM0av090mkN6FcCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 047E5139D2;
	Tue, 18 Mar 2025 01:14:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WD6hK/fI2GdxIgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 18 Mar 2025 01:14:31 +0000
Date: Tue, 18 Mar 2025 12:14:24 +1100
From: David Disseldorp <ddiss@suse.de>
To: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>
Cc: "jsperbeck@google.com" <jsperbeck@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "lukas@wunner.de" <lukas@wunner.de>, "wufan@linux.microsoft.com"
 <wufan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] initramfs: Add size validation to prevent tmpfs
 exhaustion
Message-ID: <20250318121424.614148e1.ddiss@suse.de>
In-Reply-To: <BYAPR12MB3205A7903D8EF06EFF8F575AD5DF2@BYAPR12MB3205.namprd12.prod.outlook.com>
References: <BYAPR12MB3205F96E780AA2F00EAD16E8D5D22@BYAPR12MB3205.namprd12.prod.outlook.com>
	<20250317182157.7adbc168.ddiss@suse.de>
	<BYAPR12MB3205A7903D8EF06EFF8F575AD5DF2@BYAPR12MB3205.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[outlook.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Mon, 17 Mar 2025 09:41:35 +0000, Stephen Eta Zhou wrote:
...
> Before the init process runs, initramfs needs to be decompressed to tmpfs and become the root file system (rootfs). If there is insufficient tmpfs space after decompression, init may not be able to run at all, causing the system to crash or panic.
> 
> Letting the init process decide whether it is sufficient means that the initramfs must be decompressed first, which may have filled up tmpfs, making the entire system unusable, rather than a controllable error handling process.
> 
> This problem is more obvious in extreme cases, for example:
> 
> 1. After initramfs is decompressed, there is only a small amount of available space in tmpfs, causing early-user-space tasks such as mount and udevadm to fail, affecting device initialization.

It's still not clear to me why early-user-space can't determine this
before attempting to mount, etc. It's in a better position to know the
resource requirements of what it's going to run.

> 2. On embedded devices, tmpfs is usually configured small, and insufficient space is found after decompression, which directly leads to boot failure.
> 
> The reason why the check is performed before decompression is to expose the problem in advance to avoid the passive failure mode of insufficient space after decompression.
> Calculating the theoretically required tmpfs resources and making judgments in advance can reduce unnecessary I/O operations and provide clearer error reports to help users adjust the initramfs size or tmpfs configuration.
> My idea is to expose problems as early as possible. If problems occur during operation, it may be more troublesome to troubleshoot or bring unnecessary risks.

There's room for improvement WRT how out-of-memory failures are reported
and handled during decompression and I/O. However, adding an extra pass
and some arbitrary free-space logic doesn't improve the situation IMO.

Cheers, David

