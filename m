Return-Path: <linux-fsdevel+bounces-67073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38F8C34769
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 09:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AD3424694
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51D2D3ED2;
	Wed,  5 Nov 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oB3Qq8e5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zXP3FhaJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oB3Qq8e5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zXP3FhaJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A8288510
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331270; cv=none; b=rsth0EPLtM2E5PckT8JqOPXcqpgVKghsQm21ph4H4iJ/I54MgeiWQPL3QJ6rGc4SdM+tqrAqK3bSUfw+rd6XNljfqVbGysKR9oCRANMRN5CZ/z+4jjmmmWWT1qB4FxH+pP/j3k9QqZQbORjwJZRwnX1+mFYKs9EPAUuzHqMzHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331270; c=relaxed/simple;
	bh=9/YYM4QrVTvaEVDPOg2pODELTjAQxCMbWkjZs2BmV4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSPRLIQg/GErSMwe7Hrs+pokIywaNyzuwUsd/6c/xtkYqc5JYgck4I8NdupHGwuoIcf6lFU/S4ByPLtl8MIdiwkuXU2bnQ8A7M007PGRLTe6MhtOVuau1qyT6mQg+/4rpeMsd9VtzFnFV0i8hfvySKc9rQz3NRYqGKxWkr6vZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oB3Qq8e5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zXP3FhaJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oB3Qq8e5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zXP3FhaJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71D2621190;
	Wed,  5 Nov 2025 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762331267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTfiJrekzapOg1bZIHfQgyPTVye8NZAS7/4c8g+TPSo=;
	b=oB3Qq8e5dZDDu6AGv8sAkWx95yrxGEHymjjNRPu5z/0Jh1M9ngWkstHKeRJnB5pzFzWHrD
	AD97vONGGdAiWmVtrxXjEkNqovKhXOxMEE2Lnr/VcV0DLHW1KIDEKdXG+BAY8PjV01eavY
	sixW1OQcfMHlyQ4HE4IT0PqjNYxrADA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762331267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTfiJrekzapOg1bZIHfQgyPTVye8NZAS7/4c8g+TPSo=;
	b=zXP3FhaJy5ge00Nbc8cVKnvJMZAL6hrWiBWPzldFoOk7L2XvQIj+kOZHapmMgS9HNO27h0
	daKCRK6aOx4lRzBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762331267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTfiJrekzapOg1bZIHfQgyPTVye8NZAS7/4c8g+TPSo=;
	b=oB3Qq8e5dZDDu6AGv8sAkWx95yrxGEHymjjNRPu5z/0Jh1M9ngWkstHKeRJnB5pzFzWHrD
	AD97vONGGdAiWmVtrxXjEkNqovKhXOxMEE2Lnr/VcV0DLHW1KIDEKdXG+BAY8PjV01eavY
	sixW1OQcfMHlyQ4HE4IT0PqjNYxrADA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762331267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yTfiJrekzapOg1bZIHfQgyPTVye8NZAS7/4c8g+TPSo=;
	b=zXP3FhaJy5ge00Nbc8cVKnvJMZAL6hrWiBWPzldFoOk7L2XvQIj+kOZHapmMgS9HNO27h0
	daKCRK6aOx4lRzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 663CA13699;
	Wed,  5 Nov 2025 08:27:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id twbyGIMKC2noXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 08:27:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1329BA28C2; Wed,  5 Nov 2025 09:27:43 +0100 (CET)
Date: Wed, 5 Nov 2025 09:27:43 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	Baokun Li <libaokun@huaweicloud.com>
Subject: Re: [PATCH 10/25] ext4: add EXT4_LBLK_TO_P and EXT4_P_TO_LBLK for
 block/page conversion
Message-ID: <at4bgovycfr2djhu74dx6vjjr4r5rh7lhggxilpnkqt37jnmdt@nbk463hqeia7>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-11-libaokun@huaweicloud.com>
 <pgrk2x54egzxcvmfi4rra3exooxe3yxuvug6yvbtrgxm2oppym@fy52xh4weeww>
 <761b447d-6e34-4a6d-b1d8-9f744ab548db@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <761b447d-6e34-4a6d-b1d8-9f744ab548db@huawei.com>
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 

On Mon 03-11-25 22:45:45, Baokun Li wrote:
> On 2025-11-03 16:26, Jan Kara wrote:
> > On Sat 25-10-25 11:22:06, libaokun@huaweicloud.com wrote:
> > BTW, patch 8 could already use these macros...
> >
> > 								Honza
> 
> In Patch 8, the conversion is for a physical block number, which has a
> different variable type than lblk. Since this is the only location where
> this conversion is used in the code, I made a dedicated modification there.

Ok, fair.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

