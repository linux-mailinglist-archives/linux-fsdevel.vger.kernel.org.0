Return-Path: <linux-fsdevel+bounces-77756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Lv9Bjuql2lV5AIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:26:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 893D4163DA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 028E2302C6DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6F1E1DE5;
	Fri, 20 Feb 2026 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kc+pCR9A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zhlWl2uR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kc+pCR9A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zhlWl2uR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840FB1C84BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771547180; cv=none; b=MiKvfeh4c9egzQaWILWJJHGqZEkyIvGiHXtEXjtI32hCZGuXIM5jEBy1bHMdo3CkiHpyxvGsn/0uPv741fwUfeOoU4MFKsWligOolvtgoIK7Enf4UbgltUEzYx1KE68O9RblNquasRCl81AdTaVKhmFdlykGsUfrOpV2A5JK1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771547180; c=relaxed/simple;
	bh=/NLpKxGCG/FJdLzlZ+PXHLNTdM1REhMrNq6sp83Ij38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxV4IFNrCy2EIghj1VojdY3+5e56rmiWEtbnomLe4UNjjZ8oKjtsy+sjDHTJmfdFvQbjLFBSxnETpUbof/uLB8ztSbTgc6Wg751BlB8kSgpmz5tjbkmXgyCPJoB6QeBNaWz7waDKfi5tZi2mdAujXXJKWnld00IqGK21sQuvcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kc+pCR9A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zhlWl2uR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kc+pCR9A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zhlWl2uR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8DFB75BCEC;
	Fri, 20 Feb 2026 00:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771547177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti6/Un1bwWRUUOHHY8uRk2oc0+xJnmBZdcBUvJxFcM4=;
	b=kc+pCR9A1nYdJpkUTYId9QHSEktFjpnJHioQ48x3h24LE/zJlrgok2emgp3q0rw7a+jLlV
	/djKMzrDPRVNlOKG/DGESaGCLglF6Dzox3gTs7h4Mf8tMXzICdyWIY6WOvAfGuEQJk0Y+R
	XtmK2359thUcIib2sEsFsxKzhmCFQo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771547177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti6/Un1bwWRUUOHHY8uRk2oc0+xJnmBZdcBUvJxFcM4=;
	b=zhlWl2uR/lbcC95WJR6e489kQ0pnk6vd05eOizXuj/6EHcoulabLsTug3j8UxrnWsbLNqm
	37nMsR1wu8egxWBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kc+pCR9A;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zhlWl2uR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771547177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti6/Un1bwWRUUOHHY8uRk2oc0+xJnmBZdcBUvJxFcM4=;
	b=kc+pCR9A1nYdJpkUTYId9QHSEktFjpnJHioQ48x3h24LE/zJlrgok2emgp3q0rw7a+jLlV
	/djKMzrDPRVNlOKG/DGESaGCLglF6Dzox3gTs7h4Mf8tMXzICdyWIY6WOvAfGuEQJk0Y+R
	XtmK2359thUcIib2sEsFsxKzhmCFQo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771547177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti6/Un1bwWRUUOHHY8uRk2oc0+xJnmBZdcBUvJxFcM4=;
	b=zhlWl2uR/lbcC95WJR6e489kQ0pnk6vd05eOizXuj/6EHcoulabLsTug3j8UxrnWsbLNqm
	37nMsR1wu8egxWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1FE83EA65;
	Fri, 20 Feb 2026 00:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 59X2GySql2l+TgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 20 Feb 2026 00:26:12 +0000
Date: Fri, 20 Feb 2026 11:26:06 +1100
From: David Disseldorp <ddiss@suse.de>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Randy
 Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, initramfs@vger.kernel.org, Rob Landley
 <rob@landley.net>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
 <nsc@kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH 2/2] init: ensure that /dev/null is (nearly) always
 available in initramfs
Message-ID: <20260220112606.551099f5.ddiss@suse.de>
In-Reply-To: <20260219210312.3468980-3-safinaskar@gmail.com>
References: <20260219210312.3468980-1-safinaskar@gmail.com>
	<20260219210312.3468980-3-safinaskar@gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77756-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,landley.net:url,android.com:url]
X-Rspamd-Queue-Id: 893D4163DA4
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 21:03:12 +0000, Askar Safin wrote:

> Binaries linked with bionic libc require /dev/null to be present,
> otherwise they will crash before entering "main", as explained
> in https://landley.net/toybox/faq.html#cross3 .

It looks as though Bionic has extra logic to handle missing /dev/null
during early boot, although it's dependent on !is_AT_SECURE:
  https://cs.android.com/android/platform/superproject/main/+/main:bionic/libc/bionic/libc_init_common.cpp;drc=a7637a8f06f103c53d61a400a6b66f48f2da32be;l=400

I think this would be better addressed via documentation (e.g. in Bionic
or ramfs-rootfs-initramfs.rst).

Thanks, David

