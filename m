Return-Path: <linux-fsdevel+bounces-15387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A4388DA4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 10:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F3D1C23517
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542D6364B4;
	Wed, 27 Mar 2024 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vng5gi4s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7Xk/ghNk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vng5gi4s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7Xk/ghNk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7DB36AEE;
	Wed, 27 Mar 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531997; cv=none; b=LGmwmrV2R4IA4KVCgmRclgHpvEtjhnISc7n874lraXmFS//OS7+8T1QNEEKurIYiJH+akMnUsXM2kbLVAVEpMthIEgoq3zwoOAvcj8YvFmHRLL6dtrnrouOUHDM4+SNX1gNjQLJBvUOPORDdRVoCvfROjKv+oKhUs/rG88tq4vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531997; c=relaxed/simple;
	bh=vEcZ/Q1akhcZHJE06X72YESNtGMAMVwjBWD8vmdT8T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuC68ev6EzKRtmXwO+OfH3JjyLiV3Nd0R642uhBucYiFNw6EnE/CUU/xfHRLJjEVyfn7UlwCMj14gOY7cTXRz6cx2g1QVGMKo85mguqwN2tlaLxV/efnbDx1AdCV9jIaheR0Kgrwp5ZZkIJdS7NmSbCSLoP/5EUC5XKJb0sQb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vng5gi4s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7Xk/ghNk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vng5gi4s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7Xk/ghNk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5E21387EF;
	Wed, 27 Mar 2024 09:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711531993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q1Gpg1vNXmP8CcxozlvISl2pAsCSU9f210dFyaw38Y=;
	b=Vng5gi4sxoupKaSAG8p96Lfo9gIv+5sPUTQPFcXjd51APv0naDgto8X/CXP4Vn0eEnldRN
	OmWprAcUte9j+3pY8DG2XMwmy8diCh+5noU2wf2tiMVuWAREqQdImKhyZDjtJ8hvwuRT2/
	bRUHzGaVReAdhwXyy+5EQ9LJ+Ojbqyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711531993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q1Gpg1vNXmP8CcxozlvISl2pAsCSU9f210dFyaw38Y=;
	b=7Xk/ghNkRUjffJZlf7vWMhyMSAjGjn6Jwxmt3kO9g/cJONbTjb7YtOyl2mxqsv/ADShrDd
	W3wPWh6dShi509BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711531993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q1Gpg1vNXmP8CcxozlvISl2pAsCSU9f210dFyaw38Y=;
	b=Vng5gi4sxoupKaSAG8p96Lfo9gIv+5sPUTQPFcXjd51APv0naDgto8X/CXP4Vn0eEnldRN
	OmWprAcUte9j+3pY8DG2XMwmy8diCh+5noU2wf2tiMVuWAREqQdImKhyZDjtJ8hvwuRT2/
	bRUHzGaVReAdhwXyy+5EQ9LJ+Ojbqyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711531993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q1Gpg1vNXmP8CcxozlvISl2pAsCSU9f210dFyaw38Y=;
	b=7Xk/ghNkRUjffJZlf7vWMhyMSAjGjn6Jwxmt3kO9g/cJONbTjb7YtOyl2mxqsv/ADShrDd
	W3wPWh6dShi509BQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A243613215;
	Wed, 27 Mar 2024 09:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id m9dXJ9nnA2aXCgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 27 Mar 2024 09:33:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4566AA0812; Wed, 27 Mar 2024 10:33:09 +0100 (CET)
Date: Wed, 27 Mar 2024 10:33:09 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, willy@infradead.org,
	bfoster@redhat.com, jack@suse.cz, dsterba@suse.com,
	mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 6/6] writeback: remove unneeded GDTC_INIT_NO_WB
Message-ID: <20240327093309.ejuzjus2zcixb4qt@quack3>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-7-shikemeng@huaweicloud.com>
 <Zfr9my_tfxO-N6HS@mtj.duckdns.org>
 <becdb16b-a318-ec05-61d2-d190541ae997@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <becdb16b-a318-ec05-61d2-d190541ae997@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,kvack.org,vger.kernel.org,infradead.org,redhat.com,suse.cz,suse.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Thu 21-03-24 15:12:21, Kemeng Shi wrote:
> 
> 
> on 3/20/2024 11:15 PM, Tejun Heo wrote:
> > Hello,
> > 
> > On Wed, Mar 20, 2024 at 07:02:22PM +0800, Kemeng Shi wrote:
> >> We never use gdtc->dom set with GDTC_INIT_NO_WB, just remove unneeded
> >> GDTC_INIT_NO_WB
> >>
> >> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> > ...
> >>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty)
> >>  {
> >> -	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
> >> +	struct dirty_throttle_control gdtc = { };
> > 
> > Even if it's currently not referenced, wouldn't it still be better to always
> > guarantee that a dtc's dom is always initialized? I'm not sure what we get
> > by removing this.
> As we explicitly use GDTC_INIT_NO_WB to set global_wb_domain before
> calculating dirty limit with domain_dirty_limits, I intuitively think the
> dirty limit calculation in domain_dirty_limits is related to
> global_wb_domain when CONFIG_WRITEBACK_CGROUP is enabled while the truth
> is not. So this is a little confusing to me.

I'm not sure I understand your confusion. domain_dirty_limits() calculates
the dirty limit (and background dirty limit) for the dirty_throttle_control
passed in. If you pass dtc initialized with GDTC_INIT[_NO_WB], it will
compute global dirty limits. If the dtc passed in is initialized with
MDTC_INIT() it will compute cgroup specific dirty limits.

Now because domain_dirty_limits() does not scale the limits based on each
device throughput - that is done only later in __wb_calc_thresh() to avoid
relatively expensive computations when we don't need them - and also
because the effective dirty limit (dtc->dom->dirty_limit) is not updated by
domain_dirty_limits(), domain_dirty_limits() does not need dtc->dom at all.
But that is a technical detail of implementation and I don't want this
technical detail to be relied on by even more code.

What might have confused you is that GDTC_INIT_NO_WB is defined to be empty
when CONFIG_CGROUP_WRITEBACK is disabled. But this is only because in that
case dtc_dom() function unconditionally returns global_wb_domain so we
don't bother with initializing (or even having) the 'dom' field anywhere.

Now I agree this whole code is substantially confusing and complex and it
would all deserve some serious thought how to make it more readable. But
even after thinking about it again I don't think removing GDTC_INIT_NO_WB is
the right way to go.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

