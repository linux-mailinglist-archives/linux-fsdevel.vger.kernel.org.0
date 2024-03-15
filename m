Return-Path: <linux-fsdevel+bounces-14433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA7787CAC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 10:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C6E1F21A27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 09:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F050F17C6C;
	Fri, 15 Mar 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQuit0ju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CFA17C67
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710495340; cv=none; b=LmOjUozHB7I90mlIwewGxrlCDB4MrV/SO7P6FP4fZ8+dIpa4hhIYlCIEkVV6N8lMDPcOzDvbzRH7GL0Y+tUmULOVUPVePqlyhvtZyTXbFTe7cxneRryOgUsTMGB5pgguQoRP5k1IC3SrzvEOfdeJ8iHsNJpejYAj0Zp4+/3M60c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710495340; c=relaxed/simple;
	bh=2yAE5iV1MSSTh1feLI8XyJKlFo7iOZ+pIPnLE4Jf16M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maxnX9e2xzKScf75G1PiB1SfJxKrV6IvEUlYsmksk3cLlswtwRd77vYZ/EJuwu0aYW0iHeARI8Kqh2iIVRN4ITEiHNBxW4LnLBqSpQytngNah4jcb2vHQ7dDmEWr8g1qXXt3KGNRHjz7vMSF/ZLGF2iIjdALSDxfc/xLSJ5fAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQuit0ju; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710495337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iA147xZGlBwqF7Q86Jc3Wh+c7m/V0s46+JVOCVxwzLk=;
	b=VQuit0juDu8NFSQFKWurc5RsyU9ZGvu5oF3SVBML9Y+MsInt76dZamw5IjZA3GSOnsc07K
	qODT3fWRE/rF/7WdxUy2jX2Zhg+VdpG0Eh3lr6WHi7y6depNcHjKdKWc549uZa+WXx1qGD
	R3NEz8IJZIquvuLTJ8oJhbNiXFROIsM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-ifVu-lcyP6e4JCuFke454A-1; Fri, 15 Mar 2024 05:35:35 -0400
X-MC-Unique: ifVu-lcyP6e4JCuFke454A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d51bb9353so832072f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 02:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710495334; x=1711100134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA147xZGlBwqF7Q86Jc3Wh+c7m/V0s46+JVOCVxwzLk=;
        b=bQBDnKGFSjmV/VqQRozbr6N/TEA3xNSYmhJTD0+6acqWx2LTb+sBrMw3K99Y6tTiyE
         kwG79cRt3Gmrgl9ITT+s2tiCNNJQJZhVBHkpEjsvq7q/wQwbfXR12CPcIaNDNYQlbp7P
         8KW7ASuhJd59uW1iTL7wv7wG5FeUGXpaT5nRMrTd2gEr4LLrCgEBHnuS2EIWNM+G5qVE
         s93eu4LblcVz9L4MEZXS5TxmL6M1XRh05kTIRdq1wGuDFTW/CFuOdeyPAjr9PP9V+CWR
         J2ToRBVFntQ+gxf4yuoWoTtL/Hm7X52SsdmXpC+VPaj+wYb1UB8Yih6UBsNI5rRCGpHm
         M6FA==
X-Forwarded-Encrypted: i=1; AJvYcCXVY3Lp0eF2NBUyxLe4E6FoEzV5pCS7Sb6+ZujbzRKwic/6+8EKyZAv8A/Z+kLg8ZSaOj0Hnjp604YF8uDtcPvaWNMp2XH+yTO6KyS5DQ==
X-Gm-Message-State: AOJu0Yxf1zdULSU9PovGxEsRLNvFZfMeZHuaF7j759bOxXJXM7saQjMb
	i5ADlqmqyqFLn7Qpa+GhpCFOnG7mR/lTX1Hq5Ak0SAO8eGJ1B6vb+4NDar4tLJtDuHpFkxz/Dfw
	f8aIC1L210uLiwE5ohz6wl2ETljW8QnfbItHYTSRF921UHsKpJBA11rcSSXCvhw==
X-Received: by 2002:a5d:6692:0:b0:33d:7e99:babc with SMTP id l18-20020a5d6692000000b0033d7e99babcmr1902767wru.50.1710495334325;
        Fri, 15 Mar 2024 02:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2v6neodCoZA53J2GKmZGMZqBs+vBhsxHf1LBZOrQ08F4prtacHbJQmkKaU7FWwZhauAP9AQ==
X-Received: by 2002:a5d:6692:0:b0:33d:7e99:babc with SMTP id l18-20020a5d6692000000b0033d7e99babcmr1902741wru.50.1710495333637;
        Fri, 15 Mar 2024 02:35:33 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id bt17-20020a056000081100b0033ec8c1c233sm2831824wrb.19.2024.03.15.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:35:33 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:35:32 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: david@fromorbit.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, chandan.babu@oracle.com
Subject: Re: [PATCH v2] xfs: allow cross-linking special files without
 project quota
Message-ID: <ptvityysbpctponllgsenstpymivqhnrqpudeuzvfohzdcvfp7@c5ruilxfzlzb>
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

Yeah, there's already that prj ID = 0 file, so nothing changes
regarding accounting.

> Question: Should we have a XFS_IOC_SETFSXATTRAT where we can pass in
> relative directory paths and actually query/update special files?

Added to xfs_quota to not skip them? It would probably solve the
issue, but for existing filesystems with projects this will require
to go through all of special files

> 
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

-- 
- Andrey


