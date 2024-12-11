Return-Path: <linux-fsdevel+bounces-37108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDA59EDA36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 23:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2BC280A0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA7E20E706;
	Wed, 11 Dec 2024 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="j/ejm0YH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47AA1F4E39
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956418; cv=none; b=okI89EKuju0rJvO9UM2NogDzQO5BZqzRaLxdB4/XrV/1bjI0NZQdSStwW+6WdXN4n8Pq6288sHF9R9ly1oZigHASH1lEPr7Rx7jxpy32Oica7HDQDApIcNELEA9IebirlJndBiZU53jflsxJu0csa4RRiCZEayLmpFh+wQXYdRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956418; c=relaxed/simple;
	bh=VOGzIGGSxqcC7jyFVRhHAo+5MH48iBCMJkB64VO7HdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL7HGY6g5U7ee4DptESI8qp9VlcIoSkgB6aik/WQkoUZIe3Djy6q8bldx4UXIalo9eErHJH5kzh80tLi+MNvBPiuUjU+QYLqyIiA/YSO6XPNwhgANz+VhUv9eha2DSSFJ+DLVja55p0RBcaGQ4m9Cy26FwOj1D5WC+9QQp6L33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=j/ejm0YH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2efa856e4a4so2870627a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 14:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733956414; x=1734561214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngWPL7F+k5wxiISlgKbwW4fjhxxXTEP4BljwhbzST3s=;
        b=j/ejm0YH6vC3JTn6aSaULZwKVb89iCsaOgno1knpGPttaxzaexerLkwhwtTgTAYe3i
         6Q2kT/jo7vdHRRcLmk+qxinVMGJWI/wgVjkal81UtOU3esAlKVxiJ12O1QhU1uWvvI8X
         ZSxrcig/cUDx+ROYR1l0ciOET5DvuSjfDeuONsH1i0wqXUmYDuhm/KUq3Uh5iBa/a/rC
         Up0NzYZQezfMvegZ6nMR4LICpIUHTEBLpt6+bS47f98Ush3v5BkEHaPPlZSMSOOExoo5
         8dnh69STWKdciRv4FW8E2707xhq9LVyjTJLasZ7EUpFsj0J6eGhtGRoKO2RIsoebYdg/
         NMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956414; x=1734561214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngWPL7F+k5wxiISlgKbwW4fjhxxXTEP4BljwhbzST3s=;
        b=i6y7PO50/IgceSyqCDSgphEWsH3TTXrNW1tR4D7FuUqt2oKTgFY0AdhG3YOUKF+qjj
         W0ZOmQfSrA8L3PQmjtqiOKEQSLNlBoySDoYPZ15DNiZL9m7GKMhVMdxvLtHvYnFscfEe
         HtWREgXCnFt+IglAag4Qyqx5eXDGU+5etPKBsgNltMlbTdiVpcYe0eQIXC3GCDXRet+x
         lxk7og9xLwZPas5uUv5g+HphdCG7gM5LldzdLQQcJi23IWGwtSM3zIu2dL/ykY2OCNev
         eVUbdHdu8rYAygCE33Y6I/mX/kmdL1uUXsUa64HggsG+ivECAfs854DJ26fKwbgxNzpO
         CLLw==
X-Forwarded-Encrypted: i=1; AJvYcCXUfgW1xuEb6Y6ApU0xGhW0qB1gH0CU2ybbm7elgM9qdiPwt/AB4e3IiHIssZB7OzfGhS+KCYhVn1Ql8KI9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyikypde2ze8ssFgH3zwrvq4bsz/3da+hCzVh4S36G3NtB7JIKC
	C/isxwAVBPuadSeRZDZujSVHJjB3kxEaCiRkt9UqDWEb8gyKRW2maK/wNoJAsDg=
X-Gm-Gg: ASbGncuyalFOFagtgcn5n6a1foGuRinA0R1DhFtLZH69h2/oUA8K7NWhjVgd+/lo2us
	NOMsvUkTIDJZcnzb8Y3QxfGvOGKiPgoBae41dX5bx0jtuWVsceMT6TkAwvvtmdfKMNJ15VRYrNH
	uXRsNRHWOLshdLE8I62prNyqBWj8CeEUHDlOZMGnoo2N130C6Wfuf/TV1BTni8pnGCfqVZkTN8H
	PGumTGaaZfNfHIBolQMbXDD/e3sDyipVJ0sUkxVDGeszB5mUPd0RPC7lYjIbmd/LLixks7i6Dyw
	EvrRTQee4wHvnGJPnbHNqWKI24c=
X-Google-Smtp-Source: AGHT+IEVKuZamiHIkIRgt4sKWSN/CxUsh7q1Rtn5YMJ8loDhLinrZmWvhpreTWA49/k9SjEkFUp/vQ==
X-Received: by 2002:a17:90b:358b:b0:2ee:c457:bf83 with SMTP id 98e67ed59e1d1-2f1392b7518mr2309164a91.19.1733956413993;
        Wed, 11 Dec 2024 14:33:33 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45ff77b9sm12072842a91.36.2024.12.11.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:33:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLVGr-00000009ZKP-40OP;
	Thu, 12 Dec 2024 09:33:29 +1100
Date: Thu, 12 Dec 2024 09:33:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/3] xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR
 details
Message-ID: <Z1oTOUCui9vTgNoM@dread.disaster.area>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>
 <20241211181706.GB6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211181706.GB6678@frogsfrogsfrogs>

On Wed, Dec 11, 2024 at 10:17:06AM -0800, Darrick J. Wong wrote:
> On Wed, Dec 11, 2024 at 01:24:03PM +0530, Ojaswin Mujoo wrote:
> > Currently with stat we only show FS_IOC_FSGETXATTR details
> > if the filesystem is XFS. With extsize support also coming
> > to ext4 make sure to show these details when -c "stat" or "statx"
> > is used.
> > 
> > No functional changes for filesystems other than ext4.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  io/stat.c | 38 +++++++++++++++++++++-----------------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> > 
> > diff --git a/io/stat.c b/io/stat.c
> > index 326f2822e276..d06c2186cde4 100644
> > --- a/io/stat.c
> > +++ b/io/stat.c
> > @@ -97,14 +97,14 @@ print_file_info(void)
> >  		file->flags & IO_TMPFILE ? _(",tmpfile") : "");
> >  }
> >  
> > -static void
> > -print_xfs_info(int verbose)
> > +static void print_extended_info(int verbose)
> >  {
> > -	struct dioattr	dio;
> > -	struct fsxattr	fsx, fsxa;
> > +	struct dioattr dio;
> > +	struct fsxattr fsx, fsxa;
> > +	bool is_xfs_fd = platform_test_xfs_fd(file->fd);
> >  
> > -	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > -	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> > +	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > +		(is_xfs_fd && (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa) < 0))) {
> 
> Urgh... perhaps we should call FS_IOC_FSGETXATTR and if it returns zero
> print whatever is returned, no matter what filesystem we think is
> feeding us information?

Yes, please. FS_IOC_FSGETXATTR has been generic functionality for
some time, we should treat it the same way for all filesystems.

> e.g.
> 
> 	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> 		if (is_xfs_fd || (errno != EOPNOTSUPP &&
> 				  errno != ENOTTY))
> 			perror("FS_IOC_GETXATTR");

Why do we even need "is_xfs_fd" there? XFS will never give a
EOPNOTSUPP or ENOTTY error to this or the FS_IOC_GETXATTRA ioctl...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

