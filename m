Return-Path: <linux-fsdevel+bounces-11825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BE85770F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 08:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284C51F25EFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460CF179AF;
	Fri, 16 Feb 2024 07:55:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8212E5D;
	Fri, 16 Feb 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070115; cv=none; b=Tuj1yU/zVc8pNY8YBF0KlDuhwRYenSlyzM87DRKR0BtGrmYgZjuy6rsFR8mpIogtW6yOpTpcXKbWkLuVQ2I6zW7iCSK0t4J9up7EbNVsGdh6/O+TpeuY1AJLTjL7z0//2wVAH7FcqbagQ1AuT+o+jtDLyAyh06Lp0alK1eoxkBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070115; c=relaxed/simple;
	bh=VCWiUNtrcsS5Bbg884AsO/L41fooQwqIz2TLGDos6rc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hot16m7/KfkGTXSuaf1Gyqt+O13wp3ob/YvQXlTj4Pcrlv86z7sePTbKF/ezddsbHVjZHNgpd+1ItHnGwHhZAlRWsyO/Oj3tuRz126vToXMXlFmcvxiBjFEmm4JthxusFwTWQGGeCY04sIwTIASMdr+WkHbyV1manMum86Jsiqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TbkNM4CT7z9y5ZF;
	Fri, 16 Feb 2024 15:39:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 13058140631;
	Fri, 16 Feb 2024 15:54:54 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwC3YBm9FM9lcmabAg--.60113S2;
	Fri, 16 Feb 2024 08:54:53 +0100 (CET)
Message-ID: <45699f4ed5726fd0d9346069250cd22b04623d9a.camel@huaweicloud.com>
Subject: Re: [PATCH v10 0/25] security: Move IMA and EVM to the LSM
 infrastructure
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, jack@suse.cz, chuck.lever@oracle.com,
 jlayton@kernel.org,  neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
 tom@talpey.com,  jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
 dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, 
 jarkko@kernel.org, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
 casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Fri, 16 Feb 2024 08:54:35 +0100
In-Reply-To: <2cdfefc8661d0a82c28250fc22a93a47@paul-moore.com>
References: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
	 <2cdfefc8661d0a82c28250fc22a93a47@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwC3YBm9FM9lcmabAg--.60113S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4DAF1rtr18Gr13uryrtFb_yoW8Xw1DpF
	Z7ta1UCr4qqF13Can7Zr48ua1rAwsYqr4jkry8KrWUZa45KF1ftr1xGF4j9FykWwn3ua4Y
	q34jv3sYy34DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj5ZmBQAAsN

On Thu, 2024-02-15 at 23:43 -0500, Paul Moore wrote:
> On Feb 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
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
> As discussed earlier, I've just merged this into the lsm/dev tree; a big
> thank you to Roberto for working on this and to all helped along the way
> with reviews, testing, etc.  I've wanted to see IMA/EVM integrated as
> proper LSMs for a while and I'm very happy to finally see it happening.

Thank you, and thanks to all! That's an excellent news! Excited about
that!

> Mimi, Roberto, I'm going to hold off on merging anything into the lsm/dev
> tree for a few days in case you decide you would prefer to take these
> patches yourselves.  If I don't hear anything from the two of you, I'll
> plan to send these to Linus during the next merge window.

Perfect!

Roberto


