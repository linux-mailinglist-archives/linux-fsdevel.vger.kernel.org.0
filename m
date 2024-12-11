Return-Path: <linux-fsdevel+bounces-37072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C569ED1BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 17:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AF5281141
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD41DE3A9;
	Wed, 11 Dec 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SfTs3FVh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E/WlTmkR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SfTs3FVh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E/WlTmkR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02C1DD88D;
	Wed, 11 Dec 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934610; cv=none; b=fkca95WQNeHvtbce/Dp7qopHRXr+l4L7Z/xh2QKe8zUI7iux2zSYCjQC0vkJfHGFa+MtaATGYC7OFV1keYHBYytKFI40pmlThLXV5RZkb/hcH8auLTfa4mpOQ3j0YXvkyygWmvqhDTgCz/Hjq/Riw+QJY1W+Lu75l74NjiNMRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934610; c=relaxed/simple;
	bh=ugD1/9RfvopYK+t6OBJAj2qhfWD1ah5i/AWvmW/o8tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS1j4Di3PGRIHg3ZyPLnIS1hmWikzab0izFnTM5ndfCrAeFHkjh7i5n4N9Djk07FpxSbv5S5KD0E00qp0xxbowCZx6pDqVS03Yd4X8IGGDnrGBac8YC/Q7qZU1d4b/P86bNNuJi09yIP0eoMfeeDMkOh+W/G4oMW18IgYCrC5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SfTs3FVh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E/WlTmkR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SfTs3FVh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E/WlTmkR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C30FA1F74B;
	Wed, 11 Dec 2024 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733934606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3twRuAkYpHgCNmk1tjJ/d+LtY2uXM1gPNvHwK+vKo5g=;
	b=SfTs3FVh+l0sYUrKpZENXj63N+SojRDtvsiUbjl3KO1N9JmCEVfxE0YrbLrxyB8VT1/3FF
	wxFI3FBtTdkzF8qY6kqhVA7ve+LKUFqSaETTtVUd4aG1l0jGEdmkjVUqUdg3geI6eS82yy
	Yx9YEqI9WAiWqbPEw4Qndf1Om4l65ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733934606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3twRuAkYpHgCNmk1tjJ/d+LtY2uXM1gPNvHwK+vKo5g=;
	b=E/WlTmkRIUkUF9Qq1A+G3/+Pekx2KQvgk/b/FSP2OL2X80rDqU2jF+m27J6+LP9IcUZBoO
	WQokHPkDiqcsn6Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SfTs3FVh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="E/WlTmkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733934606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3twRuAkYpHgCNmk1tjJ/d+LtY2uXM1gPNvHwK+vKo5g=;
	b=SfTs3FVh+l0sYUrKpZENXj63N+SojRDtvsiUbjl3KO1N9JmCEVfxE0YrbLrxyB8VT1/3FF
	wxFI3FBtTdkzF8qY6kqhVA7ve+LKUFqSaETTtVUd4aG1l0jGEdmkjVUqUdg3geI6eS82yy
	Yx9YEqI9WAiWqbPEw4Qndf1Om4l65ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733934606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3twRuAkYpHgCNmk1tjJ/d+LtY2uXM1gPNvHwK+vKo5g=;
	b=E/WlTmkRIUkUF9Qq1A+G3/+Pekx2KQvgk/b/FSP2OL2X80rDqU2jF+m27J6+LP9IcUZBoO
	WQokHPkDiqcsn6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B41151344A;
	Wed, 11 Dec 2024 16:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VQjwKw6+WWfKVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Dec 2024 16:30:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 60CDAA0894; Wed, 11 Dec 2024 17:30:06 +0100 (CET)
Date: Wed, 11 Dec 2024 17:30:06 +0100
From: Jan Kara <jack@suse.cz>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Klara Modin <klarasmodin@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 16/19] fsnotify: generate pre-content permission event
 on page fault
Message-ID: <20241211163006.2r2mxe7vddzgk7ka@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <aa56c50ce81b1fd18d7f5d71dd2dfced5eba9687.1731684329.git.josef@toxicpanda.com>
 <5d0cd660-251c-423a-8828-5b836a5130f9@gmail.com>
 <391b9d5f-ec3a-4c90-8345-5dab929917f7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <391b9d5f-ec3a-4c90-8345-5dab929917f7@infradead.org>
X-Rspamd-Queue-Id: C30FA1F74B
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com,fb.com,vger.kernel.org,suse.cz,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 10-12-24 13:12:01, Randy Dunlap wrote:
> On 12/8/24 8:58 AM, Klara Modin wrote:
> >> +/**
> >> + * filemap_fsnotify_fault - maybe emit a pre-content event.
> >> + * @vmf:    struct vm_fault containing details of the fault.
> >> + * @folio:    the folio we're faulting in.
> >> + *
> >> + * If we have a pre-content watch on this file we will emit an event for this
> >> + * range.  If we return anything the fault caller should return immediately, we
> >> + * will return VM_FAULT_RETRY if we had to emit an event, which will trigger the
> >> + * fault again and then the fault handler will run the second time through.
> >> + *
> >> + * This is meant to be called with the folio that we will be filling in to make
> >> + * sure the event is emitted for the correct range.
> >> + *
> >> + * Return: a bitwise-OR of %VM_FAULT_ codes, 0 if nothing happened.
> >> + */
> >> +vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
> > 
> > The parameters mentioned above do not seem to match with the function.
> 
> 
> which causes a warning:
> 
> mm/filemap.c:3289: warning: Excess function parameter 'folio' description in 'filemap_fsnotify_fault'

Thanks, fixed up!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

