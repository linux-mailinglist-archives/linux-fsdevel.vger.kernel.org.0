Return-Path: <linux-fsdevel+bounces-18861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ABD8BD544
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 21:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAF61C2132C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034031591F1;
	Mon,  6 May 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p22adx8V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB641C73;
	Mon,  6 May 2024 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022995; cv=none; b=N3fb+B/+Km4TpQ5vOLKGDFfFPIhfEMRup0yVuFT6smVb4tak8AGtIaoMuJ9cIgiYDFF289WogBjbdy8zP78kNBW/ZrNO4PMEv6eA4+3frCWzsv4iOq1Ux+NIwEzLrURkCg7CDDI7m29WZqqcGQmTGZ3wOpv22cpOPFooFai//k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022995; c=relaxed/simple;
	bh=dM4RYK1HPhpiphlZExp0kEMnb2WuO6EBZsOrpdKmkeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBQ1z4dbznicDsR9AErtgKPqM/FFcQzqIwvmgXk8oeKdrGv7OqinjwUVloUiaCy+/wmDtMr6+zUIh13Xg2nwTpNz3yHSC+5jyO7m94m0lxMcgrKuo+Mo23+qb0dnUZzGA2Lyz7hnfYxVJfDrSCywPy2d16n3vPNOJVtinSB3Cpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p22adx8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D687C116B1;
	Mon,  6 May 2024 19:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715022994;
	bh=dM4RYK1HPhpiphlZExp0kEMnb2WuO6EBZsOrpdKmkeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p22adx8VFW7ioiNw8e/ZClDpQeoamqBgo/VwXvYdTwee3MTcDB2ZePDbNbjAvc4T5
	 NuGCLi+wL0GgrhzfHq6N9p0AFieqH32JaMVefOMxHrSdra4NOfhuWldsP15wD7WedX
	 OoxyBdvnnMSyWkIrxg6rk0nv4igi/dCiaZeaQ+bQOQck7dkfETOlMAxrws+8WIhOOd
	 nLYtWcMphLkM4rwdvbXR+Hmw03/ilUto8JVBQvKOp80RI7niKEEcz0NnYK2Z273oMa
	 6dcJGaWJf31fdI2kMmlRNFbgcogQyWoXU+k2xg8smolJCa7JAMdHFNTCHIBc3s26we
	 lN3Uzt6mOpauw==
Date: Mon, 6 May 2024 16:16:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-mm@kvack.org,
	Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for
 /proc/<pid>/maps
Message-ID: <Zjksc3yqvkocS18M@x1>
References: <20240504003006.3303334-1-andrii@kernel.org>
 <20240504003006.3303334-3-andrii@kernel.org>
 <2024050439-janitor-scoff-be04@gregkh>
 <CAEf4BzZ6CaMrqRR1Rah7=HnTpU5-zw5HUnSH9NWCzAZZ55ZXFQ@mail.gmail.com>
 <ZjjiFnNRbwsMJ3Gj@x1>
 <CAM9d7cgvCB8CBFGhMB_-4tCm6+jzoPBNg4CR7AEyMNo8pF9QKg@mail.gmail.com>
 <ZjknNJSFcKaxGDS4@x1>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjknNJSFcKaxGDS4@x1>

On Mon, May 06, 2024 at 03:53:40PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 06, 2024 at 11:05:17AM -0700, Namhyung Kim wrote:
> > On Mon, May 6, 2024 at 6:58 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > On Sat, May 04, 2024 at 02:50:31PM -0700, Andrii Nakryiko wrote:
> > > > On Sat, May 4, 2024 at 8:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > On Fri, May 03, 2024 at 05:30:03PM -0700, Andrii Nakryiko wrote:
> > > > > > Note also, that fetching VMA name (e.g., backing file path, or special
> > > > > > hard-coded or user-provided names) is optional just like build ID. If
> > > > > > user sets vma_name_size to zero, kernel code won't attempt to retrieve
> > > > > > it, saving resources.
> 
> > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> > > > > Where is the userspace code that uses this new api you have created?
> 
> > > > So I added a faithful comparison of existing /proc/<pid>/maps vs new
> > > > ioctl() API to solve a common problem (as described above) in patch
> > > > #5. The plan is to put it in mentioned blazesym library at the very
> > > > least.
> > > >
> > > > I'm sure perf would benefit from this as well (cc'ed Arnaldo and
> > > > linux-perf-user), as they need to do stack symbolization as well.
>  
> > I think the general use case in perf is different.  This ioctl API is great
> > for live tracing of a single (or a small number of) process(es).  And
> > yes, perf tools have those tracing use cases too.  But I think the
> > major use case of perf tools is system-wide profiling.
>  
> > For system-wide profiling, you need to process samples of many
> > different processes at a high frequency.  Now perf record doesn't
> > process them and just save it for offline processing (well, it does
> > at the end to find out build-ID but it can be omitted).
> 
> Since:
> 
>   Author: Jiri Olsa <jolsa@kernel.org>
>   Date:   Mon Dec 14 11:54:49 2020 +0100
>   1ca6e80254141d26 ("perf tools: Store build id when available in PERF_RECORD_MMAP2 metadata events")
> 
> We don't need to to process the events to find the build ids. I haven't
> checked if we still do it to find out which DSOs had hits, but we
> shouldn't need to do it for build-ids (unless they were not in memory
> when the kernel tried to stash them in the PERF_RECORD_MMAP2, which I
> haven't checked but IIRC is a possibility if that ELF part isn't in
> memory at the time we want to copy it).

> If we're still traversing it like that I guess we can have a knob and
> make it the default to not do that and instead create the perf.data
> build ID header table with all the build-ids we got from
> PERF_RECORD_MMAP2, a (slightly) bigger perf.data file but no event
> processing at the end of a 'perf record' session.

But then we don't process the PERF_RECORD_MMAP2 in 'perf record', it
just goes on directly to the perf.data file :-\

Humm, perhaps the sideband thread...

- Arnaldo

