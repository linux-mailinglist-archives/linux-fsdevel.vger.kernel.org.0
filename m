Return-Path: <linux-fsdevel+bounces-7401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEE1824769
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 18:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEEE2816CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6405928DC0;
	Thu,  4 Jan 2024 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ssCieMHq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7vRREkty";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ssCieMHq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7vRREkty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29B286B1;
	Thu,  4 Jan 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE61221F99;
	Thu,  4 Jan 2024 17:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704389126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kM2Xcpu+q93CJKY69SzeuyLvmtyJpPaFQj/dXNDYds=;
	b=ssCieMHqylV6I6OqXgdO9qIXeeHj4XxUSUUnj44tgz6xvxKPS0oj8QDfDsHoXv/T2SzgwN
	a5Eku9SsJKZ5ibhYyvkMdnhgphuy3fq+2IuubQzErrWKyQ6MYw2oBqAla6VwDfpHliLDjq
	ZxpdWxvUc+WYL0CF9IgPaeO5T7P60vI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704389126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kM2Xcpu+q93CJKY69SzeuyLvmtyJpPaFQj/dXNDYds=;
	b=7vRREktyd32/nyj3nG2ZW49+/BAQqfVi/iJSijLyT3Lw+hn/+sY6mJxShxxbJXXYdO/hhd
	Edpnr5fdmKbEzACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704389126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kM2Xcpu+q93CJKY69SzeuyLvmtyJpPaFQj/dXNDYds=;
	b=ssCieMHqylV6I6OqXgdO9qIXeeHj4XxUSUUnj44tgz6xvxKPS0oj8QDfDsHoXv/T2SzgwN
	a5Eku9SsJKZ5ibhYyvkMdnhgphuy3fq+2IuubQzErrWKyQ6MYw2oBqAla6VwDfpHliLDjq
	ZxpdWxvUc+WYL0CF9IgPaeO5T7P60vI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704389126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kM2Xcpu+q93CJKY69SzeuyLvmtyJpPaFQj/dXNDYds=;
	b=7vRREktyd32/nyj3nG2ZW49+/BAQqfVi/iJSijLyT3Lw+hn/+sY6mJxShxxbJXXYdO/hhd
	Edpnr5fdmKbEzACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6A7413722;
	Thu,  4 Jan 2024 17:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bm9XKAbqlmW6bQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 17:25:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC8F8A07EF; Thu,  4 Jan 2024 18:25:25 +0100 (CET)
Date: Thu, 4 Jan 2024 18:25:25 +0100
From: Jan Kara <jack@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 08/14] hfsplus: Really remove hfsplus_writepage
Message-ID: <20240104172525.6yg6lv42vcrluezp@quack3>
References: <20231215200245.748418-1-willy@infradead.org>
 <20231215200245.748418-9-willy@infradead.org>
 <20231216043328.GF9284@lst.de>
 <50696fa1-a7b9-4f5f-b4ef-73ca99a69cd2@wdc.com>
 <20231218150401.GA19279@lst.de>
 <cdf6a3d8-4f5c-4fce-a93e-9b0304effcb9@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf6a3d8-4f5c-4fce-a93e-9b0304effcb9@wdc.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.84
X-Spamd-Result: default: False [-1.84 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 URIBL_BLOCKED(0.00)[suse.com:email];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.04)[87.62%]
X-Spam-Flag: NO

On Mon 18-12-23 15:40:42, Johannes Thumshirn wrote:
> On 18.12.23 16:04, Christoph Hellwig wrote:
> > On Mon, Dec 18, 2023 at 10:41:27AM +0000, Johannes Thumshirn wrote:
> >>> although I had some reason to be careful back then.  hfsplus should
> >>> be testable again that the hfsplus Linux port is back alive.  Is there
> >>> any volunteer to test hfsplus on the fsdevel list?
> >>
> >> What do you have in mind on that side? "Just" running it through fstests
> >> and see that we don't regress here or more than that?
> > 
> > Yeah.  Back in the day I ran hfsplus through xfstests, IIRC that might
> > even have been the initial motivation for supporting file systems
> > that don't support sparse files.  I bet a lot has regressed or isn't
> > support since, though.
> > 
> 
> Let me see what I can do on that front over my winter vacation. As long 
> as there's no APFS support in Linux its the only way to exchange data 
> between macOS and Linux anyways, so we shouldn't break it.

AFAIK macOS actually does support UDF so there are other filesystems you
can use for data exchange.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

