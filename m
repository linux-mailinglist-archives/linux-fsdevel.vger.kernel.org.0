Return-Path: <linux-fsdevel+bounces-32327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334E9A39EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7569A1C21E04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 09:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FAE1EF950;
	Fri, 18 Oct 2024 09:24:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D98192B86;
	Fri, 18 Oct 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243482; cv=none; b=sIQIvydaCq0SUN50PJdxURgQ6MFbcggIdZAf+l0SRhKj8TnapyAiUMtIbeqh2jI61rK0oA+U0L35GNzEPf20gcd3UvF9GLX/nXK766bXjT8eoJxzVAK2IdLb0DVXhZeLnF+3j9MNTuU78NDQcyWeqwiHBmzZvW++YMRSmlAWufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243482; c=relaxed/simple;
	bh=1sLfiUDBza5jFj3cD8J4rytpZUEZxs21Emfhwv90lcQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FkGLsuUSnYg3itm5uNFrmu9TcGCN3wjse8v865Pky1KS1cStJHZFnrzQhnvKMVfXXJESClV8LkvhUzdLgyZanEL7WMJMlaPAL9D+v/bA/SJTVu0j4ROL1JRNrOWiQNOaD2pqpJJdWc83UPRcu3HWxQ7J0u1jRuJXYuWy2PG7YQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XVJfn2zh3z9v7NH;
	Fri, 18 Oct 2024 17:04:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 8E1411403A2;
	Fri, 18 Oct 2024 17:24:24 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnUcI5KRJnDJocAw--.31484S2;
	Fri, 18 Oct 2024 10:24:23 +0100 (CET)
Message-ID: <b498e3b004bedc460991e167c154cc88d568f587.camel@huaweicloud.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, ebpqwerty472123@gmail.com, 
	kirill.shutemov@linux.intel.com
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  jmorris@namei.org, serge@hallyn.com,
 linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org,  bpf@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>,  linux-mm@kvack.org, akpm@linux-foundation.org,
 vbabka@suse.cz,  lorenzo.stoakes@oracle.com, linux-fsdevel@vger.kernel.org
Date: Fri, 18 Oct 2024 11:24:06 +0200
In-Reply-To: <c1e47882720fe45aa9d04d663f5a6fd39a046bcb.camel@huaweicloud.com>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
	 <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
	 <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
	 <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
	 <593282dbc9f48673c8f3b8e0f28e100f34141115.camel@huaweicloud.com>
	 <15bb94a306d3432de55c0a12f29e7ed2b5fa3ba1.camel@huaweicloud.com>
	 <c1e47882720fe45aa9d04d663f5a6fd39a046bcb.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCnUcI5KRJnDJocAw--.31484S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJr4UCr1UJFyxJw17ZryUtrb_yoW8Ww1rCo
	WUXr9xAws0k345tr18A3srtrW8Ka95XrWSyry0ka1kGFy2v34jywn5Jr17JrZ8JwsYvFWx
	Gw17ZrWrZ3W8tFn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABGcRw-kF4gADst

On Wed, 2024-10-16 at 11:59 +0200, Roberto Sassu wrote:
> On Fri, 2024-10-11 at 15:30 +0200, Roberto Sassu wrote:
> > On Wed, 2024-10-09 at 18:43 +0200, Roberto Sassu wrote:
> > > On Wed, 2024-10-09 at 18:25 +0200, Roberto Sassu wrote:
> > > > On Wed, 2024-10-09 at 11:37 -0400, Paul Moore wrote:
> > > > > On Wed, Oct 9, 2024 at 11:36=E2=80=AFAM Paul Moore <paul@paul-moo=
re.com> wrote:
> > > > > > On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
> > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > >=20
> > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > >=20
> > > > > > > Move out the mutex in the ima_iint_cache structure to a new s=
tructure
> > > > > > > called ima_iint_cache_lock, so that a lock can be taken regar=
dless of
> > > > > > > whether or not inode integrity metadata are stored in the ino=
de.
> > > > > > >=20
> > > > > > > Introduce ima_inode_security() to simplify accessing the new =
structure in
> > > > > > > the inode security blob.
> > > > > > >=20
> > > > > > > Move the mutex initialization and annotation in the new funct=
ion
> > > > > > > ima_inode_alloc_security() and introduce ima_iint_lock() and
> > > > > > > ima_iint_unlock() to respectively lock and unlock the mutex.
> > > > > > >=20
> > > > > > > Finally, expand the critical region in process_measurement() =
guarded by
> > > > > > > iint->mutex up to where the inode was locked, use only one ii=
nt lock in
> > > > > > > __ima_inode_hash(), since the mutex is now in the inode secur=
ity blob, and
> > > > > > > replace the inode_lock()/inode_unlock() calls in ima_check_la=
st_writer().
> > > > > > >=20
> > > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > ---
> > > > > > >  security/integrity/ima/ima.h      | 26 ++++++++---
> > > > > > >  security/integrity/ima/ima_api.c  |  4 +-
> > > > > > >  security/integrity/ima/ima_iint.c | 77 +++++++++++++++++++++=
+++++-----
> > > > > > >  security/integrity/ima/ima_main.c | 39 +++++++---------
> > > > > > >  4 files changed, 104 insertions(+), 42 deletions(-)
> > > > > >=20
> > > > > > I'm not an IMA expert, but it looks reasonable to me, although
> > > > > > shouldn't this carry a stable CC in the patch metadata?
> > > > > >=20
> > > > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > > >=20
> > > > > Sorry, one more thing ... did you verify this patchset resolves t=
he
> > > > > syzbot problem?  I saw at least one reproducer.
> > > >=20
> > > > Uhm, could not reproduce the deadlock with the reproducer. However,
> > > > without the patch I have a lockdep warning, and with I don't.
> > > >=20
> > > > I asked syzbot to try the patches. Let's see.
> > >=20
> > > I actually got a different lockdep warning:
> > >=20
> > > [  904.603365] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [  904.604264] WARNING: possible circular locking dependency detected
> > > [  904.605141] 6.12.0-rc2+ #20 Not tainted
> > > [  904.605697] ------------------------------------------------------
> >=20
> > I can reproduce by executing the syzbot reproducer and in another
> > terminal by logging in with SSH (not all the times).
> >=20
> > If I understood what the lockdep warning means, this is the scenario.
> >=20
> > A task accesses a seq_file which is in the IMA policy, so we enter the
> > critical region guarded by the iint lock. But before we get the chance
> > to measure the file, a second task calls remap_file_pages() on the same
> > seq_file.
> >=20
> > remap_file_pages() takes the mmap lock and, if the event matches the
> > IMA policy too, the second task waits for the iint lock to be released.
> >=20
> > Now, the first task starts to measure the seq_file and takes the
> > seq_file lock. I don't know if 3 processes must be involved, but I was
> > thinking that reading the seq_file from the first task can trigger a
> > page fault, which requires to take the mmap lock.
> >=20
> > At this point, we reach a deadlock. The first task waits for the mmap
> > lock to be released, and the second waits for the iint lock to be
> > released, which both cannot happen.
>=20
> + mm, mm folks
>=20
> (I leave the lockdep warning down for the new people included in the
> thread).
>=20
> I think I understood what the problem is. Any lock that is taken inside
> security_file_mmap() would cause lock inversion since:

+ Kirill
=20
Ok, to be clear, we are talking about a regression introduced by commit
ea7e2d5e49c05 ("mm: call the security_mmap_file() LSM hook in
remap_file_pages()").

Originally, Mimi asked this patch to be included:

https://lore.kernel.org/lkml/1336963631-3541-1-git-send-email-zohar@us.ibm.=
com/

This was due to the commit 196f518 ("IMA: explicit IMA i_flag to remove
global lock on inode_delete"), which added an inode lock to protect the
new flag S_IMA, used to track integrity metadata only for the set of
inodes evaluated by IMA.

The problem was that, for mmapped files, the lock is taken in the
opposite order than the convention (i_mutex and then mmap_sem), causing
a lock inversion and a lockdep warning.

Linus proposed to split security_file_mmap() into security_mmap_file()
and security_mmap_addr(), so that the former can be taken out of the
mmap_sem lock and remove the lock inversion. The final commit was made
by Al Viro, 8b3ec6814c83 ("take security_mmap_file() outside of -
>mmap_sem").

Commit ea7e2d5e49c05 put again a security_mmap_file() call inside the
mmap_sem (now mmap_lock) lock, causing the recent syzbot reports.

Paul asked if the inode lock can be removed from IMA, and actually
partially can be done:

https://lore.kernel.org/linux-integrity/20241008165732.2603647-1-roberto.sa=
ssu@huaweicloud.com/

The patch is good in its own, since it merges two critical sections in
one. However, the inode lock cannot be removed completely:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sec=
urity/integrity/ima/ima_main.c?h=3Dv6.12-rc3#n386

This one is required to set the security.ima xattr in
ima_appraise_measurement() -> ima_fix_xattr(), when IMA-Appraise is in
fix mode (ima_appraise=3Dfix in the kernel command line).

I would say that my original suggestion of putting security_mmap_file()
back to the mmap_lock lock probably is not the optimal solution. Maybe
we could get around removing the remaining inode lock in IMA, but we
would also limit future LSMs to not use the inode lock if they need.

Probably it is hard, @Kirill would there be any way to safely move
security_mmap_file() out of the mmap_lock lock?

Thanks

Roberto


PS: I'm aware that Shu Han proposed a solution to the lock inversion:

https://lore.kernel.org/linux-security-module/20240928180044.50-1-ebpqwerty=
472123@gmail.com/

but I think anyway it boils down to either moving security_mmap_file()
to the mmap_lock lock again for all calls, or viceversa, moving
security_mmap_file() out of the remap_file_pages() system call.

> vm_mmap_pgoff():
>=20
> 	ret =3D security_mmap_file(file, prot, flag);
> 	if (!ret) {
> 		if (mmap_write_lock_killable(mm))
>=20
>=20
>=20
> SYSCALL_DEFINE5(remap_file_pages, ...):
>=20
> 	if (mmap_write_lock_killable(mm))
> 		return -EINTR;
>=20
> [...]
>=20
> 	file =3D get_file(vma->vm_file);
> 	ret =3D security_mmap_file(vma->vm_file, prot, flags);
> 	if (ret)
> 		goto out_fput;
>=20
>=20
> Since I didn't see a good way to change the order of the second, I
> changed the order of the first, i.e. I put security_file_mmap() under
> the mmap lock.
>=20
> (I don't know if this is a good idea.)
>=20
> I cannot reproduce the lockdep warning anymore.
>=20
> @mm folks, what is your opinion?
>=20
> Thanks
>=20
> Roberto
>=20
> > Roberto
> >=20
> > > [  904.606577] systemd/1 is trying to acquire lock:
> > > [  904.607227] ffff88810e5c2580 (&p->lock){+.+.}-{4:4}, at: seq_read_=
iter+0x62/0x6b0
> > > [  904.608290]=20
> > > [  904.608290] but task is already holding lock:
> > > [  904.609105] ffff88810f4abf20 (&ima_iint_lock_mutex_key[depth]){+.+=
.}-{4:4}, at: ima_iint_lock+0x24/0x40
> > > [  904.610429]=20
> > > [  904.610429] which lock already depends on the new lock.
> > > [  904.610429]=20
> > > [  904.611574]=20
> > > [  904.611574] the existing dependency chain (in reverse order) is:
> > > [  904.612628]=20
> > > [  904.612628] -> #2 (&ima_iint_lock_mutex_key[depth]){+.+.}-{4:4}:
> > > [  904.613681]        __mutex_lock+0xaf/0x760
> > > [  904.614266]        mutex_lock_nested+0x27/0x40
> > > [  904.614897]        ima_iint_lock+0x24/0x40
> > > [  904.615490]        process_measurement+0x176/0xef0
> > > [  904.616168]        ima_file_mmap+0x98/0x120
> > > [  904.616767]        security_mmap_file+0x408/0x560
> > > [  904.617444]        __do_sys_remap_file_pages+0x2fa/0x4c0
> > > [  904.618194]        __x64_sys_remap_file_pages+0x29/0x40
> > > [  904.618937]        x64_sys_call+0x6e8/0x4550
> > > [  904.619546]        do_syscall_64+0x71/0x180
> > > [  904.620155]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  904.620952]=20
> > > [  904.620952] -> #1 (&mm->mmap_lock){++++}-{4:4}:
> > > [  904.621813]        __might_fault+0x6f/0xb0
> > > [  904.622400]        _copy_to_iter+0x12e/0xa80
> > > [  904.623009]        seq_read_iter+0x593/0x6b0
> > > [  904.623629]        proc_reg_read_iter+0x31/0xe0
> > > [  904.624276]        vfs_read+0x256/0x3d0
> > > [  904.624822]        ksys_read+0x6d/0x160
> > > [  904.625372]        __x64_sys_read+0x1d/0x30
> > > [  904.625964]        x64_sys_call+0x1068/0x4550
> > > [  904.626594]        do_syscall_64+0x71/0x180
> > > [  904.627188]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  904.627975]=20
> > > [  904.627975] -> #0 (&p->lock){+.+.}-{4:4}:
> > > [  904.628787]        __lock_acquire+0x17f3/0x2320
> > > [  904.629432]        lock_acquire+0xf2/0x420
> > > [  904.630013]        __mutex_lock+0xaf/0x760
> > > [  904.630596]        mutex_lock_nested+0x27/0x40
> > > [  904.631225]        seq_read_iter+0x62/0x6b0
> > > [  904.631831]        kernfs_fop_read_iter+0x1ef/0x2c0
> > > [  904.632599]        __kernel_read+0x113/0x350
> > > [  904.633206]        integrity_kernel_read+0x23/0x40
> > > [  904.633902]        ima_calc_file_hash_tfm+0x14e/0x230
> > > [  904.634621]        ima_calc_file_hash+0x97/0x250
> > > [  904.635281]        ima_collect_measurement+0x4be/0x530
> > > [  904.636008]        process_measurement+0x7c0/0xef0
> > > [  904.636689]        ima_file_check+0x65/0x80
> > > [  904.637295]        security_file_post_open+0xb1/0x1b0
> > > [  904.638008]        path_openat+0x216/0x1280
> > > [  904.638605]        do_filp_open+0xab/0x140
> > > [  904.639185]        do_sys_openat2+0xba/0x120
> > > [  904.639805]        do_sys_open+0x4c/0x80
> > > [  904.640366]        __x64_sys_openat+0x23/0x30
> > > [  904.640992]        x64_sys_call+0x2575/0x4550
> > > [  904.641616]        do_syscall_64+0x71/0x180
> > > [  904.642207]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  904.643003]=20
> > > [  904.643003] other info that might help us debug this:
> > > [  904.643003]=20
> > > [  904.644149] Chain exists of:
> > > [  904.644149]   &p->lock --> &mm->mmap_lock --> &ima_iint_lock_mutex=
_key[depth]
> > > [  904.644149]=20
> > > [  904.645763]  Possible unsafe locking scenario:
> > > [  904.645763]=20
> > > [  904.646614]        CPU0                    CPU1
> > > [  904.647264]        ----                    ----
> > > [  904.647909]   lock(&ima_iint_lock_mutex_key[depth]);
> > > [  904.648617]                                lock(&mm->mmap_lock);
> > > [  904.649479]                                lock(&ima_iint_lock_mut=
ex_key[depth]);
> > > [  904.650543]   lock(&p->lock);
> > > [  904.650974]=20
> > > [  904.650974]  *** DEADLOCK ***
> > > [  904.650974]=20
> > > [  904.651826] 1 lock held by systemd/1:
> > > [  904.652376]  #0: ffff88810f4abf20 (&ima_iint_lock_mutex_key[depth]=
){+.+.}-{4:4}, at: ima_iint_lock+0x24/0x40
> > > [  904.653759]=20
> > > [  904.653759] stack backtrace:
> > > [  904.654391] CPU: 2 UID: 0 PID: 1 Comm: systemd Not tainted 6.12.0-=
rc2+ #20
> > > [  904.655360] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS 1.15.0-1 04/01/2014
> > > [  904.656497] Call Trace:
> > > [  904.656856]  <TASK>
> > > [  904.657166]  dump_stack_lvl+0x134/0x1a0
> > > [  904.657728]  dump_stack+0x14/0x30
> > > [  904.658206]  print_circular_bug+0x38d/0x450
> > > [  904.658812]  check_noncircular+0xed/0x120
> > > [  904.659396]  ? srso_return_thunk+0x5/0x5f
> > > [  904.659972]  ? srso_return_thunk+0x5/0x5f
> > > [  904.660569]  __lock_acquire+0x17f3/0x2320
> > > [  904.661145]  lock_acquire+0xf2/0x420
> > > [  904.661664]  ? seq_read_iter+0x62/0x6b0
> > > [  904.662217]  ? srso_return_thunk+0x5/0x5f
> > > [  904.662886]  __mutex_lock+0xaf/0x760
> > > [  904.663408]  ? seq_read_iter+0x62/0x6b0
> > > [  904.663961]  ? seq_read_iter+0x62/0x6b0
> > > [  904.664525]  ? srso_return_thunk+0x5/0x5f
> > > [  904.665098]  ? mark_lock+0x4e/0x750
> > > [  904.665610]  ? mutex_lock_nested+0x27/0x40
> > > [  904.666194]  ? find_held_lock+0x3a/0x100
> > > [  904.666770]  mutex_lock_nested+0x27/0x40
> > > [  904.667337]  seq_read_iter+0x62/0x6b0
> > > [  904.667869]  kernfs_fop_read_iter+0x1ef/0x2c0
> > > [  904.668536]  __kernel_read+0x113/0x350
> > > [  904.669079]  integrity_kernel_read+0x23/0x40
> > > [  904.669698]  ima_calc_file_hash_tfm+0x14e/0x230
> > > [  904.670349]  ? __lock_acquire+0xc32/0x2320
> > > [  904.670937]  ? srso_return_thunk+0x5/0x5f
> > > [  904.671525]  ? __lock_acquire+0xfbb/0x2320
> > > [  904.672113]  ? srso_return_thunk+0x5/0x5f
> > > [  904.672693]  ? srso_return_thunk+0x5/0x5f
> > > [  904.673280]  ? lock_acquire+0xf2/0x420
> > > [  904.673818]  ? kernfs_iop_getattr+0x4a/0xb0
> > > [  904.674424]  ? srso_return_thunk+0x5/0x5f
> > > [  904.674997]  ? find_held_lock+0x3a/0x100
> > > [  904.675564]  ? srso_return_thunk+0x5/0x5f
> > > [  904.676156]  ? srso_return_thunk+0x5/0x5f
> > > [  904.676740]  ? srso_return_thunk+0x5/0x5f
> > > [  904.677322]  ? local_clock_noinstr+0x9/0xb0
> > > [  904.677923]  ? srso_return_thunk+0x5/0x5f
> > > [  904.678502]  ? srso_return_thunk+0x5/0x5f
> > > [  904.679075]  ? lock_release+0x4e2/0x570
> > > [  904.679639]  ima_calc_file_hash+0x97/0x250
> > > [  904.680227]  ima_collect_measurement+0x4be/0x530
> > > [  904.680901]  ? srso_return_thunk+0x5/0x5f
> > > [  904.681496]  ? srso_return_thunk+0x5/0x5f
> > > [  904.682070]  ? __kernfs_iattrs+0x4a/0x140
> > > [  904.682658]  ? srso_return_thunk+0x5/0x5f
> > > [  904.683242]  ? process_measurement+0x7c0/0xef0
> > > [  904.683876]  ? srso_return_thunk+0x5/0x5f
> > > [  904.684462]  process_measurement+0x7c0/0xef0
> > > [  904.685078]  ? srso_return_thunk+0x5/0x5f
> > > [  904.685654]  ? srso_return_thunk+0x5/0x5f
> > > [  904.686228]  ? _raw_spin_unlock_irqrestore+0x5d/0xd0
> > > [  904.686938]  ? srso_return_thunk+0x5/0x5f
> > > [  904.687523]  ? srso_return_thunk+0x5/0x5f
> > > [  904.688098]  ? srso_return_thunk+0x5/0x5f
> > > [  904.688672]  ? local_clock_noinstr+0x9/0xb0
> > > [  904.689273]  ? srso_return_thunk+0x5/0x5f
> > > [  904.689846]  ? srso_return_thunk+0x5/0x5f
> > > [  904.690430]  ? srso_return_thunk+0x5/0x5f
> > > [  904.691005]  ? srso_return_thunk+0x5/0x5f
> > > [  904.691583]  ? srso_return_thunk+0x5/0x5f
> > > [  904.692180]  ? local_clock_noinstr+0x9/0xb0
> > > [  904.692841]  ? srso_return_thunk+0x5/0x5f
> > > [  904.693419]  ? srso_return_thunk+0x5/0x5f
> > > [  904.693990]  ? lock_release+0x4e2/0x570
> > > [  904.694544]  ? srso_return_thunk+0x5/0x5f
> > > [  904.695115]  ? kernfs_put_active+0x5d/0xc0
> > > [  904.695708]  ? srso_return_thunk+0x5/0x5f
> > > [  904.696286]  ? kernfs_fop_open+0x376/0x6b0
> > > [  904.696872]  ima_file_check+0x65/0x80
> > > [  904.697409]  security_file_post_open+0xb1/0x1b0
> > > [  904.698058]  path_openat+0x216/0x1280
> > > [  904.698589]  do_filp_open+0xab/0x140
> > > [  904.699106]  ? srso_return_thunk+0x5/0x5f
> > > [  904.699693]  ? lock_release+0x554/0x570
> > > [  904.700264]  ? srso_return_thunk+0x5/0x5f
> > > [  904.700836]  ? do_raw_spin_unlock+0x76/0x140
> > > [  904.701450]  ? srso_return_thunk+0x5/0x5f
> > > [  904.702021]  ? _raw_spin_unlock+0x3f/0xa0
> > > [  904.702606]  ? srso_return_thunk+0x5/0x5f
> > > [  904.703178]  ? alloc_fd+0x1ca/0x3b0
> > > [  904.703685]  do_sys_openat2+0xba/0x120
> > > [  904.704223]  ? file_free+0x8d/0x110
> > > [  904.704729]  do_sys_open+0x4c/0x80
> > > [  904.705221]  __x64_sys_openat+0x23/0x30
> > > [  904.705784]  x64_sys_call+0x2575/0x4550
> > > [  904.706337]  do_syscall_64+0x71/0x180
> > > [  904.706863]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [  904.707587] RIP: 0033:0x7f3462123037
> > > [  904.708120] Code: 55 9c 48 89 75 a0 89 7d a8 44 89 55 ac e8 a1 7a =
f8 ff 44 8b 55 ac 8b 55 9c 41 89 c0 48 8b 75 a0 8b 7d a8 b8 01 01 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 45 ac e8 f6 7a f8 ff 8b 45 ac
> > > [  904.710744] RSP: 002b:00007ffdd1a79370 EFLAGS: 00000293 ORIG_RAX: =
0000000000000101
> > > [  904.711821] RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 00007=
f3462123037
> > > [  904.712829] RDX: 0000000000080100 RSI: 00007ffdd1a79420 RDI: 00000=
000ffffff9c
> > > [  904.713839] RBP: 00007ffdd1a793e0 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  904.714848] R10: 0000000000000000 R11: 0000000000000293 R12: 00007=
ffdd1a794c8
> > > [  904.715855] R13: 00007ffdd1a794b8 R14: 00007ffdd1a79690 R15: 00007=
ffdd1a79690
> > > [  904.716877]  </TASK>
> > >=20
> > > Roberto
> >=20
>=20


