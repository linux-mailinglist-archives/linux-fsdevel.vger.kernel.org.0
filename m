Return-Path: <linux-fsdevel+bounces-12260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9310185D883
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 13:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44DE1C22C9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7753816;
	Wed, 21 Feb 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ikkpFEOF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YmVZzqrw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ikkpFEOF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YmVZzqrw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D353B794
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520326; cv=none; b=u6JwmHZICWZPX3qDO8SiFbwMAP4m2DhxEK0wpa6JuMqDWiyuizNoDmHCg7F3NwmRh9lkjewAMm8kAIfXMJYHgkgA35HMiHxpYahwCdEKazdKPY5fxC+DU0QmH8qBJr91XLLPeUnPayyZ1MQFsB4iRMg/ahGFZ8Nqzh70PZzKAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520326; c=relaxed/simple;
	bh=gdaTcCL33Q8j8CTa5q5OxjkgZ8HEO4AK4fYHHg/alfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXj+maSR4wuLzqQzPh9/dgMJcScWh8vfx8JdL6Yx5AgtX+JD82Uk+q3TxiA+m54wMZkoyFdFSsrLyEsxdPAcQQNKw3/92nK5ISgYxTohtXlIEzbpmQPKSApeU7Q30JKK2xhm1OTUCgMDvp0+lHoUpZLfuyMz5WDd1Kh/+YUCnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ikkpFEOF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YmVZzqrw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ikkpFEOF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YmVZzqrw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B7081FB5A;
	Wed, 21 Feb 2024 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708520323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iOSPh9X9+ea+lHz0m1irfS2e3kA6Y27fXyWmeAEM6T4=;
	b=ikkpFEOFDQBPAlaBveN7RZu2FSpsJkoV/HgH7Ocx9AqXyXZe099/5HHt0OsFhmaD+p+TZr
	nzzVu1aTjDlm9g4f523Ak+6Nf9/StryiRYrA09PBDbNGGgL/hLI61Z+hEEOO2OqAV7exnR
	Mi56GuzaCStXDnN8A+4aE/voEaAqlCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708520323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iOSPh9X9+ea+lHz0m1irfS2e3kA6Y27fXyWmeAEM6T4=;
	b=YmVZzqrwqrrO7YrZfhPdRTavs5y1by3YIuZd0WkbzDx1XwF3k+PVXOFjiIGWufi9IA9gAI
	ymqUtsubmEZV5QCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708520323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iOSPh9X9+ea+lHz0m1irfS2e3kA6Y27fXyWmeAEM6T4=;
	b=ikkpFEOFDQBPAlaBveN7RZu2FSpsJkoV/HgH7Ocx9AqXyXZe099/5HHt0OsFhmaD+p+TZr
	nzzVu1aTjDlm9g4f523Ak+6Nf9/StryiRYrA09PBDbNGGgL/hLI61Z+hEEOO2OqAV7exnR
	Mi56GuzaCStXDnN8A+4aE/voEaAqlCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708520323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iOSPh9X9+ea+lHz0m1irfS2e3kA6Y27fXyWmeAEM6T4=;
	b=YmVZzqrwqrrO7YrZfhPdRTavs5y1by3YIuZd0WkbzDx1XwF3k+PVXOFjiIGWufi9IA9gAI
	ymqUtsubmEZV5QCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 01E39139D1;
	Wed, 21 Feb 2024 12:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id V4F0AIPz1WUmNwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 12:58:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AAF65A0807; Wed, 21 Feb 2024 13:58:38 +0100 (CET)
Date: Wed, 21 Feb 2024 13:58:38 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Bill O'Donnell <billodo@redhat.com>
Subject: Re: [PATCH 0/2] udf: convert to new mount API
Message-ID: <20240221125838.t25pcsje33y576jz@quack3>
References: <ecf5bc91-69fc-45ce-a70c-c0cd84c42766@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf5bc91-69fc-45ce-a70c-c0cd84c42766@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ikkpFEOF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YmVZzqrw
X-Spamd-Result: default: False [-0.99 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.18)[88.97%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.99
X-Rspamd-Queue-Id: 0B7081FB5A
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Tue 20-02-24 15:42:00, Eric Sandeen wrote:
> 2nd version of UDF mount API conversion patch(es)
> 
> Patch one changes novrs to a flag like other options as Jan
> requested.
> 
> Patch two converts to new mount API; changes since V1:
> 
> * Fix long lines
> * Remove double semicolon
> * Ensure we free nls_map as needed in udf_free_fc()
> * Use fsparam_flag_no for "adinicb" option
> * remove stray/uninitialized char *p; in udf_parse_param()
> * avoid assigning invalid [ug]ids to the uopt structure

Thanks! Everything looks good to me now. I've added the patches to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

