Return-Path: <linux-fsdevel+bounces-53629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AF5AF1483
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA574A61F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A822266EFB;
	Wed,  2 Jul 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tU/WrFHR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MIwXesIo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tU/WrFHR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MIwXesIo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52923C503
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456961; cv=none; b=gQAMAx22udXCZbxcRUo+m06EFOQ7XqXNpuzEknn9DV3Dv+XFDAD5SFpcnB7atVWRauavJxaefwIJq7GVOaam5FkVmEo84vEJ0yDY1PBeBmva/1gTu+GCRVEKzbCYoCu0C5hMjs8323kflDoWTFGlbBu43VdG7emCe6Tmz0Exh3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456961; c=relaxed/simple;
	bh=qWnyvQcndsVB1NxTjPXew1S5g/yDqRUWdFVcFyfOcvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYfe4fNDPzA1C8Za/TdDd83fxgiYujFllktHr+osjRbSbGwbxMu/Q13NcQow+TUu/UtciiJZ2POaM3yU50JSl+Fbv629ZN/iBArcFg1ut3+bSbKgxajafFzfYoYzMj7Z98BAOqOzMjRNgV7Blzkb03CzCWyJq9OqjNajVIIfFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tU/WrFHR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MIwXesIo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tU/WrFHR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MIwXesIo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AC182116F;
	Wed,  2 Jul 2025 11:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751456957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AnPBExCtsDj4n5vi94luf18NZFEykytoQmIPPeFAX2A=;
	b=tU/WrFHR3dRum2miR5UWAkM4WdQn91FfDDvJRwBUXqS+8lnQBGGWjtKvfsa7e62L06du2m
	/f6EasQoS6o9nlBk1Rou9QkPfszWLJT+tKXt2918kImQgU8vll2c2Z2EsLUMjjErP8UmNv
	OR38Bnnn78OFRNvm6BpY447YzZ5pp+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751456957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AnPBExCtsDj4n5vi94luf18NZFEykytoQmIPPeFAX2A=;
	b=MIwXesIoyaxSx9h9oTbaqaLitdYPbAVmowe5rhU7YVKSA6Fso7HmtMhsa79sOvshLUmDjk
	li8mxlscBN8dVRDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751456957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AnPBExCtsDj4n5vi94luf18NZFEykytoQmIPPeFAX2A=;
	b=tU/WrFHR3dRum2miR5UWAkM4WdQn91FfDDvJRwBUXqS+8lnQBGGWjtKvfsa7e62L06du2m
	/f6EasQoS6o9nlBk1Rou9QkPfszWLJT+tKXt2918kImQgU8vll2c2Z2EsLUMjjErP8UmNv
	OR38Bnnn78OFRNvm6BpY447YzZ5pp+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751456957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AnPBExCtsDj4n5vi94luf18NZFEykytoQmIPPeFAX2A=;
	b=MIwXesIoyaxSx9h9oTbaqaLitdYPbAVmowe5rhU7YVKSA6Fso7HmtMhsa79sOvshLUmDjk
	li8mxlscBN8dVRDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD5AB13A24;
	Wed,  2 Jul 2025 11:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6lvGLrwcZWgKDgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 02 Jul 2025 11:49:16 +0000
Date: Wed, 2 Jul 2025 12:49:10 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: linux-kernel@vger.kernel.org, pmladek@suse.com, rostedt@goodmis.org, 
	john.ogness@linutronix.de, senozhatsky@chromium.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] KASAN: slab-out-of-bounds in vsnprintf triggered by large
 stack frame
Message-ID: <i5f3iec7iprrqecr7r7wqhu5xl5cjujizwctsy3tphq2xzxck2@ieszua2sryec>
References: <9052e70eb1cf8571c1b37bb0cee19aaada7dfe3d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9052e70eb1cf8571c1b37bb0cee19aaada7dfe3d.camel@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Tue, Jul 01, 2025 at 10:11:55PM +0530, Shardul Bankar wrote:
> Hello,
> 
> I would like to report a slab-out-of-bounds bug that can be reliably
> reproduced with a purpose-built kernel module. This report was
> initially sent to security@kernel.org, and I was advised to move it to
> the public lists.
> 
> I have confirmed this issue still exists on the latest mainline kernel
> (v6.16.0-rc4).
> 
> Bug Summary:
> 
> The bug is a KASAN-reported slab-out-of-bounds write within vsnprintf.
> It appears to be caused by a latent memory corruption issue, likely
> related to the names_cache slab.
> 
> The vulnerability can be triggered by loading a kernel module that
> allocates an unusually large stack frame. When compiling the PoC
> module, GCC explicitly warns about this: warning: the frame size of
> 29760 bytes is larger than 2048 bytes. This "stack grooming" positions
> the task's stack to overlap with a stale pointer from a freed
> names_cache object. A subsequent call to pr_info() then uses this
> corrupted value, leading to the out-of-bounds write.
> 
> Reproducer:
> 
> The following minimal kernel module reliably reproduces the crash on my
> x86-64 test system.
> 
> #include <linux/init.h>
> #include <linux/module.h>
> #include <linux/printk.h>
> 
> #define STACK_FOOTPRINT (3677 * sizeof(void *))
> 
> static int __init final_poc_init(void)
> {
>     volatile char stack_eater[STACK_FOOTPRINT];
>     stack_eater[0] = 'A'; // Prevent optimization
> 
>     pr_info("Final PoC: Triggering bug with controlled stack
> layout.\n");
> 
>     return -EAGAIN;
> }
> 
> static void __exit final_poc_exit(void) {}
> 
> module_init(final_poc_init);
> module_exit(final_poc_exit);
> MODULE_LICENSE("GPLv2");
> MODULE_DESCRIPTION("A PoC to trigger a kernel bug by creating a large
> stack frame.");
> 
>

There's no issue here. You're using an extremely buggy module with a huge local
variable that far exceeds the stack size, and proving it crashes. Like yeah, of
course it crashes, you gave it a broken module.

Kernel stacks do not expand. You're overwriting other memory in the direct map
with this. CONFIG_VMAP_STACK=y helps remedy this, but still only adds a single
page for the stack guard.

-- 
Pedro

