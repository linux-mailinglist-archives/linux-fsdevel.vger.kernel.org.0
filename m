Return-Path: <linux-fsdevel+bounces-12646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F6186224D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 03:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A030B1F245B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 02:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93611190;
	Sat, 24 Feb 2024 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZEwnLgT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F70863DF;
	Sat, 24 Feb 2024 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708741454; cv=none; b=kOPnYG601edh0c40CqkELRz3SWAXEJhrihhj5n1qgOLfCTzujCcTQGwnNp/ba7fUoBbPOURPHLd1uy2M7RzOkLnQ1ao+b+C+VxWqgeT6jX8OpREJT5bx1lc2BVCLg3OpS3iLlm//PPrmv0Gf+mF4oSRH5NXjtskv5jgZbSpLlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708741454; c=relaxed/simple;
	bh=96/hYmvsl6lJNB2fS6l4UYShHAt/iwzhUf86OQUpLDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIovhuBy41QozAXD7CmW313fPib9k+MpL+Pb90Jpp2hIVkS6ZdxJwnHWpC+aYglVI/5L8mKswM5IE0nwu3qASTqweHcaKKQBKgW+15AjKCfOwOvQ8nCCM8Q6QK2WZFUoEBjRfZmzQiPffXsP5fhsGuxtwTMN7Z0f2jA4Tw1V6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZEwnLgT; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-21e5fa2f7efso681199fac.0;
        Fri, 23 Feb 2024 18:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708741450; x=1709346250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOuv/zCxApvTn7JI2PSH32UWjQlemun/rMcaip0qb0o=;
        b=eZEwnLgTtZqaxDvM3Qti3LK1ZNRjl90JauSaqjdbo7XNcXMIdimBWgFpO29ZljBZlY
         MLjYOnCgsjXGvq5b0Unmp4lm70CJmBpHwweyioXsWkoss+OfbjcqF406OsA17oadIfyN
         Qjw9VxcVWoa9wqkPfcDw3JggeUynRF18KoqQazVitzVskScUgPX+0lM2D+Lf72t7B6ta
         e36U06+91dmYilIeYw3L5rSCVYWxEoPRvhcOllTIDwjyCZ4levChDXGS8qM3M0MIQbwm
         f/jjUNmo1j+u5ora9LFXdqel6/TjknESypW8g+dcLCAiRLjF5ikS8PQ6Su0BIvgfkgvR
         OcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708741450; x=1709346250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOuv/zCxApvTn7JI2PSH32UWjQlemun/rMcaip0qb0o=;
        b=VHl7gyzEj1TxiFl3RFmE2if0kVZ05GhojlnUdkbpzbmljrqqDfIHYOFv89g/Cu5fbD
         IGiglFQfrTVLAASY5DWg1ESivUqSlIAksMSs5vgcXCz7bGNX5I/HN0+BhmKbxTZRDyLS
         Ji7VcxlIWrEvDderuXXA+tbfy2QK0P19lZTIJNdjfvpyqP6/IsG38q8J0Jq8eEW9WQ8+
         3uJNqskcUpDXWkIynBxfXr09OHGXz1FrytiOmAR4Iebw4HwQ9LDfk26L2doDSR2yIwTo
         Y+51sfzfq6EQ8kly5NPmx2tPa2LeYgBUV3oiN1QsymBTcllXWZs/3DukSwchPIuNfp37
         Y8vw==
X-Forwarded-Encrypted: i=1; AJvYcCVaGVeMyJcyD30X1Dimy1e9iHVmS9XFKZFi/IOoIoBhvUHWNn5q65x2nQXDPuntvvysTmZofPy259hmxsRZ3I7RZzVjSb1+yAeYLbBLAVg19zXIHv1qTLKuovG5aZ5XjpkCHwryHKYZHoGCE3FsZGVsAN1U8kjY14l6TtTHoN5ivztmk8uggYzWCI2MYXcce2R0tdhM7ABd366s//o8zH3yVg==
X-Gm-Message-State: AOJu0Yw3zqWMlqNxS66gXusufJ/ZlsaYJewOkCmJ7ruN5dlV4Pj4Htzw
	ju/BA5sG4CEymAqsykd6ZJG2QMIgd0PEvvwdpPOnb52hFSBXqgy7
X-Google-Smtp-Source: AGHT+IHSwDehYa6qmK5HSq895V5y1nwMHTQrmOJ+xptsqjtflER37IUrDa4cTZzMA3WP0zG9JHmiDA==
X-Received: by 2002:a05:6870:4214:b0:21e:231e:a63 with SMTP id u20-20020a056870421400b0021e231e0a63mr1690531oac.11.1708741447364;
        Fri, 23 Feb 2024 18:24:07 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id gk27-20020a0568703c1b00b0021edaa6e35asm123256oab.21.2024.02.23.18.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 18:24:07 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 23 Feb 2024 20:24:05 -0600
From: John Groves <John@groves.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 20/20] famfs: Add Kconfig and Makefile plumbing
Message-ID: <kujd277lutkvpafgkstyh4opm7bwlbvv2gerwab7rutfwwsuzh@j5zdvx2brz3m>
References: <cover.1708709155.git.john@groves.net>
 <1225d42bc8756c016bb73f8a43095a384b08524a.1708709155.git.john@groves.net>
 <161f53c9-65ba-422d-b08e-2e5d88a208a2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161f53c9-65ba-422d-b08e-2e5d88a208a2@infradead.org>

On 24/02/23 05:50PM, Randy Dunlap wrote:
> Hi,
> 
> On 2/23/24 09:42, John Groves wrote:
> > Add famfs Kconfig and Makefile, and hook into fs/Kconfig and fs/Makefile
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/Kconfig        |  2 ++
> >  fs/Makefile       |  1 +
> >  fs/famfs/Kconfig  | 10 ++++++++++
> >  fs/famfs/Makefile |  5 +++++
> >  4 files changed, 18 insertions(+)
> >  create mode 100644 fs/famfs/Kconfig
> >  create mode 100644 fs/famfs/Makefile
> > 
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 89fdbefd1075..8a11625a54a2 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -141,6 +141,8 @@ source "fs/autofs/Kconfig"
> >  source "fs/fuse/Kconfig"
> >  source "fs/overlayfs/Kconfig"
> >  
> > +source "fs/famfs/Kconfig"
> > +
> >  menu "Caches"
> >  
> >  source "fs/netfs/Kconfig"
> > diff --git a/fs/Makefile b/fs/Makefile
> > index c09016257f05..382c1ea4f4c3 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -130,3 +130,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
> >  obj-$(CONFIG_EROFS_FS)		+= erofs/
> >  obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
> >  obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> > +obj-$(CONFIG_FAMFS)             += famfs/
> > diff --git a/fs/famfs/Kconfig b/fs/famfs/Kconfig
> > new file mode 100644
> > index 000000000000..e450928d8912
> > --- /dev/null
> > +++ b/fs/famfs/Kconfig
> > @@ -0,0 +1,10 @@
> > +
> > +
> > +config FAMFS
> > +       tristate "famfs: shared memory file system"
> > +       depends on DEV_DAX && FS_DAX
> > +       help
> > +         Support for the famfs file system. Famfs is a dax file system that
> > +	 can support scale-out shared access to fabric-attached memory
> > +	 (e.g. CXL shared memory). Famfs is not a general purpose file system;
> > +	 it is an enabler for data sets in shared memory.
> 
> Please use one tab + 2 spaces to indent help text (below the "help" keyword)
> as documented in Documentation/process/coding-style.rst.

Will do, thank you!

John


