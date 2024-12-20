Return-Path: <linux-fsdevel+bounces-37927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A59F91AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 12:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A074A1895CA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 11:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA41C4A16;
	Fri, 20 Dec 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cgo47Jkf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2041C3027
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734695464; cv=none; b=nwcVEaYO9JpuDmNfmTLWsKZTUokeFqJwK49hbZ5gSlzjThVNVXxkYc9qWkE9aNPbJkAsEatywky2jumeeM9eRQHK2l/5LbOOyXOy0KWGTtArUSzxMjCfBLHIXK9zyaY8B/KgoHFWhNPmOojdfQoJeqb54DwD1Zv3wjRFwuycRrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734695464; c=relaxed/simple;
	bh=aBqOW8VcDW3vZzaxBudlXklI0UZO+JYoD6Hsv4ZASNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrwunM782HLHzsDZWxYOlZrS0j3S+ecy7N/vco/Zh0GtsMwLfEiGDlph7jKww7TL7+uOnlhkz9FLIMevzKfFrILzDFrr50MoVEEfWQjlUrznI4f64tCkEFboW3lmE7iW7SB8mKfj3x0W6H5Uj6Ofoo8gTkZWkvS9OQokHJO7gYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cgo47Jkf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734695461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOV3QE8gcBZ5MVKrGesNSPW5GTb8ph5wnuAYk1P1CZs=;
	b=Cgo47JkfUsb7sDnjQcDcFtTaEYFlEOj8u/2/OFQSQ44EI1nVPPFi8upb0W4Pi6tbdMO42x
	u01tFqCRkfCGmornFh7NuCM7mpizJZovXbCiG8Dj30rjVjkWMsTPsSptyGJwdQsVUIez+B
	te0rW420xSn815jCAttlo0zhWxNbLlg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-viGedOvTPiCGNiM-alIHHw-1; Fri,
 20 Dec 2024 06:50:58 -0500
X-MC-Unique: viGedOvTPiCGNiM-alIHHw-1
X-Mimecast-MFC-AGG-ID: viGedOvTPiCGNiM-alIHHw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50D321956048;
	Fri, 20 Dec 2024 11:50:57 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.128])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63B30195608A;
	Fri, 20 Dec 2024 11:50:56 +0000 (UTC)
Date: Fri, 20 Dec 2024 06:52:55 -0500
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <Z2Val8PjhcfBdBFK@bfoster>
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
 <20241218210122.3809198-2-joannelkoong@gmail.com>
 <Z2QtyaryQtBZZw7q@bfoster>
 <CAJnrk1ZfvyrP=8qKyHFzVte_G1q85bVtmKb4KRwJCe_cYHBmxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZfvyrP=8qKyHFzVte_G1q85bVtmKb4KRwJCe_cYHBmxg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Dec 19, 2024 at 02:34:01PM -0800, Joanne Koong wrote:
> On Thu, Dec 19, 2024 at 6:27 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Wed, Dec 18, 2024 at 01:01:21PM -0800, Joanne Koong wrote:
> > > Add support for reads/writes from buffers backed by hugepages.
> > > This can be enabled through the '-h' flag. This flag should only be used
> > > on systems where THP capabilities are enabled.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> >
> > Firstly, thanks for taking the time to add this. This seems like a nice
> > idea. It might be nice to have an extra sentence or two in the commit
> > log on the purpose/motivation. For example, has this been used to detect
> > a certain class of problem?
> 
> Hi Brian,
> 
> Thanks for reviewing this. That's a good idea - I'll include the
> sentence from the cover letter to this commit message as well: "This
> is motivated by a recent bug that was due to faulty handling for
> userspace buffers backed by hugepages."
> 

Thanks. Got a link or anything, for my own curiosity?

Also, I presume the followup fstest is a reproducer?

> >
> > A few other quick comments below...
> >
> > >  ltp/fsx.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 92 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index 41933354..3656fd9f 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -190,6 +190,7 @@ int       o_direct;                       /* -Z */
> > >  int  aio = 0;
> > > +}
> > > +
> > > +static void *
> > > +init_hugepages_buf(unsigned len, long hugepage_size)
> > > +{
> > > +     void *buf;
> > > +     long buf_size = roundup(len, hugepage_size);
> > > +
> > > +     if (posix_memalign(&buf, hugepage_size, buf_size)) {
> > > +             prterr("posix_memalign for buf");
> > > +             return NULL;
> > > +     }
> > > +     memset(buf, '\0', len);
> >
> > I'm assuming it doesn't matter, but did you want to use buf_size here to
> > clear the whole buffer?
> 
> I only saw buf being used up to len in the rest of the code so I
> didn't think it was necessary, but I also don't feel strongly about
> this and am happy to change this to clear the entire buffer if
> preferred.
> 

Yeah.. at first it looked like a bug to me, then I realized the same
thing later. I suspect it might be wise to just clear it entirely to
avoid any future landmines, but that could just be my internal bias
talking too. No big deal either way.

> >
> > > +     if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> > > +             prterr("madvise collapse for buf");
> > > +             free(buf);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     return buf;
> > > +}
> > > @@ -3232,12 +3287,41 @@ main(int argc, char **argv)
> > >       original_buf = (char *) malloc(maxfilelen);
> > >       for (i = 0; i < maxfilelen; i++)
> > >               original_buf[i] = random() % 256;
> > > -     good_buf = (char *) malloc(maxfilelen + writebdy);
> > > -     good_buf = round_ptr_up(good_buf, writebdy, 0);
> > > -     memset(good_buf, '\0', maxfilelen);
> > > -     temp_buf = (char *) malloc(maxoplen + readbdy);
> > > -     temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> > > -     memset(temp_buf, '\0', maxoplen);
> > > +     if (hugepages) {
> > > +             long hugepage_size;
> > > +
> > > +             hugepage_size = get_hugepage_size();
> > > +             if (hugepage_size == -1) {
> > > +                     prterr("get_hugepage_size()");
> > > +                     exit(99);
> > > +             }
> > > +
> > > +             if (writebdy != 1 && writebdy != hugepage_size)
> > > +                     prt("ignoring write alignment (since -h is enabled)");
> > > +
> > > +             if (readbdy != 1 && readbdy != hugepage_size)
> > > +                     prt("ignoring read alignment (since -h is enabled)");
> >
> > I'm a little unclear on what these warnings mean. The alignments are
> > still used in the read/write paths afaics. The non-huge mode seems to
> > only really care about the max size of the buffers in this code.
> >
> > If your test doesn't actually use read/write alignments and the goal is
> > just to keep things simple, perhaps it would be cleaner to add something
> > like an if (hugepages && (writebdy != 1 || readbdy != 1)) check after
> > option processing and exit out as an unsupported combination..?
> 
> My understanding of the 'writebdy' and 'readbdy' options are that
> they're for making reads/writes aligned to the passed-in value, which
> depends on the starting address of the buffer being aligned to that
> value as well. However for hugepages buffers, they must be aligned to
> the system hugepage size (eg 2 MiB) or the madvise(... MADV_COLLAPSE)
> call will fail. As such, it is not guaranteed that the requested
> alignment will actually be abided by. For that reason, I thought it'd
> be useful to print this out to the user so they know requested
> alignments will be ignored, but it didn't seem severe enough of an
> issue to error out and exit altogether. But maybe it'd be less
> confusing for the user if this instead does just error out if the
> alignment isn't a multiple of the hugepage size.
> 

Ahh, I see. I missed the round_ptr_up() adjustments. That makes more
sense now.

IMO it would be a little cleaner to just bail out earlier as such. But
either way, I suppose if you could add a small comment with this
alignment context you've explained above with the error checks then that
is good enough for me. Thanks!

Brian

> >
> > BTW, it might also be nice to factor out this whole section of buffer
> > initialization code (including original_buf) into an init_buffers() or
> > some such. That could be done as a prep patch, but just a suggestion
> > either way.
> 
> Good idea - i'll do this refactoring for v2.
> 
> 
> Thanks,
> Joanne
> >
> > Brian
> >
> > > +
> > > +             good_buf = init_hugepages_buf(maxfilelen, hugepage_size);
> > > +             if (!good_buf) {
> > > +                     prterr("init_hugepages_buf failed for good_buf");
> > > +                     exit(100);
> > > +             }
> > > +
> > > +             temp_buf = init_hugepages_buf(maxoplen, hugepage_size);
> > > +             if (!temp_buf) {
> > > +                     prterr("init_hugepages_buf failed for temp_buf");
> > > +                     exit(101);
> > > +             }
> > > +     } else {
> > > +             good_buf = (char *) malloc(maxfilelen + writebdy);
> > > +             good_buf = round_ptr_up(good_buf, writebdy, 0);
> > > +             memset(good_buf, '\0', maxfilelen);
> > > +
> > > +             temp_buf = (char *) malloc(maxoplen + readbdy);
> > > +             temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> > > +             memset(temp_buf, '\0', maxoplen);
> > > +     }
> > >       if (lite) {     /* zero entire existing file */
> > >               ssize_t written;
> > >
> > > --
> > > 2.47.1
> > >
> > >
> >
> 


