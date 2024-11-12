Return-Path: <linux-fsdevel+bounces-34544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2B39C635F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B540CB30A31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F432219CAC;
	Tue, 12 Nov 2024 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcBfe+b0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562E20ADFA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442800; cv=none; b=EguRjnEXhsZrfpCbVAnXMYgZclDmnyuBUqfw28dYl01zYfSBQUZ/5+SvBvkWCjIvBQ6RcHWsR8YqT2+E1l1cjwiNVH2CEa6e7+5w4ZLW1qYyka97uywjdIb2IOb5L8UZjGP8awzYIZAYFydh/YVzeQufD/m9toRFkd17vscxXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442800; c=relaxed/simple;
	bh=U3bw4s/i0+eozZS7kG2uTdJ5X0ebW75hqS6031sKcNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elifgakKfooEXP2jC3r9BLHSeqk6MS4gRQf5esewd8rs690bj9O+vBGD8/KlQar8voxtEIAHsLyBEFsAJpvqnc2aPw+0HosaFgxe9qajyBjT42kLYjRpuWcxY/BMzgr4LkeOj8swztYII+GXGyZaqFQtB/aQDXClBwJ9Q+2Ztb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcBfe+b0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731442796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WXlvQkvFWX/vPGCP4GfItyIf5yJB87PKwwJ7kOXASbs=;
	b=BcBfe+b0VEfmckFwI4lQS5EyrUfVo11e9rzHZKxG76uW8MGhsAtJ5spgYJKClbgM+k1itN
	Ty/h4U2BYgzh61LtuQUs+nYFOwAXYlewZGeoicuqC/AevZLoImLdXbi4EXttA72lWr8JfL
	oQyRC+UhAaYZHnWqX257y3A2k8Vrjms=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-SSKmdJ4cMNaqMlq2w3V5xg-1; Tue,
 12 Nov 2024 15:19:53 -0500
X-MC-Unique: SSKmdJ4cMNaqMlq2w3V5xg-1
X-Mimecast-MFC-AGG-ID: SSKmdJ4cMNaqMlq2w3V5xg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 655E0195608A;
	Tue, 12 Nov 2024 20:19:51 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D65DD19560A3;
	Tue, 12 Nov 2024 20:19:48 +0000 (UTC)
Date: Tue, 12 Nov 2024 15:21:21 -0500
From: Brian Foster <bfoster@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <ZzO4wUTNQk-Hh-sT@bfoster>
References: <3da73668-a954-47b9-b66d-bb2e719f5590@kernel.dk>
 <ZzLkF-oW2epzSEbP@infradead.org>
 <e9b191ad-7dfa-42bd-a419-96609f0308bf@kernel.dk>
 <ZzOEzX0RddGeMUPc@bfoster>
 <7a4ef71f-905e-4f2a-b3d2-8fd939c5a865@kernel.dk>
 <3f378e51-87e7-499e-a9fb-4810ca760d2b@kernel.dk>
 <ZzOiC5-tCNiJylSx@bfoster>
 <b1dcd133-471f-40da-ab75-d78ea9a8fa4c@kernel.dk>
 <ZzOu9G3whgonO8Ae@bfoster>
 <f26d1d04-3dfb-40d3-b878-9c731459650d@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f26d1d04-3dfb-40d3-b878-9c731459650d@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Nov 12, 2024 at 12:45:58PM -0700, Jens Axboe wrote:
> On 11/12/24 12:39 PM, Brian Foster wrote:
> > On Tue, Nov 12, 2024 at 12:08:45PM -0700, Jens Axboe wrote:
> >> On 11/12/24 11:44 AM, Brian Foster wrote:
> >>> On Tue, Nov 12, 2024 at 10:19:02AM -0700, Jens Axboe wrote:
> >>>> On 11/12/24 10:06 AM, Jens Axboe wrote:
> >>>>> On 11/12/24 9:39 AM, Brian Foster wrote:
> >>>>>> On Tue, Nov 12, 2024 at 08:14:28AM -0700, Jens Axboe wrote:
> >>>>>>> On 11/11/24 10:13 PM, Christoph Hellwig wrote:
> >>>>>>>> On Mon, Nov 11, 2024 at 04:42:25PM -0700, Jens Axboe wrote:
> >>>>>>>>> Here's the slightly cleaned up version, this is the one I ran testing
> >>>>>>>>> with.
> >>>>>>>>
> >>>>>>>> Looks reasonable to me, but you probably get better reviews on the
> >>>>>>>> fstests lists.
> >>>>>>>
> >>>>>>> I'll send it out once this patchset is a bit closer to integration,
> >>>>>>> there's the usual chicken and egg situation with it. For now, it's quite
> >>>>>>> handy for my testing, found a few issues with this version. So thanks
> >>>>>>> for the suggestion, sure beats writing more of your own test cases :-)
> >>>>>>>
> >>>>>>
> >>>>>> fsx support is probably a good idea as well. It's similar in idea to
> >>>>>> fsstress, but bashes the same file with mixed operations and includes
> >>>>>> data integrity validation checks as well. It's pretty useful for
> >>>>>> uncovering subtle corner case issues or bad interactions..
> >>>>>
> >>>>> Indeed, I did that too. Re-running xfstests right now with that too.
> >>>>
> >>>> Here's what I'm running right now, fwiw. It adds RWF_UNCACHED support
> >>>> for both the sync read/write and io_uring paths.
> >>>>
> >>>
> >>> Nice, thanks. Looks reasonable to me at first glance. A few randomish
> >>> comments inlined below.
> >>>
> >>> BTW, I should have also mentioned that fsx is also useful for longer
> >>> soak testing. I.e., fstests will provide a decent amount of coverage as
> >>> is via the various preexisting tests, but I'll occasionally run fsx
> >>> directly and let it run overnight or something to get the op count at
> >>> least up in the 100 millions or so to have a little more confidence
> >>> there isn't some rare/subtle bug lurking. That might be helpful with
> >>> something like this. JFYI.
> >>
> >> Good suggestion, I can leave it running overnight here as well. Since
> >> I'm not super familiar with it, what would be a good set of parameters
> >> to run it with?
> >>
> > 
> > Most things are on by default, so I'd probably just go with that. -p is
> > useful to get occasional status output on how many operations have
> > completed and you could consider increasing the max file size with -l,
> > but usually I don't use more than a few MB or so if I increase it at
> > all.
> 
> When you say default, I'd run it without arguments. And then it does
> nothing :-)
> 
> Not an fs guy, I never run fsx. I run xfstests if I make changes that
> may impact the page cache, writeback, or file systems.
> 
> IOW, consider this a "I'm asking my mom to run fsx, I need to be pretty
> specific" ;-)
> 

Heh. In that case I'd just run something like this:

	fsx -p 100000 <file>

... and see how long it survives. It may not necessarily be an uncached
I/O problem if it fails, but depending on how reproducible a failure is,
that's where a cli knob comes in handy.

> > Random other thought: I also wonder if uncached I/O should be an
> > exclusive mode more similar to like how O_DIRECT or AIO is implemented.
> > But I dunno, maybe it doesn't matter that much (or maybe others will
> > have opinions on the fstests list).
> 
> Should probably exclude it with DIO, as it should not do anything there
> anyway. Eg if you ask for DIO, it gets turned off. For some of the other
> exclusions, they seem kind of wonky to me. Why can you use libaio and
> io_uring at the same time, for example?
> 

To your earlier point, if I had to guess it's probably just because it's
grotty test code with sharp edges.

Brian

> io_uring will work just fine with both buffered and direct IO, and it'll
> do the right thing with uncached as well. AIO is really a DIO only
> thing, not useful for anything else.
> 
> -- 
> Jens Axboe
> 


