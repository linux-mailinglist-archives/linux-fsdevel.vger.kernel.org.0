Return-Path: <linux-fsdevel+bounces-70133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30973C91C55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951083ADA82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FC430DEB9;
	Fri, 28 Nov 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="COknjECa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="teTayLxp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="COknjECa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="teTayLxp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730B30CD9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764328508; cv=none; b=p899yZ3w1/XtL0Y7UgAGdGYqepdY2WnfMJTpYFbQFFwASjulkgUZyCLpLWP4u+Pw1FxBUrqw7oiY2Dj6p+CXVUNubw9d0FurGi598JHOzOSjZ8Euqwo+jhMv2bwN9+UcPAniEOpmrw4L1o8nmn9Y782zr0qhnUZlS97j/UPv98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764328508; c=relaxed/simple;
	bh=YoZ3V45j6g9Ht6vZa6SWxo5kh/Xvp6DsJmhkRbDNcW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGE8aBKMZkDROGEGTcK4sD1Dsxsu+mpcHkiN3CAr26tuEA8QX8XVyTuOsgk55mgPEHzuxrPM0QSxwXFf7ms9odN0nG7PxrX/kclxPKN1VLlLWbNXvxiQsPhx7YmjKhYOopJAWCDj6gFVMlHlRS3B2mdavx0ejOpNwW56pvuO5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=COknjECa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=teTayLxp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=COknjECa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=teTayLxp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 038595BD2E;
	Fri, 28 Nov 2025 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764328505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YjbZZKXvhot5amM6eYaTdzmGNaRHVpJZ/gN2gho08M=;
	b=COknjECaSkXVNVGCAjzjejHz+30U+DJgOfsOaBWZeKThJPkvQg+kminFnMOAkR3ywvxG3D
	wH5NhAHl0D2hqswZlHYne6XyEdUjvjqC7D7ASFmWvMVsttPxOpR8SwkzK3aPdnDZyzc/96
	6GgnhzBy2RGrL9LanVtqHi/nhlR4V5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764328505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YjbZZKXvhot5amM6eYaTdzmGNaRHVpJZ/gN2gho08M=;
	b=teTayLxpAA9kuIhodKmj9U7EN0tXwyhdtoQY0dO/UiRJvIA/Fuk+B+Kaf0Pf34dtW8QwzV
	bNLgD97gwnxZYzAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764328505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YjbZZKXvhot5amM6eYaTdzmGNaRHVpJZ/gN2gho08M=;
	b=COknjECaSkXVNVGCAjzjejHz+30U+DJgOfsOaBWZeKThJPkvQg+kminFnMOAkR3ywvxG3D
	wH5NhAHl0D2hqswZlHYne6XyEdUjvjqC7D7ASFmWvMVsttPxOpR8SwkzK3aPdnDZyzc/96
	6GgnhzBy2RGrL9LanVtqHi/nhlR4V5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764328505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YjbZZKXvhot5amM6eYaTdzmGNaRHVpJZ/gN2gho08M=;
	b=teTayLxpAA9kuIhodKmj9U7EN0tXwyhdtoQY0dO/UiRJvIA/Fuk+B+Kaf0Pf34dtW8QwzV
	bNLgD97gwnxZYzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3C8B3EA63;
	Fri, 28 Nov 2025 11:15:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 88ORNziEKWnwJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Nov 2025 11:15:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 99732A08F1; Fri, 28 Nov 2025 12:14:56 +0100 (CET)
Date: Fri, 28 Nov 2025 12:14:56 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huaweicloud.com>, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, yi.zhang@huawei.com, 
	yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/13] ext4: don't zero the entire extent if
 EXT4_EXT_DATA_PARTIAL_VALID1
Message-ID: <i3voptrv4rm3q3by7gksrgmgy2n5flchuveugjll5cchustm4z@qvixahynpize>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-4-yi.zhang@huaweicloud.com>
 <yro4hwpttmy6e2zspvwjfdbpej6qvhlqjvlr5kp3nwffqgcnfd@z6qual55zhfq>
 <aSlPFohdm8IfB7r7@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSlPFohdm8IfB7r7@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,huaweicloud.com,vger.kernel.org,mit.edu,dilger.ca,huawei.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 28-11-25 12:58:22, Ojaswin Mujoo wrote:
> On Thu, Nov 27, 2025 at 02:41:52PM +0100, Jan Kara wrote:
> > Good catch on the data exposure issue! First I'd like to discuss whether
> > there isn't a way to fix these problems in a way that doesn't make the
> > already complex code even more complex. My observation is that
> > EXT4_EXT_MAY_ZEROOUT is only set in ext4_ext_convert_to_initialized() and
> > in ext4_split_convert_extents() which both call ext4_split_extent(). The
> > actual extent zeroing happens in ext4_split_extent_at() and in
> > ext4_ext_convert_to_initialized(). I think the code would be much clearer
> > if we just centralized all the zeroing in ext4_split_extent(). At that
> > place the situation is actually pretty simple:
> 
> This is exactly what I was playing with in my local tree to refactor this
> particular part of code :). I agree that ext4_split_extent() is a much
> better place to do the zeroout and it looks much cleaner but I agree
> with Yi that it might be better to do it after fixing the stale
> exposures so backports are straight forward. 
> 
> Am I correct in understanding that you are suggesting to zeroout
> proactively if we are below max_zeroout before even trying to extent
> split (which seems be done in ext4_ext_convert_to_initialized() as well)?

Yes. I was suggesting to effectively keep the behavior from
ext4_ext_convert_to_initialized().

> In this case, I have 2 concerns:
> 
> > 
> > 1) 'ex' is unwritten, 'map' describes part with already written data which
> > we want to convert to initialized (generally IO completion situation) => we
> > can zero out boundaries if they are smaller than max_zeroout or if extent
> > split fails.
> 
> Firstly, I know you mentioned in another email that zeroout of small ranges
> gives us a performance win but is it really faster on average than
> extent manipulation?

I guess it depends on the storage and the details of the extent tree. But
it definitely does help in cases like when you have large unwritten extent
and then start writing randomly 4k blocks into it because this zeroout
logic effectively limits the fragmentation of the extent tree. Overall
sequentially writing a few blocks more of zeros is very cheap practically
with any storage while fragmenting the extent tree becomes expensive rather
quickly (you generally get deeper extent tree due to smaller extents etc.).

> For example, for case 1 where both zeroout and splitting need
> journalling, I understand that splitting has high journal overhead in worst case,
> where tree might grow, but more often than not we would be manipulating
> within the same leaf so journalling only 1 bh (same as zeroout). In which case
> seems like zeroout might be slower no matter how fast the IO can be
> done. So proactive zeroout might be for beneficial for case 3 than case
> 1.

I agree that initially while the split extents still fit into the same leaf
block, zero out is likely to be somewhat slower but over the longer term
the gains from less extent fragmentation win.

> > 2) 'ex' is unwritten, 'map' describes part we are preparing for write (IO
> > submission) => the split is opportunistic here, if we cannot split due to
> > ENOSPC, just go on and deal with it at IO completion time. No zeroing
> > needed.
> > 
> > 3) 'ex' is written, 'map' describes part that should be converted to
> > unwritten => we can zero out the 'map' part if smaller than max_zeroout or
> > if extent split fails.
> 
> Proactive zeroout before trying split does seem benficial to help us
> avoid journal overhead for split. However, judging from
> ext4_ext_convert_to_initialized(), max zeroout comes from
> sbi->s_extent_max_zeroout_kb which is hardcoded to 32 irrespective of
> the IO device, so that means theres a chance a zeroout might be pretty
> slow if say we are doing it on a device than doesn't support accelerated
> zeroout operations. Maybe we need to be more intelligent in setting
> s_extent_max_zeroout_kb?

You can also tune the value in sysfs. I'm not 100% sure how the kernel
could do a better guess. Also I think 32k works mostly because it is small
enough to be cheap to write but already large enough to noticeably reduce
fragmentation for some pathological workloads (you can easily get 1/4 of
the extents than without this logic). But I'm open to ideas if you have
some.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

