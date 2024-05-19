Return-Path: <linux-fsdevel+bounces-19720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D6C8C938C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 07:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEF8281768
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 05:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F7512E5D;
	Sun, 19 May 2024 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbFqS1BM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D805FC01;
	Sun, 19 May 2024 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716098370; cv=none; b=DebI9mkb7VbXECcTaOqYeNfBsSN9K9j3qlvpMCUz00X+fI4HTYKvLrLP4mds/1jX5uMfKcUnOzZ9PXGbInJgUHAe/qQkg7W4H93trU6SF5KXysBZE22XM0chhXjnkL333dsz8QirjntOEG1+JV1Tw5WjXcC7pKeMc5l0CyuVVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716098370; c=relaxed/simple;
	bh=NmN54ee38hsuoKztnpSGK2jQepru5rXH4Gp4EPxGG/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6qe+lmgLHOuwBTN9KCazQ99nHQSL+rAIKhFsuqRLYoV+SvwOIwb3pPrbRtMt4EyAophut0uFJaB/b2fhfr37FT2T8QNqN9HHEJFaVoNHe+aT9nRI0dixSKGKDXsUx2M9Sn88tTc/qQZDB1AoC4O7c4+GXfpX0gRm6SeoCeUC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbFqS1BM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792ce7a2025so52296385a.0;
        Sat, 18 May 2024 22:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716098367; x=1716703167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9NrPccSk3dxue6yKBry7lygPcaCTpzVb/uwrQLilDQ=;
        b=UbFqS1BMC7a831CbLauUqd6ER0ywFqSa/ltBqGHB5qhkJdcfvfINXTcK8nJEqppPen
         Juwjmb2iJ+bbsTrn1irzkU0eISVv84mc+l3E2WekNYVBXeNJdtXhm8RBH75DLB7ATlRH
         qk3IH2YHNGYddUO2BLMajH5Q24jG2ySvY1q5rUwIJ/vrtK6yzL6qpqFDl41tPBa4IilF
         60O+9ZrlFzfAAlAlsQSPMqLXS+euTo8NGxIMeSIWu4DSsxaHZu2PaOTU38XDKRSNn6sL
         +fftRoKwGTXnkXnflldGiFrsVM+Q3eHpk/IGGCI7pgZkqtg3puGhtnyPRPTz0HMP7B3r
         xKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716098367; x=1716703167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9NrPccSk3dxue6yKBry7lygPcaCTpzVb/uwrQLilDQ=;
        b=cVcPXKzdQrsBHj0qrzhKlgFxIMJ3sbP1kOKQiYtzxNpTbT3qw/lDgIJ0rZQyhQriXc
         Ytrnt3xbP5bUo6xD45AqUmWVfkSPeNX1vFrCW0ne6Tp/P1bHg//vyblEFP+wYv7/5Bib
         xcyL52WDQMoYnDs3VZaP2lFRP5r/IDVqIONYWH8XctabUVbpqBRo9n0JLs25dlxX0hEF
         yM6uEwqdUZ7QeNp3jE6CQpIX5AXdk8WF6LEl1T0zTFqnNmLttrvYwK/iTRUnlIfDFtfz
         W7vjeWCS3osRboAphj8utHSfjPifm3GbNtlpkpFvf+mgu+97toGNQFUfmoWsOBRZyr7r
         1k8w==
X-Forwarded-Encrypted: i=1; AJvYcCUyTrTurj0C539WqrifVStZ+ga6aJiTYpQpe/I1eH4shRyte8nCmm7Atp/FvO00iPf4D/P55iQXTQShPM+bZBtqh2nnzGZ6/ltWtA57WXxWGx/9ifXO382w1PwkhV5KtW6gCFEYBrYbr6gToJkj2YaP3wqN+YQu8uzgELWB+sTtEKv0bs9HNbVjvCGSCQPJJMqNUy0Ro1+SdshUIbZOxO04QA==
X-Gm-Message-State: AOJu0YyVO6s8d3F+rx3UN92sjdtOcKAyBEfNH3Z7nzV31/kzJU9COAgk
	GkwCGPyWme3p67Z0tM3aL62Fp/mR+iPui15nOsCd8iQl4rZll4aBZwi222Oy0djEOJSU8dQN5G4
	sjtLWP/UIQ4h9I2ycNZjCvpzAGt0=
X-Google-Smtp-Source: AGHT+IH3KgC5/5RTYZFFyAgi3gGOQGkSBTIG6FnrvcN+/pNJE8X5PHNe6d/ZdqiUCwpFLg5jGKiFsKPx3NTMctwKRHM=
X-Received: by 2002:a37:c44c:0:b0:793:343:6db5 with SMTP id
 af79cd13be357-79303437020mr998126385a.11.1716098367007; Sat, 18 May 2024
 22:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708709155.git.john@groves.net> <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
 <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
In-Reply-To: <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 May 2024 08:59:15 +0300
Message-ID: <CAOQ4uxg9WyQ_Ayh7Za_PJ2u_h-ncVUafm5NZqT_dt4oHBMkFQg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
To: Miklos Szeredi <miklos@szeredi.hu>, John Groves <john@groves.net>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, 
	gregory.price@memverge.com, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 12:55=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Thu, 29 Feb 2024 at 07:52, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I'm not virtiofs expert, but I don't think that you are wrong about thi=
s.
> > IIUC, virtiofsd could map arbitrary memory region to any fuse file mmap=
ed
> > by virtiofs client.
> >
> > So what are the gaps between virtiofs and famfs that justify a new file=
system
> > driver and new userspace API?
>
> Let me try to fill in some gaps.  I've looked at the famfs driver
> (even tried to set it up in a VM, but got stuck with the EFI stuff).
>
> - famfs has an extent list per file that indicates how each page
> within the file should be mapped onto the dax device, IOW it has the
> following mapping:
>
>   [famfs file, offset] -> [offset, length]
>
> - fuse can currently map a fuse file onto a backing file:
>
>   [fuse file] -> [backing file]
>
> The interface for the latter is
>
>    backing_id =3D ioctl(dev_fuse_fd, FUSE_DEV_IOC_BACKING_OPEN, backing_m=
ap);
> ...
>    fuse_open_out.flags |=3D FOPEN_PASSTHROUGH;
>    fuse_open_out.backing_id =3D backing_id;

FYI, library and example code was recently merged to libfuse:
https://github.com/libfuse/libfuse/pull/919

>
> This looks suitable for doing the famfs file - > dax device mapping as
> well.  I wouldn't extend the ioctl with extent information, since
> famfs can just use FUSE_DEV_IOC_BACKING_OPEN once to register the dax
> device.  The flags field could be used to tell the kernel to treat
> this fd as a dax device instead of a a regular file.
>
> Letter, when the file is opened the extent list could be sent in the
> open reply together with the backing id.  The fuse_ext_header
> mechanism seems suitable for this.
>
> And I think that's it as far as API's are concerned.
>
> Note: this is already more generic than the current famfs prototype,
> since multiple dax devices could be used as backing for famfs files,
> with the constraint that a single file can only map data from a single
> dax device.
>
> As for implementing dax passthrough, I think that needs a separate
> source file, the one used by virtiofs (fs/fuse/dax.c) does not appear
> to have many commonalities with this one.  That could be renamed to
> virtiofs_dax.c as it's pretty much virtiofs specific, AFAICT.
>
> Comments?

Would probably also need to decouple CONFIG_FUSE_DAX
from CONFIG_FUSE_VIRTIO_DAX.

What about fc->dax_mode (i.e. dax=3D mount option)?

What about FUSE_IS_DAX()? does it apply to both dax implementations?

Sounds like a decent plan.
John, let us know if you need help understanding the details.

> Am I missing something significant?

Would we need to set IS_DAX() on inode init time or can we set it
later on first file open?

Currently, iomodes enforces that all opens are either
mapped to same backing file or none mapped to backing file:

fuse_inode_uncached_io_start()
{
...
        /* deny conflicting backing files on same fuse inode */

The iomodes rules will need to be amended to verify that:
- IS_DAX() inode open is always mapped to backing dax device
- All files of the same fuse inode are mapped to the same range
  of backing file/dax device.

Thanks,
Amir.

