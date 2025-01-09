Return-Path: <linux-fsdevel+bounces-38726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F75A072EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 11:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4413A8F7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 10:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F08216E00;
	Thu,  9 Jan 2025 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ciDErO7e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fSRlFUWo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ciDErO7e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fSRlFUWo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE902153C7
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418074; cv=none; b=TufSxWZmTwb8g50rh9ePuHFo6XXOtlrG0JHUexViIPhbRWgJjBeTQdhe3Qd0nh6+xSsuCQGW1zj0qPJ+p4MEH5Msxk8Rr1wjGxgxRKUvFq4I71VEHyugXrRZgPRI14deM8Y50lGFI/eE0JSi0iEWQoOYPHcMwD2EcTZnPmLiYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418074; c=relaxed/simple;
	bh=PVXLemHqbm3NbEGFBGharVqrfd8llLLDv3je5x14Rio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMLq7w/UYG8Z6alaZkmvnkKxleUIjR66rU0Ad7RpipNZalCD17Yh9GJKukvz2Upxwbi2sBds2uRe+ScRFOcrPIW50+fzpXF191jzNJ/BzWn4znFs7CyVeQaAk4g/1x42S8iYJK8daPv2fbeu4pna9G11MT9tiqMnbQkpMItLvXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ciDErO7e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fSRlFUWo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ciDErO7e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fSRlFUWo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B596E21101;
	Thu,  9 Jan 2025 10:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736418070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RD/Go8GakXcQNS/wr3NWmGSY+qbUSSyDhJT0l2tR2+U=;
	b=ciDErO7euAoSJG5fcPyqeh6xI69F0lSVFAuj9oBi9Aa1hzZq3gOn0rywNzyElF3NqDVFOK
	FKf94jJUeKweo74MvLCvLnK5Ov9R7POfV5BVYaxz9YOYJiy5qrVZaFJf7TV0zReFaScYfX
	KNModr1PeBXae6b511mjXyM0W6lgOHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736418070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RD/Go8GakXcQNS/wr3NWmGSY+qbUSSyDhJT0l2tR2+U=;
	b=fSRlFUWoz/69D05/yzBHhIUvEblB4nFnyxyD9pY4wEyPVbBYq2Y9AH8bdiUXUuDK0by2EW
	Kk2VzhUks4ZjXpAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736418070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RD/Go8GakXcQNS/wr3NWmGSY+qbUSSyDhJT0l2tR2+U=;
	b=ciDErO7euAoSJG5fcPyqeh6xI69F0lSVFAuj9oBi9Aa1hzZq3gOn0rywNzyElF3NqDVFOK
	FKf94jJUeKweo74MvLCvLnK5Ov9R7POfV5BVYaxz9YOYJiy5qrVZaFJf7TV0zReFaScYfX
	KNModr1PeBXae6b511mjXyM0W6lgOHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736418070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RD/Go8GakXcQNS/wr3NWmGSY+qbUSSyDhJT0l2tR2+U=;
	b=fSRlFUWoz/69D05/yzBHhIUvEblB4nFnyxyD9pY4wEyPVbBYq2Y9AH8bdiUXUuDK0by2EW
	Kk2VzhUks4ZjXpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9CD0139AB;
	Thu,  9 Jan 2025 10:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IylsKRajf2crEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 Jan 2025 10:21:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 58FDAA0887; Thu,  9 Jan 2025 11:21:02 +0100 (CET)
Date: Thu, 9 Jan 2025 11:21:02 +0100
From: Jan Kara <jack@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] The future of anon_vma
Message-ID: <zh2hu4fzaqrhw5qdbpcspcsvmnczjo7v5q4b65uq7eaz7exanz@ihsk5oa5njfn>
References: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hi!

On Wed 08-01-25 22:23:16, Lorenzo Stoakes via Lsf-pc wrote:
> A future where we unify anonymous and file-backed memory mappings would be
> one in which a reflinks were implemented at a general level rather than, as
> they are now, implemented individually within file systems.
> 
> I'd like to discuss how feasible doing so might be, whether this is a sane
> line of thought at all, and how a roadmap for working towards the
> elimination of anon_vma as it stands might look.

As you can imagine this has been discussed in the past and some folks are
very interested in saving page cache memory for some heavily reflinked
container setups or for various FUSE filesystems. So if someone manages to
come up with a feasible design, the usecases are there. I think reading
e.g. [1] and comments below it is a good preparation for the session to get
some idea what challenges are there :).

								Honza

[1] https://lwn.net/Articles/717950/



-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

