Return-Path: <linux-fsdevel+bounces-37232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD79EFD93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB7E288494
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 20:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8661ABEB1;
	Thu, 12 Dec 2024 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="fISalG7f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E41422D4
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036247; cv=none; b=T/o72G3DH9UKQeAIarJWV/LE/h+9AfqpCBU5LbovoGQ5avzVA7BF+ZmqcriRP+80S18cyrFO5HQraTCDFsEw8gCtL3t0+dVUWLDBdmJ8oNp5wYZ/lbmvKHDxg6I/ZLJEE+LKX3aA80nJ4Cj74P8qZJIvRsE7anwPnLg99gQyGgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036247; c=relaxed/simple;
	bh=z7dvnp1wJwcgR0OOhWAnXX3y6XFU/RaQbm+Wh5D5GIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7ZyQyFsLy7y7kZ6zg2jNB65cr4SI7ICBk3HnIiWbPnJmNYIO+ZdOpLxHdVO7h4zBDEmMlxZnA4+Z2Px0Wl//DHAGmZW4pD5nCmW3pcXf1bBx5Kp/zPWMkqtqheazZlQD4+k41pkVIPimWmuiVs26hwSXZ8p8cVgnXMJPofas0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=fISalG7f; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21680814d42so9617915ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 12:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1734036245; x=1734641045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gY9QpSeXkRgHpm7Ku8b4o1XavyERhHEQqI9K8o9LNoI=;
        b=fISalG7fFANAr5rVUIbasREP6o7UE4XM7eAJbEGWcnRRR4R2IIsObu/t3TNL9a2Dnn
         SaKXJdhkQI0V0J5LsKzl9yMSFXs6pDTy+pKoV0SjPUkOgS7JcWFVNeaI5I8i33Ff6NVx
         +TQQCvwKyQz6O3A9imOCo1wshh+jOWFTa62apsZ/LO/BIbxBRY5yJWiiVesq1Sa+rjYa
         +mH2CJMDmkywPuFr2F0bfseXEq/D69a+//KLdAg1J1wcGcGj8BjAYrBzzqDbRuT+oE/y
         rubgu4DoL0mufdPFMSOkHlQtYjGl2fTRZta8j6IbnLkCwE0d0RNAVtI3lyqtXhuCeNDN
         +CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734036245; x=1734641045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY9QpSeXkRgHpm7Ku8b4o1XavyERhHEQqI9K8o9LNoI=;
        b=KrrIR/bdzcXpv+Hjnr25jayK0NogKIbYyCdWaPJIxjzNnL76eZrDbaSGobHUOn8yZO
         2RmnyaZxp2kb7tEWDqc7ot/jm2D39DyHR04Vu4zoRg7gVXeeFAWaKXFRG1l02YGoPmib
         OGaofOo4O6GTSbBxP3WoGv7PupIgnHrvroF2LwF53I8QhMPm+6azAdzxA3dtnkLdkge8
         gfs4QKbxaFuzFO6H5rnr1Na202qTwIk3xEYf1aChigt4aEJNm/5X8pPQWCxggobJ2TuR
         huKH8eKY9N7Y+tWaegQZD/Klj3mLWR8wCkPJcSC2ahJVcqGNPipWH3FDwA8jovRIwhOs
         1fSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt+WfusO2IUnedjVqZPUfF0ZoXJr7PLGBZIM88xVEhbbdaEBDVB6dg/PIf9oGSHkMrSKqvgHAvCvETIXS0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjv33BojSCWM+apNI22aiACSvBVJlV+n/oX6OSdUhT4XV5eR8a
	USHR0usu58DJCEJeriyNn7giDMAU2ydwqUqzC1iM/gZmG6pHJJCFmya/B/EaPno=
X-Gm-Gg: ASbGncun5VVh8RucaPHgGgX6TUhHgEhh6lFsH6cKBivvXdw9VUzdk6bPrT0zmHQxIH3
	SgQ/Wd/n/hEuK8X2d9nKnwxh6rgSlLbXPwXwpQgxz36xD+bnV+44DUKWglop2PJWP6lXixYykK6
	cYh8inFfZjVbt8iLmd2lmBlv6MD5+PrgqsRUG7xaqDBtNR9RY2M4hJvnBafmsIXFHo8YtDcYSG5
	nfPhf6lrROVVOhL1pKQEnmfJP/ZXK8F8HX5D/gYtm1DfntBE+HbwsRf8gkev5cvsPqKtS4tURqs
	r3ukYWmKclhX+pWfuZPJrhXYOgDypA==
X-Google-Smtp-Source: AGHT+IFikBPMpBDF7pd2lmWNowKlEuQrYWQcmYnDsTJx6agqxEvZabEob6zJiQBYVY3pZ7/94b/Img==
X-Received: by 2002:a17:902:e748:b0:215:577b:ab77 with SMTP id d9443c01a7336-21892a40509mr1511235ad.39.1734036245314;
        Thu, 12 Dec 2024 12:44:05 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21674098324sm50638695ad.52.2024.12.12.12.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:44:04 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLq2T-00000009wiF-3FPn;
	Fri, 13 Dec 2024 07:44:01 +1100
Date: Fri, 13 Dec 2024 07:44:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/3] xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR
 details
Message-ID: <Z1tLEQmRiZc7alBo@dread.disaster.area>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>
 <20241211181706.GB6678@frogsfrogsfrogs>
 <Z1oTOUCui9vTgNoM@dread.disaster.area>
 <20241212161919.GA6657@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212161919.GA6657@frogsfrogsfrogs>

On Thu, Dec 12, 2024 at 08:19:19AM -0800, Darrick J. Wong wrote:
> On Thu, Dec 12, 2024 at 09:33:29AM +1100, Dave Chinner wrote:
> > On Wed, Dec 11, 2024 at 10:17:06AM -0800, Darrick J. Wong wrote:
> > > On Wed, Dec 11, 2024 at 01:24:03PM +0530, Ojaswin Mujoo wrote:
> > > > Currently with stat we only show FS_IOC_FSGETXATTR details
> > > > if the filesystem is XFS. With extsize support also coming
> > > > to ext4 make sure to show these details when -c "stat" or "statx"
> > > > is used.
> > > > 
> > > > No functional changes for filesystems other than ext4.
> > > > 
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > ---
> > > >  io/stat.c | 38 +++++++++++++++++++++-----------------
> > > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/io/stat.c b/io/stat.c
> > > > index 326f2822e276..d06c2186cde4 100644
> > > > --- a/io/stat.c
> > > > +++ b/io/stat.c
> > > > @@ -97,14 +97,14 @@ print_file_info(void)
> > > >  		file->flags & IO_TMPFILE ? _(",tmpfile") : "");
> > > >  }
> > > >  
> > > > -static void
> > > > -print_xfs_info(int verbose)
> > > > +static void print_extended_info(int verbose)
> > > >  {
> > > > -	struct dioattr	dio;
> > > > -	struct fsxattr	fsx, fsxa;
> > > > +	struct dioattr dio;
> > > > +	struct fsxattr fsx, fsxa;
> > > > +	bool is_xfs_fd = platform_test_xfs_fd(file->fd);
> > > >  
> > > > -	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > > > -	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> > > > +	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > > > +		(is_xfs_fd && (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa) < 0))) {
> > > 
> > > Urgh... perhaps we should call FS_IOC_FSGETXATTR and if it returns zero
> > > print whatever is returned, no matter what filesystem we think is
> > > feeding us information?
> > 
> > Yes, please. FS_IOC_FSGETXATTR has been generic functionality for
> > some time, we should treat it the same way for all filesystems.
> > 
> > > e.g.
> > > 
> > > 	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> > > 		if (is_xfs_fd || (errno != EOPNOTSUPP &&
> > > 				  errno != ENOTTY))
> > > 			perror("FS_IOC_GETXATTR");
> > 
> > Why do we even need "is_xfs_fd" there? XFS will never give a
> > EOPNOTSUPP or ENOTTY error to this or the FS_IOC_GETXATTRA ioctl...
> 
> Yeah, in hindsight I don't think it's needed for FS_IOC_FSGETXATTR, but

*nod*

> it's definitely nice for XFS_IOC_FSGETXATTRA (which is not implemented
> outside xfs) so that you don't get unnecessary error messages on ext4.

I don't think we even need it for FS_IOC_GETXATTRA - if the
filesystem does not support that ioctl, we don't print the fields,
nor do we output an error.

After all, this "extended info" and it's only ever been printed
for XFS, so we can define whatever semantics we want for foreign
filesystem output right now. As long as XFS always prints the same
info as it always has (i.e. all of it), we can do whatever we want
with the foreign filesystem stuff.

Keep in mind that we don't need platform tests for XFS files - that
has already been done when the file was opened and the state stored
in file->flags via the IO_FOREIGN flag. We already use that in the
stat_f() to determine whether we print the "xfs info" or not.

IOWs, I think all we need to do is  move where we check the
IO_FOREIGN flag. i.e.:

print_extented_info(file)
{
	struct dioattr  dio = {};
        struct fsxattr  fsx = {}, fsxa = {};

	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
		perror("FS_IOC_GETXATTR");
		exitcode = 1;
		return;
	}

	printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
	printxattr(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
	printf(_("fsxattr.projid = %u\n"), fsx.fsx_projid);
	printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
	printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
	printf(_("fsxattr.nextents = %u\n"), fsx.fsx_nextents);

	/* Only XFS supports FS_IOC_FSGETXATTRA and XFS_IOC_DIOINFO */
	if (file->flags & IO_FOREIGN)
		return;

	if (ioctl(file->fd, FS_IOC_FSGETXATTRA, &fsxa)) < 0) {
		perror("FS_IOC_GETXATTRA");
		exitcode = 1;
		return;
	}
	if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
		perror("XFS_IOC_DIOINFO");
		exitcode = 1;
		return;
	}

	printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
	printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
	printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
	printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
}

Thoughts?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

