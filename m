Return-Path: <linux-fsdevel+bounces-44301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B2EA6704E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 10:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C5118889BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B67204F9F;
	Tue, 18 Mar 2025 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yg0JkUeD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ac2tg3Hg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yg0JkUeD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ac2tg3Hg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723DE1F180C
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291514; cv=none; b=LaPiDQAInCnh+YfmTiCWjwGX63MWoIdnwEG6QEEMZkxobOu2cIVKYuM7ED+mrpXdlXtTUD9ZmpWe2tKJRytRQEPIooO1xvOmC1gNycUv7xN9YLQTWZcJI+klDryhf3umDPIl95/njG8xo6XDwSNulWZ3j1Ur+S9WuF4M6PrJR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291514; c=relaxed/simple;
	bh=tMqDMi4z/Af/1nBj06gC748vZT9/ks5A8LiXVhbqv4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d++FFAV5bP6k9sGlW+C2zDakzunLizAbJGU7m2ELW2NWWL70ukVgCcwAybe6r+oKmbMM3wus1/DyMOYWQ+WbPXbDngouJXaGI5O/c5+AC0LCrvnJ0+kVtgQnsSEPSbW0vH07PErZFzQ/67ZIdU+u2MlUOBJJc1LJCr+CTGWzRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yg0JkUeD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ac2tg3Hg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yg0JkUeD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ac2tg3Hg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 938C51F7C7;
	Tue, 18 Mar 2025 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742291510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QMRWmFfPW970c52ux+nGJ79iDYhzbXP95zIUATY3vc=;
	b=yg0JkUeDmL/bEPZxG65TSJIKkNAsjdz9whjvVQKCi2s14EFkG6AIfHo7Ovs+hquPBqic46
	Uq/IBPzIMeA/KYYyZBvE5zuQPu8hlmXY9UvaXV0tf7gCmu4sWX++PSrGV9jry6zx+1xBof
	Rr63qv6qO/iN6qdGFa+B47pQuEizoPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742291510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QMRWmFfPW970c52ux+nGJ79iDYhzbXP95zIUATY3vc=;
	b=ac2tg3HgF8sNvVWtjHZ5THXA3LVdTKFTF01U91HgqjvidH1Ol4wOlgUGqTLErmnoMyB1Vh
	obmE4MQMuanlPlCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yg0JkUeD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ac2tg3Hg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742291510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QMRWmFfPW970c52ux+nGJ79iDYhzbXP95zIUATY3vc=;
	b=yg0JkUeDmL/bEPZxG65TSJIKkNAsjdz9whjvVQKCi2s14EFkG6AIfHo7Ovs+hquPBqic46
	Uq/IBPzIMeA/KYYyZBvE5zuQPu8hlmXY9UvaXV0tf7gCmu4sWX++PSrGV9jry6zx+1xBof
	Rr63qv6qO/iN6qdGFa+B47pQuEizoPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742291510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QMRWmFfPW970c52ux+nGJ79iDYhzbXP95zIUATY3vc=;
	b=ac2tg3HgF8sNvVWtjHZ5THXA3LVdTKFTF01U91HgqjvidH1Ol4wOlgUGqTLErmnoMyB1Vh
	obmE4MQMuanlPlCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B7C41379A;
	Tue, 18 Mar 2025 09:51:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kk1yFDNC2WdiKgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 18 Mar 2025 09:51:47 +0000
Date: Tue, 18 Mar 2025 20:51:39 +1100
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
Message-ID: <20250318205139.71fe0c02.ddiss@suse.de>
In-Reply-To: <BYAPR12MB320590A9238C334D68717C34D5DE2@BYAPR12MB3205.namprd12.prod.outlook.com>
References: <BYAPR12MB3205F96E780AA2F00EAD16E8D5D22@BYAPR12MB3205.namprd12.prod.outlook.com>
	<20250317182157.7adbc168.ddiss@suse.de>
	<BYAPR12MB3205A7903D8EF06EFF8F575AD5DF2@BYAPR12MB3205.namprd12.prod.outlook.com>
	<20250318121424.614148e1.ddiss@suse.de>
	<BYAPR12MB320590A9238C334D68717C34D5DE2@BYAPR12MB3205.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 938C51F7C7
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 18 Mar 2025 06:28:53 +0000, Stephen Eta Zhou wrote:

> > There's room for improvement WRT how out-of-memory failures are reported  
> 
> I am currently trying to find a good optimization solution for this. Since initramfs is decompressed in the early stage of the kernel, if the decompression fails, it will call panic to put the kernel into a panic state.

Not always. The *built-in* initramfs unpack_to_rootfs() error path
panics, but external initramfs unpack_to_rootfs() failure won't panic
immediately...

> There is a contradiction: at this time, the console and serial port have not been initialized yet, which will cause the error message to fail to be output, resulting in a suspended state, and no valid output can be seen.

Are your console/serial drivers loaded as external modules? That sounds
like a configuration problem.

