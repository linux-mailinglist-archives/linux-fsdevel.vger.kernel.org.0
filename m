Return-Path: <linux-fsdevel+bounces-47466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED298A9E5F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 03:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D133B8FA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 01:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA2978F3A;
	Mon, 28 Apr 2025 01:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDe8Jm81"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450A5684;
	Mon, 28 Apr 2025 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745805007; cv=none; b=XQ+1zat4Ab0PypqHpzgykhM8IFhPjrpvLuELei5XAcN5q6V16Aw64B4NNFZdIlQwrM/ibE4856WvOUMX/U3eZJVEcxwygSOI7GdqVXFD2SokAMtF3fQ5Dss6sXn8jfyoeh4fBSwLjIyeTAveKrvUj3aaj6gUS7SEUXwR0tf3WpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745805007; c=relaxed/simple;
	bh=doj6zOgc5VWWmm/qoFnhXtoIVGZlxDYg5PUinPuwuBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElibRTLueDsIigd66oluvtP8IE0kgJJTdRU2mZplj3CG7dwmCw66kNtvnxT5GROcYS9TYg5vAB2x7Gg4xoYJG6R7jFAtpLKHfKeb4wgAeWWEhutEMsAi2wMSsjhPCYOGV9CD03rFy9WkIzRwkxBiun/ZBR2BqiNNA+Mndp0JBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDe8Jm81; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c2c754af3cso2373429fac.3;
        Sun, 27 Apr 2025 18:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745805005; x=1746409805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/ubERfRjdkzW5emP2ZZP5xPtJL9kCLbv4s5tOyr1d0=;
        b=lDe8Jm8130K+k48alpc04zifXk+zPW1ptL3XKSHukfF9MwO9lqiA+bcsQ1bpbyMcpT
         EHp/p2dCAfN/KuuRhV+zuImI0tauPNBZ1tPnqvwHSTCDlSjBIJt1/X6hCTnhLiw3p+z9
         NESHzxQDOx7EJL+5lZluj+Gx3npdDjy9XsS/cwHLeeHCo2NrSTi5n/GXfMNeXVb1g9Wv
         HRCan7A7JGZ91/ZnZc42YKRDdGiEXW9dX6Z3o00DXKsOpPW/fAoBzTNKvyee+R6lN+NM
         4ik29xg/RFacllvxI62djdBjAL6nMx+qPjITsNB1VpYQ2jnJkScZUqQZK3BKQgmRuUK9
         pcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745805005; x=1746409805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/ubERfRjdkzW5emP2ZZP5xPtJL9kCLbv4s5tOyr1d0=;
        b=VXJMogY2WFoXeTZSlFK9QIs1+pSGOSQwLQZ/QkONd4+X05UO3g6mzwzbkPnU1rIsHd
         Syt0ARSRXpNDl4xI9mdy4uYSxKyAakMCg+oZrXukofP10zHu6HYnhTTunUzqsOz5rJES
         GqLvnfxWiI5j7wx9qMG6SXBEYWaOdf13yB1+zVUoJUWZH8po5nEw5c/eeMaJOPcxTrw/
         s1NmxmVMzZoVo25KMluVP9NE9bdMJ/7gXr1PLZNhExFOvrIErf4vD3PdTpInI6UwGewO
         gXIApeNP02fQx/RCnJg7gqpc0bCdHdmOo/DVXfcR6z+mFxYlPDPUdXxfemQh6RPUIIOW
         592w==
X-Forwarded-Encrypted: i=1; AJvYcCUaP4qTeM5y4aGHlYjkwSTCqqLiAI4xRvhteofwFyoFDOai1v7J9dqURey4+5HYc8RfxxGP0gnBUcgIca7w@vger.kernel.org, AJvYcCWPO3OFm+PAjkn8EgBZYFH5JNFc4U3TqReeAOu/RTkTaGaBXZCZGD3DaE/Qsarj7L5U9DeJi+920w5YIe0AUg==@vger.kernel.org, AJvYcCXRB6JVyQUxkjzfv+TlUX7o8yv8h821JImy5yfA2DBCRiZkgNmB0xIAbvLJRsPV3aSQraovncsUp0I=@vger.kernel.org, AJvYcCXcS1WWj9GV4n6KkpDFRPm+P21VwTlltX0ka4BAUodzLA2CrQa9n9gYmZMKPlAtqNRN/KOOj2ssL/di@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4wLz5neh8vB7XAhnXUeX6qYRWr7H7kI8Y5gzIDSrbJ/snngjd
	5eT47wo3eeim2FvyWtrM6iXwjBXftD50zmvEl49pj0xNv7CueB+f
X-Gm-Gg: ASbGncstpT0b6PNk6qmEQW1yYSdY2lULUxdW/NkRjKGk7vUW3hIVrpUK4WUj0zO7Uyp
	HEWeQJ8Dcqo3bQdK7torityLd4MRoaLaH1XSl0RSd4bRNRmQq9D53CysawYKeefTPyZgc1RN0Rn
	sUju/9RSg1PQCkd/0lRMBr6ydsFdN5WAC7fOQB9rlRQi+BkEGSz/vRxAtDQfAHLsPsQmbyB86mq
	/wye2br6x9g6WYnXRVIOQWuQ13R/sX0iHqX/yD9BvkViYIFW9sHy/MwOrUJl4copsOMg/wQZVT8
	kRc1xOyVNOuhr3aqF9/ozSL9l3X1ZY/FmKORTR8qVHzqEgJVsdXke2s1zL2ncSiXnA==
X-Google-Smtp-Source: AGHT+IFAMuKE1EJyX06l+5odcVHGZDhKhFY+nBb5zJuOWKhWorN6ZVXS6F1/faYUmlVc/WvBl7O1dg==
X-Received: by 2002:a05:6870:a794:b0:2c1:6948:d57c with SMTP id 586e51a60fabf-2d99db0acc8mr6417200fac.28.1745805003074;
        Sun, 27 Apr 2025 18:50:03 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:14de:ab78:90c3:bb9a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d9737e73b7sm2071903fac.26.2025.04.27.18.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 18:50:02 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sun, 27 Apr 2025 20:50:00 -0500
From: John Groves <John@groves.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 18/19] famfs_fuse: Add documentation
Message-ID: <bwazd4vbwj2c7flrrkizycvl22oflufawxdiaan674vqqkgumw@lt4zppeg4l7e>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-19-john@groves.net>
 <db2415e3-0ee7-4b72-ac6b-4c7cda875dd3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db2415e3-0ee7-4b72-ac6b-4c7cda875dd3@infradead.org>

On 25/04/21 07:10PM, Randy Dunlap wrote:
> 
> 
> On 4/20/25 6:33 PM, John Groves wrote:
> > Add Documentation/filesystems/famfs.rst and update MAINTAINERS
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  Documentation/filesystems/famfs.rst | 142 ++++++++++++++++++++++++++++
> >  Documentation/filesystems/index.rst |   1 +
> >  MAINTAINERS                         |   1 +
> >  3 files changed, 144 insertions(+)
> >  create mode 100644 Documentation/filesystems/famfs.rst
> > 
> > diff --git a/Documentation/filesystems/famfs.rst b/Documentation/filesystems/famfs.rst
> > new file mode 100644
> > index 000000000000..b6b3500b6905
> > --- /dev/null
> > +++ b/Documentation/filesystems/famfs.rst
> > @@ -0,0 +1,142 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +.. _famfs_index:
> > +
> > +==================================================================
> > +famfs: The fabric-attached memory file system
> > +==================================================================
> > +
> > +- Copyright (C) 2024-2025 Micron Technology, Inc.
> > +
> > +Introduction
> > +============
> > +Compute Express Link (CXL) provides a mechanism for disaggregated or
> > +fabric-attached memory (FAM). This creates opportunities for data sharing;
> > +clustered apps that would otherwise have to shard or replicate data can
> > +share one copy in disaggregated memory.
> > +
> > +Famfs, which is not CXL-specific in any way, provides a mechanism for
> > +multiple hosts to concurrently access data in shared memory, by giving it
> > +a file system interface. With famfs, any app that understands files can
> > +access data sets in shared memory. Although famfs supports read and write,
> > +the real point is to support mmap, which provides direct (dax) access to
> > +the memory - either writable or read-only.
> > +
> > +Shared memory can pose complex coherency and synchronization issues, but
> > +there are also simple cases. Two simple and eminently useful patterns that
> > +occur frequently in data analytics and AI are:
> > +
> > +* Serial Sharing - Only one host or process at a time has access to a file
> > +* Read-only Sharing - Multiple hosts or processes share read-only access
> > +  to a file
> > +
> > +The famfs fuse file system is part of the famfs framework; User space
> 
>                                                               user
> 
> > +components [1] handle metadata allocation and distribution, and provide a
> > +low-level fuse server to expose files that map directly to [presumably
> > +shared] memory.
> > +
> > +The famfs framework manages coherency of its own metadata and structures,
> > +but does not attempt to manage coherency for applications.
> > +
> > +Famfs also provides data isolation between files. That is, even though
> > +the host has access to an entire memory "device" (as a devdax device), apps
> > +cannot write to memory for which the file is read-only, and mapping one
> > +file provides isolation from the memory of all other files. This is pretty
> > +basic, but some experimental shared memory usage patterns provide no such
> > +isolation.
> > +
> > +Principles of Operation
> > +=======================
> > +
> > +Famfs is a file system with one or more devdax devices as a first-class
> > +backing device(s). Metadata maintenance and query operations happen
> > +entirely in user space.
> > +
> > +The famfs low-level fuse server daemon provides file maps (fmaps) and
> > +devdax device info to the fuse/famfs kernel component so that
> > +read/write/mapping faults can be handled without up-calls for all active
> > +files.
> > +
> > +The famfs user space is responsible for maintaining and distributing
> > +consistent metadata. This is currently handled via an append-only
> > +metadata log within the memory, but this is orthogonal to the fuse/famfs
> > +kernel code.
> > +
> > +Once instantiated, "the same file" on each host points to the same shared
> > +memory, but in-memory metadata (inodes, etc.) is ephemeral on each host
> > +that has a famfs instance mounted. Use cases are free to allow or not
> > +allow mutations to data on a file-by-file basis.
> > +
> > +When an app accesses a data object in a famfs file, there is no page cache
> > +involvement. The CPU cache is loaded directly from the shared memory. In
> > +some use cases, this is an enormous reduction read amplification compared
> > +to loading an entire page into the page cache.
> > +
> > +
> > +Famfs is Not a Conventional File System
> > +---------------------------------------
> > +
> > +Famfs files can be accessed by conventional means, but there are
> > +limitations. The kernel component of fuse/famfs is not involved in the
> > +allocation of backing memory for files at all; the famfs user space
> > +creates files and responds as a low-level fuse server with fmaps and
> > +devdax device info upon request.
> > +
> > +Famfs differs in some important ways from conventional file systems:
> > +
> > +* Files must be pre-allocated by the famfs framework; Allocation is never
> 
>                                                          allocation
> 
> > +  performed on (or after) write.
> > +* Any operation that changes a file's size is considered to put the file
> > +  in an invalid state, disabling access to the data. It may be possible to
> > +  revisit this in the future. (Typically the famfs user space can restore
> > +  files to a valid state by replaying the famfs metadata log.)
> > +
> > +Famfs exists to apply the existing file system abstractions to shared
> > +memory so applications and workflows can more easily adapt to an
> > +environment with disaggregated shared memory.
> 
> 
> -- 
> ~Randy
> 

Both edits applied to the -next branch for the patch set. Thanks!


