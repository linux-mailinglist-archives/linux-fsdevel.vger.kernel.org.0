Return-Path: <linux-fsdevel+bounces-20040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584998CCD4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 09:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6E428338C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E713C9BE;
	Thu, 23 May 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FexJNFJq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J6gcOKPR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FexJNFJq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J6gcOKPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69C171C4;
	Thu, 23 May 2024 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450516; cv=none; b=P44SRQ8fNQ4+94Icub3eeD9BvxhD6ljdobiPIZptbfM+t0aQ+1QjtxNzM50HJkUfNnjssCr8YBxybc60gap2yryymr1yKAtIN8gB4XKx3S4+uEx1tAVu9vN4kNtIwtMPzeGBm/PuoWb2SPeN7vTZgYdOYNF4b2TlGqSOCfMjuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450516; c=relaxed/simple;
	bh=1ESEDKUGAJSo53or4wFviNcnAhIF8l5JuoBQ+/yX2ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyq3IKaaZoFSyL+IH0dzK2BNbE+jHRyERgH0ibElvSqaXJE5uZ2+BETO+8dQWeP/867r5wCMZ+fxRkP164JATXXB2hHhgMgNnTVxFU+ISDi5szXKhACxVXAtS0hhwJ71wt/oLi05NrpmjIMZo/3OxksgFL8yGQNV+rbKMA+2aqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FexJNFJq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J6gcOKPR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FexJNFJq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J6gcOKPR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FCE7222F3;
	Thu, 23 May 2024 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716450513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pr9G5+0mat3rzZGr475+icta2YMTeQ9L0eCdvy0VQ5s=;
	b=FexJNFJqK92hhrBa/CNYjLGEVeSV/eTN+/CoNvwCsOJjf0qIpSgChYK/qcvL4woUgYhsgn
	yZKvcVc7YwijgaWrjLiFbHWYfnKO2i19rZdJPpXn94gFwDWZa2C4KFw+INbSzi0yj0ouHb
	ZngGAod0DwjukOz/7ProHkDMe7x+vzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716450513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pr9G5+0mat3rzZGr475+icta2YMTeQ9L0eCdvy0VQ5s=;
	b=J6gcOKPRfBiFhxvg3yeOHrTCyUwR0nVdIOSPGg9D0VWfK7dAWZup5NXiCgMPUvb4QquvKC
	HJYXdOyb8JmVrODA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716450513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pr9G5+0mat3rzZGr475+icta2YMTeQ9L0eCdvy0VQ5s=;
	b=FexJNFJqK92hhrBa/CNYjLGEVeSV/eTN+/CoNvwCsOJjf0qIpSgChYK/qcvL4woUgYhsgn
	yZKvcVc7YwijgaWrjLiFbHWYfnKO2i19rZdJPpXn94gFwDWZa2C4KFw+INbSzi0yj0ouHb
	ZngGAod0DwjukOz/7ProHkDMe7x+vzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716450513;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pr9G5+0mat3rzZGr475+icta2YMTeQ9L0eCdvy0VQ5s=;
	b=J6gcOKPRfBiFhxvg3yeOHrTCyUwR0nVdIOSPGg9D0VWfK7dAWZup5NXiCgMPUvb4QquvKC
	HJYXdOyb8JmVrODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1444C13A6C;
	Thu, 23 May 2024 07:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1vTuBNH0Tmb2EwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 23 May 2024 07:48:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B8221A0770; Thu, 23 May 2024 09:48:28 +0200 (CEST)
Date: Thu, 23 May 2024 09:48:28 +0200
From: Jan Kara <jack@suse.cz>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <20240523074828.7ut55rhhbawsqrn4@quack3>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <20240522100007.zqpa5fxsele5m7wo@quack3>
 <snhvkg3lm2lbdgswfzyjzmlmtcwcb725madazkdx4kd6ofqmw6@hiunsuigmq6f>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <snhvkg3lm2lbdgswfzyjzmlmtcwcb725madazkdx4kd6ofqmw6@hiunsuigmq6f>
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
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hi!

On Wed 22-05-24 12:45:09, Andrey Albershteyn wrote:
> On 2024-05-22 12:00:07, Jan Kara wrote:
> > Hello!
> > 
> > On Mon 20-05-24 18:46:21, Andrey Albershteyn wrote:
> > > XFS has project quotas which could be attached to a directory. All
> > > new inodes in these directories inherit project ID set on parent
> > > directory.
> > > 
> > > The project is created from userspace by opening and calling
> > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > files such as FIFO, SOCK, BLK etc. as opening them returns a special
> > > inode from VFS. Therefore, some inodes are left with empty project
> > > ID. Those inodes then are not shown in the quota accounting but
> > > still exist in the directory.
> > > 
> > > This patch adds two new ioctls which allows userspace, such as
> > > xfs_quota, to set project ID on special files by using parent
> > > directory to open FS inode. This will let xfs_quota set ID on all
> > > inodes and also reset it when project is removed. Also, as
> > > vfs_fileattr_set() is now will called on special files too, let's
> > > forbid any other attributes except projid and nextents (symlink can
> > > have one).
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > I'd like to understand one thing. Is it practically useful to set project
> > IDs for special inodes? There is no significant disk space usage associated
> > with them so wrt quotas we are speaking only about the inode itself. So is
> > the concern that user could escape inode project quota accounting and
> > perform some DoS? Or why do we bother with two new somewhat hairy ioctls
> > for something that seems as a small corner case to me?
> 
> So there's few things:
> - Quota accounting is missing only some special files. Special files
>   created after quota project is setup inherit ID from the project
>   directory.
> - For special files created after the project is setup there's no
>   way to make them project-less. Therefore, creating a new project
>   over those will fail due to project ID miss match.
> - It wasn't possible to hardlink/rename project-less special files
>   inside a project due to ID miss match. The linking is fixed, and
>   renaming is worked around in first patch.
> 
> The initial report I got was about second and last point, an
> application was failing to create a new project after "restart" and
> wasn't able to link special files created beforehand.

I see. OK, but wouldn't it then be an easier fix to make sure we *never*
inherit project id for special inodes? And make sure inodes with unset
project ID don't fail to be linked, renamed, etc...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

