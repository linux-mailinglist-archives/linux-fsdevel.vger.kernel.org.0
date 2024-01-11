Return-Path: <linux-fsdevel+bounces-7777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ABD82A8D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 09:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0ED1F2776A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 08:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9586BDDBA;
	Thu, 11 Jan 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JA9Zwnud";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AIyIC3ln";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EsnaEA0H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I0Vrlw2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7439BD534;
	Thu, 11 Jan 2024 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33C5722055;
	Thu, 11 Jan 2024 08:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704960860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epYN9+7p5WMnq2SmCY5xMgAlEwe1x52O//QpDZYpGn0=;
	b=JA9Zwnudb2GOcwYYum4fUlEjX6dXrLnM4EtKlLgoKHF+JJlvz1QcLoxf9e8aVoDvjR/VFS
	CWz3Ix2Etr09gwXBR0eG+5utuyqByaiuN54QZS0B05Uf1rv0s3LAqZkVz2bSZVyLlnC1F4
	Zan+ww1Y5bcalGHFSK3I7y8YJDPQAf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704960860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epYN9+7p5WMnq2SmCY5xMgAlEwe1x52O//QpDZYpGn0=;
	b=AIyIC3lnH3BKUTRyKd8X3gR+B1eVDRBbGs7zxudx55+2N+wC/prMdlXQbVpz/SWjGVDfrJ
	m/lhwdHceZjun0Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704960936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epYN9+7p5WMnq2SmCY5xMgAlEwe1x52O//QpDZYpGn0=;
	b=EsnaEA0HoLUMTOeo0yo/OhV+Fbj2MsvQ62BNAsbkWbrGGxNV/7bxFaP8cxcD1jophlUwt9
	L25/oFp6FIURwVOYTQIl91f2mx2kU3wxCUuwZ9oWqV85aXTrzBmlE6lnyB/sHc7CF+BjtW
	OZRqVprwoAlshkBk+Dqz56EpIo0qawE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704960936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epYN9+7p5WMnq2SmCY5xMgAlEwe1x52O//QpDZYpGn0=;
	b=I0Vrlw2V1kuHDFQSxN3rdIturjjutppXH/oSxK/+1C6aJart3ZWwa0DgntV7mc9MwBEuEV
	v/aX/TdZ5Srj1+DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BF103138E5;
	Thu, 11 Jan 2024 08:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YXTHG1mjn2XrHQAAn2gu4w
	(envelope-from <ddiss@suse.de>); Thu, 11 Jan 2024 08:14:17 +0000
Date: Thu, 11 Jan 2024 19:15:10 +1100
From: David Disseldorp <ddiss@suse.de>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs: remove duplicate built-in __initramfs_start
 unpacking
Message-ID: <20240111191510.09fbab13@echidna>
In-Reply-To: <20240111064540.GA7285@lst.de>
References: <20240111062240.9362-1-ddiss@suse.de>
	<20240111064540.GA7285@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.23 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.63)[92.69%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.23

On Thu, 11 Jan 2024 07:45:40 +0100, Christoph Hellwig wrote:

> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks Christoph.
I don't think there's a regular tree for queueing initramfs changes.
Christian: would the vfs queue be appropriate?

Cheers, David

