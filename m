Return-Path: <linux-fsdevel+bounces-49600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA7DABFF89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947AC4E0ECA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EFF239E9C;
	Wed, 21 May 2025 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt6P5Amh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF81D5151;
	Wed, 21 May 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866619; cv=none; b=L4SCd3fFWw7Lw8Z2fb3cPDTq8veJiRNB2LeqZFf7rNoK77bXRmvqEFZ+az6EsjU+l1Lyyt+24XzsuxVKMRVLDg564/3xtY+GaUXryrOcseqhcgkEyD8O9PVrky+jyxF8xOdDfej3orjKUQqaj7wN5UgGe9Oz2nioknjg4mHcQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866619; c=relaxed/simple;
	bh=nb9O4TtCOuppud69ug4IkU6bS5EpzMCb96C4mzfPqcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJc0C2yCLsusDJaXZF1BxodW5ROmB9p6vhAkGwwoe3KjYJZIK24dyygm2JdxUF+qRMcrvQwCXqTsiNaUP1CxYTehrApkAJK5zJLXrBel0L7Yz3R0SnMdODBtbJkRLv4aUNP9znwg1btAXXI7h6o/nA1xEkav0+m8L0dnE0vvXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt6P5Amh; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-404a5f4cdedso1930703b6e.0;
        Wed, 21 May 2025 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747866616; x=1748471416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nb9O4TtCOuppud69ug4IkU6bS5EpzMCb96C4mzfPqcs=;
        b=Zt6P5Amh5rIldEFh4iEbcqods8og4Qf1BbPcNY2ZLIqzzSfeOo+Yp36TjzuAyWChAB
         AqjWocatQ+ARc3RQ3QBzUm7HlcL6+D3AfUvG4peebDN/Neh4A+/KS6gncG3shn/pTW3j
         6G6UN4v7cl1zl5xt297RVwTblj403yrTwH3gpjMobeT6oKA0vT9wLFz08tdmywBlAt8j
         ngrdCAAhQ3aCZO9xOqN7t0hvcPpRWZJpG70eUr3xNbZ92r//MkfCgmD6JEmLRpCE5jbn
         ukwEv/T413GR6dGIRPcdXlXqqzDtotIj6GRCtlt+/PEK5ranA8SZ71LIigMOs9WtQO4r
         H9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747866616; x=1748471416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb9O4TtCOuppud69ug4IkU6bS5EpzMCb96C4mzfPqcs=;
        b=Co0Y7iBi+mgWRYJrmt9/HZLGAgxzL/AUEczJrI8eeHGSIC4FaAA9YhLe/KEtw4ZXK3
         r++3SOzWywfhDV5qbxynNM3NXbr4npixOb6MiF2WZUR3NJkd44m1C/9roDO/ihUez+25
         z/1H1JPZYAia8ka1E4JSuxCUd6g7QH3tgZEPb7dYTAHz19Iv7869LFDM2tffjJ4pzV/L
         cYZppDQKPvPEkTJo9fAyLaVOo2bNJJ4ao9+jmLs0oJwbf59tTw84Pc0Ehi19dEbIt2tH
         bQhm+aE8oNB1x4PvnT4RzpO+WQYIJfjPd9ANJsHHP9h+Q+3XX8yRLpUqaX3HYK4+0Z/K
         bduw==
X-Forwarded-Encrypted: i=1; AJvYcCUJLZ4ORGUHw/ZyTGGhYvMKRuIOq7XJ3h+fn+PR9Djh39+mUT62PGFTG1pjuC2ulnwoJnavLls4GnWe@vger.kernel.org, AJvYcCUKw/IVsaO5Fhq4GNqsG0R3EO+LUOkMBUtrBD67T0XD0s/breRFFyUcvEFXoVxJJKgukyxbwCsbdwU=@vger.kernel.org, AJvYcCWVWdol9rc9EfVgvnGRp4h9nf4244poxSqebsbSn3LVsrYvdt8W5KSsEHg13s4AwJyr5wGwUF004lDxnz+ing==@vger.kernel.org, AJvYcCX/rYEcd8Cp1AXt9mk+K2UkJdm/qPsGczroQrkf1rZqQqM1pmMmfmDS236gmqgXz27ylu3pR2aq8WLkv479@vger.kernel.org
X-Gm-Message-State: AOJu0YyGSmQStp25bHIYJlQPjteZB6sfnrW7js7QwTdRUbkyghJ4YbGn
	xNfkfePvcQwGbGuY6zxnSalHsiDtgkKOvw8pxisZXAsEe9gv/k0LqPYB
X-Gm-Gg: ASbGncs/gkuOx1z/qmZnSxYFOC2w7qZr0zYitI4vpSBCidd8Op7nxooyeUh3fpIWx5J
	7+OhE9skCZR2j6zBefnfpmCbNVYnh/tnC6K/fGh+r4SSnAMeprpFnN/LTd3+tSbdEBZ9oUufK8d
	k6hHV4zdjh5utz3C6auU55UJgnEWplOEhLv8QXHnQYI9ZkuT+23dw9N1b6vGAD3i+WflSSYfIZn
	1cE+QhA+iaWjVbBM8wh7y7r5n029zIOMRH8+ykpjbVbw4DBJ4Nzh9DjB760isHQ434GU/FkDpUT
	QTeumovuiQmDtyXDM5MXHTQGYXdOniqo7+jfBWdSnPgRBnN2KIqYRaYnZwhIIy7wfvvVFxA=
X-Google-Smtp-Source: AGHT+IFRVrKFlC0xucIoI6A+MH0Ub4hMMxnTf/HTOcSeOiiFXD7vWW4zpucHXKEWzpbcRbmwqIHzEQ==
X-Received: by 2002:a05:6808:6c8b:b0:403:37dd:e26f with SMTP id 5614622812f47-404da82bb8dmr14303754b6e.33.1747866615474;
        Wed, 21 May 2025 15:30:15 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:b8ec:6599:4c13:ce82])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-404e303ffcasm2023067b6e.4.2025.05.21.15.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 15:30:14 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Wed, 21 May 2025 17:30:12 -0500
From: John Groves <John@groves.net>
To: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
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
	Ajay Joshi <ajayjoshi@micron.com>, Alistair Popple <apopple@nvidia.com>, john@groves.net
Subject: Re: [RFC PATCH 00/19] famfs: port into fuse
Message-ID: <hobxhwsn5ruaw42z4xuhc2prqnwmfnbouui44lru7lnwimmytj@fwga2crw2ych>
References: <20250421013346.32530-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421013346.32530-1-john@groves.net>

On 25/04/20 08:33PM, John Groves wrote:
> Subject: famfs: port into fuse
>
> <snip>

I'm planning to apply the review comments and send v2 of
this patch series soon - hopefully next week.

I asked a couple of specific questions for Miklos and
Amir at [1] that I hope they will answer in the next few
days. Do you object to zeroing fuse_inodes when they're
allocated, and do I really need an xchg() to set the
fi->famfs_meta pointer during fuse_alloc_inode()? cmpxchg
would be good for avoiding stepping on an "already set"
pointer, but not useful if fi->famfs_meta has random
contents (which it does when allocated).

I plan to move the GET_FMAP message to OPEN time rather than
LOOKUP - unless that leads to problems that I don't
currently foresee. The GET_FMAP response will also get a
variable-sized payload.

Darrick and I have met and discussed commonality between our
use cases, and the only thing from famfs that he will be able
to directly use is the GET_FMAP message/response - but likely
with a different response payload. The file operations in
famfs.c are not applicable for Darrick, as they only handle
mapping file offsets to devdax offsets (i.e. fs-dax over
devdax).

Darrick is primarily exploring adapting block-backed file
systems to use fuse. These are conventional page-cache-backed
files that will primarily be read and written between
blockdev and page cache.

(Darrick, correct me if I got anything important wrong there.)

In prep for Darrick, I'll add an offset and length to the
GET_FMAP message, to specify what range of the file map is
being requested. I'll also add a new "first header" struct
in the GET_FMAP response that can accommodate additional fmap
types, and will specify the file size as well as the offset
and length of the fmap portion described in the response
(allowing for GET_FMAP responses that contain an incomplete
file map).

If there is desire to give GET_FMAP a different name, like
GET_IOMAP, I don't much care - although the term "iomap" may
be a bit overloaded already (e.g. the dax_iomap_rw()/
dax_iomap_fault() functions debatably didn't need "iomap"
in their names since they're about converting a file offset
range to daxdev ranges, and they don't handle anything
specifically iomap-related). At least "FMAP" is more narrowly
descriptive of what it is.

I don't think Darrick needs GET_DAXDEV (or anything
analogous), because passing in the backing dev at mount time
seems entirely sufficient - so I assume that at least for now
GET_DAXDEV won't be shared. But famfs definitely needs
GET_DAXDEV, because files must be able to interleave across
memory devices.

The one issue that I will kick down the road until v3 is
fixing the "poisoned page|folio" problem. Because of that,
v2 of this series will still be against a 6.14 kernel. Not
solving that problem means this series won't be merge-able
until v3.

I hope this is all clear and obvious. Let me know if not (or
if so).

Thanks,
John


[1] https://lore.kernel.org/linux-fsdevel/20250421013346.32530-1-john@groves.net/T/#me47467b781d6c637899a38b898c27afb619206e0


