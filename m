Return-Path: <linux-fsdevel+bounces-40213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E646CA2085A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 11:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519F2167A25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741B19C56D;
	Tue, 28 Jan 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Zn+EXCn2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421781487F8
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738059413; cv=none; b=ifEh4rzplugP1nJDRS2LkkXoaJ/ccZmmf5wZdYrlfKTMk/lfOSYaQpHE5C8Mz/iosAMvO35TcQFFYXN/ST5240q/IUh34CM7pdcuSjn1pqSvM+8JOgLIoWYLR3EYKfHRVIxTpk5FEY+nNikmx6bI6zIgCXgh9bBjGwrjtzzN5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738059413; c=relaxed/simple;
	bh=Bxd6eRZDjlCh4aMUS56URxZUJKzQogsCRag1ROtaObs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIIElZsGktC5fL76NcpRlOHOBk0NyfOTIPgVual7v5aWHtOEbekQ8yqk7dEjawbiO8H7lrfERTztslbTyXvQcLhGcAOXVvXDCDVRHoCrDPDBOYJB7BQsRH3q2ZJRwyLC75zM0fGMnIK6Sb1ajh84Rkf1cMD3OrOfXY2KtzAE/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Zn+EXCn2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4678664e22fso47985011cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 02:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738059410; x=1738664210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BPEyMd98vNN+GRTzAXiHc1FCEhyXV1COXKz9r10gCRU=;
        b=Zn+EXCn2UPUPCi/Ws9r/GLnG5GhbQKMLndPIyUVKBlKYInMSCKW+lRWIiSR+c6JL2O
         QNSekftaQIASRe9n5ehbtbHJwQHtQGI5Tmfn3bvw4j/wW1lJnnCue7WnhjWutDz9+gjO
         w6GSLVlaeJrwiYx3yDoycMSFciuM2tID/MPAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738059410; x=1738664210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPEyMd98vNN+GRTzAXiHc1FCEhyXV1COXKz9r10gCRU=;
        b=p4C0h/eM/G55a6Rpk3Nljv2gXyvCN2XnRwBgt8hzLS4pBq1gpANx7gC8JRRVnLyGQK
         ecJJ5Wc7UBccGwV9DFXhgIc6ikTjKqJn9RxM9TCbW4KBXsZqVauz3T/v//EjdkbAxhux
         fZUDd0WGo8WPQKv3ttb5VLUoZE8hdstoaBSolUJsH3rH4jfEOY/I2rUKFqFPZXHqTnxr
         kn/UiM499lX3TPzKHXiQOrJfHucRP3uwGUyXeVY4CgNrdxRGU8pSN4J73dUZt+r8Gp2Z
         znvGagHfkVo5r4GkzyMj8mnkxD1PGEnvMDLRDaqsjcn2pCLZ5timxzTbQDPd4BxmU+/W
         d2zA==
X-Forwarded-Encrypted: i=1; AJvYcCVN4V5HYIWhVW4j4CQdJdo4sxDTIxxVNK3Ge8B5f7Bq+SpEwGcj0Dep/oGWt/Aq0nVnSJlcap5X0KHuoLUf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3b8TfZweiNMMlLkL7lgOebn8cgXiFGNOjnbWOOpiXkhSXPPfq
	dvuuSfuHuTmzxn+1WZYvxgyOu9xJHpKArA4i66qHyWw45ejwrUP27LhSqv+rVaX+s/r1+atO9zI
	An31jq6BFbsfAfICKLwTGTTkX7LQlMSS/lYT77w==
X-Gm-Gg: ASbGncvvb61yzS0zSafUyZJuLiy3oeBEm+OQjMhVx+YIdAvzfzLL9tjVG+Lb9DrfyZq
	GA1aE6nwWaSmO55vHrghJJow250NqDAqL6wg8DHPvGbaQJV/1AiMifPy0PGLnEc23VQ01Afc=
X-Google-Smtp-Source: AGHT+IEMiNHpXGXEKPmWrOqZT6qEgAQmHRQtdJwbZec6UMKf0O/ADxrUOeWzIO8I5hbB90zgwKZh8YB9ZwqdbLxH2Uk=
X-Received: by 2002:ac8:5a45:0:b0:467:5f95:679 with SMTP id
 d75a77b69052e-46e12b986e9mr562673851cf.42.1738059409912; Tue, 28 Jan 2025
 02:16:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com> <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com> <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com> <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com> <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
 <2848b566-3cae-4e89-916c-241508054402@redhat.com> <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
 <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
 <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
 <3c09175916c2a56b55d9cf61e4d8c0ea66156da2.camel@kernel.org> <752b098c-345e-4374-bf01-37193b402890@redhat.com>
In-Reply-To: <752b098c-345e-4374-bf01-37193b402890@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 Jan 2025 11:16:38 +0100
X-Gm-Features: AWEUYZmmF-5k5dD6SW6YMKFQrd4EmkWMa8Gy2a9g1PbqqS-FWhT17Hy-5YbTwEk
Message-ID: <CAJfpegvKrs3ROVooDT6tifyWBco9=fwZW0SobuyBxe1McNHEZw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jan 2025 at 13:29, David Hildenbrand <david@redhat.com> wrote:

> Yeah, that was one of my initial questions as well: could one
> "transparently" (to user space) handle canceling writeback and simply
> re-dirty the page.

1) WRITE request is not yet dequeued by userspace: the writeback can
be cancelled

2/a) WRITE request is dequeued (copied) to userspace: the page can be
reused, but the writeback isn't yet complete.  Calling
folio_end_writeback() is lying in the same sense that it's lying with
temp pages.

2/b) WRITE request is dequeued (spliced) to userspace:  the page is
referenced indefinitely (could even be after the writeback completes).
Temp page could be allocated at splice time, which means performance
will be no better than with current temp page writeback, but at least
it will be less complex.

3) WRITE request is currently being copied to userspace: this should
normally be short, but userspace can be nasty and have the buffer be
an mmap of another fuse file, and make the copy hang in the middle by
triggering a page fault.  The request cannot be cancelled at this
point.  In such a case the "echo 1 >
/sys/fs/fuse/connections/##/abort" mechanism or the upcoming server
timeout can be used to shutdown the filesystem.

So this is definitely more complicated than I'd like.

Thanks,
Miklos

