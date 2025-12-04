Return-Path: <linux-fsdevel+bounces-70629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAA7CA2C6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 09:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C943021FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 08:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F13B30E0FA;
	Thu,  4 Dec 2025 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnJ0Hzva";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aC7uI14V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C022217F27
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836310; cv=none; b=bELI0InyLPjDpje7dviGA3uJEfBqZi4qk05JyLk0cZspwcPyPQQwlLCl9nIdxI+vGar1l7cMaeZQCF2JCO2Q2d4TNAHCnPYBuIbfkUjCyTPjwOboXK+02+L7YMlrZm9fPKMXD4jydgniiVChRlPMMQbzW7Bm55lC5jUdDtuftV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836310; c=relaxed/simple;
	bh=l3n8b//bGBWl/a+YQkuZUxtyHjsFRNdEWLqd85Nfjd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aElDxUnKguwsvXqD94ZXqJH9Z6XsKrNdSeyyjXxPqSDZx4g+0uy0alLkPn27bORzVEGsDRWFnATDQpTOk/aU31nR4IcvrkcbyBHs+pe5iccMrDHtrGfBPwh1X13oxbZVextJ3oTP1lntfLZzhkMMx0jjtoUKvC9U7BagihdX58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnJ0Hzva; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aC7uI14V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764836307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3n8b//bGBWl/a+YQkuZUxtyHjsFRNdEWLqd85Nfjd0=;
	b=UnJ0HzvaJpKdV5Qe94zsreEyGMujVN44MgMpyGZ1bFDdMP2XKFMVAC25E14XLXJ8plouEh
	QL+vet7QoStao0HjSV1Ff+wSml+Hq/ZZnrQpnl/SzzgBwPNItyN8Aq07qLczhpQ4bTO8GJ
	EIxjBG8hLDsxHHadfZhq9sRo8l4tZhg=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-IK6JjgAJPleHR62VbdrEuA-1; Thu, 04 Dec 2025 03:18:26 -0500
X-MC-Unique: IK6JjgAJPleHR62VbdrEuA-1
X-Mimecast-MFC-AGG-ID: IK6JjgAJPleHR62VbdrEuA_1764836306
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5dfb407f31bso283928137.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 00:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764836306; x=1765441106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3n8b//bGBWl/a+YQkuZUxtyHjsFRNdEWLqd85Nfjd0=;
        b=aC7uI14VPynjx+4kfd/SyuFi0Y0yoqUMhblCtkbcIdtI0JW6wuoPfVVHTku3f5bFD2
         142wa+2RYdSCGNTNf/X48huRHTYpJHbX38/fhzHntDO3F7cTGqze3jGwDqwjR+jObASW
         B6pljJlc3l/2gyb8iKLimP6Vka/yOlN/X97a8ktjgpOZazWrzNkPTjvKciaqOJQUlLhF
         h0OHihSomMMqdQujXw8JVoCL5mPfocbG1WBwN36TOYyzz2GbdEVO++xtubMR1u6r1riL
         iix9AvdbBwmqraHNVX/alf+Y2Kp8NGO1wixVRw5dEGwb4GFn78XgzS0RnziwMNVPW98u
         PmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764836306; x=1765441106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3n8b//bGBWl/a+YQkuZUxtyHjsFRNdEWLqd85Nfjd0=;
        b=GMRdok48CR1NW19sZ6AjYndWhCmG8yKZqq0QiZCg/spG+ZO1iNL4eNAhrQa6j59XWC
         qgJAwRbf2fBJOh1vIhLobaMpJgCwejkmXxfmHVAvllM03q+POK7Ht0+A6fvbbOxQSZpA
         DbFXbJMu44uT8FbS3HFF05gpNPqV8OZ5r86ims3t8PLH4AnVQQIqi2hAlREGp2cTCIZI
         FFJG3BDwneuKnGzDQXIe3n+S3GcUuuer9cndIenSXk6MXigfPJJimFYuiNXKchbMN5wk
         ktIYWXGmC9ofN0QZu3VMj2rDZhG4P6ajnzolh83y7ZnlnD81Wca8VsieJz4G4mXWl0zH
         bIqg==
X-Forwarded-Encrypted: i=1; AJvYcCWsuKeiziTYJXSONdvBNNCCss1ORT6bZgMxd11yeeXDP/b+ZXJq4LQKEXjo494aCpr25BngqudOp2t4w+w5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4MQLFljBc/leMaEeuNKF7uRLE04tm+54G4lLYpOOtWWjslmsM
	DAysZupqJQZiQlnjVN29XtAfJ+sKXsnAOss/XTuMzB1DuqNqWf/cYCDrwng7uFF5Fs+DxggHIqa
	cYfhYRVibCG6qP9evDmRC6bGXK+9nsIQtafceG2jjFfpiMdJRWFIM743bZSEhKZoIw65PMa3WvX
	of5AWE3gPMP9Vl4nfK1q2Umn3UBgeMXmNIzYsgRjUyqA==
X-Gm-Gg: ASbGnctGNWLLAO1YRk9LpYSAW3uKA295FPQ/A5ON5Ag5ARrvb7T73iOWecLcRiU5VqF
	YCC+LuaeLYcRmI3MFqXkA0eK8v0T/BWWphOubmFUuDw6TXsuiQFXiTljLpUIpszF5I/0dXtZTWW
	U/FDMU4kBJl24dGFN2aY3aSZc5BLrvGUICyZibSgzNqhKB79ItOw0wTXmeEX9vM3vxk+GH3NdoZ
	QuyH42DXISv
X-Received: by 2002:a05:6102:3f49:b0:5dd:b5a2:b590 with SMTP id ada2fe7eead31-5e48e25d2admr1639476137.16.1764836305820;
        Thu, 04 Dec 2025 00:18:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9259AlA8bpjd7xviHx6Xvbs8Ow4hKJv3lNZaP8woqjVu9DiigswlUGZerpm1NmcWbqdDUoIamKQtZgGmKFUI=
X-Received: by 2002:a05:6102:3f49:b0:5dd:b5a2:b590 with SMTP id
 ada2fe7eead31-5e48e25d2admr1639471137.16.1764836305408; Thu, 04 Dec 2025
 00:18:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203154625.2779153-1-amarkuze@redhat.com> <20251203154625.2779153-5-amarkuze@redhat.com>
 <361062ac3b2caf3262b319003c7b4aa2cf0f6a6e.camel@ibm.com> <CAO8a2SjQDC2qaVV6_jsQbzOtUUdxStx2jEMYkG3VVkSCPbiH_Q@mail.gmail.com>
 <7720f7ee8f8e8289c8e5346c2b129de2592e2d64.camel@ibm.com>
In-Reply-To: <7720f7ee8f8e8289c8e5346c2b129de2592e2d64.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 4 Dec 2025 10:18:14 +0200
X-Gm-Features: AWmQ_bnzTJj_cVx7c8ckoJqlRdYNd6wKsmg7j7g1VnYIuuD5402gvwGbKwcYplU
Message-ID: <CAO8a2SjN0BQqHJme-8WwMP2PKeR_QvKHYrNr96H4ymLTDC8EZw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ceph: adding CEPH_SUBVOLUME_ID_NONE
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is no separate test needed. The client only differs in that the
mount path is for a subvolume.
Regardless its outside the scope of this patchset

On Thu, Dec 4, 2025 at 12:55=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2025-12-03 at 23:22 +0200, Alex Markuze wrote:
> > The latest ceph code supports subvolume metrics.
> > The test is simple:
> > 1. Deploy a ceph cluster
> > 2. Create and mount a subvolume
> > 3. run some I/O
> > 4. I used debugfs to see that subvolume metrics were collected on the
> > client side and checked for subvolume metrics being reported on the
> > mds.
> >
> > Nothing more to it.
> >
>
> So, if it is simple, then what's about of adding another Ceph's test into
> xfstests suite? Maybe, you can consider unit-test too. I've already intro=
duced
> initial patch with Kunit-based unit-test. We should have some test-case t=
hat
> anyone can run and test this code.
>
> Thanks,
> Slava.
>


