Return-Path: <linux-fsdevel+bounces-67901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF9C4D1CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB30C420723
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A544134D90E;
	Tue, 11 Nov 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oERShwSy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XNUAfiDO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oERShwSy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XNUAfiDO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A734CFAD
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857227; cv=none; b=AW5qMRGFTaIcm8mHEjYyfcVkot9KaV8P/SRk29DYDrEXkKsKI/7ZvCHUkJN9YKCiOSKIKu5Avu9f6c00KucQUs+bpVxD7coGcz4elHfqiJr5Qfrh4gDZh7V80e7LzZ5IRubYYETegABK/gKF/IQfOANMem3JgKrHlvcgXb6i2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857227; c=relaxed/simple;
	bh=Aiyv5ucnncWw2iaSvGLNFpegRjmlSJULqrmNLCRCH4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc/Ky87RioVcD9Znuiwuode3PcLLw9WTeXicYAH1zJfJ4KmeTmrjcUMpyvg6/fcgFa5Tq8n3sd8I3XsMZ6Cv+R2a+nvO7d2YB0spInHuDrC0fXw6cSuNn8WOk6a+H16+fvmjGiBgj5F5lsCEnU0rYtDvnS6z+XBIWuSI7nBfavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oERShwSy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XNUAfiDO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oERShwSy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XNUAfiDO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 093931F6E6;
	Tue, 11 Nov 2025 10:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762857223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NL8a+UlhbGyXd2WdlBHIwL7vr0c6ivysNI9rxft/p9U=;
	b=oERShwSyYBtspyRIyoopoZRIXEwdsO/rC2ArSz/bj/rPcHc3nfiD2q89H8uLYMW4SGS8ke
	u8yKWMLhpbdGPRE6OzELQ13YzpPV2WaKnx2nA+JkFhkY/rWo9LABpVYX/EPZ+gvFQHPlb3
	Y6TX7WhxiS/YJp4zKSbi5ftrV3JwA0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762857223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NL8a+UlhbGyXd2WdlBHIwL7vr0c6ivysNI9rxft/p9U=;
	b=XNUAfiDOVXT3RAvs62TpP1BZ+GhMf08UvsgK5W3Hv2FH1E5JCggH1+w3ebXpooDw49hbyG
	Mr1y90tZ4w49QDDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oERShwSy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XNUAfiDO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762857223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NL8a+UlhbGyXd2WdlBHIwL7vr0c6ivysNI9rxft/p9U=;
	b=oERShwSyYBtspyRIyoopoZRIXEwdsO/rC2ArSz/bj/rPcHc3nfiD2q89H8uLYMW4SGS8ke
	u8yKWMLhpbdGPRE6OzELQ13YzpPV2WaKnx2nA+JkFhkY/rWo9LABpVYX/EPZ+gvFQHPlb3
	Y6TX7WhxiS/YJp4zKSbi5ftrV3JwA0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762857223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NL8a+UlhbGyXd2WdlBHIwL7vr0c6ivysNI9rxft/p9U=;
	b=XNUAfiDOVXT3RAvs62TpP1BZ+GhMf08UvsgK5W3Hv2FH1E5JCggH1+w3ebXpooDw49hbyG
	Mr1y90tZ4w49QDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1FBE148ED;
	Tue, 11 Nov 2025 10:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iykQOwYRE2nMMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Nov 2025 10:33:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9ED77A28C8; Tue, 11 Nov 2025 11:33:34 +0100 (CET)
Date: Tue, 11 Nov 2025 11:33:34 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, yi.zhang@huawei.com, libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 1/4] ext4: make ext4_es_cache_extent() support overwrite
 existing extents
Message-ID: <hmfdz3arnmmmrvar2266ye4vb64txvxsa4hrpzppb4sp354b25@tnpvja7o7uww>
References: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
 <20251031062905.4135909-2-yi.zhang@huaweicloud.com>
 <l7tb75bsk52ybeok737b7o4ag4zeleowtddf3v6wcbnhbom4tx@xv643wp5wp6a>
 <ee200d75-6f3e-4514-8fd4-8cdcbd3754d4@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee200d75-6f3e-4514-8fd4-8cdcbd3754d4@huaweicloud.com>
X-Rspamd-Queue-Id: 093931F6E6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,huawei.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

Hi!

On Thu 06-11-25 21:02:35, Zhang Yi wrote:
> On 11/6/2025 5:15 PM, Jan Kara wrote:
> > On Fri 31-10-25 14:29:02, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Currently, ext4_es_cache_extent() is used to load extents into the
> >> extent status tree when reading on-disk extent blocks. Since it may be
> >> called while moving or modifying the extent tree, so it does not
> >> overwrite existing extents in the extent status tree and is only used
> >> for the initial loading.
> >>
> >> There are many other places in ext4 where on-disk extents are inserted
> >> into the extent status tree, such as in ext4_map_query_blocks().
> >> Currently, they call ext4_es_insert_extent() to perform the insertion,
> >> but they don't modify the extents, so ext4_es_cache_extent() would be a
> >> more appropriate choice. However, when ext4_map_query_blocks() inserts
> >> an extent, it may overwrite a short existing extent of the same type.
> >> Therefore, to prepare for the replacements, we need to extend
> >> ext4_es_cache_extent() to allow it to overwrite existing extents with
> >> the same type.
> >>
> >> In addition, since cached extents can be more lenient than the extents
> >> they modify and do not involve modifying reserved blocks, it is not
> >> necessary to ensure that the insertion operation succeeds as strictly as
> >> in the ext4_es_insert_extent() function.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Thanks for writing this series! I think we can actually simplify things
> > event further. Extent status tree operations can be divided into three
> > groups:
> > 1) Lookups in es tree - protected only by i_es_lock.
> > 2) Caching of on-disk state into es tree - protected by i_es_lock and
> >    i_data_sem (at least in read mode).
> > 3) Modification of existing state - protected by i_es_lock and i_data_sem
> >    in write mode.
> 
> Yeah.
> 
> > 
> > Now because 2) has exclusion vs 3) due to i_data_sem, the observation is
> > that 2) should never see a real conflict - i.e., all intersecting entries
> > in es tree have the same status, otherwise this is a bug.
> 
> While I was debugging, I observed two exceptions here.
> 
> A. The first exceptions is about the delay extent. Since there is no actual
>    extent present in the extent tree on the disk, if a delayed extent
>    already exists in the extent status tree and someone calls
>    ext4_find_extent()->ext4_cache_extents() to cache an extent at the same
>    location, then a status mismatch will occur (attempting to replace
>    the delayed extent with a hole). This is not a bug.
> B. I also observed that ext4_find_extent()->ext4_cache_extents() is called
>    during splitting and conversion between unwritten and written states (in
>    most scenarios, EXT4_EX_NOCACHE is not added). However, because the
>    process is in an intermediate state of handling extents, there can be
>    cases where the status do not match. I did not analyze this scenario in
>    detail, but since ext4_es_insert_extent() is called at the end of the
>    processing to ensure the final state is correct, I don't think this is a
>    practical issue either.

Thanks for bringing this up. I didn't think about these two cases. As for
case A that is easy to deal with as you write below. A hole insertion can
be deemed compatible with existing delalloc extent.

Case B is more difficult and I think I need to better understand the
details there to decide what to do. Only extent splitting (as it happens
e.g. with EXT4_GET_BLOCKS_PRE_IO) should keep extents in the extent tree and
extent status tree compatible. So it has to be something like
EXT4_GET_BLOCKS_CONVERT case. There indeed after we call
ext4_ext_mark_initialized() we have initialized extent on disk but in
extent status tree it is still as unwritten. But I just didn't find a place
in the extent conversion path that would modify extent state on disk and
then call ext4_find_extent(). Can you perhaps share a stacktrace where the
extent incompatibility was hit from ext4_cache_extents()? Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

