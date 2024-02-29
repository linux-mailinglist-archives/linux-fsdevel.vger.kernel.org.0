Return-Path: <linux-fsdevel+bounces-13223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D993486D6B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 23:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E121F244AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D674BF1;
	Thu, 29 Feb 2024 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhuE7cZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2B74BF0;
	Thu, 29 Feb 2024 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244999; cv=none; b=qq8OySrIZrB9tbBs+fQy4ESASjh2vciAJnfbfqzdT8mBWu+FS87aI8mFmiDFaVmOr15Y/uqP8Dml+qs/ymWY/Q0nnrETEtOykmmNhNZS64Rw8Q3dYF0uVmJayJwIggeU0YO6LIDSIZszkxLJlO+YDonh8W4Iw9LiPGznlu4fuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244999; c=relaxed/simple;
	bh=ACzWMSBVSbROvAz/KF0+OOhAKUBYt21796gDCX9IvxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjX7TVFaKJiINyFQa4E1Arn2BSeGh3wgDrmg3xy/lfFnlPM72RKyuArZmJ/+BJVd9PNKO7BP2Qllihm7dLwP9SZGWti3YlqETJqgPLGsOlXpCoNyJxN2WMFk+jY58Q2xwqkIzIWj7SFrIPtBcgqeW1qhiUuElJifXc/eZOOMBqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhuE7cZa; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21fa97a9c53so662780fac.3;
        Thu, 29 Feb 2024 14:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709244996; x=1709849796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jX/0FGNYJgzcsBn/SznB4/DvBP9JHSAGQHtl/qEj9o=;
        b=BhuE7cZanAF1sKFrDrNrZdFojfQ386Psy8w0FFRn6GPUgnwidWYdgfPIyqrKfz7bZ+
         /54adNoGV6VTxcCqbseRcgFBWSJ0beKI605OMtWUS9CQgAsMVF2gvnNJ0XvBnC/vtXHe
         GYm4yde8wefGueFdEtvqFNHJUgHDMtHWGV36R7W29LE85yFZDzpaEocrm3bvG0359QKZ
         kqrC4z40qVUiYBmHyy5dKHSBeObAUz6EOsGNkDpEtGdGi0/G7TBZSB8EplNsjeAghmZc
         D78qa9wUFGjKEit/oM2YCqiWHllgNmTAUk5lsyb73vx8nAXs2zGSdfHvaDMzCZk0XXP/
         XNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709244996; x=1709849796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jX/0FGNYJgzcsBn/SznB4/DvBP9JHSAGQHtl/qEj9o=;
        b=MjWYFDJViLTWNPE2y1Suum+BAuJhTYccjlxrQPlEXO5/l6Evxle9SHha3e7o4YTZOD
         JbTQ6GInASfq2g1xN8ecqxXbQiVNXu5ulahxVeqmkhgIFAd6/lRC8J00ZaR8irzRlEN7
         NLv0oUBhh0YSE+T2nu8u2uFzuUPMYUXMjKZfqrrWRoOrLFhftX8U6OqIYS1WOYB7j5Bg
         gR6jKTaufXJK/G/RM6R+jdYw8F9AECYerPYioEtEXlnHY9G7XAEGsZgf35jVCMRl1ozP
         RPEq71GkverUS8KTko9csWVlbwUF2z4/F910AZWmCBher+UkK0q5Anyj1TPfZuNTM7cV
         0kvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcGmayLn7CTHFeOr2kTQ4cwzm1vz6nDO063sdhBHWtLycRVhaOAVp7DQXfhGhWwbH5quUkOA+Ak7JuIdnizWmHrHXVrSAKtwxWb+F4Vh46je7hHK6Wz3EhRnsOyeuyYsDESj+Rs3uoSDOuIg1YIURIqJR3kZcK5fsfmr4CFMfZ37dSk0KnwfuAjSvOnLT9hxWJPgkN2hgol5RX3rfTTtbHMg==
X-Gm-Message-State: AOJu0Yxgs4gzy4aRqEbacKVknGqCp5dyR89RirYNdW4Ugkq5fGrjRNhb
	uz0CadkSwTM321ZZ0KF+qqOlWWS6sTAiNNjbbfaGkkswJYyf4V97
X-Google-Smtp-Source: AGHT+IFyGPwgD+94e5jiTNKG6OD6umzOYBwkvbAB5UKUevYwym/Dgn02nynUh8GFXuJUSfHgSNy1AA==
X-Received: by 2002:a05:6870:6112:b0:220:88b7:5145 with SMTP id s18-20020a056870611200b0022088b75145mr3500762oae.41.1709244996533;
        Thu, 29 Feb 2024 14:16:36 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id s20-20020a0568302a9400b006e4ad2edb1bsm446693otu.8.2024.02.29.14.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 14:16:36 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 29 Feb 2024 16:16:33 -0600
From: John Groves <John@groves.net>
To: Amir Goldstein <amir73il@gmail.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com, Miklos Szeredi <miklos@szeredi.hu>, 
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
Message-ID: <3jwluwrqj6rwsxdsksfvdeo5uccgmnkh7rgefaeyxf2gu75344@ybhwncywkftx>
References: <cover.1708709155.git.john@groves.net>
 <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>

On 24/02/29 08:52AM, Amir Goldstein wrote:
> On Fri, Feb 23, 2024 at 7:42 PM John Groves <John@groves.net> wrote:
> >
> > This patch set introduces famfs[1] - a special-purpose fs-dax file system
> > for sharable disaggregated or fabric-attached memory (FAM). Famfs is not
> > CXL-specific in anyway way.
> >
> > * Famfs creates a simple access method for storing and sharing data in
> >   sharable memory. The memory is exposed and accessed as memory-mappable
> >   dax files.
> > * Famfs supports multiple hosts mounting the same file system from the
> >   same memory (something existing fs-dax file systems don't do).
> > * A famfs file system can be created on either a /dev/pmem device in fs-dax
> >   mode, or a /dev/dax device in devdax mode (the latter depending on
> >   patches 2-6 of this series).
> >
> > The famfs kernel file system is part the famfs framework; additional
> > components in user space[2] handle metadata and direct the famfs kernel
> > module to instantiate files that map to specific memory. The famfs user
> > space has documentation and a reasonably thorough test suite.
> >
> 
> So can we say that Famfs is Fuse specialized for DAX?
> 
> I am asking because you seem to have asked it first:
> https://lore.kernel.org/linux-fsdevel/0100018b2439ebf3-a442db6f-f685-4bc4-b4b0-28dc333f6712-000000@email.amazonses.com/
> I guess that you did not get your answers to your questions before or at LPC?

Thanks for paying attention Amir. I think there is some validity to thinking
of famfs as Fuse for DAX. Administration / metadata originating in user space
is similar (but doing it this way also helps reduce RAS exposure to memory 
that might have a more complex connection path).

One way it differs from fuse is that famfs is very much aimed at use
cases that require performance. *Accessing* files must run at full
memory speeds.

> 
> I did not see your question back in October.
> Let me try to answer your questions and we can discuss later if a new dedicated
> kernel driver + userspace API is really needed, or if FUSE could be used as is
> extended for your needs.
> 
> You wrote:
> "...My naive reading of the existence of some sort of fuse/dax support
> for virtiofs
> suggested that there might be a way of doing this - but I may be wrong
> about that."
> 
> I'm not virtiofs expert, but I don't think that you are wrong about this.
> IIUC, virtiofsd could map arbitrary memory region to any fuse file mmaped
> by virtiofs client.
> 
> So what are the gaps between virtiofs and famfs that justify a new filesystem
> driver and new userspace API?

I have a lot of thoughts here, and an actual conversation might be good
sooner rather than later. I hope to be at LSFMM to discuss this - if you agree,
put in a vote for my topic ;). But if you want to talk sooner than that, I'm
interested.

I think one piece of evidence that this isn't possible with Fuse today is that
I had to plumb the iomap interface for /dev/dax in this patch set. That is the
way that fs-dax file systems communicate with the dax layer for fault 
resolution. If fuse/virtiofs handles dax somehow without the iomap interface,
I suspect it's doing something somehow simpler, /and/ that might need to get 
reconciled with the fs-dax methodology. Or maybe I don't know what I'm talking
about (in which case, please help :D).

I think one thing that might make sense would be to bring up this functionality
as a standalone file system, and then consider merging it into fuse when &
if the time seems right. 

Famfs doesn't currently have any up-calls. User space plays the log and tells
the kmod to instantiate files with extent lists to dax. Access happens with
zero user space involvement.

The important thing, the thing I'm currently paid for, is making it
practical to use disaggregated shared memory - it's ultimately not important 
which mechanism is used to enable a filesystem access method for memory.

But caching metadata in the kernel for efficient fault handling is the
only way to get it to perform at "memory speeds" so that appears critical.

One final observation: famfs has significantly more code in user space than
in kernel space, and it's the user side that is likely to grow over time.
That logic is at least theoretically independent of the kernel ABI.

> 
> Thanks,
> Amir.

Thanks!
John


