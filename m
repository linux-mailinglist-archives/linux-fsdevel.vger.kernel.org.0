Return-Path: <linux-fsdevel+bounces-45323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53349A763BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468B27A3AC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D71DF98E;
	Mon, 31 Mar 2025 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dOzp4PzM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X14oSJ4x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dOzp4PzM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X14oSJ4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F71DF269
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415212; cv=none; b=Hu/OTeP1PiHpM6WZlKR5ia+HUGI2JucTV0vtQPQt5cLKBfyqbzUmGg23IbHM/E6HmXsEU76lKJyGlH1o4IOEGAVQrPHvyQvZKhWVDxFXkwDdNfB87yMtOzYaP9ZGpJ3LVMaD4FsMrf/qsj26BQD654J/djAquzjksKUqwwwgzN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415212; c=relaxed/simple;
	bh=zFM+yQZlN1R4ZCOzZvevXwiwTcHKtB3+eTAiY6LTaTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRGl5rfihkXSkmyUk3PDM5w0poxJ7REKRtDYvNcFBl7TEfAi1jURzOUxsxmBOMlyCh7cZcptOyeNdPC0RAAEUIRC4TugCn0Wy1Evt7nuxnVUxwqyOG9Okh5qmO+rXgKyp0N7CqxEZFRQus20R3BrntiSlfYlmCt6nuBdS3LuXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dOzp4PzM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X14oSJ4x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dOzp4PzM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X14oSJ4x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F2D11F397;
	Mon, 31 Mar 2025 10:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26J/56uAfoJJ8xugZQGjwF1NQW4dazq5yMX0c6TIdRc=;
	b=dOzp4PzMZ8f8zgYnYnioZPFxIphLsRyytbcS4lK28kOeL7ZybXaewDib9jn5XJECAqeKsX
	rotjT7U76r3xAArtqbeGsSPHy5SmnfRm1F090w2Amenz8Xg0Cj415Qg/KkU+DGb4EUf7f7
	VZAo8kbQGa8ltkqr0wxKKvke+sBoNKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26J/56uAfoJJ8xugZQGjwF1NQW4dazq5yMX0c6TIdRc=;
	b=X14oSJ4xNh5cUkyRINIQp7Rw/bBKGiJ84m+4Px6bKcyK2jZ3Adpc38Hl62+txD5441Z+Lg
	JhRc7Ugfs4PskhAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26J/56uAfoJJ8xugZQGjwF1NQW4dazq5yMX0c6TIdRc=;
	b=dOzp4PzMZ8f8zgYnYnioZPFxIphLsRyytbcS4lK28kOeL7ZybXaewDib9jn5XJECAqeKsX
	rotjT7U76r3xAArtqbeGsSPHy5SmnfRm1F090w2Amenz8Xg0Cj415Qg/KkU+DGb4EUf7f7
	VZAo8kbQGa8ltkqr0wxKKvke+sBoNKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26J/56uAfoJJ8xugZQGjwF1NQW4dazq5yMX0c6TIdRc=;
	b=X14oSJ4xNh5cUkyRINIQp7Rw/bBKGiJ84m+4Px6bKcyK2jZ3Adpc38Hl62+txD5441Z+Lg
	JhRc7Ugfs4PskhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12F2D13A1F;
	Mon, 31 Mar 2025 10:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9XKhBKln6me6WwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Mar 2025 10:00:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B1A8FA08D2; Mon, 31 Mar 2025 12:00:00 +0200 (CEST)
Date: Mon, 31 Mar 2025 12:00:00 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 3/6] super: skip dying superblocks early
Message-ID: <5zehh27ppycrz3cbopt3i37ycqbvr6462don3coemgmscrebpa@kjnqijskg35f>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <20250329-work-freeze-v2-3-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329-work-freeze-v2-3-a47af37ecc3d@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,hansenpartnership.com,kernel.org,infradead.org,fromorbit.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 29-03-25 09:42:16, Christian Brauner wrote:
> Make all iterators uniform by performing an early check whether the
> superblock is dying.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index b1acfc38ba0c..c67ea3cdda41 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -925,6 +925,9 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
>  	list_for_each_entry(sb, &super_blocks, s_list) {
>  		bool locked;
>  
> +		if (super_flags(sb, SB_DYING))
> +			continue;
> +
>  		sb->s_count++;
>  		spin_unlock(&sb_lock);
>  
> @@ -962,6 +965,9 @@ void iterate_supers_type(struct file_system_type *type,
>  	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
>  		bool locked;
>  
> +		if (super_flags(sb, SB_DYING))
> +			continue;
> +
>  		sb->s_count++;
>  		spin_unlock(&sb_lock);
>  
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

