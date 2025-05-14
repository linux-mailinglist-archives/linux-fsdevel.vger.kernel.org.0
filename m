Return-Path: <linux-fsdevel+bounces-48998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F77AB743B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 20:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9B34C28CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073021F4CB7;
	Wed, 14 May 2025 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WWRWxFIb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286127FB2B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747246930; cv=none; b=g+xtHqDzj5ZriHga0tdMimH6ULETNmWvUqOu4kPGaVORjIKRHKJ/ASxUiULADyUwSoZEbunW4nRhAxEB2Xt1e8BmDvq9Io88h54whaMpt6T4PPR+tNQdKbUz+0eICguA7bOhCuDEIuiHzmjB63d6qtLd9jrv0srlApD8L2ADnm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747246930; c=relaxed/simple;
	bh=hvp9AsDlC7TL+8bvq++1Xv3VIY/5QZ/Nz8QK3FfrkQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icGSNSn2bMToKhwaj3LPtmYnmFkURYzrtPRYvpg+OXABWp6XOTHoDJQX3aIOD/xqRQdOOq8CgpB4iw0FaSErSBGboQwSvwse48YFHprhtsStn5xi84DBuqBX76lIbwkRciUssaAYoSHkhpcs/cgULVRIoB82ELtMmWAvDCZfS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WWRWxFIb; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747246920; bh=4rsUJ5zSzI0wKb//W2svOsP/TtV/akPljErK2UMIick=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WWRWxFIbj800zN1VDAZSyeF3izVPbPvd1f3T1RenAomjI4vHmILtakAVC4RhRq4w08roT62zCuTt+hJmuAwndM8oW8nf/w/heYfGtTHOMZZL4u4qR/4DGxmEHdgD3GOR5833KgQx8Bc3Tex1Pw1OypjCnHM7454gJiGhJqezx5QsCs9fU3G1oROgMTP5ahAdEQlGrMroC6ZZceiWaTreKQxilV7a0wiBp2u10ol9DwpnLc2075TaCydSY+9QGjcp9Wnx3YD9V7Crl/WT5jZIyJxDslb6wlzTtqZTRIRcnhiTtz/W4Jx+CclR3yFlgx1zdIQ+iUqZH3Ix8gH6V5BIpA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747246920; bh=7XIVsWwpvRVuD2kUvv8jP3KMVNVcpcWLvza1lIhTR5T=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dv8cuo0dR0+/s5svcTcefp5qM31VGmnQMyaeveWxUZf3YhM71BHVhKVW/SpFuBXDoB3+MJyeigcMHoHG5lRxzIRUNkCT4j0ZAVssrvZKE6oAbDBDFdk2f1H5vIKteiKfJjx+ZJ77u343L3jaXfXu5PMYsSDQLz0//vaFrT9c1kXt9uXC1Y0d7Woh31Ti3NbbeLaL0VKXgqkDY/wM3vMFAokJYRzpQNsljn1rzyJrbeNK5r+4kCRCPXUyltjOkXrRD5+6VeFwikzCN9d1YFkqvnvme2ux09yulI51pGazKKW2t5G7HBB+691apzZklzk/I9q2h2c7BYQjat90m6mfIA==
X-YMail-OSG: nHPTOOIVM1ng.ulIm4wc2Ny2ydbnKy4sbBqTMSuPkDp0amWcNkMMXeYVyWztuil
 VJbnVLWjdnbKddBtA3KvWNF7f0mTgKXu1_U8J.VquvfScER2QosE1vvelxxu1ks621hTS55km3f2
 2DDCZtEErKMYGXcVnN_G_sqjSJHfDH90pgVVbCdHxIoG8IwCL0wn0EtGtO46uv5uecqM0jOM8nX7
 RNdfo_n866OEbgZIx5eyWzbDgg3SRdeQiW.qmBd2X.pnYO8KcevYhfFCWUu8Ondx9j9JHmLjnwUg
 3nm2aUwVkZuEudC54x16Rt7.UlZNFP94d2FTSd2mfzvgeUm.L2fxzEm310L3WOKlTERgRRz4XVnU
 y.F_qzkZUAWW5FfScZJzWWeatYXSA2f7U52noW2Czt1bvpV8_67XwUkvOqG1FYn_HgQgm52aOJP_
 b9A1DZRaFMHk5RzZltDEi8bmO4omDHIV4_LhPjYIsr8mABhGZOumnwdUaNBtfI7EnTuPMtXasiBa
 DkjMUCNYRXp.a98a56yA3GaHwekZPCACqLjqJraoASkfcz3s8AKt2TVUIFWSz1hTy_jM5KLvDzJf
 5PqEy9zaoYAA8.v0fDjzENMmMdUSpRnUi9mKIlzaX2SC8sBtptVu8.MLb2S3aWi9vzyToedUeo7T
 37Tr1.nXQAHTrKVoC6TYXwL.aHH4ok3FQegm9qcrkr4h1RuP.ohwB1pA3w12ZZOD6u5LxQs.x4wa
 YocMlUbBRVi2OcOlia83TXIxwSPnzVGMccuJDteRMXww6TB2BpuHyFbZHUVLQt7fcx1nXEZRGG2R
 shiokbekeYIHrWxwrrv8C.NBor3cqqmF45CPmnYFbwpPQRgfjiN7DM.gAV_3Y2yzuBnLbWqnR8l3
 5.rqduMR.pzo8kV2cw1OtutsRKzePiLk7EpaJgzNphySEMaX_0bq7UPEjpvL6VzQXcPj2c7woYrJ
 4pRcgG.ROQYf2XpkytoWKAf12INW16guMpjchJRNCtVoCXuMOlO0umNmOIGfeIKPjhRw1OTwEsFg
 BQ_CFUF7jLD8QxXPdcnnv6vEaAoGG3HMrI6Pv1a1gdIGVpMwwLKYxhQnvescAdrj0ii4E_nqTDgN
 0ZHIt9vbO7XuK98HMIyBtBOWajwHVNe3_RigFk7mKZZ5AR8TIy5Q4v5f3QuyQajkbkg8cUigBm5q
 FWmBm4L2LoKA4CY6.cGG8Gc3vK9Y3vK8UPe_dU_AKqmffw5nCg7BlSnEo1HK5dh86jKHzXVe.Tvi
 HsghkhzDwokY29i7383cum6PLAl9dZA2QrfZu6PQuaovFZ3..34vcpKCNnLkfr1sv7OjvAeWv57y
 Z5aowgIXJwTXqsY0nE_8JkpEUeFd7vipcj6_U02vkltUe.k2.WJs8rGLIcAfs8WHMVJaUR_SRm9a
 kLTklbTsRnKsvGdnWZD2yMw0bopDYTl2aMAuKwoe.wc0XXBaSilMbCcepXtHlX_qjY4hYbq8tc8U
 bR.XKOnkLLroFhduQHJDprADVKx.dUefQ81QcHs.AeeJpfHuZzBtSElaCKC3fnNuJbKl11D1qMDQ
 EOjorKrlRKSps6PCkMsljkaY3szDFDPkNNsKteaBnrG8NAV1HHiNf3xUabtMdQ2TYVm1MVLFMruf
 BT0LlNoBUL7e4D_1gXY7_FrIZpyGGeHNjiNny_RiIUnec69icjUcgmERSukDs0K.f7z2eLzcc9YY
 l37ksgbNuddIamOmXkMnQwQYz47XUUlYKKPn3hVAPdrzxGjEepp80xg5zCJagMsUB3khgYkQPHhg
 xw2DqUUidVfzpoH3XrG3_dUI0xhN7NzZFQ1vTh9bKuCGStmd_ZyhnUXZ2fKGSxLpbsM3Hg96ntMN
 QNUOky2UwbmKu4ResRxhyl0rtBqHYE_neausETDs8nhbb81NBd8O6SuJLubxMwMSOeOVnOq62tdW
 2EBIu22kkqmmuTmprVPPecu8c4bXgUZeXXGFFR_77dH2yICxf2VX1wOKrF.dXdV.fB8tuGzQrKfE
 vt755q5ZMMdC3.vqa0dLyel40TcQbpulDR7V79PDJ_qRfpXJ.ykn0q66m8VQ4Eylh45B6YUM7.VD
 DO3c4AQSEgwtqvyyHnD4aW.JE0BC0l8Mb8Rm6tkfEhNN5dM917w9MYEYKJuumfLvH28R8LCAu4hN
 faxejEjYc2FGwoTR7jWTVFq7aGVIqjsDL.kV.hP1eqs2ow8SkuYv9_NdtouNhbt8fQqs2UhfUDaR
 vO4NboQM5f1Dz0RTJ1xQMD8x4fFN5MOoT08FZDZeqdePW.ZrjOo17BfpXBkS_RBVi5_uJumnyPQ-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1720cbeb-f9c3-4a7e-be5c-7547ab69837d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 14 May 2025 18:22:00 +0000
Received: by hermes--production-gq1-74d64bb7d7-dp9cd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a94d104d78fd57954bd2c60c7ad9d5b3;
          Wed, 14 May 2025 18:21:54 +0000 (UTC)
Message-ID: <cb737e58-51ab-4918-b5ba-2c18bf1ad601@schaufler-ca.com>
Date: Wed, 14 May 2025 11:21:46 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] lsm: introduce new hooks for setting/getting inode
 fsxattr
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Tyler Hicks <code@tyhicks.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 selinux@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250512-xattrat-syscall-v5-0-4cd6821e8ff7@kernel.org>
 <20250512-xattrat-syscall-v5-2-4cd6821e8ff7@kernel.org>
 <f700845d-f332-4336-a441-08f98cd7f075@schaufler-ca.com>
 <kgl5h2iruqnhmad65sonlvneu6mdj6jl3sd4aoc3us3lvrgviy@imce27t4nk2e>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <kgl5h2iruqnhmad65sonlvneu6mdj6jl3sd4aoc3us3lvrgviy@imce27t4nk2e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23840 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/14/2025 4:02 AM, Andrey Albershteyn wrote:
> On 2025-05-12 08:43:32, Casey Schaufler wrote:
>> On 5/12/2025 6:25 AM, Andrey Albershteyn wrote:
>>> Introduce new hooks for setting and getting filesystem extended
>>> attributes on inode (FS_IOC_FSGETXATTR).
>>>
>>> Cc: selinux@vger.kernel.org
>>> Cc: Paul Moore <paul@paul-moore.com>
>>>
>>> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
>>> ---
>>>  fs/file_attr.c                | 19 ++++++++++++++++---
>>>  include/linux/lsm_hook_defs.h |  2 ++
>>>  include/linux/security.h      | 16 ++++++++++++++++
>>>  security/security.c           | 30 ++++++++++++++++++++++++++++++
>>>  4 files changed, 64 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/file_attr.c b/fs/file_attr.c
>>> index 2910b7047721..be62d97cc444 100644
>>> --- a/fs/file_attr.c
>>> +++ b/fs/file_attr.c
>>> @@ -76,10 +76,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
>>>  int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>>>  {
>>>  	struct inode *inode = d_inode(dentry);
>>> +	int error;
>>>  
>>>  	if (!inode->i_op->fileattr_get)
>>>  		return -ENOIOCTLCMD;
>>>  
>>> +	error = security_inode_file_getattr(dentry, fa);
>>> +	if (error)
>>> +		return error;
>>> +
>> If you're changing VFS behavior to depend on LSMs supporting the new
>> hooks I'm concerned about the impact it will have on the LSMs that you
>> haven't supplied hooks for. Have you tested these changes with anything
>> besides SELinux?
> Sorry, this thread is incomplete, I've resent full patchset again.
> If you have any further comments please comment in that thread [1]
>
> I haven't tested with anything except SELinux, but I suppose if
> module won't register any hooks, then security_inode_file_*() will
> return 0. Reverting SELinux implementation of the hooks doesn't
> cause any errors.
>
> I'm not that familiar with LSMs/selinux and its codebase, if you can
> recommend what need to be tested while adding new hooks, I will try
> to do that for next revision.

At a minimum the Smack testsuite:
	https://github.com/smack-team/smack-testsuite.git
And the audit suite:
	https://github.com/linux-audit/audit-testsuite.git

AppArmor has a suite as well, but I'm not sure where is resides.

My primary concern is that you're making changes that remove existing
hook calls and add new hook calls without verifying that the protections
provided by the old calls are always also provided by the new ones.

>
> [1]: https://lore.kernel.org/linux-fsdevel/CAOQ4uxgOAxg7N1OUJfb1KMp7oWOfN=KV9Lzz6ZrX0=XRGOQrEQ@mail.gmail.com/T/#t
>

