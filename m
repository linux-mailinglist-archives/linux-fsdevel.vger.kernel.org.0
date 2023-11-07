Return-Path: <linux-fsdevel+bounces-2215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D1C7E3ABD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 12:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84338B20C33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 11:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A842D2D052;
	Tue,  7 Nov 2023 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A34E2D039
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 11:04:07 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E899FB6;
	Tue,  7 Nov 2023 03:04:05 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SPlKv09kyz9xsNG;
	Tue,  7 Nov 2023 18:47:47 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBHhHSHGUpl1aU1AA--.40870S2;
	Tue, 07 Nov 2023 12:03:46 +0100 (CET)
Message-ID: <b560ed9477d9d03f0bf13af2ffddfeebbbf7712b.camel@huaweicloud.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, syzbot
	 <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>, jack@suse.cz, 
	jeffm@suse.com
Cc: hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org, 
	roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com, linux-security-module@vger.kernel.org
Date: Tue, 07 Nov 2023 12:03:32 +0100
In-Reply-To: <CAHC9VhTFs=AHtsdzas-XXq2-Ub4V9Tbkcp4_HBspmGaARzWanw@mail.gmail.com>
References: <000000000000cfe6f305ee84ff1f@google.com>
	 <000000000000a8d8e7060977b741@google.com>
	 <CAHC9VhTFs=AHtsdzas-XXq2-Ub4V9Tbkcp4_HBspmGaARzWanw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBHhHSHGUpl1aU1AA--.40870S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw13JF18Aw1fKr1fGr1ftFb_yoW5Xr1UpF
	WrCrW3KwnYyr4UJr4vgF17G3W0grZ3CFy7W393trykuan2vFn7Jrs29r4xuFWFkr4DCr90
	y3W3uwn8K34S937anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5YY9AACsC
X-CFilter-Loop: Reflected

On Mon, 2023-11-06 at 17:53 -0500, Paul Moore wrote:
> On Mon, Nov 6, 2023 at 3:34=E2=80=AFAM syzbot
> <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com> wrote:
> >=20
> > syzbot has bisected this issue to:
> >=20
> > commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> > Author: Roberto Sassu <roberto.sassu@huawei.com>
> > Date:   Fri Mar 31 12:32:18 2023 +0000
> >=20
> >     reiserfs: Add security prefix to xattr name in reiserfs_security_wr=
ite()
> >=20
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14d0b787=
680000
> > start commit:   90b0c2b2edd1 Merge tag 'pinctrl-v6.7-1' of git://git.ke=
rne..
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D16d0b787=
680000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12d0b787680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D93ac5233c13=
8249e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc319bb5b10141=
13a92cf
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D113f37176=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D154985ef680=
000
> >=20
> > Reported-by: syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com
> > Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in re=
iserfs_security_write()")
> >=20
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>=20
> Hi Roberto,
>=20
> I know you were looking at this over the summer[1], did you ever find
> a resolution to this?  If not, what do you think of just dropping
> security xattr support on reiserfs?  Normally that wouldn't be
> something we could consider, but given the likelihood that this hadn't
> been working in *years* (if ever), and reiserfs is deprecated, I think
> this is a viable option if there isn't an obvious fix.
>=20
> [1] https://lore.kernel.org/linux-security-module/CAHC9VhTM0a7jnhxpCyonep=
cfWbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com/

Hi Paul

at the time, I did some investigation and came with a patch that
(likely) solves some of the problems:

https://lore.kernel.org/linux-fsdevel/4aa799a0b87d4e2ecf3fa74079402074dc42b=
3c5.camel@huaweicloud.com/#t

I did a more advanced patch (to be validated), trying to fix the root
cause:

https://lore.kernel.org/linux-fsdevel/ffde7908-be73-cc56-2646-72f4f94cb51b@=
huaweicloud.com/

However, Jeff Mahoney (that did a lot of work in this area) suggested
that maybe we should not try invasive changes, as anyway reiserfs will
be removed from the kernel in 2025.

It wouldn't be a problem to move the first patch forward.

Roberto


