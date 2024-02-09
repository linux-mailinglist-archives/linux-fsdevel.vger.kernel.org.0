Return-Path: <linux-fsdevel+bounces-10943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F290F84F4FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B800D28C7E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A32328B1;
	Fri,  9 Feb 2024 12:03:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3812E630;
	Fri,  9 Feb 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480211; cv=none; b=CXrAZ42b1z5HqaoB0Sn778zf1t4xyZH0kN+ddfOQDYZrizn9Ba5xTCs9G0FIy3lXwGHKF0pGAnB2dRarUL8M2CUJyjwdcYwWseTJW0MWA0JrgNXMAVuRo+8Gmgwuu5w8yIgfi0EuM3lay/YwVkCTV5rYQEeDtWamWrM6y/ZuiaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480211; c=relaxed/simple;
	bh=BhA/UikenM4m0IyfeHs3E+dkP69p7UWIJfw5VFHgk24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=brJx/cQC5LWOZnAB7EiCvcPfLjwyigMZaHefHf1hZyqHCwZh4ThybmE52nP5ARE0e50TmXZEEBD+TO+mV2w5BbAQASuTVnKtgyjHUnzHnKZ7S7wckaYJgH0+F0KRz43oVDuKke+K6FfAHDqNY1l7ILNKjUEDXUfvd4JtboShyn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TWXDB6LM8z9xvhR;
	Fri,  9 Feb 2024 19:48:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id DB61B14086B;
	Fri,  9 Feb 2024 20:03:09 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXBChtFMZlv1EoAg--.21619S2;
	Fri, 09 Feb 2024 13:03:09 +0100 (CET)
Message-ID: <f61cb90858d866ed3eb7a2b607152c4aa2a52f5d.camel@huaweicloud.com>
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
Date: Fri, 09 Feb 2024 13:02:49 +0100
In-Reply-To: <20240209-giert-erlenholz-b131fa85ee36@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
	 <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
	 <20240209-luftleer-jobangebote-6d6ab29b7191@brauner>
	 <86ab971f45c2ff11dcbdeab78b4b050f07495f55.camel@huaweicloud.com>
	 <20240209-giert-erlenholz-b131fa85ee36@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAXBChtFMZlv1EoAg--.21619S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4UAr1ftFWDuF4xKF17KFg_yoW8Kw4rpa
	y5J3Z8GF4kGry7Cr9IvF90qFnYg392qFyUXrZxX34UArnFqrnI9F47Cr15uFyqqr1xGr10
	vr429r9xWr1UArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj5Y3PwAAsh

On Fri, 2024-02-09 at 12:34 +0100, Christian Brauner wrote:
> On Fri, Feb 09, 2024 at 11:46:16AM +0100, Roberto Sassu wrote:
> > On Fri, 2024-02-09 at 11:12 +0100, Christian Brauner wrote:
> > > On Mon, Jan 15, 2024 at 07:17:56PM +0100, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > In preparation to move IMA and EVM to the LSM infrastructure, intro=
duce the
> > > > file_post_open hook. Also, export security_file_post_open() for NFS=
.
> > > >=20
> > > > Based on policy, IMA calculates the digest of the file content and
> > > > extends the TPM with the digest, verifies the file's integrity base=
d on
> > > > the digest, and/or includes the file digest in the audit log.
> > > >=20
> > > > LSMs could similarly take action depending on the file content and =
the
> > > > access mask requested with open().
> > > >=20
> > > > The new hook returns a value and can cause the open to be aborted.
> > > >=20
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > ---
> > > >  fs/namei.c                    |  2 ++
> > > >  fs/nfsd/vfs.c                 |  6 ++++++
> > > >  include/linux/lsm_hook_defs.h |  1 +
> > > >  include/linux/security.h      |  6 ++++++
> > > >  security/security.c           | 17 +++++++++++++++++
> > > >  5 files changed, 32 insertions(+)
> > > >=20
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index 71c13b2990b4..fb93d3e13df6 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -3620,6 +3620,8 @@ static int do_open(struct nameidata *nd,
> > > >  	error =3D may_open(idmap, &nd->path, acc_mode, open_flag);
> > > >  	if (!error && !(file->f_mode & FMODE_OPENED))
> > > >  		error =3D vfs_open(&nd->path, file);
> > > > +	if (!error)
> > > > +		error =3D security_file_post_open(file, op->acc_mode);
> > >=20
> > > What does it do for O_CREAT? IOW, we managed to create that thing and=
 we
> > > managed to open that thing. Can security_file_post_open() and
> > > ima_file_check() fail afterwards even for newly created files?
> >=20
> > $ strace touch test-file
> > ...
> > openat(AT_FDCWD, "test-file", O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK, 066=
6) =3D -1 EPERM (Operation not permitted)
>=20
> Ah, meh. I was hoping IMA just wouldn't care about this case.

Actually it doesn't. I added code to artifically create the situation
(to see what happens if a new LSM does that).

Roberto


