Return-Path: <linux-fsdevel+bounces-70012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 39405C8E3DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B28B34CF6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E4433030D;
	Thu, 27 Nov 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fQS2xmR6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YYh4853n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fQS2xmR6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YYh4853n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB91632E12C
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764246273; cv=none; b=M0AmNQTiHb3U2JCXH3E71xgfe0oxiYkXA0Xu3MifwutUjzRwWlrHZuFpCUirQFFEkxD+lzWaly/o13DSwt6ZazfphAc6nvuH1YXaHqNIiFRvPhJajIN1I/0mPfTzZKj0o/9XP4mrPrezPwuXFTzkmGjfy3lWx5hKPlxOl5RjlTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764246273; c=relaxed/simple;
	bh=YR4ALjbQ2E76vBQJqyBiOe93M1XOepLWns7AQwXo/04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7/N0dSDxDmxUY5NQF55e3l0j063Xf/vmZ7xNl+vUUXGVlcftfpcWmoZmSejGetGx6wPlogY+usqz3pOxYB4SO3LxRTaCr6C40t1AYkGOfU8tqR6Ki5rs58kalx+9HYgT7+jyubb+mX0dlmH0lKzsB6/Ne1S3u2MGucZdBVt9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fQS2xmR6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YYh4853n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fQS2xmR6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YYh4853n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AEC521247;
	Thu, 27 Nov 2025 12:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764246270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+GIh1RZPB6kn4lo03uhXtfPG71KNz8R0NUyprXAeDc=;
	b=fQS2xmR6DeLYni8TBIHt7ACgS8D9i/C7z36H3bP8TAc52ICF/4O/SSFaTOvRGTr1ejWlrK
	aQPz/B4hx1ey1pyL7U7Yjzm4pOnj6uJBaKeoe6CAH+VazJgb3mAIYY0V7mH+RzVmx0tgf5
	F1I32aiAc1CIbNYnaBOWxk2JzPRNbic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764246270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+GIh1RZPB6kn4lo03uhXtfPG71KNz8R0NUyprXAeDc=;
	b=YYh4853nANGVkh3BxSmNXsqUpLKlwNEVz0zoIfHlrPmr6Yk8lrDZFq722clc8CUVeQR/UB
	jZil9WDPpIwfVUAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764246270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+GIh1RZPB6kn4lo03uhXtfPG71KNz8R0NUyprXAeDc=;
	b=fQS2xmR6DeLYni8TBIHt7ACgS8D9i/C7z36H3bP8TAc52ICF/4O/SSFaTOvRGTr1ejWlrK
	aQPz/B4hx1ey1pyL7U7Yjzm4pOnj6uJBaKeoe6CAH+VazJgb3mAIYY0V7mH+RzVmx0tgf5
	F1I32aiAc1CIbNYnaBOWxk2JzPRNbic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764246270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+GIh1RZPB6kn4lo03uhXtfPG71KNz8R0NUyprXAeDc=;
	b=YYh4853nANGVkh3BxSmNXsqUpLKlwNEVz0zoIfHlrPmr6Yk8lrDZFq722clc8CUVeQR/UB
	jZil9WDPpIwfVUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E54083EA63;
	Thu, 27 Nov 2025 12:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P5LxN/1CKGmxEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 12:24:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3237DA0C94; Thu, 27 Nov 2025 13:24:29 +0100 (CET)
Date: Thu, 27 Nov 2025 13:24:29 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 00/13] ext4: replace ext4_es_insert_extent() when
 caching on-disk extents
Message-ID: <yfekmxz7biiuvairgen2pw6laccs4qvblt56uxmqenyckt2pp6@rfagttgqpdfr>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <aSLoN-oEqS-OpLKE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9cef3b97-083e-48e6-aced-3e250df364e3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cef3b97-083e-48e6-aced-3e250df364e3@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
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
	FREEMAIL_CC(0.00)[linux.ibm.com,vger.kernel.org,mit.edu,dilger.ca,suse.cz,huawei.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

Hi Yi!

On Mon 24-11-25 13:04:04, Zhang Yi wrote:
> On 11/23/2025 6:55 PM, Ojaswin Mujoo wrote:
> > On Fri, Nov 21, 2025 at 02:07:58PM +0800, Zhang Yi wrote:
> >> Changes since v1:
> >>  - Rebase the codes based on the latest linux-next 20251120.
> >>  - Add patches 01-05, fix two stale data problems caused by
> > 
> > Hi Zhang, thanks for the patches.
> > 
> 
> Thank you for take time to look at this series.
> 
> > I've always felt uncomfortable with the ZEROOUT code here because it
> > seems to have many such bugs as you pointed out in the series. Its very
> > fragile and the bugs are easy to miss behind all the data valid and
> > split flags mess. 
> > 
> 
> Yes, I agree with you. The implementation of EXT4_EXT_MAY_ZEROOUT has
> significantly increased the complexity of split extents and the
> potential for bugs.

Yep, that code is complex and prone to bugs.

> > As per my understanding, ZEROOUT logic seems to be a special best-effort
> > try to make the split/convert operation "work" when dealing with
> > transient errors like ENOSPC etc. I was just wondering if it makes sense
> > to just get rid of the whole ZEROOUT logic completely and just reset the
> > extent to orig state if there is any error. This allows us to get rid of
> > DATA_VALID* flags as well and makes the whole ext4_split_convert_extents() 
> > slightly less messy.
> > 
> > Maybe we can have a retry loop at the top level caller if we want to try
> > again for say ENOSPC or ENOMEM. 
> > 
> > Would love to hear your thoughts on it.
> 
> I think this is a direction worth exploring. However, what I am
> currently considering is that we need to address this scenario of
> splitting extent during the I/O completion. Although the ZEROOUT logic
> is fragile and has many issues recently, it currently serves as a
> fallback solution for handling ENOSPC errors that arise when splitting
> extents during I/O completion. It ensures that I/O operations do not
> fail due to insufficient extent blocks.

Also partial extent zeroout offers a good performance win when the
portion needing zeroout is small (we can save extent splitting). And I
agree it is a good safety net for ENOSPC issues - otherwise there's no
guarantee page writeback can finish without hitting ENOSPC. We do have
reserved blocks for these cases but the pool is limited so you can still
run out of blocks if you try hard enough.

> Please see ext4_convert_unwritten_extents_endio(). Although we have made
> our best effort to tried to split extents using
> EXT4_GET_BLOCKS_IO_CREATE_EXT before issuing I/Os, we still have not
> covered all scenarios. Moreover, after converting the buffered I/O path
> to the iomap infrastructure in the future, we may need to split extents
> during the I/O completion worker[1].

Yes, this might be worth exploring. The advantage of doing extent splitting
in advance is that on IO submission you have the opportunity of restarting
the transaction on ENOSPC to possibly release some blocks. This is not
easily doable e.g. on writeback completion so the pressure on the pool of
reserved blocks is going to be more common (previously you needed reserved
blocks only when writeback was racing with fallocate or similar, now you
may need them each time you write in the middle of unwritten extent). So I
think the change will need some testing whether it isn't too easy to hit
ENOSPC conditions on IO completion without EXT4_GET_BLOCKS_IO_CREATE_EXT.
But otherwise it's always nice to remove code :)
 
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

