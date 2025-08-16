Return-Path: <linux-fsdevel+bounces-58080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BF5B28F6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 18:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C731B6333E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06BC2EF644;
	Sat, 16 Aug 2025 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIGyBKU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DEF33086;
	Sat, 16 Aug 2025 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755361376; cv=none; b=RafKloZcuH5Pyw7x4zi3Nq8c3I0Q6ViV/EA5A9oaqErbwaC9Yw6G6ogTpW0Ar/SZ1epsBvs6kND4ZttnsBCRSi9J9dRf4NWbyhUpNxAGdgJ4Az7zGYQr8z1766uquXTxSkyiCx5jdIDX49rOVS3oi8monigkH7pI+qGtyAXY3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755361376; c=relaxed/simple;
	bh=NZM13o2Exswd9U+U96wypdU8sDgj2Ia3oSNRi53SxnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcAQGIc17fwD04XrY9EbPCu6wfhGtgcwXH3G6Xoe9aDRQnbGeC0zBjNw7eORut6+i5hq2rQQeK1/SLjJhfzOdZUey/uPS5ropXRSpog5exCZNUPXqYv2fp9ruT34KabVfdeOoDXo24mVm99oz4gi/l1fkUyVMexYmnbbSZsl6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIGyBKU4; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce58bb89so2599749fac.0;
        Sat, 16 Aug 2025 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755361372; x=1755966172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Rtpc5s7M7/+q1cABKsKTJfzX3/F+/4NGbX+n4VhZH8=;
        b=cIGyBKU4ukL+l+lzIL85FrzttJMEoqq2eHc7WbB1iAr/K1zYthOV6jwEI1T/rCeB8T
         MFkGcSSnGY3+E5KRdaMUsi/Dlu+bpqCiRh2+Z6BImuWvZwrbx4cUVruorh/HPY6uqs8f
         Cq/ZpMJMLh06K7CTPoOUOaWft8iZvBm+F2CcNTi4g4IgeHUc97qO5NNd5R4Wyl7Kf1Ma
         a55qTJIK63NIBd71jBm3pq/cXPlK/hjwaGBNPb0fOGFv93t5fZ2kasjrfkoqG8Oq+39z
         AueKoyuQGYOsF5WnREomdlFXvbMVCnw2u/Odw6RiE/izFlmjCEA6BBLCJjyTGNN/gND6
         7vsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755361372; x=1755966172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Rtpc5s7M7/+q1cABKsKTJfzX3/F+/4NGbX+n4VhZH8=;
        b=XtjHNmD0TMBTN0kPAtjSHtjL5vsYC7LeY+okFJzlFu5i1b8GYkUpghKXeDH0dNiuen
         OLVuSAhd1oNpV6Ji9Q4n1bzd5q2XMxGMnj63Z+t+sKrwMBfBqyP43g2LOKhW39XYi30g
         mNIIP0l28mzeY9HyXKBk44nK4OwJC2kmJz3PE1onid3jwDGROFMUDLNqsB/pPTDrGMTC
         sdduoDNjH+puLBRfiTVvPnzgR00oIjC0KzCquf6gN3w4JvPGiIJlos+EuULQrWKuSq5K
         N1AP/kAkPiUQXv1IHY+B/5DvY0hzEUpSbP7f9lvUeEndx5tAQvn3xyuN26/qestUzM5/
         +mrw==
X-Forwarded-Encrypted: i=1; AJvYcCVWn0yvHl8Gz0jtF5htXRuzzv99SmIrMvm72qPgdbCVL8z4jHp2QTflaYqTufdzsRwjJF5nucDMEfk=@vger.kernel.org, AJvYcCVbuLxnCBl2WgUzwZXLFY5r+vlX4dTa+UJy5CtEuNtBWOfF9f5BPA0F4FCy9/bj5ylbsZuoKEjF4ReoDL+e@vger.kernel.org, AJvYcCWYCulUJlN+9MYSD2LWpIMxxG7+EmchaKgmP03wDZsr8fPlvsoI5cNMsMQGKuOxg+jCseh3P4zsGtAP@vger.kernel.org, AJvYcCXpM4Re49A4EEqwH+LznVVm8UNsaoNMzHVSJEDHzhXe9G6pEI3deG7Sl8ow8DJ88aoCCYC/hIIfMTqwGI1XNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ewsyApcKvOdEeVh8XoxdT4KdW1/xd/8sVVa/pLQJHcMfdp2J
	FGTMPzN/xw5QfD35YO7bTw5dM8UxR9qayoJUF9Fk3o2OS3ykjJGDOaQ5
X-Gm-Gg: ASbGncus3hshJJMG7lsK0lcHXePF4F1vdlTht6vZH0EaNjuLqLolRGnBrxnJBGVp0qt
	yDUvRBF6ZIpncURZbfvbH/udZfcEddomfzt0EYMTiMKzLTWNtZfK/gKZoySYvzFZQCAiiF7qnp/
	1O8H/jqJki/pY7brZg58XVP798G/zyrAsLdReN9anQH2XvRtehJq2FmpAvqkWsg85rSksokKC9D
	S9LvdOvMF+sNdfHPyoXaa4KxQ1EEvyUYUGKzPBadh8wdBcYuNbhGYVGb6si5rtzcQ7o2qY6FZ4S
	tH/Gid2AdmJCiY0c42yI6afWP2uDrNy38ppLcqkT8u4PEu7I6MB1Q8OpB5K3smqRyKkC0f87LYp
	cjTE249zGjr7lnGQtUaaIgs6DNcbsSqMrWxAo
X-Google-Smtp-Source: AGHT+IHCxUIkdlGxbKhRgkda2hbannURDDEsuMBjaUCvPESePWFZyXXJu5EUcQ/LJ4zZvF6BnvAeCQ==
X-Received: by 2002:a05:6870:15c8:b0:30c:5189:5707 with SMTP id 586e51a60fabf-310aae9750cmr3295321fac.28.1755361372333;
        Sat, 16 Aug 2025 09:22:52 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:1d43:22e9:7ffa:494a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74391bd20a3sm911591a34.21.2025.08.16.09.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 09:22:51 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sat, 16 Aug 2025 11:22:49 -0500
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, john@groves.net
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
Message-ID: <vfg7t7dzqjf6g6374wavesakk332n4dqabgokw4xobsar5jnxm@m7xfan6vhyty>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-15-john@groves.net>
 <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>
 <20250814171941.GU7942@frogsfrogsfrogs>
 <CAJfpegv8Ta+w4CTb7gvYUTx3kka1-pxcWX_ik=17wteU9XBT1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv8Ta+w4CTb7gvYUTx3kka1-pxcWX_ik=17wteU9XBT1g@mail.gmail.com>

On 25/08/14 08:25PM, Miklos Szeredi wrote:
> On Thu, 14 Aug 2025 at 19:19, Darrick J. Wong <djwong@kernel.org> wrote:
> > What happens if you want to have a fuse server that hosts both famfs
> > files /and/ backing files?  That'd be pretty crazy to mix both paths in
> > one filesystem, but it's in theory possible, particularly if the famfs
> > server wanted to export a pseudofile where everyone could find that
> > shadow file?
> 
> Either FUSE_DEV_IOC_BACKING_OPEN detects what kind of object it has
> been handed, or we add a flag that explicitly says this is a dax dev
> or a block dev or a regular file.  I'd prefer the latter.
> 
> Thanks,
> Miklos

I have future ideas of famfs supporting non-dax-memory files in a mixed
namespace with normal famfs dax files. This seems like the simplest way 
to relax the "files are strictly pre-allocated" rule. But I think this 
is orthogonal to how fmaps and backing devs are passed into the kernel. 

The way I'm thinking about it, the difference would be handled in
read/write/mmap. Taking fuse_file_read_iter as the example, the code 
currently looks like this:

	if (FUSE_IS_VIRTIO_DAX(fi))
		return fuse_dax_read_iter(iocb, to);
	if (fuse_file_famfs(fi))
		return famfs_fuse_read_iter(iocb, to);

	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
	if (ff->open_flags & FOPEN_DIRECT_IO)
		return fuse_direct_read_iter(iocb, to);
	else if (fuse_file_passthrough(ff))
		return fuse_passthrough_read_iter(iocb, to);
	else
		return fuse_cache_read_iter(iocb, to);

If the famfs fuse servert wants a particular file handled via another 
mechanism -- e.g. READ message to server or passthrough -- the famfs 
fuse server can just provide an fmap that indicates such.  Then 
fuse_file_famfs(fi) would return false for that file, and it would be 
handled through other existing mechanisms (which the famfs fuse 
server would have to handle correctly).

Famfs could, for example, allow files to be created as generic or
passthrough, and then have a "commit" step that allocated dax memory, 
moved the data from a non-dax into dax, and appended the file to the 
famfs metadata log - flipping the file to full-monty-famfs (tm). 
Prior to the "commit", performance is less but all manner of mutations 
could be allowed.

So I don't think this looks very be hard, and it's independent of the 
mechanism by which fmaps get into the kernel.

Regards,
John



