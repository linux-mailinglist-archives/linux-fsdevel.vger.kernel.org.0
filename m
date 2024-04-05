Return-Path: <linux-fsdevel+bounces-16244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18EA89A71C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 00:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C3E2831C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 22:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2A0174EF1;
	Fri,  5 Apr 2024 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ua+YxjjZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3219174ECA
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712355739; cv=none; b=CPhyK46jD4DmvUgEqn7mXqcvQm7sUbk3Zyib7ihSuSMD1Zj4MpvVPtsISQXQLBo53LkOJ/eYfPadavcztkygrrGyZwR9wzNCSBgfMo/tVe1No9TwlaDEitzEAIK3q7rXghB9NfIV6KTeZTUthC9n0N83CJ2nHA7qdI4rWDqM0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712355739; c=relaxed/simple;
	bh=C3c8/EqeUmfqbwGIriYMFtJaO0XaFVxVfL4OfFTtnCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1FsnzE2tu4JcNQ1lDI2y05gaGgxseXsBlQ/kqyJINnTZ7sBk1+Ungjx6vzAiAyxPVCFBYyorVxHqVFqlKyBZTV04QPJwPxkHM8EkZegc7YxyYy5y8W51pAUawtb0j1FNp43SAH9QpqqJ/GRUaHzZYFGfUcKnzyA0qpd+NX/3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ua+YxjjZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712355736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=flb3Hgo6KKlOvZKW6EtqxNKNXHh6F2bGM0rHWpVw7DU=;
	b=Ua+YxjjZZ/Wpqr+ijueG+NLKKXGbyNXJnOYETs1mDY3r0eN2IsFl4lU74mKys6G4HLGXf8
	R6EPwNxw9d3hhnzZ8FNAgciBvCcKqibd6/iCIsmjlF1dDeh5UKsOnnwQKpJhO9hHH+cQZp
	8tPnCpzHfSD9luKon32lrduRXCrRq94=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-BdNA0E1MM0aS11Xuo-8vUQ-1; Fri, 05 Apr 2024 18:22:15 -0400
X-MC-Unique: BdNA0E1MM0aS11Xuo-8vUQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56865619070so1169461a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 15:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712355734; x=1712960534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flb3Hgo6KKlOvZKW6EtqxNKNXHh6F2bGM0rHWpVw7DU=;
        b=Io/gPZ8rUjInl1Rq3hx/v0Lzjwsj8X35P/cl6KftVY7v5unX9H54OAgIYLh9TTy5Sh
         7tt+i2hWySiko1txgpB0UOeZ/VtVp+y3pJBjcrjyTPdo71dNtNVlmeHjkJfcyOJCm/p/
         vJnNyJSNcv15sHqnybqxu6pzKljLaCHRPCvH/jd3VifY5cw5FQOryHZnu4hvsqsRnJU1
         4i/swc0+gPaZLsPvyqcgc/uV8dHKNgh+29O/lUtHt9Nb1rUN0IuVKpQyy15WZ2etYKKf
         edKWimDOQJIZOJ3AdP4g7sjq2wD2kayPGyAal+ueYMeeefZnLWXH4D8fqFRIVBUIitqV
         amOg==
X-Forwarded-Encrypted: i=1; AJvYcCWPhIMdpubahr950PTnDWqKWM1C3l40iuaNg49jr7ct9oSOstes9iMUvcHYVjHDGr7qKDDFvaQy6j0Fac3vohbTLr478Y+SIbcPp7zn9g==
X-Gm-Message-State: AOJu0YyElFyMV8+S24/YYiy78Nres3uMdTTr9j2xICN+7S1oHXmhqP17
	VoPlMr0CuazJCzyny4zKyvqav6YI6HCSiX61ZDggSCEfDlHEAL/HdCH3o0c7HQlW9Zw/PhUCqQC
	mZlxHwpRzLd5qbZcsf84THkAHSI88EWZDJIxAHPvDj1JWcRt68f+i1eoDQBrsGw==
X-Received: by 2002:a50:9fce:0:b0:56b:a077:2eee with SMTP id c72-20020a509fce000000b0056ba0772eeemr1842413edf.4.1712355734056;
        Fri, 05 Apr 2024 15:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCxtMSXOienxC9b8zsqXGQAnGXbeCh9mOE4zI4LHQLZ1567C7uE5CANSZ0EEd9+XkYxChYnA==
X-Received: by 2002:a50:9fce:0:b0:56b:a077:2eee with SMTP id c72-20020a509fce000000b0056ba0772eeemr1842402edf.4.1712355733439;
        Fri, 05 Apr 2024 15:22:13 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7cd09000000b0056c0d96e099sm1198887edw.89.2024.04.05.15.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 15:22:13 -0700 (PDT)
Date: Sat, 6 Apr 2024 00:22:12 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: david@fromorbit.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, chandan.babu@oracle.com
Subject: Re: [PATCH v2] xfs: allow cross-linking special files without
 project quota
Message-ID: <whjaeatubnlc5hrawjmfcksnnth2nse5en4da4bpbfr56lwwrl@53c7v4zlrqrv>
References: <20240314170700.352845-3-aalbersh@redhat.com>
 <20240315024826.GA1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315024826.GA1927156@frogsfrogsfrogs>

On 2024-03-14 19:48:26, Darrick J. Wong wrote:
> On Thu, Mar 14, 2024 at 06:07:02PM +0100, Andrey Albershteyn wrote:
> > There's an issue that if special files is created before quota
> > project is enabled, then it's not possible to link this file. This
> > works fine for normal files. This happens because xfs_quota skips
> > special files (no ioctls to set necessary flags). The check for
> > having the same project ID for source and destination then fails as
> > source file doesn't have any ID.
> > 
> > mkfs.xfs -f /dev/sda
> > mount -o prjquota /dev/sda /mnt/test
> > 
> > mkdir /mnt/test/foo
> > mkfifo /mnt/test/foo/fifo1
> > 
> > xfs_quota -xc "project -sp /mnt/test/foo 9" /mnt/test
> > > Setting up project 9 (path /mnt/test/foo)...
> > > xfs_quota: skipping special file /mnt/test/foo/fifo1
> > > Processed 1 (/etc/projects and cmdline) paths for project 9 with recursion depth infinite (-1).
> > 
> > ln /mnt/test/foo/fifo1 /mnt/test/foo/fifo1_link
> > > ln: failed to create hard link '/mnt/test/testdir/fifo1_link' => '/mnt/test/testdir/fifo1': Invalid cross-device link
> 
> Aha.  So hardlinking special files within a directory subtree that all
> have the same nonzero project quota ID fails if that special file
> happened to have been created before the subtree was assigned that pqid.
> And there's nothing we can do about that, because there's no way to call
> XFS_IOC_SETFSXATTR on a special file because opening those gets you a
> different inode from the special block/fifo/chardev filesystem...
> 
> > mkfifo /mnt/test/foo/fifo2
> > ln /mnt/test/foo/fifo2 /mnt/test/foo/fifo2_link
> > 
> > Fix this by allowing linking of special files to the project quota
> > if special files doesn't have any ID set (ID = 0).
> 
> ...and that's the workaround for this situation.  The project quota
> accounting here will be weird because there will be (more) files in a
> directory subtree than is reported by xfs_quota, but the subtree was
> already messed up in that manner.
> 
> Question: Should we have a XFS_IOC_SETFSXATTRAT where we can pass in
> relative directory paths and actually query/update special files?

After some more thinking/looking into the code this is probably the
only way to make it work the same for special files. Also, I've
noticed that this workaround can be applied to xfs_rename then.

So, I will start with implementing XFS_IOC_SETFSXATTRAT

-- 
- Andrey

> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  fs/xfs/xfs_inode.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 1fd94958aa97..b7be19be0132 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -1240,8 +1240,19 @@ xfs_link(
> >  	 */
> >  	if (unlikely((tdp->i_diflags & XFS_DIFLAG_PROJINHERIT) &&
> >  		     tdp->i_projid != sip->i_projid)) {
> > -		error = -EXDEV;
> > -		goto error_return;
> > +		/*
> > +		 * Project quota setup skips special files which can
> > +		 * leave inodes in a PROJINHERIT directory without a
> > +		 * project ID set. We need to allow links to be made
> > +		 * to these "project-less" inodes because userspace
> > +		 * expects them to succeed after project ID setup,
> > +		 * but everything else should be rejected.
> > +		 */
> > +		if (!special_file(VFS_I(sip)->i_mode) ||
> > +		    sip->i_projid != 0) {
> > +			error = -EXDEV;
> > +			goto error_return;
> > +		}
> >  	}
> >  
> >  	if (!resblks) {
> > -- 
> > 2.42.0
> > 
> > 
> 


