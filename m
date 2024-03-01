Return-Path: <linux-fsdevel+bounces-13274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1173E86E1E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6031C2200F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A46D1B9;
	Fri,  1 Mar 2024 13:19:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867E5F483;
	Fri,  1 Mar 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299178; cv=none; b=iqx66ydRkqEKhPGhqzq4ObCeQ6MEa++wyLmFu93Bocwgo3q0QAfoX9m1zkAx7ipocwMPYTiBWHpsr10vHQy85vnx2seTTG67QOfsT1wlrUQnCZ7cMEtJbilOcIFUwj2Srfs8yVatPii0u47k2h0VqMvgd4KYHWaMMli1V6AeWG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299178; c=relaxed/simple;
	bh=xRLjt2ZtMD2Q1XzlAIEVwSLp295JjvW6H5VxtRoWhCs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VVz/xu4/nMnhNsDnOFsMpXaoaixfFY9kG67aroeQ+ZoUsWr3H+wi3V8zcu9fHAaL2IC29akD7I5FKrZUygj8oyjvWqFvAUu8n9iovs2jlUYf6F7R0IFYX307NUpJENygt7bbCk5Xy9wHcJZYx7SPpS/6X4ll8RkfiHFBcqvwrww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmSvw53b9z9y0Nw;
	Fri,  1 Mar 2024 21:03:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 279D01400D2;
	Fri,  1 Mar 2024 21:19:32 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDHACXT1eFlyDx6Aw--.60471S2;
	Fri, 01 Mar 2024 14:19:31 +0100 (CET)
Message-ID: <e6f263b25061651e948a881d36bfdff17cfaf1b0.camel@huaweicloud.com>
Subject: Re: [PATCH v2 14/25] evm: add support for fscaps security hooks
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, Serge Hallyn
 <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, Eric Paris
 <eparis@redhat.com>, James Morris <jmorris@namei.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,  Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jonathan Corbet
 <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein
 <amir73il@gmail.com>,  linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,  linux-security-module@vger.kernel.org,
 audit@vger.kernel.org,  selinux@vger.kernel.org,
 linux-integrity@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-unionfs@vger.kernel.org
Date: Fri, 01 Mar 2024 14:19:11 +0100
In-Reply-To: <20240301-zucht-umfeld-9a923a7d070a@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-14-3039364623bd@kernel.org>
	 <15a69385b49c4f8626f082bc9b957132388414fb.camel@huaweicloud.com>
	 <20240301-zucht-umfeld-9a923a7d070a@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDHACXT1eFlyDx6Aw--.60471S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWxtFWkCry7XFW5WF1DGFg_yoW5uw18pa
	y5Ka4SkF4ktF17Jr92yw4qqw40k3yfJay5Grn5J3y8Zwn8JF1fGrWSk3y3ZF9a9rs3G34a
	vr4Iya47Zwn8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYY7kG6xAYrwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUguHqUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj5rgNgACsz

On Fri, 2024-03-01 at 13:54 +0100, Christian Brauner wrote:
> On Fri, Mar 01, 2024 at 10:19:13AM +0100, Roberto Sassu wrote:
> > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> > > Support the new fscaps security hooks by converting the vfs_caps to r=
aw
> > > xattr data and then handling them the same as other xattrs.
> >=20
> > Hi Seth
> >=20
> > I started looking at this patch set.
> >=20
> > The first question I have is if you are also going to update libcap
> > (and also tar, I guess), since both deal with the raw xattr.
> >=20
> > From IMA/EVM perspective (Mimi will add on that), I guess it is
> > important that files with a signature/HMAC continue to be accessible
> > after applying this patch set.
> >=20
> > Looking at the code, it seems the case (if I understood correctly,
> > vfs_getxattr_alloc() is still allowed).
> >=20
> > To be sure that everything works, it would be really nice if you could
> > also extend our test suite:
> >=20
> > https://github.com/mimizohar/ima-evm-utils/blob/next-testing/tests/port=
able_signatures.test
> >=20
> > and
> >=20
> > https://github.com/mimizohar/ima-evm-utils/blob/next-testing/tests/evm_=
hmac.test
> >=20
> >=20
> > The first test we would need to extend is check_cp_preserve_xattrs,
> > which basically does a cp -a. We would need to set fscaps in the
> > origin, copy to the destination, and see if the latter is accessible.
> >=20
> > I would also extend:
> >=20
> > check_tar_extract_xattrs_different_owner
> > check_tar_extract_xattrs_same_owner
> > check_metadata_change
> > check_evm_revalidate
> > check_evm_portable_sig_ima_appraisal
> > check_evm_portable_sig_ima_measurement_list
> >=20
> > It should not be too complicated. The purpose would be to exercise your
> > code below.
> >=20
> >=20
> > Regarding the second test, we would need to extend just check_evm_hmac.
> >=20
> >=20
> > Just realized, before extending the tests, it would be necessary to
> > modify also evmctl.c, to retrieve fscaps through the new interfaces,
> > and to let users provide custom fscaps the HMAC or portable signature
> > is calculated on.
>=20
> While request for tests are obviously fine they should be added by the
> respective experts for IMA/EVM in this case. I don't think it's
> appropriate to expect Seth to do that especially because you seem to
> imply that you currently don't have any tests for fscaps at all. We're
> always happy to test things and if that'd be adding new IMA/EVM specific
> features than it would be something to discuss but really we're
> refactoring so the fact that you don't have tests we can run is not the
> fault of this patchset and IMA/EVM is just a small portion of it.=20

Hi Christian

I have seen this policy of adding tests in other subsystems (eBPF),
which in my opinion makes sense, since you want anyway to check that
you didn't break existing code.

And yes, I agree that we should have better tests, and a better
workflow (we are working on improving it).

In this particular case, I was not asking to write a test from scratch,
that should not be difficult per se, but adding additional commands.

If I got it correctly, even if current tests for fscaps would have
existed, they would not work anyway, since they would have been based
on getting/setting the raw xattrs (as far as I know, at least for tar).

Happy to try adding the tests, would appreciate your help to review if
the tests are done in the correct way.

Thanks

Roberto


