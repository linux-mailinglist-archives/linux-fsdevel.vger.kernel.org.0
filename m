Return-Path: <linux-fsdevel+bounces-35322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3440C9D3CA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 14:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659F5B2200B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 13:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368961A9B45;
	Wed, 20 Nov 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qnQBZCyY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m6IwTtNg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDFMFEDB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hf3WS6js"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09919D8A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110171; cv=none; b=la0NtR9LIH1dXdMX97Nks+8FlQ1qgddXTnMMa45gJHkMYgyujyTMH+Fr/hDB6Pe/QGX0ok07Wtujv/lTkV0DR2KimPm+PQGAevC4reypPhclWBsl4eWv7Bz7dsKgy7/GV5hXGikxCJXRJ1DxJF0PQDGICj5BurkdsKZ9xr6P2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110171; c=relaxed/simple;
	bh=ZTYd1+MiqXYDHBMrO4y0w6k821WxkxTDrxDxFMo6FcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKDuGHMRRwn8O/bNCiyG4R6PuPJaHbMdwF6ksx/tUovKidH1i7tHCgPZQFurpLrzXbp33Yz16QheyyyM79jHUku+2hzooz4Mor2oDhpa/bFqG0FKyqo6l27/92oM0+rhOZThztDgnsfy9ACdNEE9FU1ZmiJFI9WvZZpUoKzB5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qnQBZCyY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m6IwTtNg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MDFMFEDB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hf3WS6js; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E76A4219E3;
	Wed, 20 Nov 2024 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732110167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdH/Ran5KBaheWdNodcgCSmS2bDHN1U4ji/IsQkZKzg=;
	b=qnQBZCyYL3E8AvS1+N9GstYzac4W52/eZJsqYJy/e3L0dFgmerI04aWdu4MtHl3UEXx1ZP
	a2Ab2wQbDjfkeg9qjkRofrpSmqrIAOH4LGvcKisnleOd5eEIGTTnJ9wSrKDmEstEFOXy0G
	cGfzi7dnib22Jde1D10IDZHWFAC7Bkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732110167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdH/Ran5KBaheWdNodcgCSmS2bDHN1U4ji/IsQkZKzg=;
	b=m6IwTtNglHXczGvMVZrUKPuXeQNXlEtcfOfBmG48p9YrcsCl1nexRqxs2V/sNbYyKRCp8W
	hZUlook8i6WQjZCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732110166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdH/Ran5KBaheWdNodcgCSmS2bDHN1U4ji/IsQkZKzg=;
	b=MDFMFEDBmnTpQNrwJJiiVRFcsrJxYvUKbyax1wSRWYkBwvMLnKW6EtMnasloHcb/Agp1+i
	i4Nz7nBH9XBK0M9tzvnqywFRNbdG00FfQHOlM5QihDgMrM/dMzLBuSJMAQi3BpEkPqcv8Z
	J6ylAc0G/Ar/Gg1y1h1MDS99KuroDBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732110166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdH/Ran5KBaheWdNodcgCSmS2bDHN1U4ji/IsQkZKzg=;
	b=hf3WS6jsAwungtV7bRYcxwjiw4ssbKWtG3yng7O6PV0dtUGG4BUL6Bv1SpJQbIn42iKAa/
	PefoiW9mTbHBhDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD03713297;
	Wed, 20 Nov 2024 13:42:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DUTxNVbnPWdIJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Nov 2024 13:42:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 86C19A08B8; Wed, 20 Nov 2024 14:42:46 +0100 (CET)
Date: Wed, 20 Nov 2024 14:42:46 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [amir73il:fan_pre_content 19/21] ERROR: modpost:
 "filemap_fsnotify_fault" [fs/xfs/xfs.ko] undefined!
Message-ID: <20241120134246.toxpbv7owgzwwax2@quack3>
References: <202411191423.eEl9yEsr-lkp@intel.com>
 <CAOQ4uxhsyuyd9=iJ1GLYXPrtfUqsdWaxObLUGngKV8bwhbK1-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhsyuyd9=iJ1GLYXPrtfUqsdWaxObLUGngKV8bwhbK1-A@mail.gmail.com>
X-Spam-Score: -3.60
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	SUBJECT_ENDS_EXCLAIM(0.20)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 19-11-24 07:45:07, Amir Goldstein wrote:
> On Tue, Nov 19, 2024 at 7:25 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://github.com/amir73il/linux fan_pre_content
> > head:   a2b4aa2a63d555f7b7d22f6f54583dff35a1f608
> > commit: d3e0f4f0a419a7012bcdc60530619ba2cdf96e85 [19/21] xfs: add pre-content fsnotify hook for write faults
> > config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241119/202411191423.eEl9yEsr-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241119/202411191423.eEl9yEsr-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202411191423.eEl9yEsr-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> ERROR: modpost: "filemap_fsnotify_fault" [fs/xfs/xfs.ko] undefined!
> 
> Jan,
> 
> We need an empty implementation of filemap_fsnotify_fault() for
> !CONFIG_MMU to avert this warning.
> 
> Could you add it on commit?

Yes, I can handle that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

