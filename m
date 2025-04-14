Return-Path: <linux-fsdevel+bounces-46366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D36EFA8809A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12D118873B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FBF2BEC28;
	Mon, 14 Apr 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RT5tVldp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9HeqbEl5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LqAPkw6V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M3teTvff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990F2BE7DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634392; cv=none; b=Cdh+VRi6IRn1IUrA/Sx5h4W9CiMz/84r54zkut0fLq77KhxxHyYjyPBBjfP3xJNpwK57KLTfNrHzkWftD8Ll3/F9iw9IpL4+/h0DBzgEGiBbNxsJ7ObgO0v+kAoi71WwQKIukXM4sRvUGEO0awxoN92Gwc24dvY1NE05naAoh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634392; c=relaxed/simple;
	bh=URM1whCJuuDnPfBfJn/gp6KeNswHCL1BeHbgPZyeJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrTorzPv+GvZTeVZDxn8ZuRWfhCQ+KoXgwVIZyfkrm2+ZCTnci5pKksYdj/pFQuqrhbAbQ8VYfdaeMOk5tRjDo8g1ttOH/hWf2wDpJN54i5gjOSagDjS+Pe+fPvhNF/lE/ifi4pcaZI7Ub1Jg7zLOUn+bijotOF5YXM64v9SlBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RT5tVldp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9HeqbEl5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LqAPkw6V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M3teTvff; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21298216D6;
	Mon, 14 Apr 2025 12:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744634389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcdBCEQQMqWmXCrE3X1+v5CesV3ebLFi5qE1dkoJW/w=;
	b=RT5tVldpglVeKEzcAtOSHxsaut5VldfskZKUGlYVzKUMg4grNNk6455SoTyw0v4UzID1sx
	B91WyxUjyEDbe3491BgwO20i5TiRV/DLHFlI/LPKkwXEKodAQp2QQtxsNBqcVqm7HHHxIv
	g6of/TJ//RYprunKTK0zukjCE3fPfHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744634389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcdBCEQQMqWmXCrE3X1+v5CesV3ebLFi5qE1dkoJW/w=;
	b=9HeqbEl5yhtYna3ib2GC5YWbWQRT2daf+Aito/b0q8XNJ+jCpILlBBNJm8QCMTYzGRrDqi
	n3xecjugJVWBXlDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744634388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcdBCEQQMqWmXCrE3X1+v5CesV3ebLFi5qE1dkoJW/w=;
	b=LqAPkw6VkKkH0B4PqLs+72/RR7wpTwkJx+A0RzvDth12y71C50YmGlWyIzWN+d6HISHTBb
	hXJaV/3Yrrv4Wfm9XbNDUwNspVNJ46scnPw9PMCsiJ5PIrquapWUmKNsWhptbTegs2vqQ3
	p+vXLNb5RbNB/qSYruCxrRz3s+dgI7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744634388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcdBCEQQMqWmXCrE3X1+v5CesV3ebLFi5qE1dkoJW/w=;
	b=M3teTvffwuXWwQZYHJ24kh6LMdE+I3K9a4ZTWiY2CnpCRY7yDWUOBBjqVAcxiLl10GtHyr
	L94nImcc9YMhnyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1523E1336F;
	Mon, 14 Apr 2025 12:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aO8jBRQC/WfPbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Apr 2025 12:39:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BC473A094B; Mon, 14 Apr 2025 14:39:47 +0200 (CEST)
Date: Mon, 14 Apr 2025 14:39:47 +0200
From: Jan Kara <jack@suse.cz>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 3/5] fs/fs_parse: Fix 3 issues for
 validate_constant_table()
Message-ID: <nskvmomemvl47levkp4dmckwkyju7kjnn6wkp5go2igryfwzgv@pt2yuvjwrhoa>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
 <20250410-fix_fs-v1-3-7c14ccc8ebaa@quicinc.com>
 <20250411-beteuern-fusionieren-2a3d24f055d0@brauner>
 <1d59d38a-5674-4591-a866-27dfbc410b93@icloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d59d38a-5674-4591-a866-27dfbc410b93@icloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[icloud.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 11-04-25 22:48:40, Zijun Hu wrote:
> On 2025/4/11 22:37, Christian Brauner wrote:
> >> - Potential NULL pointer dereference.
> > I really dislike "potential NULL deref" without an explanation. Please
> > explain how this supposed NULL deref can happen.
> > 
> 
> okay.
> 
> >> Fixes: 31d921c7fb96 ("vfs: Add configuration parser helpers")
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  fs/fs_parser.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> >> index e635a81e17d965df78ffef27f6885cd70996c6dd..ef7876340a917876bc40df9cdde9232204125a75 100644
> >> --- a/fs/fs_parser.c
> >> +++ b/fs/fs_parser.c
> >> @@ -399,6 +399,9 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
> >>  	}
> >>  
> >>  	for (i = 0; i < tbl_size; i++) {
> >> +		if (!tbl[i].name && (i + 1 == tbl_size))
> >> +			break;
> >> +
> >>  		if (!tbl[i].name) {
> >>  			pr_err("VALIDATE C-TBL[%zu]: Null\n", i);
> >>  			good = false;
> >> @@ -411,13 +414,13 @@ bool validate_constant_table(const struct constant_table *tbl, size_t tbl_size,
> >>  				good = false;
> >>  			}
> >>  			if (c > 0) {
> >> -				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>=%s\n",
> >> +				pr_err("VALIDATE C-TBL[%zu]: Missorted %s>%s\n",
> >>  				       i, tbl[i-1].name, tbl[i].name);
> >>  				good = false;
> >>  			}
> >>  		}
> >>  
> >> -		if (tbl[i].value != special &&
> >> +		if (tbl[i].name && tbl[i].value != special &&
> >>  		    (tbl[i].value < low || tbl[i].value > high)) {
> >>  			pr_err("VALIDATE C-TBL[%zu]: %s->%d const out of range (%d-%d)\n",
> >>  			       i, tbl[i].name, tbl[i].value, low, high);
> 
> for good constant table which ends with empty entry. for original logic,
> when loop reach the last empty entry.  above pr_err() may access NULL
> pointer tbl[i].name.
> 
> 
> i find out this validate_constant_table() also has no callers.
> fix it or remove it ?

Yeah, just drop it. In the kernel we are pretty aggressive in dropping
unused code :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

