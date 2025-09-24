Return-Path: <linux-fsdevel+bounces-62583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC9CB9A220
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA80164763
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46CA3009F6;
	Wed, 24 Sep 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="Po2DuBhX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B782E2657
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722270; cv=none; b=FTmW0AC+FdFGuVywOTdupcUebty3NEA3bDiG7OrmivvAn78MRhossw9AtU4We9O3+hBnHzHPPPSB3Z3lJRHAS9XoNIQuPzwkYATbtIEia/RjQdxoNSwkphZ93Qq2lTM5/zeAKpmmlITTwi5Ai4+OQ5kTBpvSx1MCrqprvveDPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722270; c=relaxed/simple;
	bh=zK0d+jat/vDaaPlGtVMYSekvXbcXkoFLrAu7KvbCrTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cVS28xWE3NcJtCqRjZ9jpwl8OoYzdbMe4of2wTas2Rc8zEuTb4Gz/+zhoMXGo1UafgzVMRWnO1ssWhtwRml5F0EYRdOFSPKmtxosJDofLSf94xCSO3BxhodLYsDdbAiCXrigqu3Aok2yBgQyvYAX7eGstsraAI1gIuFiEsYJA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=Po2DuBhX; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1758722264; h=message-id
 : subject : from : to : cc : date : in-reply-to : references :
 content-type : content-transfer-encoding : mime-version : from;
 bh=zK0d+jat/vDaaPlGtVMYSekvXbcXkoFLrAu7KvbCrTo=;
 b=Po2DuBhXjvvjs2I+VefxbzzlnVlsIHVz0/Qs96htur7lpWgs2G1AMgfpNPLkvBlPy4bel
 0Ffe6+7t2/QIDraC+3NM4n+jC5dRtntP9SP46P64nxx2hSS0SmWgokXovzh1zHIKu9YpwNL
 UIRoQokXYwMOLirB/F2ysSWNBAKLxR2rO/4y/1Y+pBCCPSszYj/zoWcAxjgMPG6lslidLBE
 S9Jl+iuOk/POzV38YnbPwkqs2lOMd3kJW8kekXXEw/+GQFs1Ri4SHhpoRgrh9fZlcSCuMnw
 62zVcS81flJkIGAZCbJ5Fk7PTfqWF/ZFR4LTzKEzbT1Hm3LSomBv/g61rmXA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id CA40C5FC04;
	Wed, 24 Sep 2025 15:57:44 +0200 (CEST)
Received: from [141.24.207.96] (unknown [141.24.207.96])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id A97285FB67;
	Wed, 24 Sep 2025 15:57:43 +0200 (CEST)
Message-ID: <d86114929063d12dce4110c730df2afd2c17a551.camel@tu-ilmenau.de>
Subject: Re:  [PATCH] ceph: Fix log output race condition in osd client
From: Simon Buttgereit <simon.buttgereit@tu-ilmenau.de>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, 
 "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>
Date: Wed, 24 Sep 2025 15:57:43 +0200
In-Reply-To: <0444d05562345bba4509fb017520f05e95a3e1b3.camel@ibm.com>
References: <20250923110809.3610872-1-simon.buttgereit@tu-ilmenau.de>
	 <0444d05562345bba4509fb017520f05e95a3e1b3.camel@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-23 at 17:27 +0000, Viacheslav Dubeyko wrote:
> On Tue, 2025-09-23 at 13:08 +0200, Simon Buttgereit wrote:
> > OSD client logging has a problem in get_osd() and put_osd().
> > For one logging output refcount_read() is called twice. If recount
> > value changes between both calls logging output is not consistent.
> >=20
> > This patch adds an additional variable to store the current
> > refcount
> > before using it in the logging macro.
> >=20
> > Signed-off-by: Simon Buttgereit <simon.buttgereit@tu-ilmenau.de>
> > ---
> > =C2=A0net/ceph/osd_client.c | 10 ++++++----
> > =C2=A01 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index 6664ea73ccf8..b8d20ab1976e 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -1280,8 +1280,9 @@ static struct ceph_osd *create_osd(struct
> > ceph_osd_client *osdc, int onum)
> > =C2=A0static struct ceph_osd *get_osd(struct ceph_osd *osd)
> > =C2=A0{
> > =C2=A0	if (refcount_inc_not_zero(&osd->o_ref)) {
> > -		dout("get_osd %p %d -> %d\n", osd,
> > refcount_read(&osd->o_ref)-1,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0 refcount_read(&osd->o_ref));
> > +		unsigned int refcount =3D refcount_read(&osd-
> > >o_ref);
> > +
> > +		dout("get_osd %p %d -> %d\n", osd, refcount - 1,
> > refcount);
>=20
> Frankly speaking, I don't see the point in this change. First of all,
> it's the
> debug output and to be really precise could be not necessary here.
> And it is
> easy to make correct conclusion from the debug output about real
> value of
> refcount, even if value changes between both calls. Secondly, more
> important,
> currently we have=C2=A0 refcount_read() as part of dout() call. After thi=
s
> change,
> the refcount_read() will be called and assigned to refcount value,
> even if we
> don't need in debug output.
>=20
> Are you sure that you can compile the driver without warnings if
> CONFIG_DYNAMIC_DEBUG=3Dn?
>=20
> Thanks,
> Slava.
>=20
> > =C2=A0		return osd;
> > =C2=A0	} else {
> > =C2=A0		dout("get_osd %p FAIL\n", osd);
> > @@ -1291,8 +1292,9 @@ static struct ceph_osd *get_osd(struct
> > ceph_osd *osd)
> > =C2=A0
> > =C2=A0static void put_osd(struct ceph_osd *osd)
> > =C2=A0{
> > -	dout("put_osd %p %d -> %d\n", osd, refcount_read(&osd-
> > >o_ref),
> > -	=C2=A0=C2=A0=C2=A0=C2=A0 refcount_read(&osd->o_ref) - 1);
> > +	unsigned int refcount =3D refcount_read(&osd->o_ref);
> > +
> > +	dout("put_osd %p %d -> %d\n", osd, refcount, refcount -
> > 1);
> > =C2=A0	if (refcount_dec_and_test(&osd->o_ref)) {
> > =C2=A0		osd_cleanup(osd);
> > =C2=A0		kfree(osd);

Hi Slava,
thank you for your quick answer.

I checked it again: I built the kernel with gcc 15.2.1 with -Werror and
CONFIG_DYNAMIC_DEBUG=3Dn and everything ran through fine without any
errors.
I guess because of the way no_printk(fmt, ...) is built.

And for sure, this is only debug output, but right now, there is a race
condition, which I went into, and in my opinion this should be fixed.
Another option, which would be completely fine for me, could be to
remove one recount_read call. This would result in something like:

dout("get_osd %p; new refcount =3D %d\n", osd, refcount_read(&osd-
>o_ref));

If you have another idea on how to handle this I'm open to your
suggestions.

Best Regards
Simon

