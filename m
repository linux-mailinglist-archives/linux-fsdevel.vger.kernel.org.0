Return-Path: <linux-fsdevel+bounces-11330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E63C852BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45A21F24287
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC8E22636;
	Tue, 13 Feb 2024 08:57:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36A22611;
	Tue, 13 Feb 2024 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814657; cv=none; b=Jh/bHSlhgFaivI7wPGYfZIPelqBR+yulIuFKiMecYhaAImGuJbcbbXsHDZcnLk2/t6lvR96vH1TvvctK3v20k6TAAAaIAFvs+18gVzWdc6iHk82hiH4fUgM9gdbH65YV8EIAarIWibAwlsAv5cvfSXUi6qirWXcCouPYp0qwdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814657; c=relaxed/simple;
	bh=0FHVuXSnOE5TFanr4pfTOtnrDKxeRonirC9x/EUdZ3I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MrigbQprRU1wL8QBd+VQc/0B6pNkylymZahq70ChfryBMyZ5T9mwG/yEvlJVSM5Z/rpMjFj99+XnBpAZHajZGxl0j7BcbtjjCXEQb2humF0XMJkqzfVBj2DwauckyNWdi9aRqrM8FboX0egA17dsRrG5I7qHVVpjbEzkBFQUjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TYvvq0G2Dz9v7VH;
	Tue, 13 Feb 2024 16:42:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 1A6BC1405A1;
	Tue, 13 Feb 2024 16:57:24 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDHsibjLstlJFJmAg--.44640S2;
	Tue, 13 Feb 2024 09:57:23 +0100 (CET)
Message-ID: <b95967cd1aa2a4e751a8be3d23f72b7e1db0e4b6.camel@huaweicloud.com>
Subject: Re: [PATCH v9 19/25] integrity: Move
 integrity_kernel_module_request() to IMA
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Stefan Berger <stefanb@linux.ibm.com>, Paul Moore <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, 
	jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Tue, 13 Feb 2024 09:57:03 +0100
In-Reply-To: <7940b9d0-3133-4b08-b397-ad9ee34e3b34@linux.ibm.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
	 <20240115181809.885385-20-roberto.sassu@huaweicloud.com>
	 <fd6ddc3d-e5d3-4b9c-b00b-ac2b1f22d653@linux.ibm.com>
	 <CAHC9VhTY=X7z5SRQZzFe25FGB2E3FBBkuZ_YYA1+ETyr7pv=tA@mail.gmail.com>
	 <7940b9d0-3133-4b08-b397-ad9ee34e3b34@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDHsibjLstlJFJmAg--.44640S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4xJFy3Kr4UWrWDCF1fXrb_yoW5Gr18pF
	WrKanYyFWDXrn5Cay8Xw17WrWSgayxCrZxGrn5GrWfWrsY9rnFvF42yF4UuFZakrn7Jr1j
	9397Jw1Ivr98Z37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOlksDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBF1jj5ZOIgABsA

On Mon, 2024-02-12 at 15:28 -0500, Stefan Berger wrote:
>=20
> On 2/12/24 12:56, Paul Moore wrote:
> > On Mon, Feb 12, 2024 at 12:48=E2=80=AFPM Stefan Berger <stefanb@linux.i=
bm.com> wrote:
> > > On 1/15/24 13:18, Roberto Sassu wrote:
> >=20
> > ...
> >=20
> > > > +/**
> > > > + * ima_kernel_module_request - Prevent crypto-pkcs1pad(rsa,*) requ=
ests
> > > > + * @kmod_name: kernel module name
> > > > + *
> > > > + * We have situation, when public_key_verify_signature() in case o=
f RSA > + * algorithm use alg_name to store internal information in order t=
o
> > > > + * construct an algorithm on the fly, but crypto_larval_lookup() w=
ill try
> > > > + * to use alg_name in order to load kernel module with same name.
> > > > + * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel mo=
dules,
> > > > + * we are safe to fail such module request from crypto_larval_look=
up().
> > > > + *
> > > > + * In this way we prevent modprobe execution during digsig verific=
ation
> > > > + * and avoid possible deadlock if modprobe and/or it's dependencie=
s
> > > > + * also signed with digsig.
> > >=20
> > > This text needs to some reformulation at some point..
> >=20
> > There is no time like the present.  If you have a suggestion I would
> > love to hear it and I'm sure Roberto would too.
> >=20
>=20
> My interpretation of the issue after possibly lossy decoding of the=20
> above sentences:
>=20
> Avoid a deadlock by rejecting a virtual kernel module with the name=20
> "crypto-pkcs1pad(rsa,*)". This module may be requested by=20
> crypto_larval_lookup() while trying to verify an RSA signature in=20
> public_key_verify_signature(). Since the loading of the RSA module may=
=20
> itself cause the request for an RSA signature verification it will=20
> otherwise lead to a deadlock.

I can be even more precise I guess (I actually reproduced it).

Avoid a verification loop where verifying the signature of the modprobe
binary requires executing modprobe itself. Since the modprobe iint-
>mutex is already held when the signature verification is performed, a
deadlock occurs as soon as modprobe is executed within the critical
region, since the same lock cannot be taken again.

This happens when public_key_verify_signature(), in case of RSA
algorithm, use alg_name to store internal information in order to
construct an algorithm on the fly, but crypto_larval_lookup() will try
to use alg_name in order to load a kernel module with same name.

Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
we are safe to fail such module request from crypto_larval_lookup(),
and avoid the verification loop.

Roberto


