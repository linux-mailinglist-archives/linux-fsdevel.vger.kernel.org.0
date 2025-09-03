Return-Path: <linux-fsdevel+bounces-60149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C0B41E94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 14:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730251BA6903
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5B12FC016;
	Wed,  3 Sep 2025 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eN9486Ce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E753284896
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901670; cv=none; b=T14dvkh4nCBz6HLkKVK5MKZl6K/vIbg1FVfE/okDJbUUv1c8STcPjcfr4zCnq4bhadOluzo80GSVPFUKU/3sFQ6EnmqwYBvHiLwl+waSfaS6wiTme7chF6g4gajSVw/IOpEhaNjix64Ek7382LO8yKcKYrEbr3ruYn+eJaFeIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901670; c=relaxed/simple;
	bh=DNww89dAk+WaS6AnURZOTrIs1/NuWo7QNbyMXRksX/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BY/xeJ1otMfHc83aEVbxZHoggxXk4eF9ufKhJ6h5qr3GGKOGRQBl6vAUEoe3j/H26BKjXScvwTNq4VjXjlaAN3Ehg7JBn+lCq5kdt5jzwIn67K9QLavsrfg9T7ul6r/m1K2oGH1wh/61mVWu/LAhxz1x67eKbE899a6drGJ40SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eN9486Ce; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756901668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHMZ9wQmWJlZYdTh9s6SlH1grpRLFmPR+2/RoZI6wdA=;
	b=eN9486CeloMTkqVFN2hHEn0wLJwN9mBPSXOGn3X9JliyX7D9nHP1EpoQxEbkc+5Bonsu8R
	qJvl+MdcRQaL+182VJ1xoMsiloyVFlEU//CsjFUtIDXYD+rvS96+ZtVxnZHN4MEnBrjfBh
	ASYDuPIr4yuFQ5WnkS9mU7ZlEr+QRTU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-7dVlqKbuOLqQZuehTwE_lA-1; Wed,
 03 Sep 2025 08:14:24 -0400
X-MC-Unique: 7dVlqKbuOLqQZuehTwE_lA-1
X-Mimecast-MFC-AGG-ID: 7dVlqKbuOLqQZuehTwE_lA_1756901663
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 274CB1955DD3;
	Wed,  3 Sep 2025 12:14:23 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.143])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD06E1956056;
	Wed,  3 Sep 2025 12:14:21 +0000 (UTC)
Date: Wed, 3 Sep 2025 08:18:24 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jack@suse.cz, djwong@kernel.org
Subject: Re: [PATCH RFC 2/2] iomap: revert the iomap_iter pos on
 ->iomap_end() error
Message-ID: <aLgyELz3TH_TCZRw@bfoster>
References: <20250902150755.289469-1-bfoster@redhat.com>
 <20250902150755.289469-3-bfoster@redhat.com>
 <CAJnrk1bmjCB=8o-YOkPScftoXMrgpBKU3vtkMOViEfFQ9LXLfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bmjCB=8o-YOkPScftoXMrgpBKU3vtkMOViEfFQ9LXLfg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Sep 02, 2025 at 02:11:35PM -0700, Joanne Koong wrote:
> On Tue, Sep 2, 2025 at 8:04 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > An iomap op iteration should not be considered successful if
> > ->iomap_end() fails. Most ->iomap_end() callbacks do not return
> > errors, and for those that do we return the error to the caller, but
> > this is still not sufficient in some corner cases.
> >
> > For example, if a DAX write to a shared iomap fails at ->iomap_end()
> > on XFS, this means the remap of shared blocks from the COW fork to
> > the data fork has possibly failed. In turn this means that just
> > written data may not be accessible in the file. dax_iomap_rw()
> > returns partial success over a returned error code and the operation
> > has already advanced iter.pos by the time ->iomap_end() is called.
> > This means that dax_iomap_rw() can return more bytes processed than
> > have been completed successfully, including partial success instead
> > of an error code if the first iteration happens to fail.
> >
> > To address this problem, first tweak the ->iomap_end() error
> > handling logic to run regardless of whether the current iteration
> > advanced the iter. Next, revert pos in the error handling path. Add
> > a new helper to undo the changes from iomap_iter_advance(). It is
> > static to start since the only initial user is in iomap_iter.c.
> >
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/iter.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> > index 7cc4599b9c9b..69c993fe51fa 100644
> > --- a/fs/iomap/iter.c
> > +++ b/fs/iomap/iter.c
> > @@ -27,6 +27,22 @@ int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
> >         return 0;
> >  }
> >
> > +/**
> > + * iomap_iter_revert - revert the iterator position
> > + * @iter: iteration structure
> > + * @count: number of bytes to revert
> > + *
> > + * Revert the iterator position by the specified number of bytes, undoing
> > + * the effect of a previous iomap_iter_advance() call. The count must not
> > + * exceed the amount previously advanced in the current iter.
> > + */
> > +static void iomap_iter_revert(struct iomap_iter *iter, u64 count)
> > +{
> > +       count = min_t(u64, iter->pos - iter->iter_start_pos, count);
> > +       iter->pos -= count;
> > +       iter->len += count;
> > +}
> > +
> >  static inline void iomap_iter_done(struct iomap_iter *iter)
> >  {
> >         WARN_ON_ONCE(iter->iomap.offset > iter->pos);
> > @@ -80,8 +96,10 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> >                                 iomap_length_trim(iter, iter->iter_start_pos,
> >                                                   olen),
> >                                 advanced, iter->flags, &iter->iomap);
> > -               if (ret < 0 && !advanced && !iter->status)
> > +               if (ret < 0 && !iter->status) {
> > +                       iomap_iter_revert(iter, advanced);
> >                         return ret;
> > +               }
> 
> Should iomap_iter_revert() also be called in the "if (iter->status <
> 0)" case a few lines below? I think otherwise, that leads to the same
> problem in dax_iomap_rw() you pointed out in the commit message.
> 

My thinking was that I wanted to try for the invariant that the
operation/iteration is responsible to set the iter appropriately in the
event that it returns an error in iter.status. I.e., either not advance
or revert if appropriate.

This is more consistent with how the iter is advanced and I suspect will
help prevent potential whack a mole issues with inconsistent
expectations for error handling at the iomap_iter() level. I actually
had iomap_iter_revert() non-static originally, but changed it since I
didn't spot anywhere it needed to be called as of yet. I could have
certainly missed something though. Did you have a particular sequence in
mind, or were just thinking in general?

FWIW, I suspect there's a reasonable argument for doing the same for
->iomap_end() and make the callback responsible for reverting if
necessary. I went the way in this patch just because it seemed more
simple given the limited scope, but that may not always be the case
and/or may just be cleaner. I can take a closer look at that if there
are stronger opinions..? Thanks for the feedback.

Brian

> Thanks,
> Joanne
> >         }
> >
> >         /* detect old return semantics where this would advance */
> > --
> > 2.51.0
> >
> >
> 


