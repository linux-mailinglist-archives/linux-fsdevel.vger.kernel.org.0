Return-Path: <linux-fsdevel+bounces-10741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8E84DAFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B721C21931
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 08:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C20F6A02E;
	Thu,  8 Feb 2024 08:06:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1700569E00;
	Thu,  8 Feb 2024 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379582; cv=none; b=cjYZLj4kTYs4VdNSoShp7XqcaKzv0uX7qIhNPixldXSvlHZtJF7SI3nnPM7UOjXALHwCucZtFLOCOM63uWwXiZ2WNgMn0FIMRXbk4oL8exKB3lKbk2k81gEUrGXI/FEQdiOgwCZYFJHDGeOYYRRXdNLl0yc1cHY9HNl7O+l9W1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379582; c=relaxed/simple;
	bh=/zEYUb4yL29+qOwYug6IGb0qmLwNiMesnkRiO3l7WEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qzpLo+dt2SJzSDf5lkyUu+2LfuulHqzH8Vq7eDBHH6NjDuap0SLXVbzLeKfDETWstDkwhx5JGoRJ0xSj5rQBbaDHFfO9IF4KzgtkRYEHvGjh583SvU+pkeHdMWZQd24DInM/KGwlyawv6h6OZTLabzQtcNJf7k4yArC9+tavq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TVq144pfPzB0Mbw;
	Thu,  8 Feb 2024 15:51:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D29E2140595;
	Thu,  8 Feb 2024 16:06:13 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXEBlli8RlWRYaAg--.2529S2;
	Thu, 08 Feb 2024 09:06:13 +0100 (CET)
Message-ID: <dd8a979df500489c0d8595f9a3f89c801ce6f1c2.camel@huaweicloud.com>
Subject: Re: [PATCH v9 0/25] security: Move IMA and EVM to the LSM
 infrastructure
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de,  kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 jmorris@namei.org,  serge@hallyn.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, dhowells@redhat.com,
 jarkko@kernel.org,  stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com,  shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Thu, 08 Feb 2024 09:05:54 +0100
In-Reply-To: <d54ca249c3071522218c7ba7b4984bab@paul-moore.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
	 <d54ca249c3071522218c7ba7b4984bab@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAXEBlli8RlWRYaAg--.2529S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw17AFy8Jry7Kr13Cw1DGFg_yoW5ZrWrpF
	Z5tayfCF4qqF1I93s7Ar47WrW0kw4kKFyUJFy5Xryvy3Z8GryxJrZ7KFWUZFWDWr4rXayI
	qw17Kr9xZ3WkZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5opbgADst

On Wed, 2024-02-07 at 22:18 -0500, Paul Moore wrote:
> On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > IMA and EVM are not effectively LSMs, especially due to the fact that i=
n
> > the past they could not provide a security blob while there is another =
LSM
> > active.
> >=20
> > That changed in the recent years, the LSM stacking feature now makes it
> > possible to stack together multiple LSMs, and allows them to provide a
> > security blob for most kernel objects. While the LSM stacking feature h=
as
> > some limitations being worked out, it is already suitable to make IMA a=
nd
> > EVM as LSMs.
> >=20
> > The main purpose of this patch set is to remove IMA and EVM function ca=
lls,
> > hardcoded in the LSM infrastructure and other places in the kernel, and=
 to
> > register them as LSM hook implementations, so that those functions are
> > called by the LSM infrastructure like other regular LSMs.
>=20
> Thanks Roberto, this is looking good.  I appreciate all the work you've
> put into making this happen; when I first mentioned this idea I figured
> it would be something that would happen much farther into the future, I
> wasn't expecting to see you pick this up and put in the work to make it
> happen - thank you.

Thanks! I also appreciate a lot your guidance and suggestions.

> I had some pretty minor comments but I think the only thing I saw that
> I think needs a change/addition is a comment in the Makefile regarding
> the IMA/EVM ordering; take a look and let me know what you think.

Oh, I remember well, it is there but difficult to spot...

--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -18,5 +18,6 @@ integrity-$(CONFIG_LOAD_IPL_KEYS) +=3D platform_certs/loa=
d_ipl_s390.o
 integrity-$(CONFIG_LOAD_PPC_KEYS) +=3D platform_certs/efi_parser.o \
                                      platform_certs/load_powerpc.o \
                                      platform_certs/keyring_handler.o
+# The relative order of the 'ima' and 'evm' LSMs depends on the order belo=
w.
 obj-$(CONFIG_IMA)			+=3D ima/
 obj-$(CONFIG_EVM)			+=3D evm/

> There are also a few patches in the patchset that don't have an
> ACK/review tag from Mimi, although now that you are co-maininting IMA/EVM
> with Mimi I don't know if that matters.  If the two of you can let me
> know how you want me to handle LSM patches that are IMA/EVM related I
> would appreciate it (two ACKs, one or other, something else?).

Ok, we will come back to you about this.

> Once you add a Makefile commane and we sort out the IMA/EVM approval
> process I think we're good to get this into linux-next.  A while back
> Mimi and I had a chat offline and if I recall everything correctly she
> preferred that I take this patchset via the LSM tree.  I don't have a
> problem with that, and to be honest I would probably prefer
> that too, but I wanted to check with everyone that is still the case.
> Just in case, I've added my ACKs/reviews to this patchset in case this
> needs to be merged via the integrity tree.

Ok, given that there is the comment in the Makefile, the last thing to
do from your side is to remove the vague comment in the file_release
patch.

Other than that, I think Mimi wanted to give a last look. If that is
ok, then the patches should be ready for your repo and linux-next.

Thanks

Roberto


