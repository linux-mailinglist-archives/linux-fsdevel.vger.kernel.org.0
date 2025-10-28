Return-Path: <linux-fsdevel+bounces-65908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17235C144FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 12:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F39733526AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 11:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC172EB10;
	Tue, 28 Oct 2025 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bg7dwO0g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33A1E3DF2
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650188; cv=none; b=FFpStz8sjIQkoEtIFlfKO9sKFnQxa7z0dKO32Mg7gYUvM2UyG7DJHPlnBZFmhk7FfOVc+P9loctqXqw0M52eDseoHRmj00aooiRlr/9a+AtZ4aCXrdSYxH4C1ihv7R4ylLbHlWv9BtBFra7yzOiQ1DZIk5veoIbxda+NEF89cPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650188; c=relaxed/simple;
	bh=vvBiYUSKnP5c8hFfcmPfj2ZRLUVYFKah7cBpRH+xPtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8KfyM4m+Z/AWWNm1pYzLDwvN/uH2GrEY2PLnMeHIQjsja+r6qWTmijoQqbeUTTKUXRwF9yuwyzm2jpMAQ2ol0EtMGP+k2M5ldnESoHamoRzuVvCkU6cpY0CiDZ596KdT2mLJ28qyfUWU59TQvY9q8YS60z+03bMKzx9eiuhYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bg7dwO0g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761650185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CH56wz/CtDnzZmRfpRhYvq4TPXL1RRxHdZW6dq8njso=;
	b=Bg7dwO0gUOH8IM+VmCOuZt8HlwDRmoT70vI4OOSmWsb0jT3iIgvfIOp4IJaqSdTdSvsm0B
	SsumYYvx3Z9eeOwq1Awf+99ytU77tMJNwXWfoaFBkVmCYhkJjdZxCx68EBsYuvIWziRewa
	ugSWhS7BwAckNRWuFPIQDxciCTIPCRs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-1g1Mr1yDOoOfYcxY9MIZFg-1; Tue,
 28 Oct 2025 07:16:21 -0400
X-MC-Unique: 1g1Mr1yDOoOfYcxY9MIZFg-1
X-Mimecast-MFC-AGG-ID: 1g1Mr1yDOoOfYcxY9MIZFg_1761650180
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19F5C1956096;
	Tue, 28 Oct 2025 11:16:20 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.105])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04D9119560AD;
	Tue, 28 Oct 2025 11:16:17 +0000 (UTC)
Date: Tue, 28 Oct 2025 07:20:36 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix race when reading in all bytes of a folio
Message-ID: <aQCnBDkpda7_RAwW@bfoster>
References: <20251024215008.3844068-1-joannelkoong@gmail.com>
 <aP9jmwrd5r-VPWdg@bfoster>
 <CAJnrk1Yu0dkYCfTCzBzBiqMuYRxpyVPBh2YkJcP6YhYRf0zNMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Yu0dkYCfTCzBzBiqMuYRxpyVPBh2YkJcP6YhYRf0zNMw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Oct 27, 2025 at 09:43:59AM -0700, Joanne Koong wrote:
> On Mon, Oct 27, 2025 at 5:16 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Fri, Oct 24, 2025 at 02:50:08PM -0700, Joanne Koong wrote:
> > > There is a race where if all bytes in a folio need to get read in and
> > > the filesystem finishes reading the bytes in before the call to
> > > iomap_read_end(), then bytes_accounted in iomap_read_end() will be 0 and
> > > the following "ifs->read_bytes_pending -= bytes_accounting" will also be
> > > 0 which will trigger an extra folio_end_read() call. This extra
> > > folio_end_read() unlocks the folio for the 2nd time, which sets the lock
> > > bit on the folio, resulting in a permanent lockup.
> > >
> > > Fix this by returning from iomap_read_end() early if all bytes are read
> > > in by the filesystem.
> > >
> > > Additionally, add some comments to clarify how this accounting logic works.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > Fixes: 51311f045375 ("iomap: track pending read bytes more optimally")
> > > Reported-by: Brian Foster <bfoster@redhat.com>
> > > --
> > > This is a fix for commit 51311f045375 in the 'vfs-6.19.iomap' branch. It
> > > would be great if this could get folded up into that original commit, if it's
> > > not too logistically messy to do so.
> > >
> > > Thanks,
> > > Joanne
> > > ---
> > >  fs/iomap/buffered-io.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 72196e5021b1..c31d30643e2d 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -358,6 +358,25 @@ static void iomap_read_init(struct folio *folio)
> > >       if (ifs) {
> > >               size_t len = folio_size(folio);
> > >
> > > +             /*
> > > +              * ifs->read_bytes_pending is used to track how many bytes are
> > > +              * read in asynchronously by the filesystem. We need to track
> > > +              * this so that we can know when the filesystem has finished
> > > +              * reading in the folio whereupon folio_end_read() should be
> > > +              * called.
> > > +              *
> > > +              * We first set ifs->read_bytes_pending to the entire folio
> > > +              * size. Then we track how many bytes are read in by the
> > > +              * filesystem. At the end, in iomap_read_end(), we subtract
> > > +              * ifs->read_bytes_pending by the number of bytes NOT read in so
> > > +              * that ifs->read_bytes_pending will be 0 when the filesystem
> > > +              * has finished reading in all pending bytes.
> > > +              *
> > > +              * ifs->read_bytes_pending is initialized to the folio size
> > > +              * because we do not easily know in the beginning how many
> > > +              * bytes need to get read in by the filesystem (eg some ranges
> > > +              * may already be uptodate).
> > > +              */
> >
> > Hmm.. "we do this because we don't easily know how many bytes to read,"
> > but apparently that's how this worked before by bumping the count as
> > reads were submitted..? I'm not sure this is really telling much. I'd
> > suggest something like (and feel free to completely rework any of
> > this)..
> 
> Ahh with that sentence I was trying to convey that we need to do this
> because we don't easily know in the beginning how many bytes need to
> get read in (eg if we knew we'll be reading in 2k bytes, then we could
> just set that to 2k instead of the folio size, and skip all the
> accounting stuff). I will get rid of this and replace it with your
> suggestion.
> 
> >
> > "Increase ->read_bytes_pending by the folio size to start. We'll
> > subtract uptodate ranges that did not require I/O in iomap_read_end()
> > once we're done processing the read. We do this because <reasons>."
> >
> > ... where <reasons> explains to somebody who might look at this in a
> > month or year and wonder why we don't just bump read_bytes_pending as we
> > go.
> 
> Sounds good, I will use this for v2.
> >
> > >               spin_lock_irq(&ifs->state_lock);
> > >               ifs->read_bytes_pending += len;
> > >               spin_unlock_irq(&ifs->state_lock);
> > > @@ -383,6 +402,9 @@ static void iomap_read_end(struct folio *folio, size_t bytes_pending)
> >
> > This function could use a comment at the top to explain it's meant for
> > ending read submission (not necessarily I/O, since that appears to be
> > open coded in finish_folio_read()).
> >
> > >               bool end_read, uptodate;
> > >               size_t bytes_accounted = folio_size(folio) - bytes_pending;
> > >
> >
> > "Subtract any bytes that were initially accounted against
> > read_bytes_pending but skipped for I/O. If zero, then the entire folio
> > was submitted and we're done. I/O completion handles the rest."
> 
> Will add this in v2.
> 
> >
> > Also, maybe I'm missing something but the !bytes_accounted case means
> > the I/O owns the folio lock now, right? If so, is it safe to access the
> > folio from here (i.e. folio_size() above)?
> 
> I believe it is because there's still a reference on the folio here
> since this can only be reached from the ->read_iter() and
> ->readahead() paths, which prevents the folio from getting evicted
> (which is what I think you're referring to?).
> 

Yep, but also whether the size or anything can change.. can a large
folio split, for example?

ISTM the proper thing to do would be to somehow ensure the read submit
side finishes (with the folio) before the completion side can complete
the I/O, then there is an explicit ownership boundary and these sorts of
racy folio access questions can go away. Just my 02.

Brian

> Thanks,
> Joanne
> >
> > Comments aside, this survives a bunch of iters of my original
> > reproducer, so seems Ok from that standpoint.
> >
> > Brian
> >
> > > +             if (!bytes_accounted)
> > > +                     return;
> > > +
> > >               spin_lock_irq(&ifs->state_lock);
> > >               ifs->read_bytes_pending -= bytes_accounted;
> > >               /*
> > > --
> > > 2.47.3
> > >
> >
> 


