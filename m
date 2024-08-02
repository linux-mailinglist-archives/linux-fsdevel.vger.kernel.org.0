Return-Path: <linux-fsdevel+bounces-24892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A89946159
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763811F21DC8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4238E1537A2;
	Fri,  2 Aug 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="3FskYI6L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD81A34C6
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614641; cv=none; b=Sj0kqmoRsDQPQUhrFqn4k2tqZuuMUBsZd5ni+Y0a49+kt4M9C+AEsiz4QFRmTGfxMls5nOG3vRZqk195+n46lSFaX0ioGEQwbtye7IPJpFLrwpFRbhFkeVFDHEtpAFiRsTnQzuvXRknYrAap7FCwdtu5gW/O9JP5dMHpZJC2Q8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614641; c=relaxed/simple;
	bh=lv5W7Wm+YFAaErqVi7NgV+Q6HtPWvwZWn3EyeCDwYdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/3GWkBxFn8z8uTx+E1wHKwsf//IBoafc2fx767Lh6EtbOrF4BYF+pwvXqGPUsKUpEhQgJsHcwhoh6ZqZ8ihumj2n0WbNTRL07E7b5AW5l53o/o8+Oma8KRVdsx3n7zUlolzng7Pb5BVjLEd2kGh/QIKiz9SGDRFG+vDat5W7cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=3FskYI6L; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66a1842b452so53766047b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Aug 2024 09:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722614638; x=1723219438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6FRM4syvLLLpE4UGJCzBVrQm16sgsEXJFS7W94IDCs=;
        b=3FskYI6LFBMKO3Rx8t9Coj3UpohqJj9Sqrp7ELeFG4/+/H3Z/yMK/zcA6LaE1kxdBk
         kcvWrJ8rRae2GvoKq7JTtylAsbOLkvMniCb4q6W/tKDEG+thhL1/xWlDDNZbsBUYhYZu
         whm4sjXrvC9179x2x+AzY09slTwakAxO4f5X0+OKBNVkeW6/u1vkRx7EPN+m0a8kq/Bz
         Kd8GofDWEMsf6Hw5O0yVv6ScQPzQEEpA/A32pQv6i4ErHMSQBLyP/MM9ihfy2ALjkkm8
         vkIWremSafxFUIDd/V1FzaG2WsiTU75QyNv8jIWwc8F35yK8ZC4DN0IanD/gaIzh31Zn
         Ew5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722614638; x=1723219438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6FRM4syvLLLpE4UGJCzBVrQm16sgsEXJFS7W94IDCs=;
        b=lsCV5uGOa8C/MQs65CXI0q/90CRGTHSSjIEPhREZqHSw9PjXIYxEGiZacZc2h8pWkN
         u7OoBydEkl4/0c1K/+MdBJ/yUFMcDsZAOJCnUi+LUQ4XmkVHrhvEfp+UjlpHXvtplAso
         44FTWkBKFulV1wHr3+wXjNDRW391M+W3S66P6FUxpmKOabT9gbUPq0o9J9voWNa5+n3L
         K971RLxTNvUFcv2Oyp6QhBo7Pnpg6DCD0lBHoEmc1vLWapgFhR3MrW7W/35MbLD4uhhz
         2czZarhAJewE06T4Ir4Ips46ZcZA2ZMXu0K3bUPajWaKqPuO7lObxRxe48ocfTHwhmrc
         qFJw==
X-Forwarded-Encrypted: i=1; AJvYcCXCBg2SnnA/KX1k9t4oSgAvrLIIyY1Pit9tF6NAcsXTya3ZAv8nD6qgM3dF98CHNhO8kwPhvJiQLqxu86QllkxhgRCoAC9VNcB+fV2A2w==
X-Gm-Message-State: AOJu0Yy7fXQ0jyS6ZqOv3AZC3rdElFar6QVCBPSy1iUcBLYshl3uMAHu
	SydeJrqALnaG51t5Fh4UcETdbOYzK6HG+OIcgbe/WN9Rn7gDfo4XejHg+1xRbzs=
X-Google-Smtp-Source: AGHT+IFKltUEwTykiwjhk4QDG4SjNCquENyc17EwvmJpkXc+/5E28HA5o9K7BwTqPg/fRbdcXJZ1dQ==
X-Received: by 2002:a81:8ac7:0:b0:63b:aaf1:b8c1 with SMTP id 00721157ae682-68964392785mr47822267b3.37.1722614638400;
        Fri, 02 Aug 2024 09:03:58 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a137b40d2sm2988407b3.116.2024.08.02.09.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 09:03:58 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:03:57 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jan Kara <jack@suse.cz>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org
Subject: Re: [PATCH 10/10] fsnotify: generate pre-content permission event on
 page fault
Message-ID: <20240802160357.GD6306@perftesting>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
 <20240801214025.t5zjblmdjreheab6@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801214025.t5zjblmdjreheab6@quack3>

On Thu, Aug 01, 2024 at 11:40:25PM +0200, Jan Kara wrote:
> On Thu 25-07-24 14:19:47, Josef Bacik wrote:
> > FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> > on the faulting method.
> > 
> > This pre-content event is meant to be used by hierarchical storage
> > managers that want to fill in the file content on first read access.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ...
> > @@ -3287,6 +3288,35 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> >  	if (unlikely(index >= max_idx))
> >  		return VM_FAULT_SIGBUS;
> >  
> > +	/*
> > +	 * If we have pre-content watchers then we need to generate events on
> > +	 * page fault so that we can populate any data before the fault.
> > +	 *
> > +	 * We only do this on the first pass through, otherwise the populating
> > +	 * application could potentially deadlock on the mmap lock if it tries
> > +	 * to populate it with mmap.
> > +	 */
> > +	if (fault_flag_allow_retry_first(vmf->flags) &&
> > +	    fsnotify_file_has_content_watches(file)) {
> 
> I'm somewhat nervous that if ALLOW_RETRY isn't set, we'd silently jump into
> readpage code without ever sending pre-content event and thus we'd possibly
> expose invalid content to userspace? I think we should fail the fault if
> fsnotify_file_has_content_watches(file) && !(vmf->flags &
> FAULT_FLAG_ALLOW_RETRY).

I was worried about this too but it seems to not be the case that we'll not ever
have ALLOW_RETRY.  That being said I'm fine turning this into a sigbus.

> 
> > +		int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_READ;
> > +		loff_t pos = vmf->pgoff << PAGE_SHIFT;
> > +
> > +		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> > +
> > +		/*
> > +		 * We can only emit the event if we did actually release the
> > +		 * mmap lock.
> > +		 */
> > +		if (fpin) {
> > +			error = fsnotify_file_area_perm(fpin, mask, &pos,
> > +							PAGE_SIZE);
> > +			if (error) {
> > +				fput(fpin);
> > +				return VM_FAULT_ERROR;
> > +			}
> > +		}
> > +	}
> > +
> >  	/*
> >  	 * Do we have something in the page cache already?
> >  	 */
> ...
> > @@ -3612,6 +3643,13 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> >  	unsigned long rss = 0;
> >  	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
> >  
> > +	/*
> > +	 * We are under RCU, we can't emit events here, we need to force a
> > +	 * normal fault to make sure the events get sent.
> > +	 */
> > +	if (fsnotify_file_has_content_watches(file))
> > +		return ret;
> > +
> 
> I don't think we need to do anything for filemap_map_pages(). The call just
> inserts page cache content into page tables and whatever is in the page
> cache and has folio_uptodate() set should be already valid file content,
> shouldn't it?

I'll make this comment more clear.  filemap_fault() will start readahead, but
we'll only emit the event for the page size that we're faulting.  I had looked
at putting this at the readahead place and figuring out the readahead size, but
literally anything could trigger readahead so it's better to just not allow
filemap_map_pages() to happen, otherwise we'll end up with empty pages (if the
content hasn't been populated yet) and never emit an event for those ranges.
Thanks,

Josef

