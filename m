Return-Path: <linux-fsdevel+bounces-18906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C68F8BE523
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A3AB26F06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270C15FA60;
	Tue,  7 May 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdNZ1WEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA29158D9A
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090617; cv=none; b=e/6MTqC3+sG2FxfyudE67byDzNKmbXIbhWP0xxUGnH2yS9GTVEcwbk1ggoS3onA27CNJ+zdwnoaNYMqludFwaFtVmPaKAN0cKQ021hwo15fXw52UQyDaRckXT9C2T48i9HrJnWlObK4zVlfQb7iwJsU25bXVF8l1ZhVNC8yVk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090617; c=relaxed/simple;
	bh=gCEw21caNIfmQ/eVFgA/vGh57WvCaFBKNkleiETPWIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0EvH+1tYoB3dKY1pNaX62O0MZv5ULvwGOT/SJQjI1XO7sLPmqZ0ukifM/gasb9SC/AkRN4BbpPDE7BrCShTnSEWBrL8nodUC4mR+eSxy9u4HPSV1yQht8akdIp4x6uSyK8nnibtDk8mkUWjIuOl8XNeQpF7uTRbmW0A8LEjQi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdNZ1WEe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715090614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYUHsY9Et7QXM/QxdfCLmQrAZIMY+XTleuvEsuSw7DQ=;
	b=XdNZ1WEerZ8sITOUC6nb9UDhjCTv0aQSMleXFRBqRmFfhfbS68dIwO1MG8o4/q5N1HqBPj
	2QH4IGBgPS7LxE/hZTGM8t2Coxc7PnIUqxQwB9o5unCf28mAIJsbAtJ1OdXsh4emI0E5lh
	wBW9Vhg3EWRK7ljOw57Cs0+UtrM/DbM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-KnwXSHOrMlaPZHslmzQJCg-1; Tue, 07 May 2024 10:03:33 -0400
X-MC-Unique: KnwXSHOrMlaPZHslmzQJCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4DB818008AC
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 14:03:32 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60AE540C6EB7;
	Tue,  7 May 2024 14:03:32 +0000 (UTC)
Date: Tue, 7 May 2024 10:03:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
	vgoyal@redhat.com
Subject: Re: [PATCH] virtiofs: include a newline in sysfs tag
Message-ID: <20240507140330.GD105913@fedora.redhat.com>
References: <20240425104400.30222-1-bfoster@redhat.com>
 <20240430173431.GA390186@fedora.redhat.com>
 <ZjkoDqhIti--j1F5@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TjeDWyY7tQM6+qAr"
Content-Disposition: inline
In-Reply-To: <ZjkoDqhIti--j1F5@bfoster>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


--TjeDWyY7tQM6+qAr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 02:57:18PM -0400, Brian Foster wrote:
> On Tue, Apr 30, 2024 at 01:34:31PM -0400, Stefan Hajnoczi wrote:
> > On Thu, Apr 25, 2024 at 06:44:00AM -0400, Brian Foster wrote:
> > > The internal tag string doesn't contain a newline. Append one when
> > > emitting the tag via sysfs.
> > >=20
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >=20
> > > Hi all,
> > >=20
> > > I just noticed this and it seemed a little odd to me compared to typi=
cal
> > > sysfs output, but maybe it was intentional..? Easy enough to send a
> > > patch either way.. thoughts?
> >=20
> > Hi Brian,
> > Orthogonal to the newline issue, sysfs_emit(buf, "%s", fs->tag) is
> > needed to prevent format string injection. Please mention this in the
> > commit description. I'm afraid I introduced that bug, sorry!
> >=20
>=20
> Hi Stefan,
>=20
> Ah, thanks. That hadn't crossed my mind.
>=20
> > Regarding newline, I'm concerned that adding a newline might break
> > existing programs. Unless there is a concrete need to have the newline,
> > I would keep things as they are.
> >=20
>=20
> Not sure I follow the concern.. wasn't this interface just added? Did
> you have certain userspace tools in mind?

v6.9-rc7 has already been tagged and might be the last tag (I'm not
sure). If v6.9 is released without the newline, then changing it in the
next kernel release could cause breakage. Some ideas on how userspace
might break:

- Userspace calls mount(2) with the contents of the sysfs attr as the
  source (i.e. "myfs\n" vs "myfs").

- Userspace stores the contents of the sysfs attr in a file and runs
  again later on a new kernel after the format has changed, causing tag
  comparisons to fail.

> FWIW, my reason for posting this was that the first thing I did to try
> out this functionality was basically a 'cat /sys/fs/virtiofs/*/tag' to
> see what fs' were attached to my vm, and then I got a single line
> concatenation of every virtiofs tag and found that pretty annoying. ;)

Understood.

> I don't know that is a concrete need for the newline, but I still find
> the current behavior kind of odd. That said, I'll defer to you guys if
> you'd prefer to leave it alone. I just posted a v2 for the format
> specifier thing as above and you can decide which patch to take or not..

The v6.9 release will happen soon and I'm not sure if we can still get
the patch in. I've asked Miklos if your patch can be merged with the
newline added for v6.9. That would solve the userspace breakage
concerns.

Stefan

--TjeDWyY7tQM6+qAr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY6NLIACgkQnKSrs4Gr
c8imIwf/cGlTyLC0oAusrQTR/jG0i9ecG+yseu2J08FYNzPXdSHxly/mEUnnTFFF
Tr/gjLcSMsUVtdIBiJWRPGiWw+g3oMflfB9u8vofSeyhXdv1PiIo+Wtsmx6yswZi
SIsEEMcxKW9qWlgJB6+b+j5RrRgjEgP9lw6yo2G2OGBO01Sz3We74ZG+j850TZos
NZD9YeKR7ZGtj+gxbc8R2UCQmKtKRKCA871QJ0ApNTm/VlpmlTr5r5tIp7HfpRTH
jORGCGlM9I9OedDCkNyNqDo+zzX6hFUz98PR87ajxjh4ynSr/ttg0LRuQXmdpupp
jhvrwgOAdPCFkv2Mu8ref9xYy6wxrg==
=MsnZ
-----END PGP SIGNATURE-----

--TjeDWyY7tQM6+qAr--


