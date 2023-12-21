Return-Path: <linux-fsdevel+bounces-6687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843CB81B605
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 13:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B86F1F23F21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516C9768EF;
	Thu, 21 Dec 2023 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0wcQhuzB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lj/PL811";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0wcQhuzB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lj/PL811"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702C760B1;
	Thu, 21 Dec 2023 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7E301FB79;
	Thu, 21 Dec 2023 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703161913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwHR5tUvfneScMWsP8MbP9fmEkGw5uhOCQkhJHPk1OA=;
	b=0wcQhuzBCULrMhsrPbMUDvPq1vkJknK8Dh3qDnxgyYVejGEMPmLLd4xI0RZd24Vgr63qOG
	giAjay67i0UDSNidEpiGhBizY/QP5B2eDztrzA0VJ/ttyeM+cbHiyn8qlN4Ax1VukiCTjx
	QMrlqkDpKYso3MeMAHKZxR83HQRRjr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703161913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwHR5tUvfneScMWsP8MbP9fmEkGw5uhOCQkhJHPk1OA=;
	b=lj/PL811DVuzQ3shfd0630+UlaPG7rPzDMRTxc8wfu9DeHUCPWHcFJquegPUnPWviMhkKQ
	RCKbcyG15WM17eAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703161913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwHR5tUvfneScMWsP8MbP9fmEkGw5uhOCQkhJHPk1OA=;
	b=0wcQhuzBCULrMhsrPbMUDvPq1vkJknK8Dh3qDnxgyYVejGEMPmLLd4xI0RZd24Vgr63qOG
	giAjay67i0UDSNidEpiGhBizY/QP5B2eDztrzA0VJ/ttyeM+cbHiyn8qlN4Ax1VukiCTjx
	QMrlqkDpKYso3MeMAHKZxR83HQRRjr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703161913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwHR5tUvfneScMWsP8MbP9fmEkGw5uhOCQkhJHPk1OA=;
	b=lj/PL811DVuzQ3shfd0630+UlaPG7rPzDMRTxc8wfu9DeHUCPWHcFJquegPUnPWviMhkKQ
	RCKbcyG15WM17eAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90F3413AB5;
	Thu, 21 Dec 2023 12:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MYhiIzkwhGXfcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 12:31:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47484A07E3; Thu, 21 Dec 2023 13:31:49 +0100 (CET)
Date: Thu, 21 Dec 2023 13:31:49 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] writeback: Factor writeback_get_folio() out of
 write_cache_pages()
Message-ID: <20231221123149.liaii5ziwyvb3rmx@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-14-hch@lst.de>
 <20231221114153.2ktiwixqedsk5adw@quack3>
 <20231221122535.GE17956@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221122535.GE17956@lst.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.90
X-Spamd-Result: default: False [-2.90 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.10)[95.66%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Thu 21-12-23 13:25:35, Christoph Hellwig wrote:
> On Thu, Dec 21, 2023 at 12:41:53PM +0100, Jan Kara wrote:
> > But I'd note that the call stack depth of similarly called helper functions
> > (with more to come later in the series) is getting a bit confusing. Maybe
> > we should inline writeback_get_next() into its single caller
> > writeback_get_folio() to reduce confusion a bit...
> 
> I just hacked that up based on the fully applied series and that looks
> good to me.

Yeah, cleanup on top works for me so that you don't have to rebase.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

