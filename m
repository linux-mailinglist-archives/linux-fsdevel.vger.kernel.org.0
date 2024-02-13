Return-Path: <linux-fsdevel+bounces-11364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B1D853114
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 13:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8EB287F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE964F88D;
	Tue, 13 Feb 2024 12:59:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4D4E1D7;
	Tue, 13 Feb 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829153; cv=none; b=tLtKstzmfck0y7CB04LXKJOWfKiF3FiK5iGm1H0IKuik6Ag+dtciA3cD2YtKIyVb9vkqN5BDXgsOyaCnkuSFjWfbjQGdIeQva7ZwuuWhoBlOHUbDtdKj6EglOJHapBaIF0ALTvKPeAjJqpaURoKqTOcN0CN+HAeqi4KYMezhoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829153; c=relaxed/simple;
	bh=RM51wWriDMRxA4AuvhOUrEAbEnWZNqSpiSOaePt63sc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vBs5OPN1360osxLSegdEclHMHiAAQv4eAhR8byPhrJD98oJNlKVUwCYlwVNKUu5QikDeAjDxawdrMw2CQOXeBFlgCXPWP6BoY1c+a56BuZOf935QBmeBQF3l1kHgFxitqrr/9OrvrcPhCstMGfji91RxxHN5dfq/j6ZKhnyKKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TZ1Gc3VDyz9xvh1;
	Tue, 13 Feb 2024 20:43:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 2A8F614065B;
	Tue, 13 Feb 2024 20:59:01 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB3sCSFZ8tliwppAg--.56469S2;
	Tue, 13 Feb 2024 13:59:00 +0100 (CET)
Message-ID: <05ad625b0f5a0e6c095abee5507801da255b36cd.camel@huaweicloud.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
 jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
 tom@talpey.com, jmorris@namei.org, serge@hallyn.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, dhowells@redhat.com,
 jarkko@kernel.org,  stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com,  shuah@kernel.org, mic@digikod.net,
 linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org,  keyrings@vger.kernel.org,
 selinux@vger.kernel.org,  linux-kselftest@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>,  Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 13 Feb 2024 13:58:43 +0100
In-Reply-To: <CAHC9VhQ7DgPJtNTRCYneu_XnpRmuwfPCW+FqVuS=k6U5-F6pJw@mail.gmail.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
	 <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
	 <305cd1291a73d788c497fe8f78b574d771b8ba41.camel@linux.ibm.com>
	 <CAHC9VhQ7DgPJtNTRCYneu_XnpRmuwfPCW+FqVuS=k6U5-F6pJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB3sCSFZ8tliwppAg--.56469S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw47Ar17Ar1UCFWfuFyrtFb_yoW3ZrgEgr
	yqvwn7Grs8Z3WrAanxAF1rAFWqg3W8Jr4rC395Xr1UZ3sxXay8WF4kJrnaqw4fGF40yFsI
	93Z5WFyfAwnrXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOlksDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj5pP-AABsQ

On Mon, 2024-02-12 at 16:16 -0500, Paul Moore wrote:
> On Mon, Feb 12, 2024 at 4:06=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> =
wrote:
> >=20
> > Hi Roberto,
> >=20
> >=20
> > > diff --git a/security/security.c b/security/security.c
> > > index d9d2636104db..f3d92bffd02f 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -2972,6 +2972,23 @@ int security_file_open(struct file *file)
> > >       return fsnotify_perm(file, MAY_OPEN);  <=3D=3D=3D  Conflict
> >=20
> > Replace with "return fsnotify_open_perm(file);"
> >=20
> > >  }
> > >=20
> >=20
> > The patch set doesn't apply cleaning to 6.8-rcX without this change.  U=
nless
> > there are other issues, I can make the change.
>=20
> I take it this means you want to pull this via the IMA/EVM tree?

Not sure about that, but I have enough changes to do to make a v10.

Roberto



