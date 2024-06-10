Return-Path: <linux-fsdevel+bounces-21343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41EA90245F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 16:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DFE1C22FA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE513212C;
	Mon, 10 Jun 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YCLw543y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pTZd1H5C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YCLw543y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pTZd1H5C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129D12FF91;
	Mon, 10 Jun 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030664; cv=none; b=DdM6UlC3CmvFIeBBqAyozgNfOaOFWK75gA3U1Ow3K8fD3Gpis9ByB8krpUwnJjHH5G6Wl9UDp3ip+Wu8bdC5H4R8NopUkROexV0BytTgJPd3L8R3GEMUwJBkFaytzBsPdqd6dP0FNDtu5MuRV7HCMTvJbznpGNpk625HxWxhkNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030664; c=relaxed/simple;
	bh=HmQcNucyjY/s/dbUq8IYdq4XnxZxxyLKCjcx/ogY4Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWl7MQCTDcJPLENFN/X9Ptvd2OFB4elvCHSSy2TAT/sJXi1YfwJMk1yCVN/uIRltMTqD1t7RLPYAkQ5OoRdQ7PXUrTR1Dlewow30sZvP4/L/BlPOEDbQM14+tlvfZijfBepMb2jksvw67KDOgGI12neYsCwV1rOjEfJfYqJxiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YCLw543y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pTZd1H5C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YCLw543y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pTZd1H5C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D57EE1F7FA;
	Mon, 10 Jun 2024 14:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718030660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkVtLfh/wttYoUdbcYRzXgGRM2TsttiLJ6cY87G240M=;
	b=YCLw543yiLdGW+LDGl8NpfnP8eEtCVhSv5BvA88B+XxED7AOAY7+ROFc2QZ3cP9PFnRAX/
	CqitCXjsdU+wECE9oSg+G7+WsSIrbwPyT3O49Z1iEXjAXd+dP72vgsCUPPwz2xj0ZUD4Pa
	ngDcNOXq48XOYzFrELglpctDAxtyqkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718030660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkVtLfh/wttYoUdbcYRzXgGRM2TsttiLJ6cY87G240M=;
	b=pTZd1H5C9HIu9EcYOPpA0NZKaKol26BBktDoCewY8b1KgeWJx1zh/H4CJ8l3ZPTIg0Erdt
	2jr964aM6Q1Y0XDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718030660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkVtLfh/wttYoUdbcYRzXgGRM2TsttiLJ6cY87G240M=;
	b=YCLw543yiLdGW+LDGl8NpfnP8eEtCVhSv5BvA88B+XxED7AOAY7+ROFc2QZ3cP9PFnRAX/
	CqitCXjsdU+wECE9oSg+G7+WsSIrbwPyT3O49Z1iEXjAXd+dP72vgsCUPPwz2xj0ZUD4Pa
	ngDcNOXq48XOYzFrELglpctDAxtyqkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718030660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkVtLfh/wttYoUdbcYRzXgGRM2TsttiLJ6cY87G240M=;
	b=pTZd1H5C9HIu9EcYOPpA0NZKaKol26BBktDoCewY8b1KgeWJx1zh/H4CJ8l3ZPTIg0Erdt
	2jr964aM6Q1Y0XDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA48B13A51;
	Mon, 10 Jun 2024 14:44:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +b1cMUQRZ2ZoSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Jun 2024 14:44:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79B28A0880; Mon, 10 Jun 2024 16:44:20 +0200 (CEST)
Date: Mon, 10 Jun 2024 16:44:20 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240610144420.lvc7cbwtit7zbz5u@quack3>
References: <vbiskxttukwzhjoiic6toscqc6b2qekuwumfpzqp5vkxf6l6ia@pby5fjhlobrb>
 <20240603174259.GB52987@frogsfrogsfrogs>
 <20240604085843.q6qtmtitgefioj5m@quack3>
 <20240605003756.GH52987@frogsfrogsfrogs>
 <CAOQ4uxiVVL+9DEn9iJuWRixVNFKJchJHBB8otH8PjuC+j8ii4g@mail.gmail.com>
 <ZmEemh4++vMEwLNg@dread.disaster.area>
 <tnj5nqca7ewg5igfvhwhmjigpg3nxeic4pdqecac3azjsvcdev@plebr5ozlvmb>
 <CAOQ4uxg6qihDRS1c11KUrrANrxJ2XvFUtC2gHY0Bf3TQjS0y4A@mail.gmail.com>
 <kh5z3o4wj2mxx45cx3v2p6osbgn5bd2sdexksmwio5ad5biiru@wglky7rxvj6l>
 <CAOQ4uxgLbXHYxhgtLByDyMcEwFGfg548AmJj7A99kwFkS_qTmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgLbXHYxhgtLByDyMcEwFGfg548AmJj7A99kwFkS_qTmw@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Mon 10-06-24 16:21:39, Amir Goldstein wrote:
> On Mon, Jun 10, 2024 at 2:50 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> >
> > On 2024-06-10 12:19:50, Amir Goldstein wrote:
> > > On Mon, Jun 10, 2024 at 11:17 AM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> > > >
> > > > But those special file's inodes still will not be accounted by the
> > > > quota during initial project setup (xfs_quota will skip them), would
> > > > it worth it adding new syscalls anyway?
> > > >
> > >
> > > Is it worth it to you?
> > >
> > > Adding those new syscalls means adding tests and documentation
> > > and handle all the bugs later.
> > >
> > > If nobody cared about accounting of special files inodes so far,
> > > there is no proof that anyone will care that you put in all this work.
> >
> > I already have patch and some simple man-pages prepared, I'm
> > wondering if this would be useful for any other usecases
> 
> Yes, I personally find it useful.
> I have applications that query the fsx_xflags and would rather
> be able to use O_PATH to query/set those flags, since
> internally in vfs, fileattr_[gs]et() do not really need an open file.

Well, Christian doesn't like [1] how much functionality is actually
available through O_PATH fds because it kind of makes them more and more
similar to normal fds and that's apparently undesirable for some usecases
(for security reasons). So I don't think he'd like to have *another*
functionality accepted for O_PATH fds :) But he can speak for himself...

								Honza

[1] https://lore.kernel.org/all/20240412-labeln-filmabend-42422ec453d7@brauner
[2] https://lore.kernel.org/all/20240430-machbar-jogginganzug-7fd3cff2c3ed@brauner
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

