Return-Path: <linux-fsdevel+bounces-16118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF828898A3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 16:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4571E1F2D48E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933B91C698;
	Thu,  4 Apr 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HxUUJ+JF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iJPPRKV/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HxUUJ+JF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iJPPRKV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73715EA6
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241289; cv=none; b=jYH0wiZXUpeoLFZKkn0eAIIXqk10XKRFh4GE4+KEsqSF9TXKSxsDIFWttbzZiMtMyOd+F1UNCIbxj2i2XBCWCe04bva4yFH1Md6/xK+AWaZclhuIegzMSeFNjHRnFh+SpI1r67dE3CNbxC8E8lNlO7VI3breQx/27CgtTUd1rLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241289; c=relaxed/simple;
	bh=yqRIZt9uiklxMvZCl6WqnC3Fb66BWd6I0hAiX1PluJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFjg+0mhH3Q+9jFtXDLu5xLTHESRI+Jz3QAqbcv4afIsaAC2o4XgzyNeC7dFbhxduAUMlMpQo3yVY7WRPoAvmOc6+W+eT6l4QNMps312FBL5rmIK3U6UX7yX5hu+AKV2eUr+OQbrSyWBAbbTPGAMK5ecqRU7d9bnm3zjo/OPy6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HxUUJ+JF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iJPPRKV/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HxUUJ+JF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iJPPRKV/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C0C037C7F;
	Thu,  4 Apr 2024 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712241284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5qwxwlOlToBrIXRxAVRhFJY83jpHsG7WQFBwQ4SOFg=;
	b=HxUUJ+JFiEZcGFJs7urJ281UsQ7B0AO1EsP2X7GTl9yipr194O7rtliDKPMjoJeFfxFGDh
	+q774nXbZshNM+Qs35ECQ01lpGhGxoLaRrpZ0VV9kU6NsikiwuqatTlf5cCCkVaAWVdE5S
	pcxBq/KkEdYgRKPGCeeOEEOrnj5Fa5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712241284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5qwxwlOlToBrIXRxAVRhFJY83jpHsG7WQFBwQ4SOFg=;
	b=iJPPRKV/9cijPd0iY7J86VTe9A0IPETq/VvrchFqNyI9beI0Zn4b627wgvu3TyhJbWJEoh
	4p7HwIVecpFPAsBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712241284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5qwxwlOlToBrIXRxAVRhFJY83jpHsG7WQFBwQ4SOFg=;
	b=HxUUJ+JFiEZcGFJs7urJ281UsQ7B0AO1EsP2X7GTl9yipr194O7rtliDKPMjoJeFfxFGDh
	+q774nXbZshNM+Qs35ECQ01lpGhGxoLaRrpZ0VV9kU6NsikiwuqatTlf5cCCkVaAWVdE5S
	pcxBq/KkEdYgRKPGCeeOEEOrnj5Fa5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712241284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l5qwxwlOlToBrIXRxAVRhFJY83jpHsG7WQFBwQ4SOFg=;
	b=iJPPRKV/9cijPd0iY7J86VTe9A0IPETq/VvrchFqNyI9beI0Zn4b627wgvu3TyhJbWJEoh
	4p7HwIVecpFPAsBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E5BE13298;
	Thu,  4 Apr 2024 14:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Is8EF4S6DmZPCwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 04 Apr 2024 14:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 06677A0816; Thu,  4 Apr 2024 16:34:43 +0200 (CEST)
Date: Thu, 4 Apr 2024 16:34:43 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 00/10] Further reduce overhead of fsnotify permission
 hooks
Message-ID: <20240404143443.zfurlpe27m4mysrs@quack3>
References: <20240317184154.1200192-1-amir73il@gmail.com>
 <CAOQ4uxgssYK=vL3=0af6gh+AgSPx__UR2cU6gAu_1a3nVdYKLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgssYK=vL3=0af6gh+AgSPx__UR2cU6gAu_1a3nVdYKLA@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -1.98
X-Spam-Level: 
X-Spamd-Result: default: False [-1.98 / 50.00];
	BAYES_HAM(-1.18)[88.95%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email]

On Tue 19-03-24 11:59:11, Amir Goldstein wrote:
> On Sun, Mar 17, 2024 at 8:42 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Jan,
> >
> > Commit 082fd1ea1f98 ("fsnotify: optimize the case of no parent watcher")
> > has reduced the CPU overhead of fsnotify hooks, but we can further
> > reduce the overhead of permission event hooks, by avoiding the call to
> > fsnotify() and fsnotify_parent() altogether when there are no permission
> > event watchers on the sb.
> >
> > The main motivation for this work was to avoid the overhead that was
> > reported by kernel test robot on the patch that adds the upcoming
> > per-content event hooks (i.e. FS_PRE_ACCESS/FS_PRE_MODIFY).
> >
> > Kernel test robot has confirmed that with this series, the addition of
> > pre-conent fsnotify hooks does not result in any regression [1].
> > Kernet test robot has also reported performance improvements in some
> > workloads compared to upstream on an earlier version of this series, but
> > still waiting for the final results.
> 
> FYI, the results are back [1] and they show clear improvement in two
> workloads by this patch set as expected when the permission hooks
> are practically being disabled:

Patches are now merged into my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

