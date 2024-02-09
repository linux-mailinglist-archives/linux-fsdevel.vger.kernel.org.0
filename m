Return-Path: <linux-fsdevel+bounces-10913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCFB84F3B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D671F2A24E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1A82576A;
	Fri,  9 Feb 2024 10:46:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684B25618;
	Fri,  9 Feb 2024 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475603; cv=none; b=UGgeBToaZxlxG8rB1hU5oGPaHNpLlpg8qMzPR2Dzm5bSPBCq8TMI03DscHg4yilYPQFXKBllyxKUinIxKR08TpJqS47UxverQEmDB2NVZmzH/d+23NYumB0nmskfz8GpS7AXVveUWPj3pU9OQf56BCVnNuEE8yt2xUBHgvw1Ua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475603; c=relaxed/simple;
	bh=jOw1k4dV5z+KBAtTbBBTRdl9sL0hz8/ouWgae+bS6oo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GgJR5AQVFKm4FQbXJetV/Brdk+zFLkGm54auFU4e59IeA8YFb7G9o1lNWvmKBBMqP2GnzAc7kPb+uFY7APkfudcrnt3Q2Dqdh/hCZpfNfsAOt8Q/EbQCIBE5PBZX9ckZ/SlvR8b7A7LY3iKk57gMfQsW1Hkb7Er5TbD5xqcVSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TWVWf27KTzB043C;
	Fri,  9 Feb 2024 18:31:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 7784A1406BE;
	Fri,  9 Feb 2024 18:46:36 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD37xh8AsZlACksAg--.15226S2;
	Fri, 09 Feb 2024 11:46:35 +0100 (CET)
Message-ID: <86ab971f45c2ff11dcbdeab78b4b050f07495f55.camel@huaweicloud.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, chuck.lever@oracle.com, jlayton@kernel.org, 
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, 
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com,  dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 dhowells@redhat.com,  jarkko@kernel.org, stephen.smalley.work@gmail.com,
 eparis@parisplace.org,  casey@schaufler-ca.com, shuah@kernel.org,
 mic@digikod.net,  linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,  linux-nfs@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org,  selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Date: Fri, 09 Feb 2024 11:46:16 +0100
In-Reply-To: <20240209-luftleer-jobangebote-6d6ab29b7191@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
	 <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
	 <20240209-luftleer-jobangebote-6d6ab29b7191@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD37xh8AsZlACksAg--.15226S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr15Xr1UuryUJF47uw13CFg_yoW8ury8pa
	y5G3Z8GFykGFy7CF93ZFZ8Za4F9392qFWUXrZ3X34UAF9FqrnI9F42krn5WFn8Kr1xKr1I
	vw429r9xu34UArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj5o2JQAAs1

On Fri, 2024-02-09 at 11:12 +0100, Christian Brauner wrote:
> On Mon, Jan 15, 2024 at 07:17:56PM +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > In preparation to move IMA and EVM to the LSM infrastructure, introduce=
 the
> > file_post_open hook. Also, export security_file_post_open() for NFS.
> >=20
> > Based on policy, IMA calculates the digest of the file content and
> > extends the TPM with the digest, verifies the file's integrity based on
> > the digest, and/or includes the file digest in the audit log.
> >=20
> > LSMs could similarly take action depending on the file content and the
> > access mask requested with open().
> >=20
> > The new hook returns a value and can cause the open to be aborted.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  fs/namei.c                    |  2 ++
> >  fs/nfsd/vfs.c                 |  6 ++++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 ++++++
> >  security/security.c           | 17 +++++++++++++++++
> >  5 files changed, 32 insertions(+)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 71c13b2990b4..fb93d3e13df6 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3620,6 +3620,8 @@ static int do_open(struct nameidata *nd,
> >  	error =3D may_open(idmap, &nd->path, acc_mode, open_flag);
> >  	if (!error && !(file->f_mode & FMODE_OPENED))
> >  		error =3D vfs_open(&nd->path, file);
> > +	if (!error)
> > +		error =3D security_file_post_open(file, op->acc_mode);
>=20
> What does it do for O_CREAT? IOW, we managed to create that thing and we
> managed to open that thing. Can security_file_post_open() and
> ima_file_check() fail afterwards even for newly created files?

$ strace touch test-file
...
openat(AT_FDCWD, "test-file", O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK, 0666) =
=3D -1 EPERM (Operation not permitted)

The open fails, but the file is there. I didn't see warnings/errors in
the kernel log.

Roberto


