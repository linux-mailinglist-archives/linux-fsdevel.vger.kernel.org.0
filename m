Return-Path: <linux-fsdevel+bounces-40287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA82A21B0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 11:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E249418881EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FFE1B395F;
	Wed, 29 Jan 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA7iT9ap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6A1B042F
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738147199; cv=none; b=FkOeMeP0GGuNwllZF8QKNM9zBK8LRB1sXRoCQsa1V/CPLWTEwhoGV9YtsH2VRAZMbjCeMmB6jmcGo/PT569m6qgttNLXn1y7t6gw7YCoduT7hguWJz3w0zh5060VHOTEG9gviE2KN7Au379SbzUwa2ZgHCLyu3q0CjXJnVRmQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738147199; c=relaxed/simple;
	bh=vssPK0nD1/h5wGO8AnO890UZ0NQ26xozx/LpQDg4W+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdVTKnwNWm9nZHNsi2qye04HRTzKB/OpGPG8qKvkJmr5W+iR0ZDWjDukm3N2dSnSMasTDTPtwBVi2uLSX8zxlqSDnc0doB3skyspZPY1oyDA4DrdszQ1q2p4uxOmXc9Gkdx2+1KlB2lJlLrc69iOrJouq76W6GUS6h+hEMGCl54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bA7iT9ap; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738147196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqKdBaU8AgySuUL42mOJp5CyJnEGefGCIQtaqxiKjds=;
	b=bA7iT9apCWniMgLf79eqWCM3Vv8ozX4LRinSLl6MlvuCBVwt8rffQpifJAbJZgsdpZgXLb
	YulLlYUsqWgs6eZ3pU4QUZC2yBCJqFIpMDR5TiHzOiSVSf6GtEk8TrflZlyugeH3nvBxgK
	neHNTDtu8/pkqsjlsn7miAt3W1b/f0k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-zVrGCSfgNSqYY1yXQ3_Xfg-1; Wed, 29 Jan 2025 05:39:54 -0500
X-MC-Unique: zVrGCSfgNSqYY1yXQ3_Xfg-1
X-Mimecast-MFC-AGG-ID: zVrGCSfgNSqYY1yXQ3_Xfg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aafc90962ffso576727966b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 02:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738147193; x=1738751993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqKdBaU8AgySuUL42mOJp5CyJnEGefGCIQtaqxiKjds=;
        b=otohez0TXdRM5WAkp1IpSBjexPse8iErLXYH/NdJIs2yKLmBBucQh7VQGsC4WZuL9h
         mEFaj8FV+s5PNGJwrnLxkU7bgfSNH8OZ0HPwf6Dy+GdJWPqJfJzoiIFNWE01jedcrw2g
         YfwX8fSkNWuLP7O7RnnMdV2luEzGz+Ny2z/S11CkIpF6oSHJPhnQywHM3wEgBIfjJwXM
         AjUOjvBrA5C8jpSoAOI/1clL6H3VIaOKr/RREPwlP42LQGZlsXGazpIbQx2FQEsxd6qu
         5fujrVO9IES5RvCdl/vn1hbq82uAaleFVV2Ii8Qu0iblR5i35SjgBW5I3CIRJDAijKoF
         DtmA==
X-Forwarded-Encrypted: i=1; AJvYcCUilUzkr2EM9nzd7F7zdhxDvx5LPBUCX8PuecUzIWLrUXCOxKf/vGFOuZ7NldP2rPetbOWnMmnGtFwdgwiH@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ0DsMcLIunKYap17hpIoNqMdW+a5I5Ro5g9CLNPQIfy6n6vyd
	FMBCVHC1xYD5aDZ5frJXAPqdI5nG6EI6Ch9JpsawgIRNDIRxyfysn8cAfb1dCcJy5MZjTmRK1Dz
	QNNAPMw6VKbiTX0xnZ0rCtC+psQJUBj4KFGBaxlr5SF+7LNqFteJwN4K/oGzTsrdwGA8r3DqfeH
	qQREyfmzDBhOxbNMxaTPnb0ZkdEiQqvpP0lIWTug==
X-Gm-Gg: ASbGncsqDTI5F13iTLO41O1Z03IIHOXk0mjnBxHFuaVI4ejoZstxAQdBJvpZcvB/2Ku
	ANvhu5WTEn6z6Jn7HVt/ybZglTjomsh2afBYTXzEiF9d/pDWowSknI6IahDBg6w==
X-Received: by 2002:a17:907:7e9b:b0:ab3:8a8a:d1f2 with SMTP id a640c23a62f3a-ab6cfcec5b3mr255752266b.30.1738147193563;
        Wed, 29 Jan 2025 02:39:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyFzyC2+HvmiMTx04zDA2PVOfmL5xBeKfn9//agHjDTMjpjdsGqF9ldi9QNee/dMv8uaKgQRWKq8je6TuELi4=
X-Received: by 2002:a17:907:7e9b:b0:ab3:8a8a:d1f2 with SMTP id
 a640c23a62f3a-ab6cfcec5b3mr255750866b.30.1738147193239; Wed, 29 Jan 2025
 02:39:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d81a04646f76e0b65cd1e075ab3d410c4b9c3876.camel@ibm.com>
 <3469649.1738083455@warthog.procyon.org.uk> <3406497.1738080815@warthog.procyon.org.uk>
 <c79589542404f2b73bcdbdc03d65aed0df17d799.camel@ibm.com> <20250117035044.23309-1-slava@dubeyko.com>
 <988267.1737365634@warthog.procyon.org.uk> <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com>
 <3532744.1738094469@warthog.procyon.org.uk> <3541166.1738103654@warthog.procyon.org.uk>
 <dbf086dc3113448cb4efaeee144ad01d39d83ea3.camel@ibm.com>
In-Reply-To: <dbf086dc3113448cb4efaeee144ad01d39d83ea3.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 29 Jan 2025 12:39:42 +0200
X-Gm-Features: AWEUYZkVowFG0DSSVKfP0k9iLKhZDVEpVrcbNliuzS_T00BMUs422_jSDRIbFek
Message-ID: <CAO8a2SjrDL5TqW70P3yyqv8X-B5jfQRg-eMTs9Nbntr8=Mwbog@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: David Howells <dhowells@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI, This the set of fscrypt of tests that keep failing, w/o this patch.
Many of these revoke keys mid I/O.
generic/397
generic/421  #Test revoking an encryption key during concurrent I/O.
generic/429. #Test revoking an encryption key during concurrent I/O.
And additional fscrypt races
generic/440. #Test revoking an encryption key during concurrent I/O.
generic/580  #Testing the different keyring policies - also revokes
keys on open files
generic/593  #Test adding a key to a filesystem's fscrypt keyring via
an "fscrypt-provisioning" keyring key.
generic/595  #Test revoking an encryption key during concurrent I/O.

p.s
generic/650 is yanking CPUs mid run so may also sporadically fail.
unrelated to fscrypt.

On Wed, Jan 29, 2025 at 12:37=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Tue, 2025-01-28 at 22:34 +0000, David Howells wrote:
> > Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:
> >
> > > And even after solving these two issues, I can see dirty memory pages=
 after
> > > unmount finish. Something wrong yet in ceph_writepages_start() logic.=
 So, I am
> > > trying to figure out what I am missing here yet.
> >
> > Do you want me to push a branch with my tracepoints that I'm using some=
where
> > that you can grab it?
> >
>
> Sounds good! Maybe it can help me. :)
>
> Thanks,
> Slava.
>
>


