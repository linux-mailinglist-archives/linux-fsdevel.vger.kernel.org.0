Return-Path: <linux-fsdevel+bounces-25351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A894B040
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 21:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855A71F21011
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 19:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CCE14036D;
	Wed,  7 Aug 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oFG4La+K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9A163
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057477; cv=none; b=XwcslvjcXMBcsvsptjDhbYNcpTqnaM3ku93S3+y2DkEsRDo1lXkOEb7lWzJ+eDYmNolvpAH1UNxLXQG3RVCC8smBGpxPiNs+zUY/4RixgYW7/35+hF/8nVqDX/bqbUWTR8gzKUfYGexfvgXUOTq2KPrHBD6vqG3He+IHz6ieuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057477; c=relaxed/simple;
	bh=NdLbJhVjxwyZFpx90vWSf6yQ7UyqHrB2pQu2ij4yRPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjpPw7NuU7IlMv0N8Hi23qvdbQJ8BxTqUUJgCnic5gZIMn6PLaFwB/Y/AOR2QjSOBkvQtxD2ZQ+2DAmhAqSWLehwhUSgedSN/0Ff4F7NO2V7lK+yrKMFK4ygSSov3HQwbBJ06JIDevy/PbQn9b65qjIlwDb33JQrbme6flfu7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oFG4La+K; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d3874c1eso12544285a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723057474; x=1723662274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgCFA05zRFlcxnDPnlibiuJKldFKiARyf/dV1s3k8oQ=;
        b=oFG4La+K0tu3NkIBokhVe3cn6X5Sxqfoi8/ioHkZPt6jEzJLBTvrOn5TLnJq1gJxjX
         74XVi70mBOtxDyn4acmy7YkzqTMGzEQW0qBBNtxqY8l9fC8049Iz50gibXkJ28qyluXU
         ajktShp39fHzTx8XNUQpQcg6QYEfVKhhfxyqjSkVvcJ/D+VY5ySDaKWvMBj3ZPV6BVg4
         bc/RlaQ371cqN0WBXbFHt99WKbxIQPFEsz9VMcYU4M0S7u2l/KM4fB8DLrY8mBsEiB3v
         hbDHVtL9N3OL6b5rWRUOzX4q1kNiPkL2i1UI8VglKMmJkdxod76k/Itvuhg2ydbdGhgT
         qx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057474; x=1723662274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgCFA05zRFlcxnDPnlibiuJKldFKiARyf/dV1s3k8oQ=;
        b=ikdUYCiBgmJ30hoxQIeoepV4rlVYPaNhF3DkfmW1QFaNTJgpEU+wlkhcxR3qW8kf3V
         vDd7JW4PNQp/Uc5+mhvBPWvhTOLey5QHOjBwqjMgsP1W1oBUlf8w3d2rlfx3AY6JYSei
         4D/szXovMJztuwMEiDIYFbpdyb5l3TFCFLjUj8HekILXPWJmXMoysXptNMEPDPsripSw
         dSG4Y30SIvwslPLp/t1N48rB2qU4+Q/8p1Aj+5lfkU2sgh/RUqIUNSS028eJqREzbV9+
         bpHvO+PWzPN/Cl5jOrQNZNfkaSDf7CT3b+6W9u3DBApog7ZH88Cdj19sd+0Qar0XNSh4
         UASA==
X-Forwarded-Encrypted: i=1; AJvYcCV4hQcPlaUypwEsyitgm2C2YdSz6y7xSNvTG8byN+Gvpi9SODgXXtLmWezlwZLWhVmcqmCMVqPc3+yPJ3E13mT5abDji6JrZ4X/y9Agdw==
X-Gm-Message-State: AOJu0YyOuPm8HZ+eLsJQqOYa+725lg3YLyE6HaHtv5+S0+fN123jMNep
	mh2toxe4zclRzL5znLZCLlv9eGRKQMvpyqhiM7/yyeFMiDqcCMzVfFjqDliDBLo=
X-Google-Smtp-Source: AGHT+IGHnhhAx2038u1Fhmc2aQxa0yNzcLLqhNNaEa6hdhBGi+hf62WdVQLP1T1X41AKVAYMaX4Kug==
X-Received: by 2002:a05:620a:404a:b0:79d:7506:f194 with SMTP id af79cd13be357-7a34efac369mr1992797285a.48.1723057473576;
        Wed, 07 Aug 2024 12:04:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786c1c34sm84528585a.106.2024.08.07.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:04:32 -0700 (PDT)
Date: Wed, 7 Aug 2024 15:04:31 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jan Kara <jack@suse.cz>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org
Subject: Re: [PATCH 10/10] fsnotify: generate pre-content permission event on
 page fault
Message-ID: <20240807190431.GA274047@perftesting>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
 <20240801214025.t5zjblmdjreheab6@quack3>
 <20240802160357.GD6306@perftesting>
 <20240805121349.i4esnngbuckbpdea@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805121349.i4esnngbuckbpdea@quack3>

On Mon, Aug 05, 2024 at 02:13:49PM +0200, Jan Kara wrote:
> On Fri 02-08-24 12:03:57, Josef Bacik wrote:
> > On Thu, Aug 01, 2024 at 11:40:25PM +0200, Jan Kara wrote:
> > > On Thu 25-07-24 14:19:47, Josef Bacik wrote:
> > > > FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> > > > on the faulting method.
> > > > 
> > > > This pre-content event is meant to be used by hierarchical storage
> > > > managers that want to fill in the file content on first read access.
> > > > 
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ...
> > > > @@ -3287,6 +3288,35 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> > > >  	if (unlikely(index >= max_idx))
> > > >  		return VM_FAULT_SIGBUS;
> > > >  
> > > > +	/*
> > > > +	 * If we have pre-content watchers then we need to generate events on
> > > > +	 * page fault so that we can populate any data before the fault.
> > > > +	 *
> > > > +	 * We only do this on the first pass through, otherwise the populating
> > > > +	 * application could potentially deadlock on the mmap lock if it tries
> > > > +	 * to populate it with mmap.
> > > > +	 */
> > > > +	if (fault_flag_allow_retry_first(vmf->flags) &&
> > > > +	    fsnotify_file_has_content_watches(file)) {
> > > 
> > > I'm somewhat nervous that if ALLOW_RETRY isn't set, we'd silently jump into
> > > readpage code without ever sending pre-content event and thus we'd possibly
> > > expose invalid content to userspace? I think we should fail the fault if
> > > fsnotify_file_has_content_watches(file) && !(vmf->flags &
> > > FAULT_FLAG_ALLOW_RETRY).
> > 
> > I was worried about this too but it seems to not be the case that we'll not ever
> > have ALLOW_RETRY.  That being said I'm fine turning this into a sigbus.
> 
> Do you mean that with your workloads we always have ALLOW_RETRY set? As I
> wrote, currently you'd have to try really hard to hit such paths but they
> are there - for example if you place uprobe on an address in a VMA that is
> not present, the page fault is going to happen without ALLOW_RETRY set.

From what I can tell we almost always have FOLL_UNLOCKABLE set, which is what
translates into ALLOW_RETRY.  There's definitely some paths that can get there,
but as far as what happens in a normal environment we're going to almost always
have ALLOW_RETRY set.

This does leave a hole in some corner cases.  I'm content to say "don't do that"
if you want to use these hooks.

Optionally we could add a FAN_PRE_MMAP hook in vm_mmap() for the range that is
being mmap'ed to make sure we never miss any events, and then applications can
decide if they want to risk it with the pagefault hooks or enable the mmap hooks
for absolute certainty.

> 
> > > > +		int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_READ;
> > > > +		loff_t pos = vmf->pgoff << PAGE_SHIFT;
> > > > +
> > > > +		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> > > > +
> > > > +		/*
> > > > +		 * We can only emit the event if we did actually release the
> > > > +		 * mmap lock.
> > > > +		 */
> > > > +		if (fpin) {
> > > > +			error = fsnotify_file_area_perm(fpin, mask, &pos,
> > > > +							PAGE_SIZE);
> > > > +			if (error) {
> > > > +				fput(fpin);
> > > > +				return VM_FAULT_ERROR;
> > > > +			}
> > > > +		}
> > > > +	}
> > > > +
> > > >  	/*
> > > >  	 * Do we have something in the page cache already?
> > > >  	 */
> > > ...
> > > > @@ -3612,6 +3643,13 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> > > >  	unsigned long rss = 0;
> > > >  	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
> > > >  
> > > > +	/*
> > > > +	 * We are under RCU, we can't emit events here, we need to force a
> > > > +	 * normal fault to make sure the events get sent.
> > > > +	 */
> > > > +	if (fsnotify_file_has_content_watches(file))
> > > > +		return ret;
> > > > +
> > > 
> > > I don't think we need to do anything for filemap_map_pages(). The call just
> > > inserts page cache content into page tables and whatever is in the page
> > > cache and has folio_uptodate() set should be already valid file content,
> > > shouldn't it?
> > 
> > I'll make this comment more clear.  filemap_fault() will start readahead,
> > but we'll only emit the event for the page size that we're faulting.  I
> > had looked at putting this at the readahead place and figuring out the
> > readahead size, but literally anything could trigger readahead so it's
> > better to just not allow filemap_map_pages() to happen, otherwise we'll
> > end up with empty pages (if the content hasn't been populated yet) and
> > never emit an event for those ranges.
> 
> This seems like an interesting problem. Even ordinary read(2) will trigger
> readahead and as you say, we would be instantiating folios with wrong
> content (zeros) due to that. It seems as a fragile design to keep such
> folios in the page cache and place checks in all the places that could
> possibly make their content visible to the user. I'd rather make sure that
> if we pull folios into page cache (and set folio_uptodate() bit), their
> content is indeed valid.

The hook exists before we go looking in pagecache, so we're fine with read(2),
the only problem is mmap (AFAICT, I am not very smart after all).

> 
> What we could do is to turn off readahead on the inode if
> fsnotify_file_has_content_watches() is true. Essentially the handler of the
> precontent event can do a much better job of prefilling the page cache with
> whatever content is needed in a range that makes sense. And then we could
> leave filemap_map_pages() intact. What do you think guys?

I had considered this but decided against it because it seemed like a big
hammer, but if you're cool with it then so am I.  Thanks,

Josef

