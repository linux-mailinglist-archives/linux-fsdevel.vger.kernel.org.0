Return-Path: <linux-fsdevel+bounces-49225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39655AB99B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFF53B5D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F7235040;
	Fri, 16 May 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Q2yObfd3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6A223371E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390019; cv=none; b=J6fphgD4rao9UHwb0amLaMkOiLileOcYVLAwtpCXcQWz0CdS7kNkuzIyTNDkYvgFabOFSiI0QtY5lDf8XeyLoMXcrpwNohYl+/YMVdsnTfGapdB1xSrQ+HSN0AWFohDRNgNpQiyWPjmXcy79vKmdeaMRuAHrhTbIzef+8lKHz2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390019; c=relaxed/simple;
	bh=PZ1hzhVLhPa3dLDbMLplQU4Z4StkFXuYbw7/HI9oWu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkoxq+HasRX32V/G1m8kPL5xo5sigfhaFeX3qWLHyHQ4lOWAs8C9jpzK2Jtm+ohDfi9N910mNdz0fJ1c30ycXklGvkD8JKisHwtiAdryPKw9UnTJjFMDLS/tQmAo0t2w0L8obruckI3hzeoQ5OxKX4nP3pAvNhMtQOGBvkXS81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Q2yObfd3; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476b4c9faa2so27974521cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747390016; x=1747994816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sYr4H36z0vOGSYanC1w0/PBFKEWt1tWAZvghYgV0VXg=;
        b=Q2yObfd32ppE92QCNh3FmQzpGJVQIMNxEUm6x5bXLgiqgoo46K5nyHKNOjGcAqbemp
         XCzovOtqA5NEaBLxS0I6sqJRDmdqHGQJ34ko+evlxLbg9MjtbqSGRDdCtThEDw2qLt3/
         bnigLsB8NS4D6wnRo4FM3E1HTAe1FzaZ5BZC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747390016; x=1747994816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYr4H36z0vOGSYanC1w0/PBFKEWt1tWAZvghYgV0VXg=;
        b=IL4lAbG6dlugTDHMkB9PKEUN7o08u6cgaLATTirJW7KhAlRkq2LBhtkSAuoxDnHYXO
         spaggLXbtQ4wkeuTdzFIdTFJ4AwHNpe5PxCN0kq8YQkBIWnO4F1558FuMU21IctIlAbb
         Ros+TT/IIMJ9koEx8HLNwuZ3Smef0h18X9cDvfXA81ceIB0vEw//epNWVeXQFKfYhZlO
         OOzw22bcOwQGMxJuDqryKgkj143L8gGi/eJKJYfyxAMSmA1Zqvu0ix5I1ltyEVOaxD/C
         NohadONb3+XgFddxYeyjARx6u6VSeXZC/oKRjzYXg/IqaVuWB0LLmAweOZvu+3ydNXy4
         SVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlyO+uPL9Vouq0WuPZjecKTicYS+eQJPxDXeMrUhsHhXSsHQI+58lsohwiYYqO18166hdpfT2iV1hs2166@vger.kernel.org
X-Gm-Message-State: AOJu0YwDa1f8m49s8bWXKrEE5CDaqVzzkQ9ryk8YisGgbvrfOsc6hCt9
	74qFJtiFcdmaUtnnp4hJMZ1X4CG3urjaLNTjU207E/uU35abssZXnaWBr6JztK181RU1MZvZN2Y
	OMvSYgrZaufovm+WpL4xRDrc8xeUvuvnhavzVNrX5LQ==
X-Gm-Gg: ASbGncs2Dp0QpewFkAFdz6KxquJ7z3ux98CB5JJW/V5vg4VrWnuEczQlmlf4ynnDKn7
	VCO5p350THDZslpJ9GLq3mbM+6Z82+f1MNBWDfHxBA+C6lh3uDfTCY9zIR/KcISaYRiDdjsyfTx
	a+i9Wf7+sP+5yA+V5SizurJShs9+9Sycw=
X-Google-Smtp-Source: AGHT+IFq1iLsujGv3MRAp/42wUNDp8Fjtx0tUWAIAmM1RivLIsnYNC1bAGTr6piq4vefDLhpVhUdj5QcvATegQP1E2k=
X-Received: by 2002:a05:622a:1f9b:b0:477:13b7:8336 with SMTP id
 d75a77b69052e-494ae391ca0mr49345951cf.17.1747390016120; Fri, 16 May 2025
 03:06:56 -0700 (PDT)
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
 <20250508155644.GM1035866@frogsfrogsfrogs> <CAJfpegt4drCVNomOLqcU8JHM+qLrO1JwaQbp69xnGdjLn5O6wA@mail.gmail.com>
 <20250515020624.GP1035866@frogsfrogsfrogs>
In-Reply-To: <20250515020624.GP1035866@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 May 2025 12:06:44 +0200
X-Gm-Features: AX0GCFvDzLpmkF12kGaynggeZWP00Cr6BBFBchrM1Bqzro0NRWRGfjqCVUyzE8E
Message-ID: <CAJfpegsKf8Zog3Q6Vd1kBmD6anLSdyYyxy4BjD-dvcyWOyr4QQ@mail.gmail.com>
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

On Thu, 15 May 2025 at 04:06, Darrick J. Wong <djwong@kernel.org> wrote:

> Yeah, it's confusing.  The design doc tries to clarify this, but this is
> roughly what we need for fuse:
>
> FUSE_IOMAP_OP_WRITE being set means we're writing to the file.
> FUSE_IOMAP_OP_ZERO being set means we're zeroing the file.
> Neither of those being set means we're reading the file.
>
> (3 different operations)

Okay, I get why these need to be distinct cases.

Am I right that the only read is sanely cacheable?

> FUSE_IOMAP_OP_DIRECT being set means directio, and it not being set
> means pagecache.
>
> (and one flag, for 6 different types of IO)

Why does this make a difference?

Okay, maybe I can imagine difference allocation strategies.  Which
means that it only matters for the write case?

> FUSE_IOMAP_OP_REPORT is set all by itself for things like FIEMAP and
> SEEK_DATA/HOLE.

Which should again always be the same as the read case, no?

Thanks,
Miklos

