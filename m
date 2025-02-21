Return-Path: <linux-fsdevel+bounces-42296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 815A2A3FF72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 20:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B12A7ADAED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 19:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B53D2512FE;
	Fri, 21 Feb 2025 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="n0MEAhqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F52253325
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165051; cv=none; b=Tk7wkEikqtOftO/BQHOd9TvGBhm96R6yiojDhTlmBxNFFl2DpUeVxk5pRIhJbUaV+VVjoS1GZDZWp3wGSxuKC3APkllJ6tBotB4kBkdHh2e3X+GkrJEubK2HDuUMSkcQ0A67VKjkULn0OKANs8M7y5iY5X1R9J887vlrp+u6y64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165051; c=relaxed/simple;
	bh=yI3dmhSyYiDSIMoxMJSTIeV5baV544HSR0i+ct4QndM=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=bQ3eRqOVwl9Nv27I3GA03V/nIt4w6L6W4Oy64BiiiYcyHWUfRDVf9aleE7EOG9LKju7THH8xUuM9hHq8P5PE5DFxQabKqpZeurJNVrQZFNWxtT6pMJnJ24uJorKqOM27JIxnpoZ5Gbgum6J3fkrpgxjF/P0NTJDKdIq5pzPk+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=n0MEAhqx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2210d92292eso75869945ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1740165047; x=1740769847; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8NE366pxsly7loJXwNdcaLiS4OyPKL0PK8UxThxSJc=;
        b=n0MEAhqx2+hZ5bnEAkZLA1VCTkn4+8zG35idfs/IH1Ll4J4TpIgImdm5kSMQ7rq/gf
         KPA3N2AA+snJ2z24fFuMpVtJeMzHX+GlD+nB5O0bvxxJCWGbBQ4+RYlml1orW6p3OggR
         CO9W41yFjNEB7Gw3GBV2bMR7QB+KD/Cr49Tq3al7Ahfagx5oRTlD6Cq+bctOZ4q4LTvl
         mvG5kT/JGmagjCQ7KyOstYqhW5E35HM50MkAoBBRON0qRI/eR3ckko9tTSr80X46LeEf
         ZXlbzdnlcdbxg0yRADs3sPRh2Hn8wbaMcM6my938xOLTqGqJ+W+otj0T4/8L8dSsidrB
         TtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165047; x=1740769847;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8NE366pxsly7loJXwNdcaLiS4OyPKL0PK8UxThxSJc=;
        b=Tl+VX2uPcX4IRLfNkvzRGStzA4SSi/u0VUA31Dqp7Xu5fkuTMoDsFtofUiHV/51ODZ
         rtBG7299QGWAp43ifM1zFLxzmrT85CCzSh5+dlgdwAvTh+BbVuiEcn/fGUIVLugBr6uh
         c5xnRc7/INTZpu6JMLQRkHcHBR/fshGpgX81i21JnpCP/WlrX/6YlsKcpjPJA7G3/w11
         F7Ix9vLdUHwemohapjvLk6yw4xtrlLKIKJWfv5T2LcNOUSBDXztF3Xlbng4/6x7c1M7I
         Mwd0Itr3GKYdylhdo4Jt2DaRpSnaY7yMZepIKW0vVnjK5lwM409tedNGUdz0xNOEvSB/
         IWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNYA1FUU7RUryGu3QJbrDkLFPX7V8/yVkxJfAzSuuzMIq5GLcaJ3+PUinPZLE6al5wO4uIuYoT7l3/W+MG@vger.kernel.org
X-Gm-Message-State: AOJu0YwTkk4/gvnIFyptDNTOoV015QySqMTxap83gvg5vGazbaWVWdD9
	mtz+vlbdUFxJ1M++d8o6J+zlgFv9krkvVWSNrom0wcu3V47pC+tBx6MXY6l3IeM=
X-Gm-Gg: ASbGncvhiTJpIHcp4y6ehzENa9TChNuMG/v5feHdUvRRQoF+X43OTsCXgvNZ1WpPeD/
	vOBnlkPmyjjqmCsx64ZhRwYPtDBlcfeZ13yskckatyK3SeLkDkbkd52zqEfo/Gjue5VgkUCzAE0
	AYHpopHH0k13v2GTuhO3bP0ZlNlhE4SF9iI3nh3WzTtKxNkqyY7zXEiPeRdyxfhQRTHuZEIvlQn
	1Gu6PPUTkWKsE4hrssGDXXhs9Bwf/UFk6K0aQmwJQobObrsNJXxxzC4yiYPwMAwuEZUwNKC3L8A
	nUCiu6mwJYG+/JAInCIRYd8gv7StREY1JHn0CRCfrKXptUoF2LpqwMKOtH7fKOk9Ofzz0Z4qQXA
	=
X-Google-Smtp-Source: AGHT+IGsm3cz8CMkWhqPkYHx4pUzXJeTLyxXX2E1Qoyi6Uk1q2t2thGJdA7X/AwDgfRGQ2QCuwoWdg==
X-Received: by 2002:a05:6a20:8426:b0:1ee:6b16:983e with SMTP id adf61e73a8af0-1eef3c9ab1bmr8652308637.11.1740165047510;
        Fri, 21 Feb 2025 11:10:47 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb58618479sm12546754a12.33.2025.02.21.11.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:10:46 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <452C3BBF-0EF5-4B13-9D06-A94DF239EB03@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D1D28E5B-2E34-4F06-A340-A87EB42CD305";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Date: Fri, 21 Feb 2025 12:10:41 -0700
In-Reply-To: <20250221181135.GW21808@frogsfrogsfrogs>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-xfs@vger.kernel.org
To: "Darrick J. Wong" <djwong@kernel.org>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
 <20250221181135.GW21808@frogsfrogsfrogs>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_D1D28E5B-2E34-4F06-A340-A87EB42CD305
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 21, 2025, at 11:11 AM, Darrick J. Wong <djwong@kernel.org> wrote:
>=20
> On Tue, Feb 11, 2025 at 06:22:47PM +0100, Andrey Albershteyn wrote:
>> From: Andrey Albershteyn <aalbersh@redhat.com>
>>=20
>> Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
>> extended attributes/flags. The syscalls take parent directory fd and
>> path to the child together with struct fsxattr.
>>=20
>> This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
>> that file don't need to be open as we can reference it with a path
>> instead of fd. By having this we can manipulated inode extended
>> attributes not only on regular files but also on special ones. This
>> is not possible with FS_IOC_FSSETXATTR ioctl as with special files
>> we can not call ioctl() directly on the filesystem inode using fd.
>>=20
>> This patch adds two new syscalls which allows userspace to get/set
>> extended inode attributes on special files by using parent directory
>> and a path - *at() like syscall.
>>=20
>> Also, as vfs_fileattr_set() is now will be called on special files
>> too, let's forbid any other attributes except projid and nextents
>> (symlink can have an extent).
>>=20
>> CC: linux-api@vger.kernel.org
>> CC: linux-fsdevel@vger.kernel.org
>> CC: linux-xfs@vger.kernel.org
>> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
>> ---
>> v1:
>> =
https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kern=
el.org/
>>=20
>> Previous discussion:
>> =
https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.=
com/
>>=20
>> XFS has project quotas which could be attached to a directory. All
>> new inodes in these directories inherit project ID set on parent
>> directory.
>>=20
>> The project is created from userspace by opening and calling
>> FS_IOC_FSSETXATTR on each inode. This is not possible for special
>> files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
>> with empty project ID. Those inodes then are not shown in the quota
>> accounting but still exist in the directory. Moreover, in the case
>> when special files are created in the directory with already
>> existing project quota, these inode inherit extended attributes.
>> This than leaves them with these attributes without the possibility
>> to clear them out. This, in turn, prevents userspace from
>> re-creating quota project on these existing files.
>> ---
>> Changes in v3:
>> - Remove unnecessary "dfd is dir" check as it checked in =
user_path_at()
>> - Remove unnecessary "same filesystem" check
>> - Use CLASS() instead of directly calling fdget/fdput
>> - Link to v2: =
https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kerne=
l.org
>> ---
>> arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
>> arch/arm/tools/syscall.tbl                  |  2 +
>> arch/arm64/tools/syscall_32.tbl             |  2 +
>> arch/m68k/kernel/syscalls/syscall.tbl       |  2 +
>> arch/microblaze/kernel/syscalls/syscall.tbl |  2 +
>> arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +
>> arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +
>> arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +
>> arch/parisc/kernel/syscalls/syscall.tbl     |  2 +
>> arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +
>> arch/s390/kernel/syscalls/syscall.tbl       |  2 +
>> arch/sh/kernel/syscalls/syscall.tbl         |  2 +
>> arch/sparc/kernel/syscalls/syscall.tbl      |  2 +
>> arch/x86/entry/syscalls/syscall_32.tbl      |  2 +
>> arch/x86/entry/syscalls/syscall_64.tbl      |  2 +
>> arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +
>> fs/inode.c                                  | 75 =
+++++++++++++++++++++++++++++
>> fs/ioctl.c                                  | 16 +++++-
>> include/linux/fileattr.h                    |  1 +
>> include/linux/syscalls.h                    |  4 ++
>> include/uapi/asm-generic/unistd.h           |  8 ++-
>> 21 files changed, 133 insertions(+), 3 deletions(-)
>>=20
>=20
> <cut to the syscall definitions>
>=20
>> diff --git a/fs/inode.c b/fs/inode.c
>> index =
6b4c77268fc0ecace4ac78a9ca777fbffc277f4a..b2dddd9db4fabaf67a6cbf541a86978b=
290411ec 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -23,6 +23,9 @@
>> #include <linux/rw_hint.h>
>> #include <linux/seq_file.h>
>> #include <linux/debugfs.h>
>> +#include <linux/syscalls.h>
>> +#include <linux/fileattr.h>
>> +#include <linux/namei.h>
>> #include <trace/events/writeback.h>
>> #define CREATE_TRACE_POINTS
>> #include <trace/events/timestamp.h>
>> @@ -2953,3 +2956,75 @@ umode_t mode_strip_sgid(struct mnt_idmap =
*idmap,
>> 	return mode & ~S_ISGID;
>> }
>> EXPORT_SYMBOL(mode_strip_sgid);
>> +
>> +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, =
filename,
>> +		struct fsxattr __user *, fsx, unsigned int, at_flags)
>=20
> Should the kernel require userspace to pass the size of the fsx =
buffer?
> That way we avoid needing to rev the interface when we decide to grow
> the structure.

Definitely having some extensibility would be good, and there isn't much
room left today.

The struct size change would be handled automatically by the ioctl()
interface, but not the new syscall interface.

Another option would be to use an xflags to indicate "larger struct"
and then store the size after the end of the current struct.  It would
also be possible to use one of the few remaining fields for this, but
one is earmarked for the DOS flags and/or a bitmask of supported flags,
and there isn't really any value to it until more fields are needed.

 #define FS_XFLAG_LARGE_STRUCT 0x40000000

 struct fsxattr {
        __u32           fsx_xflags;     /* xflags field value (get/set) =
*/
        __u32           fsx_extsize;    /* extsize field value =
(get/set)*/
        __u32           fsx_nextents;   /* nextents field value (get)   =
*/
        __u32           fsx_projid;     /* project identifier (get/set) =
*/
        __u32           fsx_cowextsize; /* CoW extsize field value =
(get/set)*/
        unsigned char   fsx_pad[8];
        __u32           fsx_fsxattr_size; /* struct size in bytes =
(get/set) */
        :
        /* future fields */
        :
 };

Not su

Cheers, Andreas






--Apple-Mail=_D1D28E5B-2E34-4F06-A340-A87EB42CD305
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAme4z7EACgkQcqXauRfM
H+DMlg//W/63bQNC/XI3qo1NyxMQFunTHhnYqVFQFStkBLA3/XOtyfbKmpsnlKLr
jK9w1XjwDO8+0kQZ2F+7//daUt9DqS+ZUTe63OtpLcnnZmGkQW7GpCXa09oLRbXZ
vkti5v1ki5colZRz0muZM7Hm3U304pO1xxzS8fCBm4jxUtL2AdCmSOo9UPEOdN7H
Y1VK+ZF01cCCfjMXgudXQtIkMudjsaF6Va54vhHjtGz1ap1Y3VqbAkXV3i2emVYb
bQflRMJ2q/P+HCDoqLQBWt9RTTPYCAipcMWjsibSZ8DpEKGrnVl9nRkUuXt+NfIz
NDE9dlMnY6dZCW3zlMybiOoJRF+UABnZ62PIsmvRdI034873QgSmTC3JGu3iGxu4
cZamq2anwU7zLjhKZRLocvFq3RrdWoe1Nm3YR0bX9mTr7T+X8bR2enN/PZjZ8ClO
WXVVxnwwLmiCTUALx/1oBJXnal4mbGipMlydJshU6TNTpJK2lEFoi2kY5Tl8hP5J
EewsY4UYyP9iAycLupBu1Z9pJrTCId94MJuHwZYT3snq9weo9+CKrx0rKWruzWAq
PzjurjT13LOIBdDnsXSom6QhCEpswN1uxec3RwKsbexBcJCZZGVgjE6j8F37DjXi
ETiuMxfdHDOZ26jidKARVcbJ4k1pN5198hUGf0/yfwBsJeRViBk=
=oe2t
-----END PGP SIGNATURE-----

--Apple-Mail=_D1D28E5B-2E34-4F06-A340-A87EB42CD305--

