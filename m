Return-Path: <linux-fsdevel+bounces-47792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B8FAA5996
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC5E7A73E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 02:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D6D22F75D;
	Thu,  1 May 2025 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyIVoeUU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945222DC782;
	Thu,  1 May 2025 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746065631; cv=none; b=cK51N9/j4Yn3QaItucfvrAauHQz4GkN9xvM5BCmm0x3gj4XHBayYEYjdEsqVo21t1+TsRvOXV68oN0V8Vq0AW2xJewjTVj8niBiRLmbCyyg3Mlw43kXZK7H5ErLXQCRgfbDyFJ665rqNH/BQ5P6PrCdWYWjH0BaUKbYy8QRfDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746065631; c=relaxed/simple;
	bh=IXL7L7GEzmRTgpRI7W6C+cM7nwoU1zodTrcRAWVG/RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFtNF2o+pZTPBXJqpZHlBCENkBl9WAwH1+61QtVVbMMN/L8CMghj4VMoMbQ1aFwMtHxCw5FungNtEEvnZ/uJrKZqLSteaXniDtbgFDL42glD1/oZ+2IdNDXQ3ZHFI97KfRlKQa9qHWmClNukn9+kbfN+VrAw/qY+/QWhxPODW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyIVoeUU; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72ecc30903cso300997a34.0;
        Wed, 30 Apr 2025 19:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746065628; x=1746670428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXdPE0dAK6WPnTA+7Y1kfcDmuDvdGOZCfAYjmJvCT6s=;
        b=XyIVoeUUZCaRM8EhzzdIasPytauhPQEUby8+kPXUQaP6+7ikB7qohQoTiCYpFCZzz4
         dsMpscwh6qrSAlzdKNLxhKyuq7THG8tTz41bXCw5JAgT1PJj7EpdeRiNRjTUTWvazKuc
         h6t9FqjSo+Xtit5RBj9rPnf3rpkYn4OvMRtpmviod1E1UjJglPalNkWz5O1nt/ZAQEMr
         6YFsid1fnYpXGH1uDXrUAEkTi77YYqCMyAqbnw+6m/JgOKA5b0I3VP2yj/IH3emQqw6s
         ouZEcPJ0fJSCWTPgKXsF95X+RU3i5LzgbHuSw/0aI/y37CZSYxNsmAFmafq01Y7KUEYQ
         +MSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746065628; x=1746670428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXdPE0dAK6WPnTA+7Y1kfcDmuDvdGOZCfAYjmJvCT6s=;
        b=gAJI0/ynwecudn8s/osQNYjn3w2qsnSjrZ+U7nPTaFsvqt52Dma41MZwoNuG5A8OIx
         xVZ3QXzo9GrmP73uXDXkH7qqGVIf1MCXQQb2+zrSA83zUdC1ODTY2dZ6+XhNpaOJpPJo
         EZfVCridJRygyEO1+6upgFzwvxpxYGy7Ckk8Ua61PMw+9XjVeI2hy5J3s6Zq/HS/zQh4
         M533hwSeFh0HL//4ZiL+b1FBhRZMJc4rJ31/SZ6R54ifpm+loODxrg7iWPiR40bpFSEv
         0X5YL9FfHjYL/gfZ5v4hBAkTh3er2rt/mn5ZyEKevzAOZQvNskfSjhJbTCjQpjTHrLeF
         pzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIOUaEsn8YrZLjCt2GF8lO5NOzdJT8pLgVt0Jz0TYIdQhdR6vrjfUdpuuQT0WnMG3xuuvTh30F2qgo@vger.kernel.org, AJvYcCUQbQvz7tnhtyA1YrEX8tcUV/pxn5AujwTR7VNo2A3dov8M0MXhj4erIrQIEuAi5J45Nsba6xyKCBA=@vger.kernel.org, AJvYcCUaxTFCPZFULmWDNC1Lzo3CrZuKIrB/6nxFnXkkbgslOnm7lqgnYKX9AUP7ckwH2vo5YSBBJK7DMA9thWeLng==@vger.kernel.org, AJvYcCWvi20q77XzS0ZI4GezQCTyRvUHCuXcjP4ciSOdoeX16PiBQH6XT3wpEMZa2SuHQeoIIALyTqFmT/Wep/Zi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxof/Ph0MI5RBZzqaUWbpVRcO3PCHcfbT5MXBzbLT68/0fPkSn9
	K/LFANn1Qk9J6SLgHSd5tDV3n7IQVRufQfLl7PnBHkkWaCElcIi+
X-Gm-Gg: ASbGncvc0j45TxX+pbm/nOf9yAMYMRJFLRFgOBeGkhyTIZmG26BsJHS7jGZAAUTzILE
	liVGkCXPhPj9Ak3fHwTjQk6kJODtR87cfL5t8kdoKqtp625lV5eriH839ZUuTjjGmQrN5Wg/Chy
	9AluiqTsPaBj0YhqO4lALOZk0DwVJpuWMkCp6FblZf8YBXbIEtuY41x6UidInoif5/GxvnXGxaf
	YS5qz6qJnOJC3xtKgCm+wG+7TXhpHZFfVvtmn5hHFGMKK3m5Fq+6+BXLuEg6rhlmXh2jII0+2Vx
	hpPKVMgaQ8HK837CvSuviRPCxoGO987HJ/fKmoJXafG76f056Ga5y2+gIqfBDueifc0WMi5SwPJ
	ggTsjUFFp
X-Google-Smtp-Source: AGHT+IEmR48bt7XEiYsncU5O4Q5GIS0VjcmLqFK0GdoL7joQ9ta5UZGYwgpLnkZ5GqCYSdv4P6TBYA==
X-Received: by 2002:a05:6830:3982:b0:72b:9cc7:25c4 with SMTP id 46e09a7af769-731ce3f9330mr690833a34.22.1746065628499;
        Wed, 30 Apr 2025 19:13:48 -0700 (PDT)
Received: from groves.net (syn-070-114-204-161.res.spectrum.com. [70.114.204.161])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7308b117371sm1140234a34.16.2025.04.30.19.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:13:47 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Wed, 30 Apr 2025 19:13:37 -0700
From: John Groves <John@groves.net>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 00/19] famfs: port into fuse
Message-ID: <n4idslcksqlegd5e2nyggyzahwhgfh7qqsh3qni7fgpj342ohr@do2fu5pz7fsv>
References: <20250421013346.32530-1-john@groves.net>
 <20250430154232.000045dd.alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430154232.000045dd.alireza.sanaee@huawei.com>

On 25/04/30 03:42PM, Alireza Sanaee wrote:
> On Sun, 20 Apr 2025 20:33:27 -0500
> John Groves <John@Groves.net> wrote:
> 
>> <snip>
> 
> Hi John,
> 
> Apologies if the question is far off or irrelevant.
> 
> I am trying to understand FAMFS, and I am thinking where does FAMFS
> stand when compared to OpenSHMEM PGAS. Can't we have a OpenSHMEM-based
> shared memory implementation over CXL that serves as FAMFS?
> 
> Maybe FAMFS does more than that!?!
> 
> Thanks,
> Alireza
>

Continuation of this conversation likely belongs in the discusison section
at [1], but a couple of thoughts.

Famfs provides a scale-out filesystem mounts where the files that map to the
same disaggregated shared memory. If you mmap a famfs file, you are accessing
the memory directly. Since shmem is file-backed (usually tmpfs or
its ilk), shmem is a higher-level and more specialized abstraction, and
OpenSHMEM may be able to run atop famfs. It looks like OpenSHMEM and PGAS
cover the possibility that "shared memory" might require grabbing a copy via
[r]dma - which famfs will probably never do. Famfs only handles cases where
the memory is actually shared. (hey, I work for a memory company.)

Since famfs provides memory-mappable files, almost all apps can access them
(no requirement to write to the shmem, or other related but more estoteric
interfaces). Apps are responsible for not doing "nonsense" access WRT cache
coherency, but famfs manages cache coherency for its metadata.

The video at [2] may be useful to get up to speed.

[1] http://github.com/cxl-micron-reskit/famfs
[2] https://www.youtube.com/watch?v=L1QNpb-8VgM&t=1680


