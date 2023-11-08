Return-Path: <linux-fsdevel+bounces-2364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7640A7E518D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67C21C20D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACE2D52F;
	Wed,  8 Nov 2023 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFFFD537
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 08:01:16 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC66BAF;
	Wed,  8 Nov 2023 00:01:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SQHHp0p1cz9xFPp;
	Wed,  8 Nov 2023 15:47:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnFXUqQEtlDKtDAA--.34S2;
	Wed, 08 Nov 2023 09:00:54 +0100 (CET)
Message-ID: <110badd28083322d8895730bcd353d6d398f2db2.camel@huaweicloud.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>
Cc: syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>, 
 jack@suse.cz, jeffm@suse.com, hdanton@sina.com,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 reiserfs-devel@vger.kernel.org,  roberto.sassu@huawei.com,
 syzkaller-bugs@googlegroups.com,  syzkaller@googlegroups.com,
 linux-security-module@vger.kernel.org
Date: Wed, 08 Nov 2023 09:00:38 +0100
In-Reply-To: <CAHC9VhSH-WED1kM4UQrttJb6-ZQHpB0VceW0YGX1rz8NsZrVHA@mail.gmail.com>
References: <000000000000cfe6f305ee84ff1f@google.com>
	 <000000000000a8d8e7060977b741@google.com>
	 <CAHC9VhTFs=AHtsdzas-XXq2-Ub4V9Tbkcp4_HBspmGaARzWanw@mail.gmail.com>
	 <b560ed9477d9d03f0bf13af2ffddfeebbbf7712b.camel@huaweicloud.com>
	 <CAHC9VhSH-WED1kM4UQrttJb6-ZQHpB0VceW0YGX1rz8NsZrVHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAnFXUqQEtlDKtDAA--.34S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkXFyfuFWxKw1rZw15CFg_yoW5JF4fpF
	W5KFW5KF4vvr4xJrn2yw13Ga4I9wnxXFy7X3s3Kw1DAFW5XFyIvr4xKr43uFyY9rs3Kr1j
	qanrKas8C3srAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj5YirwACsi
X-CFilter-Loop: Reflected

On Tue, 2023-11-07 at 17:26 -0500, Paul Moore wrote:
> On Tue, Nov 7, 2023 at 6:03=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Mon, 2023-11-06 at 17:53 -0500, Paul Moore wrote:
> > > Hi Roberto,
> > >=20
> > > I know you were looking at this over the summer[1], did you ever find
> > > a resolution to this?  If not, what do you think of just dropping
> > > security xattr support on reiserfs?  Normally that wouldn't be
> > > something we could consider, but given the likelihood that this hadn'=
t
> > > been working in *years* (if ever), and reiserfs is deprecated, I thin=
k
> > > this is a viable option if there isn't an obvious fix.
> > >=20
> > > [1] https://lore.kernel.org/linux-security-module/CAHC9VhTM0a7jnhxpCy=
onepcfWbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com/
> >=20
> > Hi Paul
> >=20
> > at the time, I did some investigation and came with a patch that
> > (likely) solves some of the problems:
> >=20
> > https://lore.kernel.org/linux-fsdevel/4aa799a0b87d4e2ecf3fa74079402074d=
c42b3c5.camel@huaweicloud.com/#t
>=20
> Ah, thanks for the link, it looks like that was swallowed by my inbox.
> In general if you feel it is worth adding my email to a patch, you
> should probably also CC the LSM list.  If nothing else there is a
> patchwork watching the LSM list that I use to make sure I don't
> miss/forget about patches.
>=20
> > I did a more advanced patch (to be validated), trying to fix the root
> > cause:
> >=20
> > https://lore.kernel.org/linux-fsdevel/ffde7908-be73-cc56-2646-72f4f94cb=
51b@huaweicloud.com/
> >=20
> > However, Jeff Mahoney (that did a lot of work in this area) suggested
> > that maybe we should not try invasive changes, as anyway reiserfs will
> > be removed from the kernel in 2025.
>=20
> I tend to agree with Jeff, which is one of the reasons I was
> suggesting simply removing LSM xattr support from reiserfs, although
> depending on what that involves it might be a big enough change that
> we are better off simply leaving it broken.  I think we need to see
> what that patch would look like first.
>=20
> > It wouldn't be a problem to move the first patch forward.
>=20
> I worry that the first patch you mentioned above doesn't really solve
> anything, it only makes it the responsibility of the user to choose
> either A) a broken system where LSM xattrs don't work or B) a system
> that will likely deadlock/panic.  I think I would rather revert the
> original commit and just leave the LSM xattrs broken than ask a user
> to make that choice.

Ok, that would be fine for me.

Thanks

Roberto


