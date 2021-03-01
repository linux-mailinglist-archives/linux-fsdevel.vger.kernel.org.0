Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052983291A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 21:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbhCAU3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 15:29:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:42025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243092AbhCAU04 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614630290;
        bh=aaY9cNCNagnwn7NtLvkQ12ZRgEw3XDoAfQ6Uh3MqD6A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OBw0w9v7KSYmRLlosiE9LkYTo/HfJpkxuBqvocBcJKg9T16KlDv2WfXZISPJ060gp
         1X4+ZgBUE6zzI7X9TZRpJGZUvHtJq/Rkn9p21Cm0wnQLDVkvnIj1lXZ76vSvNyHsTb
         XOWUGZirK1WG09uxEnY4c6r4rZhWe/34K9wkw+Sk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.147.178]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzf6-1lQ8mp3gBe-00Qztv; Mon, 01
 Mar 2021 21:24:49 +0100
Subject: Re: [PATCH v2] binfmt_misc: Fix possible deadlock in
 bm_register_write
To:     Lior Ribak <liorribak@gmail.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201224111533.24719-1-liorribak@gmail.com>
 <20210228224414.95962-1-liorribak@gmail.com>
From:   Helge Deller <deller@gmx.de>
Message-ID: <1dae5800-32f3-5527-083a-88334142057a@gmx.de>
Date:   Mon, 1 Mar 2021 21:24:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210228224414.95962-1-liorribak@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vmh3k5S248QQWe+gRY6Lb0VmlkBTwlsDXhF0llWoRTCe+FW+gs1
 GjHMmJV0eSXXk2Lw/Pi2mQSQwM3EgnZIdg6M1CmZh/VxCC1xNASBmk9BZWqYrjQPHfRT9UO
 kduHKt0iZc/T0NadRaAJObXE8douUVSQEGKeBssZtvqw3dcc2ZZ5pzCe/WEmH5YA02W1VJe
 oxfaIt0vX8UoVG8pYFY8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qwGlOzVCkmI=:opPmslW5Ht9HNoDpltz2IL
 SLMBrw8mIIvh+xL9rEAKnpx01BiThjar3TUSK94YZTIsnr6we9O5fIQ4M8bXPKnwV5g0S3SH+
 sRuMHS1ylLekrqyO+lk1hIFZopss0R1dBofi90J1G7jHdHc3NxvyuoTlHy2q9U94YfdKJKzfc
 prq9GACK5ktgwNxnbsfIexyeAY5NPwixfCqH+Coq4N7Yv5VeLxZRLct1GeTkKBEtUVaUzZg9d
 jLbmYKBoKlAptDjJRMqq0lcJ0JTSHw4BmbmdqWzb++Ky9VD2vo6Hpnvz3R0X2mAHEOsKPTOqB
 0m4J2qVzShEM+PqA3lFse+Oeg13uwdAy+OueaTSIXJrqTwTZJhBEHZNnMHf14ObQQ1p/FLZSD
 x7DEJsZXoh1J39A1sweFvCv/v5ahuMXS4hwCEQVDTrBEmiyDRq5EskUnKUsD9XSAJHU2IhSXs
 JzNraNpt2o0prjlditmBSISOvxxwnK3T/Qtq8mh1BxTfdPFNEIsN6Koiyncs4FuKg8ut0uNK8
 1KC7vP34TJUtzZ0lcGOrMmi+FXKHG8W2dth2MUaWGznVf1J6L2EY2Viq3lIKTm+xhqFJDsUFM
 wmiJ0ONr2OltN6vpRt8PZDA6QGB0yyVIi7TqVBKQT8yNCEx1pDZpjW0hgU7QeqpsnE4Q8Q+4S
 MngEbF1WiX9tBCYhPa3sZTlVWPM/tNstEennNOjOY5457LTCNfVhdkQCwHxHw0KWdN25AQ1gj
 2tIkabD7VTKKJRtZOeerEQvGMddpkEUG32u+/4CCfY4mXC66ZEMU+z9eun10QJ25SpIpo6BSQ
 j4vTde4iktwg+8NWNQZ1QDrtpkS/L8FoPCnctdQkroYqLsQh1tIHewdZmG1gUk8YSug5z6Zte
 sP/vqVzs5dJFvV4j5PoQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/28/21 11:44 PM, Lior Ribak wrote:
> There is a deadlock in bm_register_write:
> First, in the beggining of the function, a lock is taken on the
> binfmt_misc root inode with inode_lock(d_inode(root))
> Then, if the user used the MISC_FMT_OPEN_FILE flag, the function will
> call open_exec on the user-provided interpreter.
> open_exec will call a path lookup, and if the path lookup process
> includes the root of binfmt_misc, it will try to take a shared lock
> on its inode again, but it is already locked, and the code will
> get stuck in a deadlock
>
> To reproduce the bug:
> $ echo ":iiiii:E::ii::/proc/sys/fs/binfmt_misc/bla:F" > /proc/sys/fs/bin=
fmt_misc/register

Yes, it's easily reproduceable with this command.


> backtrace of where the lock occurs (#5):
> 0  schedule () at ./arch/x86/include/asm/current.h:15
> 1  0xffffffff81b51237 in rwsem_down_read_slowpath (sem=3D0xffff888003b20=
2e0, count=3D<optimized out>, state=3Dstate@entry=3D2) at kernel/locking/r=
wsem.c:992
> 2  0xffffffff81b5150a in __down_read_common (state=3D2, sem=3D<optimized=
 out>) at kernel/locking/rwsem.c:1213
> 3  __down_read (sem=3D<optimized out>) at kernel/locking/rwsem.c:1222
> 4  down_read (sem=3D<optimized out>) at kernel/locking/rwsem.c:1355
> 5  0xffffffff811ee22a in inode_lock_shared (inode=3D<optimized out>) at =
./include/linux/fs.h:783
> 6  open_last_lookups (op=3D0xffffc9000022fe34, file=3D0xffff888004098600=
, nd=3D0xffffc9000022fd10) at fs/namei.c:3177
> 7  path_openat (nd=3Dnd@entry=3D0xffffc9000022fd10, op=3Dop@entry=3D0xff=
ffc9000022fe34, flags=3Dflags@entry=3D65) at fs/namei.c:3366
> 8  0xffffffff811efe1c in do_filp_open (dfd=3D<optimized out>, pathname=
=3Dpathname@entry=3D0xffff8880031b9000, op=3Dop@entry=3D0xffffc9000022fe34=
) at fs/namei.c:3396
> 9  0xffffffff811e493f in do_open_execat (fd=3Dfd@entry=3D-100, name=3Dna=
me@entry=3D0xffff8880031b9000, flags=3D<optimized out>, flags@entry=3D0) a=
t fs/exec.c:913
> 10 0xffffffff811e4a92 in open_exec (name=3D<optimized out>) at fs/exec.c=
:948
> 11 0xffffffff8124aa84 in bm_register_write (file=3D<optimized out>, buff=
er=3D<optimized out>, count=3D19, ppos=3D<optimized out>) at fs/binfmt_mis=
c.c:682
> 12 0xffffffff811decd2 in vfs_write (file=3Dfile@entry=3D0xffff8880040985=
00, buf=3Dbuf@entry=3D0xa758d0 ":iiiii:E::ii::i:CF\n", count=3Dcount@entry=
=3D19, pos=3Dpos@entry=3D0xffffc9000022ff10) at fs/read_write.c:603
> 13 0xffffffff811defda in ksys_write (fd=3D<optimized out>, buf=3D0xa758d=
0 ":iiiii:E::ii::i:CF\n", count=3D19) at fs/read_write.c:658
> 14 0xffffffff81b49813 in do_syscall_64 (nr=3D<optimized out>, regs=3D0xf=
fffc9000022ff58) at arch/x86/entry/common.c:46
> 15 0xffffffff81c0007c in entry_SYSCALL_64 () at arch/x86/entry/entry_64.=
S:120
>
> To solve the issue, the open_exec call is moved to before the write
> lock is taken by bm_register_write
>
> Signed-off-by: Lior Ribak <liorribak@gmail.com>


Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

> ---
> v2: Added "kfree(e)" above "return PTR_ERR(f)"
>
>   fs/binfmt_misc.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index c457334de43f..e1eae7ea823a 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -649,12 +649,24 @@ static ssize_t bm_register_write(struct file *file=
, const char __user *buffer,
>   	struct super_block *sb =3D file_inode(file)->i_sb;
>   	struct dentry *root =3D sb->s_root, *dentry;
>   	int err =3D 0;
> +	struct file *f =3D NULL;
>
>   	e =3D create_entry(buffer, count);
>
>   	if (IS_ERR(e))
>   		return PTR_ERR(e);
>
> +	if (e->flags & MISC_FMT_OPEN_FILE) {
> +		f =3D open_exec(e->interpreter);
> +		if (IS_ERR(f)) {
> +			pr_notice("register: failed to install interpreter file %s\n",
> +				 e->interpreter);
> +			kfree(e);
> +			return PTR_ERR(f);
> +		}
> +		e->interp_file =3D f;
> +	}
> +
>   	inode_lock(d_inode(root));
>   	dentry =3D lookup_one_len(e->name, root, strlen(e->name));
>   	err =3D PTR_ERR(dentry);
> @@ -678,21 +690,6 @@ static ssize_t bm_register_write(struct file *file,=
 const char __user *buffer,
>   		goto out2;
>   	}
>
> -	if (e->flags & MISC_FMT_OPEN_FILE) {
> -		struct file *f;
> -
> -		f =3D open_exec(e->interpreter);
> -		if (IS_ERR(f)) {
> -			err =3D PTR_ERR(f);
> -			pr_notice("register: failed to install interpreter file %s\n", e->in=
terpreter);
> -			simple_release_fs(&bm_mnt, &entry_count);
> -			iput(inode);
> -			inode =3D NULL;
> -			goto out2;
> -		}
> -		e->interp_file =3D f;
> -	}
> -
>   	e->dentry =3D dget(dentry);
>   	inode->i_private =3D e;
>   	inode->i_fop =3D &bm_entry_operations;
> @@ -709,6 +706,8 @@ static ssize_t bm_register_write(struct file *file, =
const char __user *buffer,
>   	inode_unlock(d_inode(root));
>
>   	if (err) {
> +		if (f)
> +			filp_close(f, NULL);
>   		kfree(e);
>   		return err;
>   	}
>

