Return-Path: <linux-fsdevel+bounces-74827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDxkAOihcGlyYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:52:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B379A54BAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98C4C389DED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3390847B434;
	Wed, 21 Jan 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hIuph1pJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IfkkQo0e";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hIuph1pJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IfkkQo0e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226054418C1
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988607; cv=none; b=R65Jl6b1tEYjhq+zj3l0msWX/uhxF4dYJvcZkmJEo+p92eEpyfgs2roULCRId/R6ui4H7M9R6VZWqD3LoyPvabKGS+HQtt8dqN0hjcWzhx7IhVJmQiQ1sxDBYlMjlgItd9R0+9Fb2baqzIXivIPJgs3Uj76JgeIw1ug+YebZw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988607; c=relaxed/simple;
	bh=RBaVW8QiXIimcNAs6RHXdJcRQir6tWSgqPHafqoDoqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/Hv9fHvCYPHZLxyJLN1acSPEutIDsyQJ2rdPdwUxr1uVtuBe5QIdtWucXm1qrAHtySvOpEZRzBCH7VouLIcJx1iZlsLgv6wdgj5iudadieoTR1FFAKrQRvJrp257VaFER8kb9DSqFvqunB50bhBN7RVOyS2p9axhG0PX8MkYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hIuph1pJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IfkkQo0e; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hIuph1pJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IfkkQo0e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EE105BCD2;
	Wed, 21 Jan 2026 09:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768988604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIpS+bAv+95yzB90e5e2wweMxrjxygumQ9XfX29cFWI=;
	b=hIuph1pJKb/p1p6H2F0R33SWnRKQmCdbEiMrYinwf17LCHjBqMepkv+0RUCxnogcK94edt
	j5uE2baxBO3NQeUsD1Dhcm9Z03b89lBhEdN3jrB+e03/NfPi1dyqGbFVT14mVLHfOaO89o
	NH9dVrq3Ppg88t1X0ZZRrO+sQFljtk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768988604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIpS+bAv+95yzB90e5e2wweMxrjxygumQ9XfX29cFWI=;
	b=IfkkQo0eyXL0gB786oxevf5bdd1q6lpJ3XQTqmEbhnqbacxvTdKZEIidkInm72Exz9D9Nh
	rJf2odBeh8trTrDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hIuph1pJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IfkkQo0e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768988604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIpS+bAv+95yzB90e5e2wweMxrjxygumQ9XfX29cFWI=;
	b=hIuph1pJKb/p1p6H2F0R33SWnRKQmCdbEiMrYinwf17LCHjBqMepkv+0RUCxnogcK94edt
	j5uE2baxBO3NQeUsD1Dhcm9Z03b89lBhEdN3jrB+e03/NfPi1dyqGbFVT14mVLHfOaO89o
	NH9dVrq3Ppg88t1X0ZZRrO+sQFljtk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768988604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIpS+bAv+95yzB90e5e2wweMxrjxygumQ9XfX29cFWI=;
	b=IfkkQo0eyXL0gB786oxevf5bdd1q6lpJ3XQTqmEbhnqbacxvTdKZEIidkInm72Exz9D9Nh
	rJf2odBeh8trTrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 123A53EA63;
	Wed, 21 Jan 2026 09:43:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8xxSAryfcGnpSQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 21 Jan 2026 09:43:24 +0000
Date: Wed, 21 Jan 2026 20:42:05 +1100
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] initramfs_test: test header fields with 0x hex
 prefix
Message-ID: <20260121201936.0580e4de.ddiss@suse.de>
In-Reply-To: <aW__NwDBkzq_bePk@smile.fi.intel.com>
References: <20260120204715.14529-1-ddiss@suse.de>
	<20260120204715.14529-3-ddiss@suse.de>
	<aW__NwDBkzq_bePk@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74827-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: B379A54BAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 00:18:31 +0200, Andy Shevchenko wrote:

> On Wed, Jan 21, 2026 at 07:32:33AM +1100, David Disseldorp wrote:
> > cpio header fields are 8-byte hex strings, but one "interesting"
> > side-effect of our historic simple_str[n]toul() use means that a "0x"
> > prefixed header field will be successfully processed when coupled
> > alongside a 6-byte hex remainder string.  
> 
> Should mention that this is against specifications.
> 
> > Test for this corner case by injecting "0x" prefixes into the uid, gid
> > and namesize cpio header fields. Confirm that init_stat() returns
> > matching uid and gid values.  
> 
> This is should be considered as an invalid case and I don't believe
> we ever had that bad header somewhere. The specification is clear
> that the number has to be filled with '0' to the most significant
> byte until all 8 positions are filled.
> 
> If any test case like this appears it should not be fatal.

Yes, the test case can easily be changed to expect an unpack_to_rootfs()
error (or dropped completely). The purpose is just to ensure that the
user visible change is a concious decision rather than an undocumented
side effect.

Cheers, David

