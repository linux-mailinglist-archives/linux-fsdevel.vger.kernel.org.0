Return-Path: <linux-fsdevel+bounces-39034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E381CA0B557
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 12:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A423A88BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5988C22F15E;
	Mon, 13 Jan 2025 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yus7zmaj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTd++6D9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yus7zmaj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTd++6D9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11D22AE47
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767295; cv=none; b=jvEjfUySTvAeIHYz3jcSKYbGtzHA2HLeVCBB+B2x5uaQvudQHty1nJqifBsoq4fWiLUCOVtTpVLhGZD7ek+1JaP1HZ5gA7Lp3eh5RF7aYucV2SxjoR+RJeRKhvX4lff/SidY2Fa1yegMO58kSsON/Iu0YEwQxypnY3RcvNoBOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767295; c=relaxed/simple;
	bh=W5owR2kcs+BERg4Ly4q8wp4qrjT1bfL7P2O/yYKUszw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpgSDfCWwTZv6jSaj/CwHIPngWBu5BvJG58Plpn21GCQX0VSImHTl61d9/svj6Uf5gNEGas4poCkYOD5T6TEGQkj/ixZr9UsIwWBAoB7esqKhvD7ZHpUx6EG20img3UI3+Gf1WTw/l1BfSFa7nYU37PV2oA3qDTq4uZTsleSKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yus7zmaj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aTd++6D9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yus7zmaj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aTd++6D9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 699C82116A;
	Mon, 13 Jan 2025 11:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736767292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXFLJzWZUqoF2DAdh6GROHlPPoIUdsvKhJF/6JcFW2k=;
	b=yus7zmajfOj+B5T4IjBfHqpYTbxNqFQMlmNnnDDRRWt3hIuEtCRz9LjvYuEBDTO+FKnKea
	0csSEotgUScvcwgZKHZoFo0Ia/5zTXkdn/qSOCzh3e9EH3oJKfvUareC/xizYnhlNnigVV
	ZHTQk0cKdRG3PN71WOdd/e77rP2s71Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736767292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXFLJzWZUqoF2DAdh6GROHlPPoIUdsvKhJF/6JcFW2k=;
	b=aTd++6D9o38mTk18m93zayuYTbcvyLjcsrnAOsdtLi94IbMFFtMYJxfQV3xZN2QZ9/IMK8
	EURjpO4Re9HlYXAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736767292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXFLJzWZUqoF2DAdh6GROHlPPoIUdsvKhJF/6JcFW2k=;
	b=yus7zmajfOj+B5T4IjBfHqpYTbxNqFQMlmNnnDDRRWt3hIuEtCRz9LjvYuEBDTO+FKnKea
	0csSEotgUScvcwgZKHZoFo0Ia/5zTXkdn/qSOCzh3e9EH3oJKfvUareC/xizYnhlNnigVV
	ZHTQk0cKdRG3PN71WOdd/e77rP2s71Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736767292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXFLJzWZUqoF2DAdh6GROHlPPoIUdsvKhJF/6JcFW2k=;
	b=aTd++6D9o38mTk18m93zayuYTbcvyLjcsrnAOsdtLi94IbMFFtMYJxfQV3xZN2QZ9/IMK8
	EURjpO4Re9HlYXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FE5C13876;
	Mon, 13 Jan 2025 11:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bJ1hFzz3hGcEewAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Jan 2025 11:21:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1BCEBA08E2; Mon, 13 Jan 2025 12:21:32 +0100 (CET)
Date: Mon, 13 Jan 2025 12:21:32 +0100
From: Jan Kara <jack@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] The future of anon_vma
Message-ID: <naulmpfs57zeefk3pw45l5dbzrhlhdrkhqycwta3rr23pt2frw@mmv2ouibojuq>
References: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
 <zh2hu4fzaqrhw5qdbpcspcsvmnczjo7v5q4b65uq7eaz7exanz@ihsk5oa5njfn>
 <29ad6455-cabb-4ae9-b2d6-db1c09c0009a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ad6455-cabb-4ae9-b2d6-db1c09c0009a@lucifer.local>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 09-01-25 12:33:52, Lorenzo Stoakes wrote:
> On Thu, Jan 09, 2025 at 11:21:02AM +0100, Jan Kara wrote:
> > On Wed 08-01-25 22:23:16, Lorenzo Stoakes via Lsf-pc wrote:
> > > A future where we unify anonymous and file-backed memory mappings would be
> > > one in which a reflinks were implemented at a general level rather than, as
> > > they are now, implemented individually within file systems.
> > >
> > > I'd like to discuss how feasible doing so might be, whether this is a sane
> > > line of thought at all, and how a roadmap for working towards the
> > > elimination of anon_vma as it stands might look.
> >
> > As you can imagine this has been discussed in the past and some folks are
> > very interested in saving page cache memory for some heavily reflinked
> > container setups or for various FUSE filesystems. So if someone manages to
> > come up with a feasible design, the usecases are there. I think reading
> > e.g. [1] and comments below it is a good preparation for the session to get
> > some idea what challenges are there :).
> 
> Oh I certainly imagined that it had :) Perhaps you are volunteering to
> assist me from an fs point of view on this Jan? ;)

Sure, I'll be happy to provide you with a FS point of view :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

