Return-Path: <linux-fsdevel+bounces-76302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPvNMsgig2nWhwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 11:43:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2118E4B5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 11:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DB203016482
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613533E8C61;
	Wed,  4 Feb 2026 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CCTfPAdU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PeSBqmZm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CCTfPAdU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PeSBqmZm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C023A7855
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201794; cv=none; b=C6JjJgQQ0gwWCm62Kkhk4pGL1tcdlUpJROxuI/hzQS/xFaaGHRuf4aBVjCmuPafdaqNCydc8lx7F2o3hh/AATrOxcOUp+36ml4JD+XJ08CBNSh/AKCY84ii9kWyP0cVTehHt7Z8f41YtwrwY9Ob0hmlAacJyEUgpb7HM5qs9W7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201794; c=relaxed/simple;
	bh=0Of5KLtk/hsmPIVgigjpbZC15PdmAXd0yf/vSzSwmg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIstR2EW9j+3kbv/Sbm0QXGY6C6aAOSdJae6fa+k6eRaDObKss8Y9/ExJtwVaanUje00ZimSNdZNB1qOGddlGwIOe27AG7hOCw77JrQOxgBAKoGs8dq0Y6CtTKgra/5SCT389a4BY8/cMbvQQeTOKM6A5XMI4WON/HrHafgQOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CCTfPAdU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PeSBqmZm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CCTfPAdU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PeSBqmZm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21DBD5BCE8;
	Wed,  4 Feb 2026 10:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770201786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwYHr9btE2xSFgxuQ0FzTm80tRsij+0+zqIRF9HYs9M=;
	b=CCTfPAdUC02fEcFWv5syYS7rmicvRg8FXw0rKJrAWwjSMaFygM1MtC7j1ZyAbsHFqrXVZS
	ZHyuPLZNQw0LKZ3DNYgPv0lH2BjxUqFcEd5vIRf+9PIJVQj26d5lYk2KVf1c8pDV5a5v8k
	aHRa9VH45yuJ85mdhISjHZl/YZbXC0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770201786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwYHr9btE2xSFgxuQ0FzTm80tRsij+0+zqIRF9HYs9M=;
	b=PeSBqmZmHHsuTtTeF1vyTer5HIs4z3XTdtkngJqbwiPxgpWaWs1CnXDCXWuJnHr6Rn26Ea
	Q7BoKoockNW2+fDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CCTfPAdU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PeSBqmZm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770201786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwYHr9btE2xSFgxuQ0FzTm80tRsij+0+zqIRF9HYs9M=;
	b=CCTfPAdUC02fEcFWv5syYS7rmicvRg8FXw0rKJrAWwjSMaFygM1MtC7j1ZyAbsHFqrXVZS
	ZHyuPLZNQw0LKZ3DNYgPv0lH2BjxUqFcEd5vIRf+9PIJVQj26d5lYk2KVf1c8pDV5a5v8k
	aHRa9VH45yuJ85mdhISjHZl/YZbXC0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770201786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwYHr9btE2xSFgxuQ0FzTm80tRsij+0+zqIRF9HYs9M=;
	b=PeSBqmZmHHsuTtTeF1vyTer5HIs4z3XTdtkngJqbwiPxgpWaWs1CnXDCXWuJnHr6Rn26Ea
	Q7BoKoockNW2+fDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B4073EA63;
	Wed,  4 Feb 2026 10:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gVm5Aroig2leEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Feb 2026 10:43:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A8493A09D8; Wed,  4 Feb 2026 11:43:05 +0100 (CET)
Date: Wed, 4 Feb 2026 11:43:05 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, John Groves <John@groves.net>, 
	Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>, 
	Horst Birthelmer <horst@birthelmer.de>, lsf-pc <lsf-pc@lists.linux-foundation.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <yndtg2jbj55fzd2kkhsmel4pp5ll5xfvfiaqh24tdct3jiqosd@jzbfzf3rrxrd>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
 <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com>
 <CAJnrk1YKDi9e-eTQyGBD-rFScxGTcsfz3tnmnE_EshPd18aMrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YKDi9e-eTQyGBD-rFScxGTcsfz3tnmnE_EshPd18aMrw@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,vger.kernel.org,kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76302-lists,linux-fsdevel=lfdr.de];
	SUBJECT_HAS_QUESTION(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F2118E4B5F
X-Rspamd-Action: no action

On Wed 04-02-26 01:22:02, Joanne Koong wrote:
> On Mon, Feb 2, 2026 at 11:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > I think that at least one question of interest to the wider fs audience is
> > >
> > > Can any of the above improvements be used to help phase out some
> > > of the old under maintained fs and reduce the burden on vfs maintainers?
> 
> I think it might be helpful to know ahead of time where the main
> hesitation lies. Is it performance? Maybe it'd be helpful if before
> May there was a prototype converting a simpler filesystem (Darrick and
> I were musing about fat maybe being a good one) and getting a sense of
> what the delta is between the native kernel implementation and a
> fuse-based version? In the past year fuse added a lot of new
> capabilities that improved performance by quite a bit so I'm curious
> to see where the delta now lies. Or maybe the hesitation is something
> else entirely, in which case that's probably a conversation better
> left for May.

I'm not sure which filesystems Amir had exactly in mind but in my opinion
FAT is used widely enough to not be a primary target of this effort. It
would be rather filesystems like (random selection) bfs, adfs, vboxfs,
minix, efs, freevxfs, etc. The user base of these is very small, testing is
minimal if possible at all, and thus the value of keeping these in the
kernel vs the effort they add to infrastructure changes (like folio
conversions, iomap conversion, ...) is not very favorable.

For these the biggest problem IMO is actually finding someone willing to
invest into doing (and testing) the conversion. I don't think there are
severe technical obstacles for most of them.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

