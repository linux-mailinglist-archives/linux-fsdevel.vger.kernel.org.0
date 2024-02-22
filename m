Return-Path: <linux-fsdevel+bounces-12492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F286C85FDA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 17:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF63B28BFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A0E1509A2;
	Thu, 22 Feb 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ePxFagu8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2WLpqt/e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ePxFagu8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2WLpqt/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA414F9CB;
	Thu, 22 Feb 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618111; cv=none; b=BjMMUIz680Ig4eWzCH5qeQmUKjB1GEkSoD3ku4GGaV+J19hHMz/4r/+M2JcMctpotTPtF496grioLtUqxfNAhDda3BamLH7m7p7XihZQmnzzuyAKBxka8g4E0GkVc9nz6CwfOGu6eBOYv0ElU5tgBoz3zB+NxaK9uFtUvC8Rl60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618111; c=relaxed/simple;
	bh=48BXanacAVUSV46yQ32xR3V/Cq8Aa0DPP/5keWQqljg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyAlpM8BnF4J9Pw6E1G/DftALKylUct45mgzzxGjZ4A3ZnEuM8+c5IsSmXnzWnWhNnCMNFYwT4Dtgy3IAMpQiLrKe+FyoUtkdpBYPOYqBS0d+A/H4q9sNS5bEr7MrGn4mhm3aS4+zIIICfB9wmaEn6PtjCtLK6stEDvsuuUPi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ePxFagu8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2WLpqt/e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ePxFagu8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2WLpqt/e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 035B3222CA;
	Thu, 22 Feb 2024 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708618108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KMBzPDx1ur8HmYjTZ/70Mhlnz+IVPKsaUfFS7zXjNc=;
	b=ePxFagu8i0lj4DsKzPI17lRX4vqKZW9FTg8nGFozKqIPfQqrP5m5wKeQkV7rrkLVzkLv7/
	7q8OVxHyi4+vyTc0hN3hRlqhuwJIF40pymCfE4Gl3hAiltelvqm75LVgK/GZZhijAm5DMu
	Hxrnoluxhyn/Rcj3pVV51zNmHsrztjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708618108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KMBzPDx1ur8HmYjTZ/70Mhlnz+IVPKsaUfFS7zXjNc=;
	b=2WLpqt/eod4ZPqZz/l8x5G34c8ziq1ZzbWZF2kFTZSoQCKDiXiDTSsdsREN8fMjlMObeQ8
	WH0J00m1ziqL+uAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708618108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KMBzPDx1ur8HmYjTZ/70Mhlnz+IVPKsaUfFS7zXjNc=;
	b=ePxFagu8i0lj4DsKzPI17lRX4vqKZW9FTg8nGFozKqIPfQqrP5m5wKeQkV7rrkLVzkLv7/
	7q8OVxHyi4+vyTc0hN3hRlqhuwJIF40pymCfE4Gl3hAiltelvqm75LVgK/GZZhijAm5DMu
	Hxrnoluxhyn/Rcj3pVV51zNmHsrztjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708618108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KMBzPDx1ur8HmYjTZ/70Mhlnz+IVPKsaUfFS7zXjNc=;
	b=2WLpqt/eod4ZPqZz/l8x5G34c8ziq1ZzbWZF2kFTZSoQCKDiXiDTSsdsREN8fMjlMObeQ8
	WH0J00m1ziqL+uAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EB6CC13A6B;
	Thu, 22 Feb 2024 16:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id g/1vOXtx12XbegAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 22 Feb 2024 16:08:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6F625A0807; Thu, 22 Feb 2024 17:08:23 +0100 (CET)
Date: Thu, 22 Feb 2024 17:08:23 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-btrfs@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF TOPIC] statx extensions for subvol/snapshot
 filesystems & more
Message-ID: <20240222160823.pclx6isoyaf7l64r@quack3>
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting>
 <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
 <20240222110138.ckai4sxiin3a74ku@quack3>
 <CAJfpegtUZ4YWhYqqnS_BcKKpwhHvdUsQPQMf4j49ahwAe2_AXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtUZ4YWhYqqnS_BcKKpwhHvdUsQPQMf4j49ahwAe2_AXQ@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[42.06%]
X-Spam-Flag: NO

On Thu 22-02-24 13:48:45, Miklos Szeredi wrote:
> On Thu, 22 Feb 2024 at 12:01, Jan Kara <jack@suse.cz> wrote:
> 
> > I think for "unique inode identifier" we don't even have to come up with
> > new APIs. The file handle + fsid pair is an established way to do this,
> 
> Why not uuid?
> 
> fsid seems to be just a degraded uuid.   We can do better with statx
> and/or statmount.

fanotify uses fsid because we have standard interface for querying fsid
(statfs(2)) and because not all filesystems (in particular virtual ones)
bother with uuid. At least the first thing is being changed now.

> > fanotify successfully uses this as object identifier and Amir did quite
> > some work for this to be usable for vast majority of filesystems (including
> 
> Vast majority != all.

True. If we are going to use this scheme more widely, we need to have a
look whether the remaining cases need fixing or we can just ignore them.
They were not very interesting for fanotify so we moved on.

> Also even uuid is just a statistically unique
> identifier, while st_dev was guaranteed to be unique (but not
> persistent, like uuid).

Well, everything is just statistically true in this world :) If you have
conflicting uuids, you are likely to see also other problems so I would not
be too concerned about that.

> If we are going to start fixing userspace, then we better make sure to
> use the right interfaces, that won't have issues in the future.

I agree we should give this a good thought which identification of a
filesystem is the best.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

