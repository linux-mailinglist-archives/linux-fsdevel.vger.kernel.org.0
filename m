Return-Path: <linux-fsdevel+bounces-42081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCB4A3C4D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26451179E70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E331FF1DB;
	Wed, 19 Feb 2025 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bvwGXcjG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WfVoEapw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bvwGXcjG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WfVoEapw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FF1FE47B
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982024; cv=none; b=j6ho7Yyd0kOpBOkcip4nFrbLYpvaM7s/t99MH5ENu85ZJwE1zXQiXqjycMR/gP8GOc7gqG0+5UbZ9EimpWC+ZN5Fm0yvwCfGhoGbgXBIsT/cp3GbPYbJLpnNkUxoSUeSfC20/DWnfhz9vPWHOItD5COxk5jR4vEpP75Kn+xat9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982024; c=relaxed/simple;
	bh=oWE/B+cS5Sj7ipZO4LJ/VQju3qnVg9yBsznUUUgdgN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugQ9ChreA/vMqhmyIM7lnXXrCtaj2Fo+sfSuoeF7uVuSbI0dgraKMfm5Pyq5aEdU+SSVRpvVrdXGM8oW37geGpFIxMqMS/1P+VXmlnpN7mb5p7l3k5qtOdUOX5R8YXSfxLByhxBGu7r+Zzy77bLBHyMtFtU6QjE8X/rvMOeKFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bvwGXcjG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WfVoEapw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bvwGXcjG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WfVoEapw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 665EB211B3;
	Wed, 19 Feb 2025 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739982021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6V+BUY/JEvJ94fWLWOg0Xs7qQ+LQG+BjLQoaO/Fp5k=;
	b=bvwGXcjG14SPhpCsD0rBKONmr0b0jzzxODLq1NRDgyb4eBH5/kVaYWu8AQBkFn2AgbhQko
	prCq+iYhlDcOlwuGPBnojDVGsh2h3MIkjh3q0iloPbeWsO2VTDP009XJFfkkjkjV1iX0P6
	nq2UN9RCKur1NjqjAkKNeetebFA5cRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739982021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6V+BUY/JEvJ94fWLWOg0Xs7qQ+LQG+BjLQoaO/Fp5k=;
	b=WfVoEapwxOvLlq96tBnm0CHJU/7usq7IAU7z2TjYxEJ6vsgYYOrvPowHQIqf7QNFCnbF6A
	QVtfh6q/L5J25BAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739982021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6V+BUY/JEvJ94fWLWOg0Xs7qQ+LQG+BjLQoaO/Fp5k=;
	b=bvwGXcjG14SPhpCsD0rBKONmr0b0jzzxODLq1NRDgyb4eBH5/kVaYWu8AQBkFn2AgbhQko
	prCq+iYhlDcOlwuGPBnojDVGsh2h3MIkjh3q0iloPbeWsO2VTDP009XJFfkkjkjV1iX0P6
	nq2UN9RCKur1NjqjAkKNeetebFA5cRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739982021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6V+BUY/JEvJ94fWLWOg0Xs7qQ+LQG+BjLQoaO/Fp5k=;
	b=WfVoEapwxOvLlq96tBnm0CHJU/7usq7IAU7z2TjYxEJ6vsgYYOrvPowHQIqf7QNFCnbF6A
	QVtfh6q/L5J25BAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58048137DB;
	Wed, 19 Feb 2025 16:20:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nkkmFcUEtmecRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 19 Feb 2025 16:20:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0AE27A08A7; Wed, 19 Feb 2025 17:20:17 +0100 (CET)
Date: Wed, 19 Feb 2025 17:20:17 +0100
From: Jan Kara <jack@suse.cz>
To: Brian Mak <makb@juniper.net>
Cc: Michael Stapelberg <michael@stapelberg.ch>, 
	Christian Brauner <brauner@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Oleg Nesterov <oleg@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Message-ID: <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de>
 <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 18-02-25 19:53:51, Brian Mak wrote:
> On Feb 18, 2025, at 12:54 AM, Michael Stapelberg <michael@stapelberg.ch> wrote:
> 
> > I think in your testing, you probably did not try the eu-stack tool
> > from the elfutils package, because I think I found a bug:
> 
> Hi Michael,
> 
> Thanks for the report. I can confirm that this issue does seem to be
> from this commit. I tested it with Juniper's Linux kernel with and
> without the changes.
> 
> You're correct that the original testing done did not include the
> eu-stack tool.
> 
> > Current elfutils cannot symbolize core dumps created by Linux 6.12+.
> > I noticed this because systemd-coredump(8) uses elfutils, and when
> > a program crashed on my machine, syslog did not show function names.
> > 
> > I reported this issue with elfutils at:
> > https://urldefense.com/v3/__https://sourceware.org/bugzilla/show_bug.cgi?id=32713__;!!NEt6yMaO-gk!DbttKuHxkBdrV4Cj9axM3ED6mlBHXeQGY3NVzvfDlthl-K39e9QIrZcwT8iCXLRu0OivWRGgficcD-aCuus$
> > …but figured it would be good to give a heads-up here, too.
> > 
> > Is this breakage sufficient reason to revert the commit?
> > Or are we saying userspace just needs to be updated to cope?
> 
> The way I see it is that, as long as we're in compliance with the
> applicable ELF specifications, then the issue lies with userspace apps
> to ensure that they are not making additional erroneous assumptions.
> 
> However, Eric mentioned a while ago in v1 of this patch that he believes
> that the ELF specification requires program headers be written in memory
> order. Digging through the ELF specifications, I found that any loadable
> segment entries in the program header table must be sorted on the
> virtual address of the first byte of which the segment resides in
> memory.
> 
> This indicates that we have deviated from the ELF specification with
> this commit. One thing we can do to remedy this is to have program
> headers sorted according to the specification, but then continue dumping
> in VMA size ordering. This would make the dumping logic significantly
> more complex though.
> 
> Seeing how most popular userspace apps, with the exception of eu-stack,
> seem to work, we could also just leave it, and tell userspace apps to
> fix it on their end.

Well, it does not seem eu-stack is that unpopular and we really try hard to
avoid user visible regressions. So I think we should revert the change. Also
the fact that the patch breaks ELF spec is an indication there may be other
tools that would get confused by this and another reason for a revert...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

