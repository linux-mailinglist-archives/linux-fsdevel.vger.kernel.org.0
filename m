Return-Path: <linux-fsdevel+bounces-77024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J8FC1XkjWms8QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 15:31:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EED12E41A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 15:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB30A304CCC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3FE17ADE0;
	Thu, 12 Feb 2026 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IJRLzN9m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e/dSV7Rh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IJRLzN9m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e/dSV7Rh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847712629D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770906701; cv=none; b=MREYQ2knwEImm+L6nTRckFE71lx5ZKcbQcq3go6Y0uiMCj/ELk2w/XYenIhrE/plZf/FP2AN55EblN9S5JEj4Eu5KbahOsodGqot4Nn1JIqfp4ZNY8lr369MKETbzdg0GkYvSmkxeqlBdyYKlp6EutLa7X0iD2h9hLz20GVSrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770906701; c=relaxed/simple;
	bh=qGbkvdj8pNeSKXGYzPX5ASM3qGbCB9AOL2fFJrEPj88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbdYlevIGsn2/ctbS2b4oBeVO7tMs9h3a247GtfBCiV4VRmrC9Kz9jftjo/c0mpWfd45B1aHVfsW5nDrvSaP2ufpUr8bs9syjC2CD47RDjPJST98gcj7yFPzjkKzdHDJcGOCghWv//yM4IyAZm6Ih9Tw9KOg5qsF9GfFxmPq/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IJRLzN9m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e/dSV7Rh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IJRLzN9m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e/dSV7Rh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5C9E3E6D9;
	Thu, 12 Feb 2026 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770906698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucgsEkkqGxcfa4+ZJImEno+AL1cPRkxVhlVOAxFaY6Y=;
	b=IJRLzN9mgd9pH1OfR+nWPPC6AahglfFaRsRtjdVINg8nZx1flrUjFV55fuhijTKUINeVlG
	6kQtkwZnj5QqEHVWKYMP0vhy5NDxN0cubLgMIAMXx8RfByb5idq1AQ7OzXCkGZsKTj35NW
	R0PCF8MnYMYJgEySOcs6xBXqS/U4Mak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770906698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucgsEkkqGxcfa4+ZJImEno+AL1cPRkxVhlVOAxFaY6Y=;
	b=e/dSV7RhU1nitnh3mPe+RzTu3vI4okuGks9nxmY9+h1T2U5bFXncGCyIC+yynpyzRGO/+R
	AoBL71CrxrCPdpCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IJRLzN9m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="e/dSV7Rh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770906698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucgsEkkqGxcfa4+ZJImEno+AL1cPRkxVhlVOAxFaY6Y=;
	b=IJRLzN9mgd9pH1OfR+nWPPC6AahglfFaRsRtjdVINg8nZx1flrUjFV55fuhijTKUINeVlG
	6kQtkwZnj5QqEHVWKYMP0vhy5NDxN0cubLgMIAMXx8RfByb5idq1AQ7OzXCkGZsKTj35NW
	R0PCF8MnYMYJgEySOcs6xBXqS/U4Mak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770906698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucgsEkkqGxcfa4+ZJImEno+AL1cPRkxVhlVOAxFaY6Y=;
	b=e/dSV7RhU1nitnh3mPe+RzTu3vI4okuGks9nxmY9+h1T2U5bFXncGCyIC+yynpyzRGO/+R
	AoBL71CrxrCPdpCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5FB63EA62;
	Thu, 12 Feb 2026 14:31:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1IqsJ0rkjWmZcAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 12 Feb 2026 14:31:38 +0000
Date: Thu, 12 Feb 2026 15:31:37 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, hch <hch@lst.de>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "jack@suse.com" <jack@suse.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Message-ID: <395d1665-f5f4-4484-8d68-bad00d545220@flourine.local>
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77024-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwagner@suse.de,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim]
X-Rspamd-Queue-Id: 80EED12E41A
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 01:42:35PM +0000, Hans Holmberg wrote:
> A shared project would remove the need for everyone to cook up their
> own frameworks and help define a set of workloads that the community
> cares about.
> 
> Myself, I want to ensure that any optimizations I work on:
> 
> 1) Do not introduce regressions in performance elsewhere before I
>    submit patches
> 2) Can be reliably reproduced, verified, and regression‑tested by the
>    community

Not that I use it very often but mmtests is pretty good for this:

https://github.com/gormanm/mmtests

