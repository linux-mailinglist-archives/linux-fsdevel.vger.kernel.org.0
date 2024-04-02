Return-Path: <linux-fsdevel+bounces-15880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C48955D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 15:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0FA1F23469
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F484FA9;
	Tue,  2 Apr 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GYOArCvz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oVQiqqsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F588405D;
	Tue,  2 Apr 2024 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065998; cv=none; b=nRnvRjkavISD8jnurV7kRZUQ2x7RR1kSioSSrq4JJ7J3gw/yeOWH5Pm4aSrPv47q0Y9fnHgeNm+F8BaXcb2OTkMGFdv3gq+8Y6BWt86XBauuFtwn2ID7LNu3UCjSsg6iyUwb5l9zwFRVkr6eNTPTmQJaDdzHO9+4vHUuViTpV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065998; c=relaxed/simple;
	bh=LyoTfqRjN9j3MoNuZhUjYR5rfEWeY5pb4kTEkVb3zX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM3iK0DbJqcAQP7o9sy4BlqSPWLerVGeOR9wyi99wo7ATT74o7K7Mer3H1K6OzsXNmJIPrUdT1LBy4I5ulihc5UPA4KuFzGv1S0iwSqTlBRWH0crfSg8nH6KuI/Hzm6+k49AEQiNuEIXfmWiiw88t/Ynvc1Ddbbim4TsRSUFn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GYOArCvz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oVQiqqsS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E8905BDF2;
	Tue,  2 Apr 2024 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712065995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FGcfQklvUedGwDv0N6DFd1u+IVz+5qx/4hMKzVEGwI8=;
	b=GYOArCvzuT6FP3IcfS3UQE4mfVipbv0+wGzv1Ht12S5KDzRcG57i9bzNKECetfosW/EZDK
	FRdJRkOOFBB6VFLVFHPeAmoIGmsgiAIgaPsCi6V5QKWP4TNnUjjPWb3YXBWnSwqC/9dxvV
	hDYNPljnvTDAxZHNHxUmWJ69XJi7Hkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712065995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FGcfQklvUedGwDv0N6DFd1u+IVz+5qx/4hMKzVEGwI8=;
	b=oVQiqqsSkWTMu+wnMPetAL7KPG+bdsPQACuZiBPlnhEX6ceCgZlAPkxLH3PTMYeoCTe+EP
	ymdF70jwspkycOCg==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F0AD913A90;
	Tue,  2 Apr 2024 13:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mM66OsoNDGYaXQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 02 Apr 2024 13:53:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 92DB2A0813; Tue,  2 Apr 2024 15:53:06 +0200 (CEST)
Date: Tue, 2 Apr 2024 15:53:06 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, dsterba@suse.com,
	mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 6/6] writeback: remove unneeded GDTC_INIT_NO_WB
Message-ID: <20240402135306.kluke2jjcmh5f4ei@quack3>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-7-shikemeng@huaweicloud.com>
 <Zfr9my_tfxO-N6HS@mtj.duckdns.org>
 <becdb16b-a318-ec05-61d2-d190541ae997@huaweicloud.com>
 <20240327093309.ejuzjus2zcixb4qt@quack3>
 <c2fc01e2-f15a-d331-6c4f-64319f3adc8a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2fc01e2-f15a-d331-6c4f-64319f3adc8a@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
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
	 FREEMAIL_CC(0.00)[suse.cz,kernel.org,linux-foundation.org,kvack.org,vger.kernel.org,infradead.org,redhat.com,suse.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 28-03-24 09:49:59, Kemeng Shi wrote:
> on 3/27/2024 5:33 PM, Jan Kara wrote:
> > On Thu 21-03-24 15:12:21, Kemeng Shi wrote:
> >>
> >>
> >> on 3/20/2024 11:15 PM, Tejun Heo wrote:
> >>> Hello,
> >>>
> >>> On Wed, Mar 20, 2024 at 07:02:22PM +0800, Kemeng Shi wrote:
> >>>> We never use gdtc->dom set with GDTC_INIT_NO_WB, just remove unneeded
> >>>> GDTC_INIT_NO_WB
> >>>>
> >>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> >>> ...
> >>>>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty)
> >>>>  {
> >>>> -	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
> >>>> +	struct dirty_throttle_control gdtc = { };
> >>>
> >>> Even if it's currently not referenced, wouldn't it still be better to always
> >>> guarantee that a dtc's dom is always initialized? I'm not sure what we get
> >>> by removing this.
> >> As we explicitly use GDTC_INIT_NO_WB to set global_wb_domain before
> >> calculating dirty limit with domain_dirty_limits, I intuitively think the
> >> dirty limit calculation in domain_dirty_limits is related to
> >> global_wb_domain when CONFIG_WRITEBACK_CGROUP is enabled while the truth
> >> is not. So this is a little confusing to me.
> > 
> Hi Jan,
> > I'm not sure I understand your confusion. domain_dirty_limits() calculates
> > the dirty limit (and background dirty limit) for the dirty_throttle_control
> > passed in. If you pass dtc initialized with GDTC_INIT[_NO_WB], it will
> > compute global dirty limits. If the dtc passed in is initialized with
> > MDTC_INIT() it will compute cgroup specific dirty limits.
> No doubt about this.
> > 
> > Now because domain_dirty_limits() does not scale the limits based on each
> > device throughput - that is done only later in __wb_calc_thresh() to avoid> relatively expensive computations when we don't need them - and also
> > because the effective dirty limit (dtc->dom->dirty_limit) is not updated by
> > domain_dirty_limits(), domain_dirty_limits() does not need dtc->dom at all.
> Acutally, here is the thing confusing me. For wb_calc_thresh, we always pass
> dtc initialized with a wb (GDTC_INIT(wb) or MDTC_INIT(wb,..). The dtc
> initialized with _NO_WB is only passed to domain_dirty_limits. However, The
> dom initialized by _NO_WB for domain_dirty_limits is not needed at all.
> > But that is a technical detail of implementation and I don't want this
> > technical detail to be relied on by even more code.
> Yes, I agree with this. So I wonder if it's acceptable to simply define
> GDTC_INIT_NO_WB to empty for now instead of remove defination of
> GDTC_INIT_NO_WB. When implementation of domain_dirty_limits() or any
> other low level function in future using GDTC_INIT(_NO_WB) changes to
> need dtc->domain, we re-define GDTC_INIT_NO_WB to proper value.
> As this only looks confusing to me. I will drop this one in next version
> if you still prefer to keep definatino of GDTC_INIT_NO_WB in the old way.

Yeah, please keep the code as is for now. I agree this needs some cleanups
but what you suggest is IMHO not an improvement.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

