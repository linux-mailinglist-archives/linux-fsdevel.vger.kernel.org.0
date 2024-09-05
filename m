Return-Path: <linux-fsdevel+bounces-28673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2996D08F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A337B1C246EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751AD193411;
	Thu,  5 Sep 2024 07:38:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB32618A94F;
	Thu,  5 Sep 2024 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521931; cv=none; b=ihAAH1emDn1TjVXXwtCp4KgOP9KJWT2TJBrJ/qTZdZjZTd34OYgBHRzjSHqqj2WU67BofgUsQiLTKyMdlN2wx8M2NuFzCDtZq7pf4bL6CoDznhD3lPFR3T5G6wvashHaGgx55FF3zkKgJOolkBrh3zhK4EYq/ZupNqPuQFxAPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521931; c=relaxed/simple;
	bh=UcPQ7Y+HapU5hGxQZmDDlvpby0t5vrQQOGsZY9029D8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y3UxHg2zAuPUqRr7lsYNkkXmVAmVOdtUTuRkaEp/95wMnhYdqmMK0/ETiPX5v9IUi9fNFvJIR2hf8DO2FxdbYKK5VFGbiFZtDFixhsIt70zl9JjQxiFvVmBAchDUrIFD77d3Qc1sMCPO9il3iEZ6ZZVbDt+R4EgRYA17xHs/W+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4WzrMS5kZ1z9v7Hq;
	Thu,  5 Sep 2024 15:19:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 75486140419;
	Thu,  5 Sep 2024 15:38:33 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnazLvX9lmyhpPAA--.17844S2;
	Thu, 05 Sep 2024 08:38:32 +0100 (CET)
Message-ID: <88d5a92379755413e1ec3c981d9a04e6796da110.camel@huaweicloud.com>
Subject: Re: [PATCH] fs: don't block i_writecount during exec
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, 
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Linus Torvalds
	 <torvalds@linux-foundation.org>, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	david@fromorbit.com, hch@lst.de, linux-integrity@vger.kernel.org
Date: Thu, 05 Sep 2024 09:38:19 +0200
In-Reply-To: <CAG48ez2Vv8Z8nmn=mRwQ3_5azksszwoc+8UJgo3nh2uk-VwYXQ@mail.gmail.com>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
	 <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
	 <CAG48ez2Vv8Z8nmn=mRwQ3_5azksszwoc+8UJgo3nh2uk-VwYXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAnazLvX9lmyhpPAA--.17844S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rZF4xJr4DWFWkArW5KFg_yoW8Aw4rpr
	yfG398Crs5CF18CF97G39IvFWavw1rZFW3JrZ8Kr93Za4kur1xWF4YqF1F9FykArsrCasr
	Xw429348Ar1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MD1gAAse

On Wed, 2024-09-04 at 19:04 +0200, Jann Horn wrote:
> [necrothreading...]
> [+IMA folks]
>=20
> On Fri, May 31, 2024 at 3:01=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> > Back in 2021 we already discussed removing deny_write_access() for
> > executables. Back then I was hesistant because I thought that this migh=
t
> > cause issues in userspace. But even back then I had started taking some
> > notes on what could potentially depend on this and I didn't come up wit=
h
> > a lot so I've changed my mind and I would like to try this.
> [snip]
> > Yes, someone in userspace could potentially be relying on this. It's no=
t
> > completely out of the realm of possibility but let's find out if that's
> > actually the case and not guess.
>=20
> FYI, ima_bprm_check() still has a comment that claims that executables
> use deny_write_access():
>=20
> /**
>  * ima_bprm_check - based on policy, collect/store measurement.
>  * @bprm: contains the linux_binprm structure
>  *
>  * The OS protects against an executable file, already open for write,
>  * from being executed in deny_write_access() and an executable file,
>  * already open for execute, from being modified in get_write_access().
>  * So we can be certain that what we verify and measure here is actually
>  * what is being executed.
>  *
>  * On success return 0.  On integrity appraisal error, assuming the file
>  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>  */
>=20
> But what actually happens in there is not so different from what
> happens in ima_file_mmap(), so I think probably the only change
> required here is to fix up the comment...

We need to do the violation check for the BPRM_CHECK IMA hook too:

	violation_check =3D ((func =3D=3D FILE_CHECK || func =3D=3D MMAP_CHECK
||
			    func =3D=3D MMAP_CHECK_REQPROT) &&
			   (ima_policy_flag & IMA_MEASURE));

Roberto


