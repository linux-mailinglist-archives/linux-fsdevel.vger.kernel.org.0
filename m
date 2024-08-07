Return-Path: <linux-fsdevel+bounces-25203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E93949C9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 02:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D111F23238
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454E410E6;
	Wed,  7 Aug 2024 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CnTs5MQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42008848E
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722989343; cv=none; b=JfsFA3JF2ZbukCgCxufXDsVGSpCsP8dMU6fFwZPFOwLjFRoHP9NuCYSfrCSQpw4KZJlp7c7pRczA19bXucdcpXT5Fk4C9Lyowg//Namu9X5zfFasa+8g5E/olpsIM6DOIy3Th6Pde7aysAi2LBG1JYsxQO9OalvdMTbSc4bitvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722989343; c=relaxed/simple;
	bh=hT0MeX3lN/+luMv7GRNg6x2rm+Yc+T8HNtTHn+bEfyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCa15CP/NNU61cKE1q0+O9GoiJuiwm8aaXKDVBITI07m+nx3yNoj5Meyoo835z/aCyyH9SKY0nSByoUeTdAw4iz9GsRzJyoazdmnkPRaAogq9ffopCO0Qz5i/Hj1dW0Na8E5VHtB57tgr7hw4MsfjPKt+GIHPBkTL7wzNmW8hyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CnTs5MQZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a0b2924e52so728509a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722989341; x=1723594141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1whsT5ZzX2NUYGE1kmzQNMAQqUazQflf6zBIIjfKBE=;
        b=CnTs5MQZ1fX9+cnh+rHK9jeB7sG4EwL69djebXabX/4WofeQtsFOQrdzXmsd9E8uX2
         CtrlbDgT777HnyOQbsSqMNMVyU8kFKSpsuAC77pCBqnJQbMXmMTBUViLvXgo/WeUZnHK
         Hsg1t0HmslbBhKAb99HIuPd67kci9ah7XJMkc5stuQShSh+HHqQmTSIUxyZ/LiHKOYSO
         lqe0FDtntLG5n+7Mkl5eSs2swyTJrJIUrJ0gPLc0N1RJlGWeFlD7XCpThF1tZeKMwlRI
         a4jYyj+9J5RylDizv2sLd4oskNSfsVOFCrkSFWns5x3tVtNhHRKmf3M97CKRs7CIQLxx
         mWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722989341; x=1723594141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1whsT5ZzX2NUYGE1kmzQNMAQqUazQflf6zBIIjfKBE=;
        b=foTmXd715z9G7y+VufEIwq5VU5Tc5ecT8F1duUH4ovT3V/jgJDvA6MuShdZHZ056fL
         ngGYOfQTUP+yH8QkAsNigqjriN4EJuomsgGJqk0N8IfGkJdzT5QkzmMdY7TAbZI0JM+5
         x1fUqUKT9/QHcmVrxCkr5jYb9+CAWsBvJQM/AWUcK+WzKASF4Og0qPymzAiDTSEA+A6V
         S8gyfbiJncSksa4NprOvysXcm69MhfjCg4QBP7O0lDwFAsJKCNZyaAXliwdWctCtYiZr
         I4ImzIXtu7q6lZnoPiDB3AWP4eKEf5Bha4aSxlnO77Ccxrhq4lAqUyX8bOxRqPVra71H
         c5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXH8G0kAqq0eOWPiiNOGFE6r3sTOYWwDhHCb3V+1ZW4cpj57FKzlSr23eM84QEROGVVv6UP7UJCGQT81jLRuMDtFWt95TNzruBnL5KCHA==
X-Gm-Message-State: AOJu0Ywsvfl1YnFrHKB6tfpujGlYxdGi2c82KC0lphmDABJhqeYQ+h7Z
	Q/AcV/NUubdmOOEm5dN9CbWOWJjUKmbtE9BCXZI0jBOcjL4WhuAMjKSuq7nQTNo=
X-Google-Smtp-Source: AGHT+IFw9vAclRmiZ92meoU01juLqJ0kfWZ8aeYdA0Fzv0l3GA6LwezqSDasXR1t6OKTGWBH1aY4EA==
X-Received: by 2002:a05:6a21:2717:b0:1c6:9fe9:c425 with SMTP id adf61e73a8af0-1c69fe9c522mr12396601637.45.1722989341469;
        Tue, 06 Aug 2024 17:09:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7653b4d99sm6279697a12.84.2024.08.06.17.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 17:09:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sbUEc-007wKo-2q;
	Wed, 07 Aug 2024 10:08:58 +1000
Date: Wed, 7 Aug 2024 10:08:58 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v3 11/14] xfs: Only free full extents for forcealign
Message-ID: <ZrK7GrDSebnXXzF6@dread.disaster.area>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-12-john.g.garry@oracle.com>
 <20240806192738.GN623936@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806192738.GN623936@frogsfrogsfrogs>

On Tue, Aug 06, 2024 at 12:27:38PM -0700, Darrick J. Wong wrote:
> On Thu, Aug 01, 2024 at 04:30:54PM +0000, John Garry wrote:
> > Like we already do for rtvol, only free full extents for forcealign in
> > xfs_free_file_space().
> > 
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> #earlier version
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/xfs/xfs_bmap_util.c |  7 ++-----
> >  fs/xfs/xfs_inode.c     | 14 ++++++++++++++
> >  fs/xfs/xfs_inode.h     |  2 ++
> >  3 files changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> > index 60389ac8bd45..46eebecd7bba 100644
> > --- a/fs/xfs/xfs_bmap_util.c
> > +++ b/fs/xfs/xfs_bmap_util.c
> > @@ -854,11 +854,8 @@ xfs_free_file_space(
> >  	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
> >  	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
> >  
> > -	/* We can only free complete realtime extents. */
> > -	if (xfs_inode_has_bigrtalloc(ip)) {
> > -		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
> > -		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
> > -	}
> > +	/* Free only complete extents. */
> > +	xfs_roundin_to_alloc_fsbsize(ip, &startoffset_fsb, &endoffset_fsb);
> 
> ...and then this becomes:
> 
> 	/* We can only free complete allocation units. */
> 	startoffset_fsb = xfs_inode_roundup_alloc_unit(ip, startoffset_fsb);
> 	endoffset_fsb = xfs_inode_rounddown_alloc_unit(ip, endoffset_fsb);

I much prefer this (roundup/rounddown) to the "in/out" API.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

