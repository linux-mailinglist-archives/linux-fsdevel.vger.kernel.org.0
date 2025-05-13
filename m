Return-Path: <linux-fsdevel+bounces-48821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 934FDAB4EFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FDF1B422E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41509214A64;
	Tue, 13 May 2025 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Jdl0YN6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384621420B
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127709; cv=none; b=MUNwHx/oWXw34Fbf+3115YTytBS09NkNapM1CugsocOfhimrTPUeHgI3iWxsM9Nd+3H9iQZ/JVuHUOp0VtTLZX9MOn94eNMQEjZqegrNHUpu0DSlXmZDiXs+PbJdKOquYdqdmf6Kn5P3YiqmowUjuQnLFpzuIOaf4hwmOKcVFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127709; c=relaxed/simple;
	bh=dCEwNwEt7AuPcFjOYYqXUKN9++me11ouKXeEDU4JZv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6wvF2pMe0M5zBViT8ttRLjv1JJsSnsG3JTWaMVG2H9LamnX7W0wUDluTKWVBgXAoA4tXIlPnFzUMc3EZP8DxFt2jW7QQcZK832U3E8wp0r+t36xgSHCMCZLIHwAsGJYOGDw+QyvBVCOkO+Dlefl0YSjXLRsm3pJhInqxrntNIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Jdl0YN6z; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4775ccf3e56so77790981cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 02:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747127707; x=1747732507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ihrFZxGWgoMburH5YAF+Sr/kylX3rOORHrh4dczbaY=;
        b=Jdl0YN6znOpsaNcr/4Y+IU+mukRJybWqwj9SA9se6mTBMEacbqPEIrp4xJOb7w4DZW
         tF9u+FRecvrs2dwHP7vobbMcXp2vAGOxIh8+tPgNQ1bJPK9v42+J/b1D75lBzq3VTBAo
         FkW/Vv5JpRL5FeQ2qILC9yAb4ZwluKicFPyp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127707; x=1747732507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ihrFZxGWgoMburH5YAF+Sr/kylX3rOORHrh4dczbaY=;
        b=eS/0VFnWzmEjnaTW1dSsIOzUnURA9tiS8qKl3103exe6csPaJtt+BP6HUPWhKIAchR
         N0B4Oze4rUSC+sQYvi5/bijplx1wTTl5Eq9bCERf5FoABa62UzJnw+Vez1ICH0bC61Rm
         ch1iBf9CKRlyD1CNjy2x4/pB+uqaNABoAl293fefvKIfDOygDwYovyTxUHe5LS2qTJ64
         68vd6rdBnad0erzNaKdfZRDoKTFOH2sfMiSDy9IQokoRO2IaUdw2qs1uZpMlQOi6DwYx
         DB9itqgezTqcMa3pSZW/hZVNBAcoa2W4ZsY+4zrE8rY3zOPPVc82mSNrr+LRk59hL0W+
         jeVA==
X-Forwarded-Encrypted: i=1; AJvYcCWNgKWkjxyyQSdxsk4HyL6XVe4/6kl1skZyrm+L5BZMJSE2jN4Ko7AOTZuJDOp6MuAW5J51oq6rN6B3qSIH@vger.kernel.org
X-Gm-Message-State: AOJu0YyJI5QY6f8cTDueFy7DLNyMRTdNrMBT3YDXPl+Y1BHTPsDpCBmm
	npZV7VSsVQTVBD1nQHFBNp71J0+WTjkMQHooL96R3FSB83AJGAfzrd1UBho9sXfaw1OySsoal0I
	8Jk50OrRc9caqZiuExJdQqGxSVoWV/IMQr3wWmg==
X-Gm-Gg: ASbGncsYydjnBq+x3tgtVHRgDXeX3jG2Bj0d+CWZWrLZlFo/8BCDZAl2P7/GyfvfJyc
	FkWhwdKr3aMeFQB8p4hQUnmrQ6tfWIVTYkHrQPYpPws2V3OQ8JmcQh0AntklStfVpRVtX+9L11f
	rOc1SNaMQH5A8M/CoLEfRDYbXNCDHtAA8=
X-Google-Smtp-Source: AGHT+IE6dZiqGjVqQyApS4pbcBalFyHHbwwvSoEvnbF7u5bEK2A/GpSwhcwNVYs+CDOmzCE0rRDdqSfuQIhXOHmw+f0=
X-Received: by 2002:a05:622a:1a93:b0:494:6eed:37b1 with SMTP id
 d75a77b69052e-4948732d7bdmr32223981cf.7.1747127706802; Tue, 13 May 2025
 02:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421013346.32530-1-john@groves.net> <20250421013346.32530-14-john@groves.net>
 <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
 <20250424143848.GN25700@frogsfrogsfrogs> <5rwwzsya6f7dkf4de2uje2b3f6fxewrcl4nv5ba6jh6chk36f3@ushxiwxojisf>
 <20250428190010.GB1035866@frogsfrogsfrogs> <CAJfpegtR28rH1VA-442kS_ZCjbHf-WDD+w_FgrAkWDBxvzmN_g@mail.gmail.com>
 <20250508155644.GM1035866@frogsfrogsfrogs>
In-Reply-To: <20250508155644.GM1035866@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 May 2025 11:14:55 +0200
X-Gm-Features: AX0GCFsg_IXaIo9w2jh-HmI1-M2cVqc9zT7I6qGhspawMoCH4j3pG6URFnq5ts0
Message-ID: <CAJfpegt4drCVNomOLqcU8JHM+qLrO1JwaQbp69xnGdjLn5O6wA@mail.gmail.com>
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Luis Henriques <luis@igalia.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 17:56, Darrick J. Wong <djwong@kernel.org> wrote:

> Well right now my barely functional prototype exposes this interface
> for communicating mappings to the kernel.  I've only gotten as far as
> exposing the ->iomap_{begin,end} and ->iomap_ioend calls to the fuse
> server with no caching, because the only functions I've implemented so
> far are FIEMAP, SEEK_{DATA,HOLE}, and directio.
>
> So basically the kernel sends a FUSE_IOMAP_BEGIN command with the
> desired (pos, count) file range to the fuse server, which responds with
> a struct fuse_iomap_begin_out object that is translated into a struct
> iomap.
>
> The fuse server then responds with a read mapping and a write mapping,
> which tell the kernel from where to read data, and where to write data.

So far so good.

The iomap layer is non-caching, right?   This means that e.g. a
direct_io request spanning two extents will result in two separate
requests, since one FUSE_IOMAP_BEGIN can only return one extent.

And the next direct_io request may need to repeat the query for the
same extent as the previous one if the I/O boundary wasn't on the
extent boundary (which is likely).

So some sort of caching would make sense, but seeing the multitude of
FUSE_IOMAP_OP_ types I'm not clearly seeing how that would look.

> I'm a little confused, are you talking about FUSE_NOTIFY_INVAL_INODE?
> If so, then I think that's the wrong layer -- INVAL_INODE invalidates
> the page cache, whereas I'm talking about caching the file space
> mappings that iomap uses to construct bios for disk IO, and possibly
> wanting to invalidate parts of that cache to force the kernel to upcall
> the fuse server for a new mapping.

Maybe I'm confused, as the layering is not very clear in my head yet.

But in your example you did say that invalidation of data as well as
mapping needs to be invalidated, so I thought that the simplest thing
to do is to just invalidate the cached mapping from
FUSE_NOTIFY_INVAL_INODE as well.

Thanks,
Miklos

