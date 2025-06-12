Return-Path: <linux-fsdevel+bounces-51431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 190F2AD6D24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67428188BF87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6499C22DF84;
	Thu, 12 Jun 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y40rjCbJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WLZPqOl7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y40rjCbJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WLZPqOl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63422DA0A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749722974; cv=none; b=MlPdyjqpTKVOa9xtU6riyu+pKAsxiRT1b/wOFJi/XVKdeY7IfCpfbvfZHNoqhrprvVTfyodYEu30E8uq2U+ZtFmaIbhOYM3rH7FQS4chK1PHHVPYOfr5fxIynwA9KoF7leku4OUcbHTPcxMGL0BeOtgZ9/lhDBGR7MPLyEkkEj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749722974; c=relaxed/simple;
	bh=/7buT92CMD67Wu0NPOAnI6IcuxTehor6l92Rh20xLeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf2pUDuS65KUy12AbWBZdTA6AQAF+vczXih4BmorvIfkL1FWGYWmsBPBgGHd0XIfQ3BNSVfyKw3cTuAOHxa6OL5clf8KFh1sZKS3roLpwdQXV+Z2Sb/itUWVTjVsKuyK1MagOE5CZmUSpb/W5sFunRwI78pwXLvdOB/028qzUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y40rjCbJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WLZPqOl7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y40rjCbJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WLZPqOl7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 717721F78E;
	Thu, 12 Jun 2025 10:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749722971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGxaORZo0b6DrgCfmqjxnayURv8r+ghI7qmddYwNZDA=;
	b=y40rjCbJ4y3Ai7YtQ+sbh5RN/mhFQDQMlWkyGWaqOFzT7WaaSIB9bF+b6vk/TQkXtVDRJP
	1OpmIBTOGF4sLGDsVHuSoG33pGJCCpuh8L19G1O77yCRcM10OeJCkpJWlxtu/zI6RLk6IT
	KP35dnx6hQyFYiqwiL33NaNDGNLrXRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749722971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGxaORZo0b6DrgCfmqjxnayURv8r+ghI7qmddYwNZDA=;
	b=WLZPqOl7EYAckFaRd4ZTJiXPlFn2rNhQkkuaaKMADX7tEx9g37X8dVsPsx/ExmH/r3xtAR
	HikHH3UxYcZT9gDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749722971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGxaORZo0b6DrgCfmqjxnayURv8r+ghI7qmddYwNZDA=;
	b=y40rjCbJ4y3Ai7YtQ+sbh5RN/mhFQDQMlWkyGWaqOFzT7WaaSIB9bF+b6vk/TQkXtVDRJP
	1OpmIBTOGF4sLGDsVHuSoG33pGJCCpuh8L19G1O77yCRcM10OeJCkpJWlxtu/zI6RLk6IT
	KP35dnx6hQyFYiqwiL33NaNDGNLrXRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749722971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGxaORZo0b6DrgCfmqjxnayURv8r+ghI7qmddYwNZDA=;
	b=WLZPqOl7EYAckFaRd4ZTJiXPlFn2rNhQkkuaaKMADX7tEx9g37X8dVsPsx/ExmH/r3xtAR
	HikHH3UxYcZT9gDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65A4D132D8;
	Thu, 12 Jun 2025 10:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gL7HGFunSmghTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Jun 2025 10:09:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A74EA099E; Thu, 12 Jun 2025 12:09:23 +0200 (CEST)
Date: Thu, 12 Jun 2025 12:09:23 +0200
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: unlock the superblock during iterate_supers_type
Message-ID: <bzvydikjge7rbzcm4r4wani53cywrzmokcknbf6mty5uwjsxgw@2j4crkt3tpfu>
References: <20250611164044.GF6138@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611164044.GF6138@frogsfrogsfrogs>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 11-06-25 09:40:44, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This function takes super_lock in shared mode, so it should release the
> same lock.
> 
> Cc: <stable@vger.kernel.org> # v6.16-rc1
> Fixes: af7551cf13cf7f ("super: remove pointless s_root checks")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Indeed that was an oversight. Thanks for catching it! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 21799e213fd747..80418ca8e215bb 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -964,8 +964,10 @@ void iterate_supers_type(struct file_system_type *type,
>  		spin_unlock(&sb_lock);
>  
>  		locked = super_lock_shared(sb);
> -		if (locked)
> +		if (locked) {
>  			f(sb, arg);
> +			super_unlock_shared(sb);
> +		}
>  
>  		spin_lock(&sb_lock);
>  		if (p)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

