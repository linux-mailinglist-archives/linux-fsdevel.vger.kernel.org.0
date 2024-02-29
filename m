Return-Path: <linux-fsdevel+bounces-13165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5839186C15E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 07:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1083B2869F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 06:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49B239FD1;
	Thu, 29 Feb 2024 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdZO2z78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFAD8F4A;
	Thu, 29 Feb 2024 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189566; cv=none; b=A3waFE6a/NK6qzjc29dLXPBmSJePzB2DMYRB4Eu1JWJQKe7L+q9VqE7aXLiSRepJdgAbYGr7ICKrfUPngrWXcCbCnyBBK+HMYzSXIwWzVsbdSuYtR7Qpd0RmMraMe1GfMx4VLDTtP41cdMKoxBVVZOlBo5wmiD82u6gmv6Q475Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189566; c=relaxed/simple;
	bh=QEJAoHeT2wh90dI+ZjoF1ZHx+LcAYE5U/em2XDUBioM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atALxQJHlNUCOMFuP3B8F7t8lQcteFeA4/+hI/nZzZ837GXor4FByfQ2NKljMTvF5CgtM/BdvbLMfMocOUgkU+PHeL6VjCd6HHmVPEu6cWuAIH8f5E3M4Un9WNxQvFdzjpYr6NxTsCWi2UHnfbdoBiN4kCYI4xj5puvv56ROQ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdZO2z78; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42e8758fd52so4332761cf.1;
        Wed, 28 Feb 2024 22:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709189564; x=1709794364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPX1yFcE2Qv3sy/mqTmODI/j9a9JW9C8YeAhgYmhLGs=;
        b=QdZO2z78FLEY4RWdjVmUdbrKoq0N/fYM+uC5aG9e6ZJmCKek53xR3UVmADzlUwOLDO
         0iBOf6bXHyV01JkM2zJzFHb8bKVhsB8s38YRrrvk2sgrbA+vndWnP86CWUOx44UcvRa3
         gAI9IhZLtJi89nlvmaE1yGQ+S7Y3208HzgJylGPszXl84JeLy7N81pzYM1W70jF6mPUa
         t+kMHNiUb6lzQHrGrYzQ7CnAT0H1lZ7gJh68GFElWJGU1DXh5naQWJFqp/QYvc/tMx+6
         G2GSrQRboLWvQAf9z74/RRxegpLpCW1i8fUo6VtRdLCbNFyMWzFmN7QKqFrzAw0SFXfg
         XRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709189564; x=1709794364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPX1yFcE2Qv3sy/mqTmODI/j9a9JW9C8YeAhgYmhLGs=;
        b=d7qDmIclWJrCQsb6+dBgVnj8sI/SrJZAo7vNQW5pnyrxQMTqwD/+RShwRXj2P/IpYt
         Zv9yN0AIBZFEDJoGQVcUvLrIxSPDdv4gfHM3AkDpu6YZP6PDh+n6S/UyYou/1gswljoH
         QFh1eR7jEP7ezi1TIeHp6Oqcm7dDxK3hocQSioEr2w4fCGm2Iij9A4AtOYHth8tlNEZA
         JthQdmjaI3qJW32ctRXsldx4JzLqqInEER1A1RRcYHPRv7mnxB7yK9KszWcp0XsHGess
         N+Zg1IdNPSjJ+qSJDXPX6ykHAK9No9T4N/1LfXaCFsQxNpLD0KPxPb7cLBGNaYpWMKUu
         rTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr4zRzWPu3iYMXgfM5TETbOozfb4d0Ch1BvjNcSq6dfd40P7HLNGiNNN7zVCTVH4AjPIph63xKb0zqRpIEgiJILBL6QvjLllEMVQuJUezZPYDMfkzFQjoI/YiOuAE8eGNTmLgju/Fl+QK9oLMYfamIfijAsFaEFurew1kNYdOpw4seeuU8Czn1h0h2hk2aY4bfz8GXBX9KnChX8GR4cUbIjA==
X-Gm-Message-State: AOJu0YzFCvZPqENBTpu15bNMO4Q7ZVZBFNZ0n9WXZLBvm60a+617cdCs
	3KXbkbXVoTLkcEL8Zox3IyLw/kf1evhb2tOBjYdrV/+21vuNQsoWoC5tvSeXubUZQdrTuq7nGcr
	Dun4i/FjXah7NM81MiCjWmTDomRs=
X-Google-Smtp-Source: AGHT+IFn20kiezhjvNWVPNWkvhcd3j6u19avlEPGAe1WEmIZ6yWLp27W9XetikSPB9EKVwpdSFz5h3OKt1KsGriybmc=
X-Received: by 2002:ac8:7f82:0:b0:42e:8c8f:42f6 with SMTP id
 z2-20020ac87f82000000b0042e8c8f42f6mr1421021qtj.40.1709189563696; Wed, 28 Feb
 2024 22:52:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708709155.git.john@groves.net>
In-Reply-To: <cover.1708709155.git.john@groves.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Feb 2024 08:52:32 +0200
Message-ID: <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
To: John Groves <John@groves.net>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, 
	gregory.price@memverge.com, Miklos Szeredi <miklos@szeredi.hu>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 7:42=E2=80=AFPM John Groves <John@groves.net> wrote=
:
>
> This patch set introduces famfs[1] - a special-purpose fs-dax file system
> for sharable disaggregated or fabric-attached memory (FAM). Famfs is not
> CXL-specific in anyway way.
>
> * Famfs creates a simple access method for storing and sharing data in
>   sharable memory. The memory is exposed and accessed as memory-mappable
>   dax files.
> * Famfs supports multiple hosts mounting the same file system from the
>   same memory (something existing fs-dax file systems don't do).
> * A famfs file system can be created on either a /dev/pmem device in fs-d=
ax
>   mode, or a /dev/dax device in devdax mode (the latter depending on
>   patches 2-6 of this series).
>
> The famfs kernel file system is part the famfs framework; additional
> components in user space[2] handle metadata and direct the famfs kernel
> module to instantiate files that map to specific memory. The famfs user
> space has documentation and a reasonably thorough test suite.
>

So can we say that Famfs is Fuse specialized for DAX?

I am asking because you seem to have asked it first:
https://lore.kernel.org/linux-fsdevel/0100018b2439ebf3-a442db6f-f685-4bc4-b=
4b0-28dc333f6712-000000@email.amazonses.com/
I guess that you did not get your answers to your questions before or at LP=
C?

I did not see your question back in October.
Let me try to answer your questions and we can discuss later if a new dedic=
ated
kernel driver + userspace API is really needed, or if FUSE could be used as=
 is
extended for your needs.

You wrote:
"...My naive reading of the existence of some sort of fuse/dax support
for virtiofs
suggested that there might be a way of doing this - but I may be wrong
about that."

I'm not virtiofs expert, but I don't think that you are wrong about this.
IIUC, virtiofsd could map arbitrary memory region to any fuse file mmaped
by virtiofs client.

So what are the gaps between virtiofs and famfs that justify a new filesyst=
em
driver and new userspace API?

Thanks,
Amir.

