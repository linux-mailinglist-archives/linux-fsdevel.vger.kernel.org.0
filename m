Return-Path: <linux-fsdevel+bounces-13885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B768751B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29675B243D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474EA12DDA1;
	Thu,  7 Mar 2024 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EVM4f7g6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IyOF4UQ9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EVM4f7g6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IyOF4UQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125F12AAEA
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821411; cv=none; b=DQ8znjxg62Bkc3LOC+xTKV+mbZmxMBwwVh4V7PdxsUk3TGieznBnZzNjhimzCwrnBX4MxVo6uWdnGCV9uvs8+RyYKm1nM5G0aezA4/KE2brJSRdOpcNAGvcJt0MPSGzX9fSa5TKpVY/kEXjp3uPCiChTI4AUKJ2Bo5VOfIjWJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821411; c=relaxed/simple;
	bh=HKm9LaUkcr4W6Z/uUhe1QfD60CvSfrYtzjcXZDN7vh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcfG3FGc1NvV156rB4QSeeQ9lF+hfH7kJrCMcfbwdIgtK0rQ1A5V4AMzoJC47jIpXfX2yfaI9NPxwzhfHkkQG/k6b4lhUmnBM8oP+50sokY0oYhazrc4kOeEptYN5ZnBfYESFueVvgPZb49jrP39Xpc61LmNqWH+blvvJmVAo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EVM4f7g6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IyOF4UQ9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EVM4f7g6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IyOF4UQ9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3541125ABE;
	Thu,  7 Mar 2024 12:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709815346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+rtF62uNv/judASnPyOlrA3QvKqk2dYdGFBA6ToO5sU=;
	b=EVM4f7g6AS7EU6gJxAxPbqPaSjsKiBWSbvVmGHiyZBy3HnowBRRvzsZZchSgUz6soUKoWa
	BiHPtJAxmia0/HmWA3EW8NgEle11tU1IjZe5v2M5WoKoriU7tb+PnG3vVfYVHP/XPM1Jfd
	8ipFaTbRpVT1h5y4n8dYuDZ+Wcn59GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709815346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+rtF62uNv/judASnPyOlrA3QvKqk2dYdGFBA6ToO5sU=;
	b=IyOF4UQ9S/zvS5VCEcOQJ44PYAd2Wmxs/bQwdc4mDb/qiGX911kPUFVWQ2y9A/fuvd+5Is
	xXTmRpQb4jR/sRBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709815346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+rtF62uNv/judASnPyOlrA3QvKqk2dYdGFBA6ToO5sU=;
	b=EVM4f7g6AS7EU6gJxAxPbqPaSjsKiBWSbvVmGHiyZBy3HnowBRRvzsZZchSgUz6soUKoWa
	BiHPtJAxmia0/HmWA3EW8NgEle11tU1IjZe5v2M5WoKoriU7tb+PnG3vVfYVHP/XPM1Jfd
	8ipFaTbRpVT1h5y4n8dYuDZ+Wcn59GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709815346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+rtF62uNv/judASnPyOlrA3QvKqk2dYdGFBA6ToO5sU=;
	b=IyOF4UQ9S/zvS5VCEcOQJ44PYAd2Wmxs/bQwdc4mDb/qiGX911kPUFVWQ2y9A/fuvd+5Is
	xXTmRpQb4jR/sRBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 27AC213997;
	Thu,  7 Mar 2024 12:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZAFeCTK26WV9RwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 07 Mar 2024 12:42:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C2351A0803; Thu,  7 Mar 2024 13:42:25 +0100 (CET)
Date: Thu, 7 Mar 2024 13:42:25 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Bill O'Donnell <billodo@redhat.com>
Subject: Re: [PATCH] isofs: convert isofs to use the new mount API
Message-ID: <20240307124225.gm2d4dkscbcg4kt2@quack3>
References: <f15910da-b39e-44ff-8a2f-df7ce8c52057@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f15910da-b39e-44ff-8a2f-df7ce8c52057@redhat.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EVM4f7g6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IyOF4UQ9
X-Spamd-Result: default: False [-0.06 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.25)[73.24%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Spam-Score: -0.06
X-Rspamd-Queue-Id: 3541125ABE
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi Eric!

Thanks for the conversion!

On Fri 01-03-24 16:56:41, Eric Sandeen wrote:
> -static int isofs_remount(struct super_block *sb, int *flags, char *data)
> +static int iso9660_reconfigure(struct fs_context *fc)
	      ^^^ Why this renaming? Practically all the function have
isofs prefix, not iso9660 so I'd prefer to keep it. Similarly with other
vars defined below. If anything, I'd rename struct iso9660_options to
struct isofs_options...

>  {
> -	sync_filesystem(sb);
> -	if (!(*flags & SB_RDONLY))
> +	sync_filesystem(fc->root->d_sb);
> +	if (!(fc->sb_flags & SB_RDONLY) & SB_RDONLY)
					^^^ What's this about?

Otherwise the patch looks good to me!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

