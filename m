Return-Path: <linux-fsdevel+bounces-28715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49D096D627
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4221C20C6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7304198A32;
	Thu,  5 Sep 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PylMlti7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ILpYAjl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PylMlti7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ILpYAjl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF619413B;
	Thu,  5 Sep 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532366; cv=none; b=PO/krXf0SrnO9fynPdcrsbSSaydUaf1xJ64CCcxqlDeHWhmcUal1p72M+HtR5y85wvbENBQCvyZDSjlPcTGB4JH0KN9k4kr0zieitylJsnJ+zCj6bZycGT54qlnRwzYn+noiPo9oMqe+lsDky5ER1shNs6yOvrmpFp1LgL+XHxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532366; c=relaxed/simple;
	bh=lrw6JKXkg2xkRPCTeIJW+sWANZV34HVUrJYskrX2q7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF02fw8+DXHMwKExDjWVB/qgxtydeIzqLIbEbbI16xqZgf/HlUBAROHGGeC7u0KSAjmoEG34zaADsNxYmBBJmljK/b+f+t4M9FWoI0j4dCV32/HxY/f8U/AcVztgBEvbzOlbj2OPcWtjsrOKccsZr43tmsB30Y8b0IqMBuHmRCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PylMlti7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ILpYAjl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PylMlti7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ILpYAjl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 495B921997;
	Thu,  5 Sep 2024 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725532362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGTkH4oh9NHDW96Zl9RwXbqcPM3Zj5WtaBYMX1tApro=;
	b=PylMlti7gwg0DsmBhYtHDa80c6zGryAmrJuKFjikMJFNfNO/HkscTxhaxjTi+f1dPkrWWG
	fYSeVmFDzViCZQeYhly1joWDfjMRYVNTpNO2x3UUVOCk8yUSQQWd2rnunFpW/et/+x6I5D
	Rg1jyutz3r3o+pA0bwgmxbJTcgyD/k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725532362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGTkH4oh9NHDW96Zl9RwXbqcPM3Zj5WtaBYMX1tApro=;
	b=9ILpYAjljzRtAxT6Kq/JyLrSs37uU//KgjxqN0tShlrWfHkqOR0MMR1FdmLtLTWHb6ppAw
	tgMeujab5HDi7IAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PylMlti7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9ILpYAjl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725532362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGTkH4oh9NHDW96Zl9RwXbqcPM3Zj5WtaBYMX1tApro=;
	b=PylMlti7gwg0DsmBhYtHDa80c6zGryAmrJuKFjikMJFNfNO/HkscTxhaxjTi+f1dPkrWWG
	fYSeVmFDzViCZQeYhly1joWDfjMRYVNTpNO2x3UUVOCk8yUSQQWd2rnunFpW/et/+x6I5D
	Rg1jyutz3r3o+pA0bwgmxbJTcgyD/k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725532362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGTkH4oh9NHDW96Zl9RwXbqcPM3Zj5WtaBYMX1tApro=;
	b=9ILpYAjljzRtAxT6Kq/JyLrSs37uU//KgjxqN0tShlrWfHkqOR0MMR1FdmLtLTWHb6ppAw
	tgMeujab5HDi7IAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EC2C139D2;
	Thu,  5 Sep 2024 10:32:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BLVMD8qI2WaTTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Sep 2024 10:32:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D932AA0968; Thu,  5 Sep 2024 12:32:37 +0200 (CEST)
Date: Thu, 5 Sep 2024 12:32:37 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, jack@suse.cz, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/18] fanotify: add pre-content hooks
Message-ID: <20240905103237.cuqlgj4nbrapahtu@quack3>
References: <cover.1725481503.git.josef@toxicpanda.com>
 <CAOQ4uxikusW_q=zdqDKCHz8kGoTyUg1htWhPR1OFAFGHdj-vcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxikusW_q=zdqDKCHz8kGoTyUg1htWhPR1OFAFGHdj-vcQ@mail.gmail.com>
X-Rspamd-Queue-Id: 495B921997
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 05-09-24 10:33:07, Amir Goldstein wrote:
> On Wed, Sep 4, 2024 at 10:29 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > v4: https://lore.kernel.org/linux-fsdevel/cover.1723670362.git.josef@toxicpanda.com/
> > v3: https://lore.kernel.org/linux-fsdevel/cover.1723228772.git.josef@toxicpanda.com/
> > v2: https://lore.kernel.org/linux-fsdevel/cover.1723144881.git.josef@toxicpanda.com/
> > v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/
> >
> > v4->v5:
> > - Cleaned up the various "I'll fix it on commit" notes that Jan made since I had
> >   to respin the series anyway.
> > - Renamed the filemap pagefault helper for fsnotify per Christians suggestion.
> > - Added a FS_ALLOW_HSM flag per Jan's comments, based on Amir's rough sketch.
> > - Added a patch to disable btrfs defrag on pre-content watched files.
> > - Added a patch to turn on FS_ALLOW_HSM for all the file systems that I tested.
> 
> My only nits are about different ordering of the FS_ALLOW_HSM patches
> I guess as the merge window is closing in, Jan could do these trivial
> reorders on commit, based on his preference (?).

Yes, I can do the reordering on commit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

