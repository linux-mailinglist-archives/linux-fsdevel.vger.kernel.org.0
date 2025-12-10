Return-Path: <linux-fsdevel+bounces-71066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B16CB3525
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 16:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EE4D303C287
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D7732471C;
	Wed, 10 Dec 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhR807au";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRvZetjl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0380430AD05
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380558; cv=none; b=CS0+07EtGmL7f3bx9JYHtIFZEJQEx3rA5zNe9U+WpwkyCpqTlznmtas5LQjEf4qlmrHZ/kYh2vub9I6olkZCblas3wsOphXSKPn6JlLfyZW9ARJQGSgllXyYvqAsYQZFgSOHUVbvgzWr32g6m/ycmoEDsIFd5HXwEFf51XEo/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380558; c=relaxed/simple;
	bh=lDvUkIt4DfXBy5oCSUUSe8t2srbBSGC4+Je7Xv6vk4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhcST9WbQ8RrzAzTiDT3Upb8Xr5+unrdMMlRWdFA3PO+OCm5CL9N1M0WOh5Rjh2+dBVjyyuY7ReVhM2QEP/DzOu2VDnugcjmgQj0j3RlhiMKRwie8nK6pwBfd89dC0GrLwG0z/kRSYsWqX+qcgDi5yu62ZL4NOFGqlmbTLJXz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhR807au; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRvZetjl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765380556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Db0TkqKtXHy5gSEgDOa1+ty9n2WhCMHIyw820W5VaX4=;
	b=XhR807auCT8RQmsTC3Io1WiwBvtc5SRaBGP+jGAvqV7j80Yksxm93EoK0uZAAp8espR05b
	ay0PF/5mjNXCFu17mzhd2Csp3bOcmaVWmzTmWsEgqmJfqo+h3hPFtKSrZGJUHwSrK3Ikbn
	nWOmxZYegSuCSd62a5xfF3g96cGzFE0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Uwwfc6KmN2WCzU88qukpaA-1; Wed, 10 Dec 2025 10:29:14 -0500
X-MC-Unique: Uwwfc6KmN2WCzU88qukpaA-1
X-Mimecast-MFC-AGG-ID: Uwwfc6KmN2WCzU88qukpaA_1765380553
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64097bef0e2so9699241a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 07:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765380553; x=1765985353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db0TkqKtXHy5gSEgDOa1+ty9n2WhCMHIyw820W5VaX4=;
        b=TRvZetjleRVWW/kp1+OO5/c4CWMsva6SiJuyuG0lPvHffNe4Wbiqqb59YLnKt43vVR
         qlSkyMPn6GRwsGrQw5Y+JKm4VPMTqmb+RKSbGV3OkSftxEVsIe1ZkZu6C4IAjj5GRjI2
         dgm8qqRjcA3wUl9x6SPYdE+6pJJsdFq37OxNvuPqVTubhZgIsmz2mO+R7qX9S84v7zy4
         9pRfmJZ+lvfjXP2vCRn2HF2wrip7joTrY6dBjFletCwsCL/LIr8wLXQiM+aHtQ1qSGQE
         CCsNxRuDctO8mhEQZ36hkc9/KptfNO8wJdLP4dRkldtteXO5NFqHaWB3jo+SshDjobPG
         VJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765380553; x=1765985353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Db0TkqKtXHy5gSEgDOa1+ty9n2WhCMHIyw820W5VaX4=;
        b=ENe2ETapVruSACpwH5MTvgsxNdIi1fNP1+HRI3lhw/vd3eESNg7sTXYnLYxwiimn7Y
         rQA8gv9Rc4MKMoGw1p4rtlSh+9NzBbgoN/OGH5WRh2L3ATwYP45itwvzehe7VOZGIWQa
         /63BdLBp03b4Qgna+qEmKpmD2auC0PcGmVgGo16efQ+p86m6f7raSFZtOYhsQN7yoTYb
         cvuljZgr6p0tsKWaxOm+IWrUNWCaGYADFZQv9KgvRpuQojGMxrHRyxIoFO7P0+M22UVr
         S3UCTcUSs/pagzCbuBkUkcb//4ww/di0odFLUaK3HWdy4GWYboVDksCEJf1K4nZfeC8C
         PAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG8WYv5yILk8kv3XVdeTXTmo0Z8XXrFBb0UE0WzQMur9e1SxxRLmuCAkNj8rn685pYhtsx0yxnxFl0ocHR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ApIK2XtXr6gtDXDJrc9M65hJmO6PFW2PokTMrFjsJyZrItw+
	YYoL90OiAnabjsL3NctIV9Rw8Zo0PEJJWrFj10T8puJ8bd3jjwgC12DEYshNKQfQDZFwcZXCavc
	JcWOSZHrnqYwdVmdsbXMtOQjde7aVLOHvbFVi4TLtKKm+V8j/MyZ0J3uoYKwhZ89hsREecemPa+
	xVs3ES3pwP6hu21xLHNlFoHKodmnFVwBxeKG/pHndI
X-Gm-Gg: AY/fxX55KKrYu7XXmlB1ruHInGUkfLUTdqcL0JGQlc8wac/NdjUYvj/MrTtG9zHn7Ca
	rIMG61jit50L5zuIgTBlsp7bT4p1YsgdvItscbWEjUvIwr0GyOm+twxHhelqn5wBVEehGTSJb4N
	LXkMwzzlhMFomluBI8iwtnRP7KUBgoU3EQWt2QpcllwlJi8Idw/rMaKXR5pinzBvgJ8q4VNtZfz
	co2nd0oDKC9rIebQ+1AfM1xzg==
X-Received: by 2002:a05:6402:2109:b0:640:7402:4782 with SMTP id 4fb4d7f45d1cf-6496cb20ffemr2811553a12.0.1765380553199;
        Wed, 10 Dec 2025 07:29:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9YQW1fMNzDjIEN0tojiTx5VObmByqqth9/i5m0s2c5ydl7UI1PeyqPdaoonuaZP2+WkVQ1lOgVywt6K4cCQA=
X-Received: by 2002:a05:6402:2109:b0:640:7402:4782 with SMTP id
 4fb4d7f45d1cf-6496cb20ffemr2811527a12.0.1765380552821; Wed, 10 Dec 2025
 07:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208193024.GA89444@frogsfrogsfrogs> <20251208201333.528909-1-dkarn@redhat.com>
 <enzq67rnekrh7gycgvgjc4g5ryt7qvuamaqj3ndpmns5svosa4@ozcepp4lpyls>
 <CAO4qAqK-6jpiFXTdpoB-e144N=Ux0Hs+NOouM6cmVDzV8V-Dcw@mail.gmail.com> <ujd4c2sadpu3fsux2t667ef3zz2i2nyiqvhes4ahbtpay4ba3f@unn3uh57fxdk>
In-Reply-To: <ujd4c2sadpu3fsux2t667ef3zz2i2nyiqvhes4ahbtpay4ba3f@unn3uh57fxdk>
From: Deepak Karn <dkarn@redhat.com>
Date: Wed, 10 Dec 2025 20:59:00 +0530
X-Gm-Features: AQt7F2pyplQsFO_VtwTRBVMFRkJbJ4jXnszuw_KTLOlaB1IAPKfYb_LkPJFIU34
Message-ID: <CAO4qAqLwo+K4qFgWxs6qJ2yKvc+su=SPXS6LC7gJLgfw0aNeyA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: add NULL check in drop_buffers() to prevent null-ptr-deref
To: Jan Kara <jack@suse.cz>
Cc: djwong@kernel.org, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 3:25=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 09-12-25 22:00:04, Deepak Karn wrote:
> > On Tue, Dec 9, 2025 at 4:48=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 09-12-25 01:43:33, Deepakkumar Karn wrote:
> > > > On Mon, 8 Dec 2025 11:30:24 -0800, Darrick J. Wong wrote:
> > > > > > drop_buffers() dereferences the buffer_head pointer returned by
> > > > > > folio_buffers() without checking for NULL. This leads to a null=
 pointer
> > > > > > dereference when called from try_to_free_buffers() on a folio w=
ith no
> > > > > > buffers attached. This happens when filemap_release_folio() is =
called on
> > > > > > a folio belonging to a mapping with AS_RELEASE_ALWAYS set but w=
ithout
> > > > > > release_folio address_space operation defined. In such case,
> > > >
> > > > > What user is that?  All the users of AS_RELEASE_ALWAYS in 6.18 ap=
pear to
> > > > > supply a ->release_folio.  Is this some new thing in 6.19?
> > > >
> > > > AFS directories SET AS_RELEASE_ALWAYS but have not .release_folio.
> > >
> > > AFAICS AFS sets AS_RELEASE_ALWAYS only for symlinks but not for
> > > directories? Anyway I agree AFS symlinks will have AS_RELEASE_ALWAYS =
but no
> > > .release_folio callback. And this looks like a bug in AFS because AFA=
ICT
> > > there's no point in setting AS_RELEASE_ALWAYS when you don't have
> > > .release_folio callback. Added relevant people to CC.
> > >
> > >                                                                 Honza
> >
> > Thank you for your response Jan. As you suggested, the bug is in AFS.
> > Can we include this current defensive check in drop_buffers() and I can=
 submit
> > another patch to handle that bug of AFS we discussed?
>
> I'm not strongly opposed to that (although try_to_free_buffers() would se=
em
> like a tad bit better place) but overall I don't think it's a great idea =
as
> it would hide bugs. But perhaps with WARN_ON_ONCE() (to catch sloppy
> programming) it would be a sensible hardening.
>

Thanks Jan for your response. As suggested, adding WARN_ON_ONCE()
will be more sensible.
I just wanted to clarify my understanding, you are suggesting adding
WARN_ON_ONCE()
in try_to_free_buffers() as this highlights the issue and also solves
the concern. If my
understanding is wrong please let me know, I will share the updated patch.

> Also I think mapping_set_release_always() should assert that
> mapping->a_ops->release_folio is non-NULL to catch the problem early (onc=
e
> you fix the AFS bug).
>

I will address this in another patch for AFS.

Regards,
Deepakkumar Karn


