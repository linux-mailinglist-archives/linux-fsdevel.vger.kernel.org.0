Return-Path: <linux-fsdevel+bounces-32457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BA59A5DD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 10:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C41B21251
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 08:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7741E1331;
	Mon, 21 Oct 2024 07:59:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFA71E1302;
	Mon, 21 Oct 2024 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497592; cv=none; b=EmyeXLVd2oZZvQ4eibJgNg/aUSbmRowERCL1Ltpfyh7yMEAQQlOyGIMhwfJyxQEXi3Jyw+PUoBe/ic7AioI7Z+hOxvOzAqURWh53icTEDZlgGtVqR7ZIM/JP3h4uGkwdf+04+rwZXoNlGhIssczXIGggdUqy8eZaIMbCAI/xVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497592; c=relaxed/simple;
	bh=lyQWXd8tZ+cJL5EJxSB+u2xZemaLQGSuAwwZhKQD8JQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=so0tKROT/2JP+sPNpLFBclwbPPOe47bIqvogi4OExYosWlpeADYaKWu1LTqcxfgjrq7IfO5TScYUOdAL4bTil5x9QofUJMJLA6UrBVKsYsNGfdkO7cOKHpeeKyiD/s7J9um7w6jsW7UcJN+uem3ljhpmyEOuR8eskd8VI2UZyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XX6dS3JbXz9v7NX;
	Mon, 21 Oct 2024 15:39:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 3DEE8140134;
	Mon, 21 Oct 2024 15:59:40 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCXsYDdCRZnfdwkAA--.41168S2;
	Mon, 21 Oct 2024 08:59:39 +0100 (CET)
Message-ID: <c0e85aaa89283d5e4b742d23299f286a2e3eeaad.camel@huaweicloud.com>
Subject: Re: [PATCH v2] mm: Split critical region in remap_file_pages() and
 invoke LSMs in between
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, "Kirill A. Shutemov"
	 <kirill.shutemov@linux.intel.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
 jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 ebpqwerty472123@gmail.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
  syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Mon, 21 Oct 2024 09:59:22 +0200
In-Reply-To: <CAHC9VhQP7gBa4AV-Hbh4Bq4fRU6toRmjccv52dGoU-s+MqsmfQ@mail.gmail.com>
References: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhQP7gBa4AV-Hbh4Bq4fRU6toRmjccv52dGoU-s+MqsmfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCXsYDdCRZnfdwkAA--.41168S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1rZr18XFyrCw1xCryrXrb_yoW5Cw1DpF
	ZxK3Z0kr1vqryxur1aqFy7WFWrC3yfGrW7WrZ7Xr1ruasrXF1fKr1fGF45Wa4DWrZ7CFWF
	vF1jkr93Ka1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGcVvDAFpgADsY

On Sat, 2024-10-19 at 11:34 -0400, Paul Moore wrote:
> On Fri, Oct 18, 2024 at 12:15=E2=80=AFPM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >=20
> > Commit ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in
> > remap_file_pages()") fixed a security issue, it added an LSM check when
> > trying to remap file pages, so that LSMs have the opportunity to evalua=
te
> > such action like for other memory operations such as mmap() and mprotec=
t().
> >=20
> > However, that commit called security_mmap_file() inside the mmap_lock l=
ock,
> > while the other calls do it before taking the lock, after commit
> > 8b3ec6814c83 ("take security_mmap_file() outside of ->mmap_sem").
> >=20
> > This caused lock inversion issue with IMA which was taking the mmap_loc=
k
> > and i_mutex lock in the opposite way when the remap_file_pages() system
> > call was called.
> >=20
> > Solve the issue by splitting the critical region in remap_file_pages() =
in
> > two regions: the first takes a read lock of mmap_lock, retrieves the VM=
A
> > and the file descriptor associated, and calculates the 'prot' and 'flag=
s'
> > variables; the second takes a write lock on mmap_lock, checks that the =
VMA
> > flags and the VMA file descriptor are the same as the ones obtained in =
the
> > first critical region (otherwise the system call fails), and calls
> > do_mmap().
> >=20
> > In between, after releasing the read lock and before taking the write l=
ock,
> > call security_mmap_file(), and solve the lock inversion issue.
> >=20
> > Cc: stable@vger.kernel.org # v6.12-rcx
> > Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in rem=
ap_file_pages()")
> > Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/linux-security-module/66f7b10e.050a0220=
.46d20.0036.GAE@google.com/
> > Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Jann Horn <jannh@google.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Tested-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  mm/mmap.c | 69 +++++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 52 insertions(+), 17 deletions(-)
>=20
> Thanks for working on this Roberto, Kirill, and everyone else who had
> a hand in reviewing and testing.

Welcome!

> Reviewed-by: Paul Moore <paul@paul-moore.com>
>=20
> Andrew, I see you're pulling this into the MM/hotfixes-unstable
> branch, do you also plan to send this up to Linus soon/next-week?  If
> so, great, if not let me know and I can send it up via the LSM tree.
>=20
> We need to get clarity around Roberto's sign-off, but I think that is
> more of an administrative mistake rather than an intentional omission
> :)

Ops, I just thought that I would not need to add it, since I'm not the
author of the patch. Please add my:

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto


