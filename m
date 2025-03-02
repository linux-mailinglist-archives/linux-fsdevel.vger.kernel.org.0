Return-Path: <linux-fsdevel+bounces-42903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD1EA4B2D1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 17:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A867A2134
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD171E9907;
	Sun,  2 Mar 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgY2CDND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66111E3761
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931564; cv=none; b=VHK+k1hZPi8EsDzM9LohdPv27Uf/RHX37dxJeO475rPPSRpYsEEptwiaG0TZsq/LPGN1u8HLQFk6RmFOHlNzr63ME7GpSYNts23qUWEfcs2DLB0dEYyz3LlFFxQCVV5TLuRs2czgUeHHpvoKU2ee/tA6lBnKAMjdZzZ1lYIGal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931564; c=relaxed/simple;
	bh=vW25H8q/g+47njXFgyGIStmkQcQkl7l5U0wENlQpzb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oj/iY1PLBPGuuiEYuenLczSxmp3JSBV9sUs/8pfNJbEMIU8Zb9RL4iAl/ku6hQczx97Cu4vDf05onWHbkmRVOfcTlzB3E8JYtRiZG32sC1g8QG292MnfxUIvxlsqz82aerL12YePB22NpQgbDDjLnOOMy4SlU6SjJeHZt/QsKrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgY2CDND; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740931560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjadVx1NL/uJRqGxjQNBpscASrbD3qVH3RwfEeewO4Y=;
	b=AgY2CDNDadwlxFPH15b2lv/kg3G4cLSk70QhrCllMe56naPhHN1dqpdkePZe1NUzH4faxE
	t4obZ3gzGdl+hSBZFm6HwSfr16YTGfmIalE7MjrQcIw6ETZS1spwM9DXsV1d+6ZlmxrjCD
	xICUs+ZsCp4VtVQrS9MpA1soqp2YIcI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-rfhv6jPYM7mnwNmE2BbQGg-1; Sun,
 02 Mar 2025 11:05:59 -0500
X-MC-Unique: rfhv6jPYM7mnwNmE2BbQGg-1
X-Mimecast-MFC-AGG-ID: rfhv6jPYM7mnwNmE2BbQGg_1740931557
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76B1A1800360;
	Sun,  2 Mar 2025 16:05:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C787B1800352;
	Sun,  2 Mar 2025 16:05:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  2 Mar 2025 17:05:27 +0100 (CET)
Date: Sun, 2 Mar 2025 17:05:23 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 03/10] pidfs: move setting flags into
 pidfs_alloc_file()
Message-ID: <20250302160522.GE2664@redhat.com>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-3-5bd7e6bb428e@kernel.org>
 <20250302130936.GB2664@redhat.com>
 <20250302-erbsen-leihen-e30d8feff54e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302-erbsen-leihen-e30d8feff54e@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/02, Christian Brauner wrote:
>
> On Sun, Mar 02, 2025 at 02:09:36PM +0100, Oleg Nesterov wrote:
> > On 02/28, Christian Brauner wrote:
> > >
> > > @@ -696,6 +696,10 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
> > >  		return ERR_PTR(ret);
> > >
> > >  	pidfd_file = dentry_open(&path, flags, current_cred());
> > > +	/* Raise PIDFD_THREAD explicitly as dentry_open() strips it. */
> >                                             ^^^^^^^^^^^^^^^^^^^^^^^
> > Hmm, does it?
> >
> > dentry_open(flags) just passes "flags" to alloc_empty_file()->init_file(),
> > and init_file(flags) does
> >
> > 	f->f_flags      = flags;
> >
>
> dentry_open()
> -> do_dentry_open()
>    {
>            f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);

Ah, indeed, thanks ;) so perhaps you can update the comment,
s/dentry_open/do_dentry_open/ to make it more clear?

Oleg.


