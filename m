Return-Path: <linux-fsdevel+bounces-19650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9286A8C844F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280D0B20EAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4582C68A;
	Fri, 17 May 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DpILjKRH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5BB2561D
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715939754; cv=none; b=g6T0x6d/QFiFmK0++/1+STiUrR/wAiG9uzih9oCNvQOieGx3umwq1PYuZ486p4qI0YyFe5mUP5+Yt0E7FzfzXZN3oJAJJmTLXOW0I20dLXQEP8jwnLk6DEYHDhVvEOvZ2bR/x5OsWqIgmabJQ7AOsiTedUS2ToRtEJVmtYcqieQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715939754; c=relaxed/simple;
	bh=yEo5GShOkRDZDNm8NkQ+gpHhI/5nysUzlnONr9Kdx9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRojC8l4npSygDsfliYI/2t7aLKURnSb+EPqe+ztkKU+rneCyiP1Bjl2f2+qY5A6RdTB9qpvIeUMke43CY2gWRbusXNuP6yya8OSGCn9vXlUNXoW38EVbl73rmGNDOXmYVOS2n/QhI+oIsljf/JH7Y6PMoI25oLQCHa7Zrgm2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DpILjKRH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so421346866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 02:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715939751; x=1716544551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pcObKvA4ZG4W5f3+AevN4kRUemeykWizQkVWPJqy2SU=;
        b=DpILjKRH3vDhAYA/ARHOtJO01BJvGSVK5u3XIsj2wW9u7ojtsbZVIzdtnMieqnEia3
         //gIOLPeQ1vncIvQzju+tV9TOQyQDRp48z1kOh7lHwy758BU26Hy108pt8htsKLpAg0f
         6PvYu8WCDcuJ0iy79GmV5cKOboNxTdTOZb8TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715939751; x=1716544551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcObKvA4ZG4W5f3+AevN4kRUemeykWizQkVWPJqy2SU=;
        b=Yb4OkxS0PhMBFCwWR3lQ8XEbqCz3pyQbFl+S2FZY3w212g5FOmxlyIeq+65U447RU4
         oggUPAwpKMxqWaaHi6f21DauqBiL/LHQIV/fBXxm++2Ndj6r47dEzd12t2lXB8IP0+cC
         z4c+wLJ1WFovZH7wnzXSCYDsJrpLA4Qhpd/jjt6sIT0dXnmnsxuhx8DpjGqFDyy6XK+Z
         /Mfr1yf96m4pqtewaeIUNd62PzRjasXz/ggJdWnCFt0JqWjMdExMgKoJbEf7dfFwxooo
         c+l4dGwcK0oV6mInDU76XtO3ebjVwjKKrftSWBfSdMV8NXobhrfrdpVLVu6n0jk+2PJf
         e+ow==
X-Forwarded-Encrypted: i=1; AJvYcCX6ai4MmSlCkU/hSpFnY0uZuLmFqWnoIW73bdpTFJunwlaRjsPtp/8fGVNiDaZS6Z3MxIQlbxH/sUBRynA+bF06bdw4nffY+5FDFiwPVg==
X-Gm-Message-State: AOJu0Yz+wjaaKX0W+HJmirJt27za6wU6J7Ngs8E33wuHwrXd90e8E1b+
	DyVRFl1mLCl9+7daBH/LPGFje5InMFt4M7/+30n1V+rqODtKgGNMaSUy5z0Jh/hZ0kpN4zleVIR
	8L5v/AqRSFuiFc0xC0aIAE4YXfRb/o8rG+WWpcg==
X-Google-Smtp-Source: AGHT+IGUqRqz0erBi4OJUl6VA4qkH4UEWsCMVotBiO/aEdGp+g7gFrfkzdjDJdKMS20zUZZ4qsB1zgVM9EX7g1H+bTo=
X-Received: by 2002:a17:907:7f09:b0:a59:b61f:b96d with SMTP id
 a640c23a62f3a-a5a2d53bc6amr1654347366b.5.1715939750690; Fri, 17 May 2024
 02:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708709155.git.john@groves.net> <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
In-Reply-To: <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 17 May 2024 11:55:38 +0200
Message-ID: <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
To: Amir Goldstein <amir73il@gmail.com>
Cc: John Groves <John@groves.net>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, 
	gregory.price@memverge.com, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 07:52, Amir Goldstein <amir73il@gmail.com> wrote:

> I'm not virtiofs expert, but I don't think that you are wrong about this.
> IIUC, virtiofsd could map arbitrary memory region to any fuse file mmaped
> by virtiofs client.
>
> So what are the gaps between virtiofs and famfs that justify a new filesystem
> driver and new userspace API?

Let me try to fill in some gaps.  I've looked at the famfs driver
(even tried to set it up in a VM, but got stuck with the EFI stuff).

- famfs has an extent list per file that indicates how each page
within the file should be mapped onto the dax device, IOW it has the
following mapping:

  [famfs file, offset] -> [offset, length]

- fuse can currently map a fuse file onto a backing file:

  [fuse file] -> [backing file]

The interface for the latter is

   backing_id = ioctl(dev_fuse_fd, FUSE_DEV_IOC_BACKING_OPEN, backing_map);
...
   fuse_open_out.flags |= FOPEN_PASSTHROUGH;
   fuse_open_out.backing_id = backing_id;

This looks suitable for doing the famfs file - > dax device mapping as
well.  I wouldn't extend the ioctl with extent information, since
famfs can just use FUSE_DEV_IOC_BACKING_OPEN once to register the dax
device.  The flags field could be used to tell the kernel to treat
this fd as a dax device instead of a a regular file.

Letter, when the file is opened the extent list could be sent in the
open reply together with the backing id.  The fuse_ext_header
mechanism seems suitable for this.

And I think that's it as far as API's are concerned.

Note: this is already more generic than the current famfs prototype,
since multiple dax devices could be used as backing for famfs files,
with the constraint that a single file can only map data from a single
dax device.

As for implementing dax passthrough, I think that needs a separate
source file, the one used by virtiofs (fs/fuse/dax.c) does not appear
to have many commonalities with this one.  That could be renamed to
virtiofs_dax.c as it's pretty much virtiofs specific, AFAICT.

Comments?  Am I missing something significant?

Thanks,
Miklos

