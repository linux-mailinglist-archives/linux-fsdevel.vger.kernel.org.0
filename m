Return-Path: <linux-fsdevel+bounces-71071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA96CB3B26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 18:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA4E301AD10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C6B25C6EE;
	Wed, 10 Dec 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrOWOlIw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1BIqrbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7E81E3DED
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765389041; cv=none; b=n456iAerV1oFfc5ssn8X8vSpWK2095leCrDSpczZKhDN9Iq6ZjdLtINpC64GsVJQAKVPxIFtKHIaEF/se7OhymTJBPjQcaqmCYQNAGnL1YSoVkU3+A8Nh0Oi/McO4sRVOBfmeW4cMEBtnp9pW3ZOGBeMD+Ig8roGS8jfyNv9Dyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765389041; c=relaxed/simple;
	bh=drrQD08xNj3jXlhWXuUcKujnL4i0woNqEE3DzDhls8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEuOdyFgTS4PDWX2t8XACyR2f1hWX/7jvbW3UOtZZ/hwgrgwCkkic17wn7+nPR6Lprm6ainFoiz8ErdprmgwrfS4cQ8NH713YrcWoc7cd4PgSWOISa2IFRWPlDTg0AKk4w4tPeS+rzuBRWOQDg3D/ycreQ+MNTjZHw7sKLdK3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrOWOlIw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1BIqrbA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765389038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zBnPMbgpQRvbu+t1LIyoW0JfH31LkevENElWCnCYOc=;
	b=RrOWOlIwA/u3+vVzSvn7mGdJ9WiTbx+s+13AmRI3wEhmF8McOInlAScgG9vVwSOrJs9oc+
	iZmxyxHo/8i4iaCuMPhWDjapBEABR766O2oZNmBosmPRXM88hfvf5KAQTqwmZ6vR760Cmz
	bh+NXQZcaa1GMEm4v2WRSqv6Ok1u/ow=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-Zjlaan5UMZm0qTDsfNUHXQ-1; Wed, 10 Dec 2025 12:50:36 -0500
X-MC-Unique: Zjlaan5UMZm0qTDsfNUHXQ-1
X-Mimecast-MFC-AGG-ID: Zjlaan5UMZm0qTDsfNUHXQ_1765389035
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-649783da905so205783a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765389035; x=1765993835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zBnPMbgpQRvbu+t1LIyoW0JfH31LkevENElWCnCYOc=;
        b=P1BIqrbAw6SObWoQ8T/dU362d2ARYeN0Q3RbxjOaUE2ORwQ6p4bvlrSWGl+D01952M
         Q0YQpRAgGoVMZ709xR1m8wT83Sb9ZI1IseiF0guO341mAg31RIdldPKLosD10pE5qH3K
         q0ZhtWU7H5xSIwjpeR1KwH5qqgtSDDSdS5qVXdWFU5jzGBM9UgPJM0F8ad/RaMbwUOJx
         u4iolVxlOsOe0NOjjgyH0A6RixXlkI8jfRdkz3g/DYcbP33OCN0GSbKPa0Y9xb9euKjm
         m14casM7OwAUcs7NXhAby5kQVt+gQPm4jegNMrb1luGCZ7UpY7SocfyyXjpKYZyMvmJJ
         y1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765389035; x=1765993835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zBnPMbgpQRvbu+t1LIyoW0JfH31LkevENElWCnCYOc=;
        b=BApK0EYDhEazlixbVFQdEE6ve8+6JvUomJk0zv19beeDu7qA7ET1ErjjgoFMwL09of
         kli5oQgJ9dMG6Sgrt7JAkENl7jUK/XDDPcFJJ35L2PJ3nEZdx6MzM/ls6qRuCCprlklE
         ahAulhjXw3mSrFKQxrZJQS0dyH7PPFAuvCRnFYEYw6rbsFFe+IMkkug8DfMxFHjOaDuh
         SPR741+pap1HP6Gz0FRAEZJ8LzOhnmLB3ucqbnYazK3j02cDXoXVop7K4ZMEwkQabXQ4
         R2DmuzIP4Ny9fNgIXc9gbulLqq/r8vGia0XkDw1ZYovtbjy5PIWE3Nc+8aPF8zFY/jyb
         skxw==
X-Forwarded-Encrypted: i=1; AJvYcCUEVIPVZW8AvD8Feywse4X+K3P0ot+aR2i0LoGomielCYRaWJPPNrbX0Z0sBTPF+LtXIcU7JV9ghFW6M8mo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz917lVFP0Nd75S4HCx4t+TyKZ0ABvMa0jcgnxpS3rauzvFJwwk
	0fh9Q25LQ8EofwlTxQreuHKkZ1yMcJTJKTt/vVnzRT+10/kSEpi15AAvWN71iDAgz9BrQbDaRXM
	P7oP9BW0SnA4kUbdZ5ZrSZh1zokcTP9qBgHV0YLy6F7eLSIBrBysnSlS95LdwT0Ootqyg4BlkPt
	dlmKGmVYYuXCljMBxj0PxFCrFa1med/Qv4ZIeOiqel
X-Gm-Gg: AY/fxX73Gvs8A0M9Ald6HjKxgu1i6AuGmGDBqMMNw8fz08jboqIrY9kLahE6vMm73Uq
	/eC5xDlVRpxJEUpJbDZH7wwwufKQ5UK0k2J26d29a1JiZ9H9xIaUDNxOrt672FzaNLXv/jq1sNL
	UNaXlWywtPViwNelTXb0orkcs00uBN42haaKdZhTtyLsFO9KRULaWlH2XFGIECRPbfVi18mJ5v9
	oYmc0EXYUSfFjtl+yaxPJvHUg==
X-Received: by 2002:a05:6402:2351:b0:649:593b:baf4 with SMTP id 4fb4d7f45d1cf-6496db693e1mr3112689a12.27.1765389035453;
        Wed, 10 Dec 2025 09:50:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz9MVg/27eU0zo1GhvGg17iIxyPGcWBvaYJwhK0v8fQa+bBgHJMGdEE8RaXjLhlHnF10lsIaeZEJWvgjLDLtU=
X-Received: by 2002:a05:6402:2351:b0:649:593b:baf4 with SMTP id
 4fb4d7f45d1cf-6496db693e1mr3112677a12.27.1765389035093; Wed, 10 Dec 2025
 09:50:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208193024.GA89444@frogsfrogsfrogs> <20251208201333.528909-1-dkarn@redhat.com>
 <enzq67rnekrh7gycgvgjc4g5ryt7qvuamaqj3ndpmns5svosa4@ozcepp4lpyls>
 <CAO4qAqK-6jpiFXTdpoB-e144N=Ux0Hs+NOouM6cmVDzV8V-Dcw@mail.gmail.com>
 <ujd4c2sadpu3fsux2t667ef3zz2i2nyiqvhes4ahbtpay4ba3f@unn3uh57fxdk>
 <CAO4qAqLwo+K4qFgWxs6qJ2yKvc+su=SPXS6LC7gJLgfw0aNeyA@mail.gmail.com> <cxnggvkjf7rdlif5xzbi6megywkpbqgbley6jsh2zupmwqyiqi@lwzocbqzur5a>
In-Reply-To: <cxnggvkjf7rdlif5xzbi6megywkpbqgbley6jsh2zupmwqyiqi@lwzocbqzur5a>
From: Deepak Karn <dkarn@redhat.com>
Date: Wed, 10 Dec 2025 23:20:23 +0530
X-Gm-Features: AQt7F2p-B4AnvCmHVr6GMbFt36znnhhRvd1CFCOo5s7_wBBNNnKo7Vm_FJyp1Y8
Message-ID: <CAO4qAq+YJwTgmU=QjAhfxqpKsXJ1sjSz+pniWdW8Yr9zeLGePg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: add NULL check in drop_buffers() to prevent null-ptr-deref
To: Jan Kara <jack@suse.cz>
Cc: djwong@kernel.org, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:54=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 10-12-25 20:59:00, Deepak Karn wrote:
> > On Wed, Dec 10, 2025 at 3:25=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 09-12-25 22:00:04, Deepak Karn wrote:
> > > > On Tue, Dec 9, 2025 at 4:48=E2=80=AFPM Jan Kara <jack@suse.cz> wrot=
e:
> > > > >
> > > > > On Tue 09-12-25 01:43:33, Deepakkumar Karn wrote:
> > > > > > On Mon, 8 Dec 2025 11:30:24 -0800, Darrick J. Wong wrote:
> > > > > > > > drop_buffers() dereferences the buffer_head pointer returne=
d by
> > > > > > > > folio_buffers() without checking for NULL. This leads to a =
null pointer
> > > > > > > > dereference when called from try_to_free_buffers() on a fol=
io with no
> > > > > > > > buffers attached. This happens when filemap_release_folio()=
 is called on
> > > > > > > > a folio belonging to a mapping with AS_RELEASE_ALWAYS set b=
ut without
> > > > > > > > release_folio address_space operation defined. In such case=
,
> > > > > >
> > > > > > > What user is that?  All the users of AS_RELEASE_ALWAYS in 6.1=
8 appear to
> > > > > > > supply a ->release_folio.  Is this some new thing in 6.19?
> > > > > >
> > > > > > AFS directories SET AS_RELEASE_ALWAYS but have not .release_fol=
io.
> > > > >
> > > > > AFAICS AFS sets AS_RELEASE_ALWAYS only for symlinks but not for
> > > > > directories? Anyway I agree AFS symlinks will have AS_RELEASE_ALW=
AYS but no
> > > > > .release_folio callback. And this looks like a bug in AFS because=
 AFAICT
> > > > > there's no point in setting AS_RELEASE_ALWAYS when you don't have
> > > > > .release_folio callback. Added relevant people to CC.
> > > > >
> > > > >                                                                 H=
onza
> > > >
> > > > Thank you for your response Jan. As you suggested, the bug is in AF=
S.
> > > > Can we include this current defensive check in drop_buffers() and I=
 can submit
> > > > another patch to handle that bug of AFS we discussed?
> > >
> > > I'm not strongly opposed to that (although try_to_free_buffers() woul=
d seem
> > > like a tad bit better place) but overall I don't think it's a great i=
dea as
> > > it would hide bugs. But perhaps with WARN_ON_ONCE() (to catch sloppy
> > > programming) it would be a sensible hardening.
> > >
> >
> > Thanks Jan for your response. As suggested, adding WARN_ON_ONCE() will =
be
> > more sensible.
> > I just wanted to clarify my understanding, you are suggesting adding
> > WARN_ON_ONCE() in try_to_free_buffers() as this highlights the issue an=
d
> > also solves the concern. If my understanding is wrong please let me kno=
w,
> > I will share the updated patch.
>
> Yes, I meant something like:
>
>         if (WARN_ON_ONCE(!folio_buffers(folio)))
>                 return true;
>
> in try_to_free_buffers().
>

Yes this is what I am also going for, just a minor change that I was
going to return false.

Reason:
From the flow it should return false whenever failed to free buffers /
operation
couldn't complete. Do you think otherwise.

> > > Also I think mapping_set_release_always() should assert that
> > > mapping->a_ops->release_folio is non-NULL to catch the problem early =
(once
> > > you fix the AFS bug).
> > >
> >
> > I will address this in another patch for AFS.
>
> Thanks. As a separate patch please :)
>
>                                                                 Honza

Yes.

Regards,
Deepak Karn


