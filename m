Return-Path: <linux-fsdevel+bounces-29954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0085984234
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9965CB29A12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453115539F;
	Tue, 24 Sep 2024 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TaT/Zkbg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+q2davD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TaT/Zkbg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+q2davD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC05146D59
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170085; cv=none; b=X+UcqT9Wven5hM8mSwvWzYWEidfoJuUXCvcC71bgCur6ezIXIPa4BpfFhsM7LSffejpIThQ3kZi438144YCKipgpHE7lZ+jftRykI+bq4Z5g3/4xIzRqhKvxu4eVLgpNbnYuOp7ESgVvIwsJwv63CKqh/IBrS5V77k2TgYaU394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170085; c=relaxed/simple;
	bh=tReYtK0psAEf8vOcHrvE5/wzXgPUJPY1+z2/ehCf7DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM/+PUcrLfdNhosNwrR46RtSKL3N5azQRPwbkCSozJ60WWW1lIWGZ8Y0TZc34B1B3oLrYRibzzb8FctoQr5sHjgagfWgjf+NvvXu5fcrR5j/pUERlME1TM52DsW8KNEg8XcOBoGlCGdJI4dfM9I1nc6+LzYs0BtX15BKU2xyUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TaT/Zkbg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+q2davD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TaT/Zkbg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+q2davD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 005A821AFD;
	Tue, 24 Sep 2024 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727170082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSwk1DCYrARQYrG/J7t94mfk1TfePjycEa8j231jMmo=;
	b=TaT/ZkbgQ5H1EaagiFz/7V4unToXFEzu82jkxvW853lSKjasUo8M5mtwWvM44tAeu7C/lH
	55zi1CTBwWEl7IHxDpYvpohByQQLfqfrc4HD+qs6/Vh6jwP5CQMA3t//rX2GRwWacz4eI2
	nfFr/KlI7SJw2kFf9cb+A9G4CY789vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727170082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSwk1DCYrARQYrG/J7t94mfk1TfePjycEa8j231jMmo=;
	b=F+q2davDtZ9H7OdIzaV0QM+hqLvWu16JORUPi1GG00D3M6de7OiRSRoRNCGZVpeGf1rh3n
	UwTCD+a24W3c1xCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727170082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSwk1DCYrARQYrG/J7t94mfk1TfePjycEa8j231jMmo=;
	b=TaT/ZkbgQ5H1EaagiFz/7V4unToXFEzu82jkxvW853lSKjasUo8M5mtwWvM44tAeu7C/lH
	55zi1CTBwWEl7IHxDpYvpohByQQLfqfrc4HD+qs6/Vh6jwP5CQMA3t//rX2GRwWacz4eI2
	nfFr/KlI7SJw2kFf9cb+A9G4CY789vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727170082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VSwk1DCYrARQYrG/J7t94mfk1TfePjycEa8j231jMmo=;
	b=F+q2davDtZ9H7OdIzaV0QM+hqLvWu16JORUPi1GG00D3M6de7OiRSRoRNCGZVpeGf1rh3n
	UwTCD+a24W3c1xCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBF4713AA8;
	Tue, 24 Sep 2024 09:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XxasNSGG8mafCgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Sep 2024 09:28:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6E4B2A088D; Tue, 24 Sep 2024 11:27:57 +0200 (CEST)
Date: Tue, 24 Sep 2024 11:27:57 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] Fsnotify changes for 6.12-rc1
Message-ID: <20240924092757.lev6mwrmhpcoyjtu@quack3>
References: <20240923110348.tbwihs42dxxltabc@quack3>
 <CAHk-=wiE1QQ-_kTKSf4Ur6JEjMtieu7twcLqu_CH4r1daTBiCw@mail.gmail.com>
 <20240923191322.3jbkvwqzxvopt3kb@quack3>
 <CAHk-=whm4QfqzSJvBQFrCi4V5SP_iD=DN0VkxfpXaA02PKCb6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whm4QfqzSJvBQFrCi4V5SP_iD=DN0VkxfpXaA02PKCb6Q@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 23-09-24 12:36:14, Linus Torvalds wrote:
> On Mon, 23 Sept 2024 at 12:13, Jan Kara <jack@suse.cz> wrote:
> >
> > Sure, the details are in some of the commit messages but you're right I
> > should have summarized them in the pull request as well:
> 
> So I really only looked at the parts I know - the VM side, and
> honestly, I threw up in my mouth a bit there.
> 
> Do we really want to call that horrific fsnotify path for the case
> where we already have the page cached? This is a fairly critical
> fastpath, and not giving out page cache pages means that now you are
> literally violating mmap coherency.
> 
> If the aim is to fill in caches on first access, then if we already
> have a page cache page, it's by definition not first access any more!

Well, that's what actually should be happening. do_read_fault() will do
should_fault_around(vmf) -> yes -> do_fault_around() and
filemap_map_pages() will insert all pages in the page cache into the page
table page before we even get to filemap_fault() calling our fsnotify
hooks. Note that filemap_map_pages() returns VM_FAULT_NOPAGE if it has
mapped the page for the faulting address which makes the page fault code
bail out even before ->fault handler is even called.

That being said now that I'm rereading this code again, write faults will
always end up in the fault handler so we'll generate PRE_WRITE events for
them on each write fault (if someone is watching for it). Not sure if write
faults matter that much and I don't see easy way around that as that's the
promise of PRE_WRITE event...

Do the above explanations make the VM changes acceptable for you? I agree
it isn't exactly beautiful but it should work.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

