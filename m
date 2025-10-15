Return-Path: <linux-fsdevel+bounces-64258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DFEBDFF59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B208E19C77A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BD3002DC;
	Wed, 15 Oct 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNUc/9EJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783A49659;
	Wed, 15 Oct 2025 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551048; cv=none; b=DcN7cJ5n3NXNM2whh0Bz72eyVdO5vUKruQFNjjChf1xCnUrmvxAsNgnqg6kqMXjOHR/ZTD3vwpi1KJHvjopRNc1pbZEhYFxgm1NEgRzG/d1lR38nWqJhTfQdhjghKd8XvfSsJWESAdepJY/E4Fs8M0m4K/vWJ3CL3xp6hrjE5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551048; c=relaxed/simple;
	bh=gfRoV7O/XWktQsukmzqKSNJlQpoNhjkCFzkEvFnQRC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKzvZ4D/rd0ZUMnQ90t/qjjnh1V7CcBZ6UR5/6s2sJy7hlJG9GzCG/YUypOkFlUewQttRO2udTP1dNCsROsw+NWBImx5O2Zl/M3/UML/WSaXeQ/yQlDxff/BN1FsD/O0VI91VmbzmyT4sP+SJisUd8/VBMu8rSArsVAIIy0Rraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNUc/9EJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C08FC4CEF8;
	Wed, 15 Oct 2025 17:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760551047;
	bh=gfRoV7O/XWktQsukmzqKSNJlQpoNhjkCFzkEvFnQRC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNUc/9EJJTvBbysSHzMsQNaKnKcGZvz+w+Dz+1NGhf3RDIOpXL1Ab+mmFHhwpa5SJ
	 wnL9rDEWuWhnZdE0vjoCK6IReeQ5h7/8c/1cNu6z/PlwaQjpHaejhNIxOhyiuY6OGU
	 39CvYWp/1/wRjnNSchCqZVEWr1mNSKwwFClSt5/+DccfnyKNMEzy+Yfuabip+5yqDx
	 kkulOH/pRpsjLmGnAL8ADnbXWz56XbVJV8lFInszGpO02yrCRjLj4RKPCAg59fPaN2
	 TQa9s/Jp2+vD4iAra0lH+fKvLyiSe0Q9KnWGX13GXLcP77A4/K+2IP72TmfM58rUMG
	 h6JwwVpqcp+fQ==
Date: Wed, 15 Oct 2025 10:57:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, linux-mm <linux-mm@kvack.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: Regression in generic/749 with 8k fsblock size on 6.18-rc1
Message-ID: <20251015175726.GC6188@frogsfrogsfrogs>
References: <20251014175214.GW6188@frogsfrogsfrogs>
 <rymlydtl4fo4k4okciiifsl52vnd7pqs65me6grweotgsxagln@zebgjfr3tuep>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rymlydtl4fo4k4okciiifsl52vnd7pqs65me6grweotgsxagln@zebgjfr3tuep>

On Wed, Oct 15, 2025 at 04:59:03PM +0100, Kiryl Shutsemau wrote:
> On Tue, Oct 14, 2025 at 10:52:14AM -0700, Darrick J. Wong wrote:
> > Hi there,
> > 
> > On 6.18-rc1, generic/749[1] running on XFS with an 8k fsblock size fails
> > with the following:
> > 
> > --- /run/fstests/bin/tests/generic/749.out	2025-07-15 14:45:15.170416031 -0700
> > +++ /var/tmp/fstests/generic/749.out.bad	2025-10-13 17:48:53.079872054 -0700
> > @@ -1,2 +1,10 @@
> >  QA output created by 749
> > +Expected SIGBUS when mmap() reading beyond page boundary
> > +Expected SIGBUS when mmap() writing beyond page boundary
> > +Expected SIGBUS when mmap() reading beyond page boundary
> > +Expected SIGBUS when mmap() writing beyond page boundary
> > +Expected SIGBUS when mmap() reading beyond page boundary
> > +Expected SIGBUS when mmap() writing beyond page boundary
> > +Expected SIGBUS when mmap() reading beyond page boundary
> > +Expected SIGBUS when mmap() writing beyond page boundary
> >  Silence is golden
> > 
> > This test creates small files of various sizes, maps the EOF block, and
> > checks that you can read and write to the mmap'd page up to (but not
> > beyond) the next page boundary.
> > 
> > For 8k fsblock filesystems on x86, the pagecache creates a single 8k
> > folio to cache the entire fsblock containing EOF.  If EOF is in the
> > first 4096 bytes of that 8k fsblock, then it should be possible to do a
> > mmap read/write of the first 4k, but not the second 4k.  Memory accesses
> > to the second 4096 bytes should produce a SIGBUS.
> 
> Does anybody actually relies on this behaviour (beyond xfstests)?

Beats me, but the mmap manpage says:

       SIGBUS Attempted access to a page of the buffer that  lies  be‐
              yond  the end of the mapped file.  For an explanation of
              the treatment of the bytes in the page that  corresponds
              to  the  end  of a mapped file that is not a multiple of
              the page size, see NOTES.

POSIX 2024 says:

The system shall always zero-fill any partial page at the end of an
object. Further, the system shall never write out any modified portions
of the last page of an object which are beyond its end. References
within the address range starting at pa and continuing for len bytes to
whole pages following the end of an object shall result in delivery of a
SIGBUS signal.

https://pubs.opengroup.org/onlinepubs/9799919799.2024edition/functions/mmap.html#tag_17_345

From both I would surmise that it's a reasonable expectation that you
can't map basepages beyond EOF and have page faults on those pages
succeed.

> I think this behaviour existed before the recent changes, but it was
> less prominent.
> 
> Like, tmpfs with huge=always would fault-in PMD if there's order-9 folio
> in page cache regardless of i_size.
> 
> See filemap_map_pages->filemap_map_pmd() path.
> 
> I believe the same happens for large folios in other filesystems.

<shrug> The kernel SIGBUS'd as expected in 6.17.  For the 8k fsblock
case there indeed was a large folio caching the EOF, but then we were
also installing 4k PTE mappings.

(I'm not sure what happens if you actually have a PMD-sized page since
those are a little hard to force.)

> Some of this behaviour is hidden by truncate path trying to split large
> folios, split PMD and unmap a range of PTEs. But split can fail, so we
> cannot rely on this for correctness.
> 
> I would like to understand more about expectations in real workload
> before commit to a fix.

Yeah, I dislike the incongruities between byte-stream files vs mmapping
pages.  All the post-EOF zeroing logic is constantly getting broken in
subtle weird ways.

willy? :D

--D

> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 

