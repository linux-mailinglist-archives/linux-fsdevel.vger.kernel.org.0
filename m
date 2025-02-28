Return-Path: <linux-fsdevel+bounces-42825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDDEA490CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 06:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1DA18934CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 05:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C1E1BD9CB;
	Fri, 28 Feb 2025 05:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4iUnYK6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12951BD032
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719772; cv=none; b=CaudLhWlg5GCdAKeaE7fq0OOeUtIR3+G9Mi+3628/E4UX0l6uLi2iXBWEW3eCx6n+5rmrK4sGq1HbHREN587gaZFKVJTvkOpVrqLiUHB2juwZBFBsHt7sVobNcsM8CwvvHjk3qTiss2Tp2vh797404+UR8r0Tb+LEL9fuADA4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719772; c=relaxed/simple;
	bh=9RHCAVjbSah0eLyeNIRmDl4xZOn4+H698q/9Q1qExM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUJyCLpRWAzExfY9cvh/uiA3BXhKsYvvl4tqzWegDmo3TiSutmiNIVIrNT+ODqrORQnlowHpUwKZI/xd9jSzjWxcE8HcFoBApNVczrZV4ZwM51r07eCupWLA5BOHbbNWNWbkS40LkQZBh9QhYC3Bd4Y+nTObysJrGXpqskrgGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4iUnYK6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740719769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EKWrHZVTVzm9PUjY3c5QWmYsJDZRT6mYApiTs0Udq2A=;
	b=A4iUnYK6RZmOd0B7cESIHUC6k8JLVm1t2qImFCBwwyWHvuJxWppbjk3EjrXAtdmBXoyvIy
	NOB3BqZ7VlHrIEkjXH8slhSIONNCQJikKoCGy5LM73A/MQUu4CcPQyGX8ZcqIkhZuwZcL9
	FB6YVRfb88cDN0OdfnRxwJVf99Eh06M=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-4wdonZYNO32zNcC9B67slQ-1; Fri, 28 Feb 2025 00:16:06 -0500
X-MC-Unique: 4wdonZYNO32zNcC9B67slQ-1
X-Mimecast-MFC-AGG-ID: 4wdonZYNO32zNcC9B67slQ_1740719766
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f6cb3097bso48528945ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 21:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740719765; x=1741324565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKWrHZVTVzm9PUjY3c5QWmYsJDZRT6mYApiTs0Udq2A=;
        b=DhlyOsUAqE2F/fq9FwCV49Z04Y4tKx3lRR6xZggRtLBMVGiqP3VBIUrn0UaimVW88r
         Gcjnk3nK7Rdav+iCozpIHNgy/ySY5tklej9EWhG1mPWvCD+6g9OVySRZwwnfkh/yer75
         Mpgi8sPqe4Wj25IcVsYvoJoeNRM15idmjnYVFNSVV9Qa3LGI+FeiWVvXo1hdwtVBM/Dm
         yU1735wQyeIiy0pFxTl7sEaQ7wS2Ag2pjbSq26oyFgXMa9s9WpE96rNhjQEyerAdqxEq
         Man4XcYVkmkpPDmnlCRlirycOxioj3EwFtsE2a5yOHUvodq76I41/4HLqrch2p9bNkH+
         0/zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPx0PTypqibegGfZmVltlFxCJkHmZzkvUvL2y+KmB6yCjyzUkotiPtknHKIkOv0LpshPKAXYxJb4NLBE6A@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYy2MCXtyUpLArlpjo5bk9sEbbxmxwzuOfVp2Vva+DrlLJFUZ
	sX2XP7UIuQEO9pSuLsHWAd109IvvoC2MLoDGTqk3Gfz50ejdkNGTxOnceEAmEtOi6CeNS+XxI1S
	nIzbBwfWZuPMdEPIoB2oJhVayoHbJSUjxyduceScnr+QhBvQ3wgTogBfUBFMGaGuzMtSuDHVi2w
	==
X-Gm-Gg: ASbGncs88iCSkJJHjE0V4eZrUrSDo1JSw4aP6GnVRx2QMzIh7nrUBFkV4Ys3/uYlSCF
	eNPtVncjo0CJIQhzjxsplKF8rhm9AKSZybmCbCQPQcc616EWUihmLad7dfW2mO+9KiDvtViO856
	Uqsen13l17dwXe3CDZDdKft4V1Nmp9a1gB19qxAzwzR3jUpydB7j1yDjl5ahhgKOBYQLsNU5478
	vkgecSve7a/LzSt3rvngCZ87jwSXZ5JRTRPsE/7yckNrYg/rc/KxFstCHTfhYwwtT1tFjy1WVIJ
	G5OHtWYyvN/aomiZOH+Cf8J2HVAX+nWDp2aD26B94CMVmubPxOmWWowQ
X-Received: by 2002:a17:902:e78d:b0:223:6455:8752 with SMTP id d9443c01a7336-2236925924dmr27569645ad.43.1740719765220;
        Thu, 27 Feb 2025 21:16:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJlCY9RjzFerx/NGlKWRYbNvMhP45eT0kCPCYBs7BYEbmBdh1ijbexx8BV/zE3TMS5RL/h8w==
X-Received: by 2002:a17:902:e78d:b0:223:6455:8752 with SMTP id d9443c01a7336-2236925924dmr27569255ad.43.1740719764693;
        Thu, 27 Feb 2025 21:16:04 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734b18cfb66sm590022b3a.116.2025.02.27.21.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 21:16:04 -0800 (PST)
Date: Fri, 28 Feb 2025 13:16:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] README: add supported fs list
Message-ID: <20250228051600.b44dmfimqqbrom22@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250227200514.4085734-1-zlang@kernel.org>
 <20250228022045.GA6229@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228022045.GA6229@frogsfrogsfrogs>

On Thu, Feb 27, 2025 at 06:20:45PM -0800, Darrick J. Wong wrote:
> On Fri, Feb 28, 2025 at 04:05:14AM +0800, Zorro Lang wrote:
> > To clarify the supported filesystems by fstests, add a fs list to
> > README file.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> > 
> > Hi,
> > 
> > David Sterba suggests to have a supported fs list in fstests:
> > 
> > https://lore.kernel.org/fstests/20250227073535.7gt7mj5gunp67axr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#m742e4f1f6668d39c1a48450e7176a366e0a2f6f9
> > 
> > I think that's a good suggestion, so I send this patch now. But tell the truth,
> > it's hard to find all filesystems which are supported by fstests. Especially
> > some filesystems might use fstests, but never be metioned in fstests code.
> > So please review this patch or send another patch to tell fstests@ list, if
> > you know any other filesystem is suppported.
> > 
> > And if anyone has review point about the support "level" and "comment" part,
> > please feel free to tell me :)
> > 
> > Thanks,
> > Zorro
> > 
> >  README | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> > 
> > diff --git a/README b/README
> > index 024d39531..055935917 100644
> > --- a/README
> > +++ b/README
> > @@ -1,3 +1,85 @@
> > +_______________________
> > +SUPPORTED FS LIST
> > +_______________________
> > +
> > +History
> > +-------
> > +
> > +Firstly, xfstests is the old name of this project, due to it was originally
> > +developed for testing the XFS file system on the SGI's Irix operating system.
> > +With xfs was ported to Linux, so was xfstests, now it only supports Linux.
> 
>    When
> 
> > +
> > +As xfstests has some test cases are good to run on some other filesystems,
> 
>                    many test cases that can be run

Sure, will change these.

> 
> > +we call them "generic" (and "shared", but it has been removed) cases, you
> > +can find them in tests/generic/ directory. Then more and more filesystems
> > +started to use xfstests, and contribute patches. Today xfstests is used
> > +as a file system regression test suite for lots of Linux's major file systems.
> > +So it's not "xfs"tests only, we tend to call it "fstests" now.
> > +
> > +Supported fs
> > +------------
> > +
> > +Firstly, there's not hard restriction about which filesystem can use fstests.
> > +Any filesystem can give fstests a try.
> > +
> > +Although fstests supports many filesystems, they have different support level
> > +by fstests. So mark it with 4 levels as below:
> > +
> > +L1: Fstests can be run on the specified fs basically.
> > +L2: Rare support from the specified fs list to fix some generic test failures.
> > +L3: Normal support from the specified fs list, has some own cases.
> > +L4: Active support from the fs list, has lots of own cases.
> > +
> > ++------------+-------+---------------------------------------------------------+
> > +| Filesystem | Level |                       Comment                           |
> > ++------------+-------+---------------------------------------------------------+
> > +| AFS        |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Bcachefs   |  L1+  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Btrfs      |  L4   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Ceph       |  L2   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
> > ++------------+-------+---------------------------------------------------------+
> > +| Ext2/3/4   |  L3+  | N/A                                                     |
> 
> What do the plus and minus mean?

Oh, I didn't explain them.

("+" means a slightly higher than the current level, but not reach to the next.
 "-" is opposite, means a little bit lower than the current level.)

Is that good to you?

> 
> > ++------------+-------+---------------------------------------------------------+
> > +| Exfat      |  L1+  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| f2fs       |  L3-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| FUSE       |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| GFS2       |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Glusterfs  |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| JFS        |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
> > ++------------+-------+---------------------------------------------------------+
> > +| ocfs2      |  L2-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| overlay    |  L3   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| pvfs2      |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Reiser4    |  L1   | Reiserfs has been removed, only left reiser4            |
> > ++------------+-------+---------------------------------------------------------+
> > +| tmpfs      |  L3-  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| ubifs      |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| udf        |  L1+  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| Virtiofs   |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| XFS        |  L4+  | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> > +| 9p         |  L1   | N/A                                                     |
> > ++------------+-------+---------------------------------------------------------+
> 
> This roughly tracks with my observations over the years.

Some filesystems I never tried, likes "9p" and "ubifs" etc, I just found these names
from common/rc.

If any fs list has any supplement to the fs name or the "comment", or would like to
modify the "level", please feel free to tell me.

Thanks,
Zorro



> 
> --D
> 
> > +
> >  _______________________
> >  BUILDING THE FSQA SUITE
> >  _______________________
> > -- 
> > 2.47.1
> > 
> > 
> 


