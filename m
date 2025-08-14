Return-Path: <linux-fsdevel+bounces-57869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0026B262F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090983AD4A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E792E8899;
	Thu, 14 Aug 2025 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="O/GOHdyW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6BD2D7383
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167842; cv=none; b=q7XhRimkFtaCrRhXIOEvrdt8ZL92H+uz6pX16fHe4UELtnCgLfhmFZix+Kx1birlkqG8xXVPPdZumqokgE7Q9IAvBVybqnkvkWx1Uy751KC4Bp4RjjYne4tyPihWzwzQ7RxSiFCk80jqpx1FoKupRWY8TmxyxLhSH8EOshO6mbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167842; c=relaxed/simple;
	bh=2z4KHp3G9a5b9AfVC4TLzGl8oU7ja1D8uVs4f94B57E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjgRpUh6b2L1+LqQx3/xHtcBZ4oDomp71bPSjNhrCv8oLiwRw6ScCaK1vmKRycMTkZ/rr30FvL5RFMRrei5gD8Y/2IWQqi3/6Lp87xE+ITdLRIODp00RCbz2bZO7CGKhCdUB+s+IUJv03oZpuciXTzl0PP5wCWZTVd75UUxItQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=O/GOHdyW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e8704e9687so76663385a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755167839; x=1755772639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kfg1xdeLOfyreKnr328hQaYYjz2z+mng0dgiwOWK8Ho=;
        b=O/GOHdyWZapd+Nae4I8AkqAIRlDiXTWapC6/jH6o4x70+cSV5xWtCGGTblvSY3gApB
         QHc/mOyfbM+ZTYQ8ptVLzn1NDc4xewRyPkMC87FPDYgcd9c6qEFXD6RSyGE8+s0oo4AX
         rhkrWHIK/1AfLWZXh1yFCv3TFLmRVPrORiMp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167839; x=1755772639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfg1xdeLOfyreKnr328hQaYYjz2z+mng0dgiwOWK8Ho=;
        b=vvt+1WqRHFMzg83MwuPTihxa+PgZ8tU5TPbdE/eeTmw1XVZsyTk+E16ieNKCCtnz0L
         jk902DPj3hjVNXpkFx0S4uwZrtA7si0RrsL4xseglyhfnS2ZeSc5TZJ1Yw/3yyxvATFR
         W/VYpSUA6BhE+ubABU5DJ8b75AFM7dzO27nXXmNYckYG7wZoh0QRSd57RmKXtws2LMus
         5kBuWIyYtQp2kCTXmt2kDYAL8DIZ1gPJ/pj9iokv1dfaepF48sjzxq6eES9t2GvLjhUd
         FAceYL+Tc7aFO+xWJJ/SzZ9dOnp/cLBRmnEaCaxj/S8Q+UbYncyjk53L91fvP2dabNeM
         CUdw==
X-Forwarded-Encrypted: i=1; AJvYcCUzG5K1RBcwijjKYN95onV7eNh6fxXI+qcdWQrcpUmDrc+mkV+XDQOS5MYABibKXwyleufNI8O9DkPx/oLL@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAUzLwAzv7pbuaIEQroXT5za+VCDyKtMjV5M+xzRSNc56iXJ2
	IXuKm9uyLAVvRpwomY+3O5I59YaIRFn1z3G6rJmw0dnMUVFgc3sTkD21PS0BYaLLHB+LYT3lI5o
	ouGkh8bBV1HYDhwJPZ258HLbugsDZQjQ7qHmvczBj0Q==
X-Gm-Gg: ASbGnctidvHPr76wWC7XX/pQswRJ22kGHV3hXO4JVU4pHXwaICZWrjxPS4pp0PrRP3y
	82Q4YcypBGzVwg/6I7DlqDRSaqkt6VcJdJed/9HaIYB4hXkjR6jaRbhaTyRMB/b4PXMdH+Kzacf
	8qJ4hTHsC6nufhAw7xgRgLm6nH6iEwa2nr79CMkxvj5X7KiF/PTDhLF/OKYpNT3udVNQNbokFne
	86q
X-Google-Smtp-Source: AGHT+IGCyQ+LrtnuvvD4cnfS9KWxmodF+LtsJHdOQQ03BWq4ghzPdSAt/rs4hdQANvXyGJmp0NayklHjGgL6sn9UaHM=
X-Received: by 2002:a05:620a:17a8:b0:7e7:f84c:9d65 with SMTP id
 af79cd13be357-7e87066e73cmr321505585a.38.1755167839208; Thu, 14 Aug 2025
 03:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-12-john@groves.net>
 <20250709035911.GE2672029@frogsfrogsfrogs> <ttjh3gqk3fmykwrb7dg6xaqhkpxk7g773fkvuzvbdlefimpseg@l5ermgxixeen>
 <20250712055405.GK2672029@frogsfrogsfrogs>
In-Reply-To: <20250712055405.GK2672029@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 12:37:08 +0200
X-Gm-Features: Ac12FXw_tUJvAdswzhdrUe0cP4gCxZqTC0WTTpEt7BoMabiUDl0tjdFveoca6_Y
Message-ID: <CAJfpegspQYVbWVztU5_XFwbGaTQKe2NCm2mcui6J3qv1VDxdSQ@mail.gmail.com>
Subject: Re: [RFC V2 11/18] famfs_fuse: Basic famfs mount opts
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Jul 2025 at 07:54, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, Jul 11, 2025 at 10:28:20AM -0500, John Groves wrote:

> >     famfs_fuse: Basic famfs mount opt: -o shadow=<shadowpath>
> >
> >     The shadow path is a (usually tmpfs) file system area used by the famfs
> >     user space to commuicate with the famfs fuse server. There is a minor
> >     dilemma that the user space tools must be able to resolve from a mount
> >     point path to a shadow path. The shadow path is exposed via /proc/mounts,
> >     but otherwise not used by the kernel. User space gets the shadow path
> >     from /proc/mounts...

Don't know if we want to go that way.  Is there no other way?

But if we do, at least do it in a generic way.  I.e. fuse server can
tell the kernel to display options A, B and C in /proc/mounts.

Thanks,
Miklos

