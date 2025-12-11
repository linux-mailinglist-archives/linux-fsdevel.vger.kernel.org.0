Return-Path: <linux-fsdevel+bounces-71115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACCECB5EFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E43F3028E75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 12:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6373126A1;
	Thu, 11 Dec 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhFV0N0p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0gZD3Sv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126F831196D
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457475; cv=none; b=NV+OBfnbOKhw3FF/VU8pL6QgSRhpqDZPMiiS+dQwHBgkMoSgIamJBnsaiJOBfGLqpdC7kL4ahmbFwSzlZiPnzPSJLo10ONkvd76YWzfSZLKYUJevZ4OVuI1q8jQL1L3uDvApdb66l8nyy7AcRDt6VipviKyTYGxG1AlZ6CYacyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457475; c=relaxed/simple;
	bh=bTBEwrk/+Dhw8RTvssUvRZonsLskWCt4VwLEu+F/Kms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6SAch7YNABuFKavicOtWjTbXD63eIrSaMQkbmPzMBfUHX4wuCKB0DuRSAEl0OiAToVTSg7PMNnC9yxwBii9Ymmjq9p1sZj+G2aGDrPDa7Tr8QI3x0D9IXrvfqA+tJqELaoBCYYAWrJZzPLl7U1+0ed+6r8v/3MbirZZcVcNs+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhFV0N0p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0gZD3Sv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765457472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fd3wi9/SNA02ShQpBUkt6n6w2JgF1qnJF43gb9Zt34E=;
	b=VhFV0N0pxEcOdyU+bfG5Ar0VAGuhuDXg7Q7w+y2WYhgtQW2Soe1wvoef6bk2/ILK0yqqMU
	Nz2EYJbCQfIdQAuRAS19t0Y2OywRVFkBLsL23pUf80RCa+mErLeW2ceezGjJFLj2ki4aIT
	3qme8PeTh98Ci3t7lnx0zMswKubOEYI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-8eU-L2E3NAyid8HId0qpgg-1; Thu, 11 Dec 2025 07:51:11 -0500
X-MC-Unique: 8eU-L2E3NAyid8HId0qpgg-1
X-Mimecast-MFC-AGG-ID: 8eU-L2E3NAyid8HId0qpgg_1765457470
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64986fceb33so49927a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 04:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765457470; x=1766062270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd3wi9/SNA02ShQpBUkt6n6w2JgF1qnJF43gb9Zt34E=;
        b=M0gZD3Sv6TIZzyKeu5StCePCuFhAmdd2cZcUzmJWkEijXsp1wxCe6WKOnYvztSkMoT
         L/3Vw4FUn8db+Q5wctY1lFVItsYFjpPQjZlUlNPWy38936g59wC6KnHPkrRY/6pqSDwd
         7SznF/zhHKYm1PyMTvsmQDOaw5g0QIluVqKoiw2oT9D/T2B5tsmw0KoUOUcN4OGr2Cul
         zmVM6YVMdvGPRjoBYtJ2KcH0c51p9cUidxLSItvLx8VtNHQuoD1eAI0QdQdwG8G1ghnN
         k6sGhg/YXrNcDLDqssbCFsZkRIK4c9dOUy4SwVSsur5+MOxPF4yCyB4NYEbkdpOk2qcf
         q6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457470; x=1766062270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fd3wi9/SNA02ShQpBUkt6n6w2JgF1qnJF43gb9Zt34E=;
        b=jpQM0HiT2oCOEqfJeCgDepomTB1WtDNxoyx+7BlM5AS0U7NgDxKsW175wzIYmvqBB0
         bQX7VyNNvbzOyDHBosSFH+GcwtQ9WjQGhr7fjf0CLqfF+erk20c/pYt7P8ow/YQMLv6m
         TjSSafTrnUagT6h+WRHci80xIVJpxmytdqSVE7RUh754Zw+L4sSJ4hUy3bGL4DwaZn2B
         LkB3dCvJsknG9dL904ScTsyOrVtK820ZecX+cWDltrVGeSYc9DfrbxGgk0kTXxQWILzV
         Q7RKxAWy4l9UivJ/gtuVP08psZ9Q7UHGu4YscGtGuuLSa+oz1clAt4PGyL6RV7m4Ga49
         twOA==
X-Forwarded-Encrypted: i=1; AJvYcCUjymmI/7yJJ9ZAHJSSNtSEfWKA+WMdIohUM/XVFI86QyTeYj6UQXSQ/T0m7sWS6PwWMRVnH47tgpSi6K80@vger.kernel.org
X-Gm-Message-State: AOJu0YydV4gaM9wpCuTxM1PhEXem2pewbpoDniCNoWUKl7+xOhQUOGNu
	reATyu5jHk6WGnduXHgssa9i6z7Xkjdnghff/HjWEOCUVmSls46iHjMQPEgxUrciYLRpVhC49tV
	ZoXEAEpNxOnr4chUC7O8Wpnm2Van2Au8uHSqp+byFEKUw3zUs9Ok7SdQ8TSzvStMW4ycYsQDUk8
	tLgUp3X4xMy/7CpFJva0g09qLTEuqjUdBdeO/AkyR9
X-Gm-Gg: AY/fxX4hH+GD4w3etcXdMwatIdX1pcWjxVqgTNtQNjPEVO/kJaBg2WyYLO1d5vUIDrQ
	uGxa8AXTBS34AY9RnBwNprocE6WQRsHDHuEPQxxBeDufnuKqgQMB7fjc7eTzXGl5p71MGHKLSLc
	0x5qPe0oZiUNDepqiHiHA/7/LPWHOeDcXcZJb+i24RmG8peuaf2hLrsELXM4vneaWouch1TYAIP
	UADosi2l2rPfudxENMUUf3Jvg==
X-Received: by 2002:a05:6402:278c:b0:640:a9b1:870b with SMTP id 4fb4d7f45d1cf-6496cbbcba6mr5288700a12.14.1765457470158;
        Thu, 11 Dec 2025 04:51:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc9pEG/0EnFKe8HzEnL7Sv8GU5wvoVvshl4ZVznLVg6XffJXysq0xbThe4LMxKN/hFS3B7tE0WlpDKxw5QTkA=
X-Received: by 2002:a05:6402:278c:b0:640:a9b1:870b with SMTP id
 4fb4d7f45d1cf-6496cbbcba6mr5288682a12.14.1765457469750; Thu, 11 Dec 2025
 04:51:09 -0800 (PST)
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
 <CAO4qAqLwo+K4qFgWxs6qJ2yKvc+su=SPXS6LC7gJLgfw0aNeyA@mail.gmail.com>
 <cxnggvkjf7rdlif5xzbi6megywkpbqgbley6jsh2zupmwqyiqi@lwzocbqzur5a>
 <CAO4qAq+YJwTgmU=QjAhfxqpKsXJ1sjSz+pniWdW8Yr9zeLGePg@mail.gmail.com> <nydy7jjlfh3komccku32keyyr7mr22j735toad6swucslycyci@rcc5f6vzufvc>
In-Reply-To: <nydy7jjlfh3komccku32keyyr7mr22j735toad6swucslycyci@rcc5f6vzufvc>
From: Deepak Karn <dkarn@redhat.com>
Date: Thu, 11 Dec 2025 18:20:56 +0530
X-Gm-Features: AQt7F2rOdywJaTlQsKs-mzhAWV6PxNAexOeE-C6uG-GFnvmA6d9KK2Y_yf_kMBw
Message-ID: <CAO4qAqJAgO_3tGmoTie2XpCJvHfbZawaOddzdibDkGB9+R+PQw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: add NULL check in drop_buffers() to prevent null-ptr-deref
To: Jan Kara <jack@suse.cz>
Cc: djwong@kernel.org, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 2:46=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 10-12-25 23:20:23, Deepak Karn wrote:
> > On Wed, Dec 10, 2025 at 10:54=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 10-12-25 20:59:00, Deepak Karn wrote:
> > > > On Wed, Dec 10, 2025 at 3:25=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > >
> > > > > On Tue 09-12-25 22:00:04, Deepak Karn wrote:
> > > > > > On Tue, Dec 9, 2025 at 4:48=E2=80=AFPM Jan Kara <jack@suse.cz> =
wrote:
> > > > > > >
> > > > > > > On Tue 09-12-25 01:43:33, Deepakkumar Karn wrote:
> > > > > > > > On Mon, 8 Dec 2025 11:30:24 -0800, Darrick J. Wong wrote:
> > > > > > > > > > drop_buffers() dereferences the buffer_head pointer ret=
urned by
> > > > > > > > > > folio_buffers() without checking for NULL. This leads t=
o a null pointer
> > > > > > > > > > dereference when called from try_to_free_buffers() on a=
 folio with no
> > > > > > > > > > buffers attached. This happens when filemap_release_fol=
io() is called on
> > > > > > > > > > a folio belonging to a mapping with AS_RELEASE_ALWAYS s=
et but without
> > > > > > > > > > release_folio address_space operation defined. In such =
case,
> > > > > > > >
> > > > > > > > > What user is that?  All the users of AS_RELEASE_ALWAYS in=
 6.18 appear to
> > > > > > > > > supply a ->release_folio.  Is this some new thing in 6.19=
?
> > > > > > > >
> > > > > > > > AFS directories SET AS_RELEASE_ALWAYS but have not .release=
_folio.
> > > > > > >
> > > > > > > AFAICS AFS sets AS_RELEASE_ALWAYS only for symlinks but not f=
or
> > > > > > > directories? Anyway I agree AFS symlinks will have AS_RELEASE=
_ALWAYS but no
> > > > > > > .release_folio callback. And this looks like a bug in AFS bec=
ause AFAICT
> > > > > > > there's no point in setting AS_RELEASE_ALWAYS when you don't =
have
> > > > > > > .release_folio callback. Added relevant people to CC.
> > > > > > >
> > > > > > >                                                              =
   Honza
> > > > > >
> > > > > > Thank you for your response Jan. As you suggested, the bug is i=
n AFS.
> > > > > > Can we include this current defensive check in drop_buffers() a=
nd I can submit
> > > > > > another patch to handle that bug of AFS we discussed?
> > > > >
> > > > > I'm not strongly opposed to that (although try_to_free_buffers() =
would seem
> > > > > like a tad bit better place) but overall I don't think it's a gre=
at idea as
> > > > > it would hide bugs. But perhaps with WARN_ON_ONCE() (to catch slo=
ppy
> > > > > programming) it would be a sensible hardening.
> > > > >
> > > >
> > > > Thanks Jan for your response. As suggested, adding WARN_ON_ONCE() w=
ill be
> > > > more sensible.
> > > > I just wanted to clarify my understanding, you are suggesting addin=
g
> > > > WARN_ON_ONCE() in try_to_free_buffers() as this highlights the issu=
e and
> > > > also solves the concern. If my understanding is wrong please let me=
 know,
> > > > I will share the updated patch.
> > >
> > > Yes, I meant something like:
> > >
> > >         if (WARN_ON_ONCE(!folio_buffers(folio)))
> > >                 return true;
> > >
> > > in try_to_free_buffers().
> > >
> >
> > Yes this is what I am also going for, just a minor change that I was
> > going to return false.
> >
> > Reason:
> > From the flow it should return false whenever failed to free buffers /
> > operation couldn't complete. Do you think otherwise.
>
> Well, it's rather we should return false when the page cannot be freed
> because we were unable to free the buffers. When folio_buffers() are NULL=
,
> the page *can* be freed so we should be returning true in that case.
>
Thank you Jan for your response and clarifying this. I will submit an
updated patch.

Regards,
Deepakkumar Karn


