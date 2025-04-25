Return-Path: <linux-fsdevel+bounces-47402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D89A9CF6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 19:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1952D9C4207
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D901F4CAF;
	Fri, 25 Apr 2025 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FoySpbvR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1E71F3BB2
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601676; cv=none; b=M/J6cncutM3loWeRIirgVeOhyJeQ4Tp/GEL/5OAzPUYoaSvuXkrmd1seWDptXI7e1zta8IBulFrjmZSswxTdxXZxS/WGXk+XrhQTooo6zBqgTA7R9tfI6wSEmUMwF18MofpK0LPph6D1x37d/LL3OtfWiz68gUVB1oENCO70T+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601676; c=relaxed/simple;
	bh=yePzdq35Z7LksvggzxgbBt2Xl46ejOYJdpbHjfPs0kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKzE3XxpRkGg+1nSGeZ0YGvoi0upYM6ut2mMjP2t5hWgxWO44KXZXFAi5+X469cYyV6jaekEKfrqKkHEmI/JDIs265pGjWoM0D7YvZCf7MukNDMZY9DN0P3uokFpLcthbpnnJ19It7tual2jEgiuft1TsJmmliOZQ4SMM+3bo4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FoySpbvR; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745601666; bh=keseLyNAzEGWWSwvxw93PFtqBMGnHxHVrNrPDyui0OU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FoySpbvRdHg8u9S6f+vcbH5pFA6RjIjMGk83W2XAhd1NgABquENAMGF+PVknyzgY30QbQWOBh893h7ByUET9TjlcSuBXcRspO2wxoDLBgoWM8EmWqQ2N8PEPJQJvsJWH/rYio3n5gMA3tyEfFTWeuZgtJT2WsTNii3nN5bCEHvvmgE6/LyoIULcMuoQ4C0RMPZlEYQLzVLqIxLHhjsTdu8FnzGqlIrt/3x4flQ0uL181i3vQUY/ja2mU6s6nGqDVWwBqBhYBg7g+EBNm0xcg4Ep1X02dhOB+TNJuUviUHdoeLTCsYimBkvKD/1zbTrEx7zckPFNAQ0ue6ifclKSTjw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745601666; bh=yoTGxhmN4dHjj7qw6I4rqrbwCIpbXRyfangIjkIqac9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dFwdQNu6HtKR7M5zz040tvlDBX+SrPTpU7IDyw+4x0ACCX59aFkCzqWM9inwUWR8TDbPJ+m9SiU8GGD6z4V7rp9NzpO7kaQk2/oDxnQHS4m1/MqlY29dq+pFTDSGDOOcuZadLJRcENubKZ9Hg0e4VKvXwd7m6/lkPLERRnUtWiwc8n8kdgatojLpLMoxWSmKZZsS5yWngmDr1tRB/e6qbcBTPPI3Jos81pFuU3E5tg29w1ga6ATU828k5txjig3Q9Ei2Ob6pqSZk3nIb7BYsicsBCen2p+UAMbK/Ac6cFTl6UYVSHXNCr6TqlHh+YTimeG9PsHALPoCWiRhnEHzWkg==
X-YMail-OSG: NrO6AaAVM1md0Q_sun8kK7ZBFVwVG42H_EeT8gUMJkAyoB9qnGwd4B8SJknWO4r
 Yflh2GbqmfbM_2cczXUvYdO.Ja.FrQRLgNiEI35zSKx3UAArkb5DzUOKyJ1cszcI3ncjg4JlUXAH
 o5ZLPKJRKu9J76YKNxQZPp49BYSXw6RIougiSlzcgHnWarbLN71R81GomzgOYldicYx7A6llBXg_
 sjrEOu9c8mFjYaLxMHWKQ3UN9NlUMHOl7V63Zx.opxPbvilFBSpc0IPeVC6C0capYogKz0w44..G
 YkFG4S.0zXd.dS7KxDPeh3Vmy4QJ_C5XZV1LviI2mtqn5TzClu1I.yyes6wxTfnT_sjfviXpYCH4
 pb22VwvtApCR.MvU7dkc_yTO3d6cZw0CDBLvG.HCMedOV7PYu30UrFNAGp9jpb9cvS21IDc48zl2
 9hfD3Eak8bynJKRtLJyE2vpJt7E96et7Ir5MuUx3nzVQs23HA9wM.2_BFy7531JgLQTBXpSH3nMe
 CeRysrTOEiYc.F.VXh9NZ9_faIN0QsnL7LfWQHbz0gCBuLmtaMfG_Mp6XXp6h8b6mhbxR38WWC9H
 hjAWT.Ppxtesn1ee_NlBrTSiRV6xRAeWmKL5toBV2YQVI7Knjdoed8sIOj39K2TdQmI9267kZuix
 _RjuwcP_KnJJEnHx.wwcQH1JKF2fFMYAVog2MSZjNt4_3pG5J0k9hrDlZb.zBLtjhSK8x0NxZck_
 nGZKmJPVqKa0M8k3K8ikhFs5B23e._MlP1C47Pa_xp3p3OmkG5LnpwryBjoTerV.OJZLwJKR3nBm
 xiLJ.Wbhq7Flt5yTUMmSbbUWBpUCQQw7GW42bOP9Uc1ZV3MI1Dj9JkvXD3KJd7tBcnoDNHcJlh7F
 g3D.SVl5BBzcH1xMA_QnHh1qrSYsH6AT6.7SpSuZSNdLE_2btkfLt_uiMuVloWHZJuVUFnju7mzQ
 DI6RqLCCGONZC.HW0183zqkOwlA2AjLEyxWHWt8Bb6MN5U0X3_tSb9Xj9jEfqxBaKHvfvMn_TLNf
 2BQQBvsEF.B_G5daH9CvXrAqJr6J61DHm5RtkTVCRXMg9.brgGuDQ_qJK.bwNwTg2lrPl6Jl7jFK
 iTkoVWGtGBiYrwqkKh2ekxnYKSZ1BA8efbpK7fMCMTSQ1bfKElQqYOfXUzGxKOTmLJ_1NRLB9iCp
 KctxIuaM6jJNMkDawmqkTRk9jFHGmn1N142.kT5m17ASusGS.4FnmEBS5hsPTp7PcmyyIgMyB2Td
 nuwesM6sImJim6N19KLNxN7YURipCxMp0jqc1.2FS5Y1CCp.xLlPkS4B_O5TidDfiyLXrgY_P_zW
 UZGwQ2diUOUt.V1uhAOBikm7JzW9YezfEDOD77H0Gy7Tm4vhbg_O6782rHsKoAnFZEL.Tf95StfL
 MsHOsKGo_Q5eQ89FtPdQSNaVA96hDvC7n4pcyMbLgr5bGpUUzVd_Xh.xHPDtTQneZBYpilg0uhxN
 lmR5EnIF4Jt2zHx6Qs5Zm.lszGbjtYIU_1zfOYUAyxtvmHN4anb8keosBBQTEce69S2NeMnxTNhE
 cRqVKrohF2R1OhF4gLOZLGnVRwKj1fETPLOT1xzrDCDzeqOnPZE.1FHD0kRkt3Nj3vU_a5kIgbro
 XAYR4svYVAwa3SdimX9W.qNwXAOKpk1enIatcAbcj8fkieWXWpIcmoLntqLEI3FsoxXxhxD1.WMI
 3BaW_FJhXzz1keU8p3y8IXfMvmrKlEheyr7Q1BwQr8hEAlY__7P8Yj_cOE.X0qFJE4c.dfietGcW
 BvBZggaJ0VoSdvu_vtl2iANICXUoQs52QdViYNOGHVBkg58lc.8Q1jHpl.MUYJzGbdg0NLNz4eXT
 RnX0ch_K2G_dSZsoweBDly8oq6Z6_CnxR7jjUWwAu8wkn1Ltum8WzCmtLFvJgA9LZOaCjxCofx62
 2hr7phqQRuWKpNWMZyjFL9XgpvP7Uy_rk2NZwa.Rh62oDG8BVQEdBM89P8aeIbnqkFa2NhccL1OR
 9Ozt.hls3F7vzIK_eHZEBRF3M3pr.PZZYHPjvyYNeVJYfpyIuX.OcsPg764OUzJOMa43orXhNS4K
 3owHkulGGEtz4ix_m_sIj9g_Wrhfafu1JF2i_RmvDcu9y3YzbagTrXn2GUwk8fh_TMLjrTQkASpq
 4BVd1339sYkwtOYZ1MHm9zvNNs1Lji9L2c1zL6XKBgr8M6bBDzu5PGNZpy7MJx2gLsrjgPUifq5O
 W7MSSjnROAXwzws6gRzfUNUMFG6Lyq.doIiEoRVNBLZnmyQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 58421644-9a9e-4c1b-b5b1-015a27889dce
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 25 Apr 2025 17:21:06 +0000
Received: by hermes--production-gq1-74d64bb7d7-2dlqg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 382c63824636e912791305cbab0917b5;
          Fri, 25 Apr 2025 17:21:01 +0000 (UTC)
Message-ID: <184c3ed7-5581-4bdf-99ea-083e28e530a8@schaufler-ca.com>
Date: Fri, 25 Apr 2025 10:21:00 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list to always include
 security.* xattrs
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
 <20250425-einspannen-wertarbeit-3f0c939525dc@brauner>
 <CAEjxPJ4vntQ5cCo_=KN0d+5FDPRwStjXUimE4iHXJkz9oeuVCw@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ4vntQ5cCo_=KN0d+5FDPRwStjXUimE4iHXJkz9oeuVCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23737 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/25/2025 8:14 AM, Stephen Smalley wrote:
> On Fri, Apr 25, 2025 at 5:20 AM Christian Brauner <brauner@kernel.org> wrote:
>> On Thu, Apr 24, 2025 at 11:28:20AM -0400, Stephen Smalley wrote:
>>> The vfs has long had a fallback to obtain the security.* xattrs from the
>>> LSM when the filesystem does not implement its own listxattr, but
>>> shmem/tmpfs and kernfs later gained their own xattr handlers to support
>>> other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
>> This change is from 2011. So no living soul has ever cared at all for
>> at least 14 years. Surprising that this is an issue now.
> Prior to the coreutils change noted in [1], no one would have had
> reason to notice. I might also be wrong about the point where it was
> first introduced - I didn't verify via testing the old commit, just
> looked for when tmpfs gained its own xattr handlers that didn't call
> security_inode_listsecurity().
>
> [1] https://lore.kernel.org/selinux/CAEjxPJ6ocwsAAdT8cHGLQ77Z=+HOXg2KkaKNP8w9CruFj2ChoA@mail.gmail.com/T/#t
>
>>> filesystems like sysfs no longer return the synthetic security.* xattr
>>> names via listxattr unless they are explicitly set by userspace or
>>> initially set upon inode creation after policy load. coreutils has
>>> recently switched from unconditionally invoking getxattr for security.*
>>> for ls -Z via libselinux to only doing so if listxattr returns the xattr
>>> name, breaking ls -Z of such inodes.
>> So no xattrs have been set on a given inode and we lie to userspace by
>> listing them anyway. Well ok then.
> SELinux has always returned a result for getxattr(...,
> "security.selinux", ...) regardless of whether one has been set by
> userspace or fetched from backing store because it assigns a label to
> all inodes for use in permission checks, regardless.

Smack has the same behavior. Any strict subject+object+access scheme
can be expected to do this.

> And likewise returned "security.selinux" in listxattr() for all inodes
> using either the vfs fallback or in the per-filesystem handlers prior
> to the introduction of xattr handlers for tmpfs and later
> sysfs/kernfs. SELinux labels were always a bit different than regular
> xattrs; the original implementation didn't use xattrs but we were
> directed to use them instead of our own MAC labeling scheme.

There aren't a complete set of "rules" for filesystems supporting
xattrs. As a result, LSMs have to be creative when a filesystem does
not cooperate, or does so in a peculiar manner.


>>> Before:
>>> $ getfattr -m.* /run/initramfs
>>> <no output>
>>> $ getfattr -m.* /sys/kernel/fscaps
>>> <no output>
>>> $ setfattr -n user.foo /run/initramfs
>>> $ getfattr -m.* /run/initramfs
>>> user.foo
>>>
>>> After:
>>> $ getfattr -m.* /run/initramfs
>>> security.selinux
>>> $ getfattr -m.* /sys/kernel/fscaps
>>> security.selinux
>>> $ setfattr -n user.foo /run/initramfs
>>> $ getfattr -m.* /run/initramfs
>>> security.selinux
>>> user.foo
>>>
>>> Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
>>> Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.smalley.work@gmail.com/
>>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>> ---
>>>  fs/xattr.c | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/fs/xattr.c b/fs/xattr.c
>>> index 02bee149ad96..2fc314b27120 100644
>>> --- a/fs/xattr.c
>>> +++ b/fs/xattr.c
>>> @@ -1428,6 +1428,15 @@ static bool xattr_is_trusted(const char *name)
>>>       return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN);
>>>  }
>>>
>>> +static bool xattr_is_maclabel(const char *name)
>>> +{
>>> +     const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
>>> +
>>> +     return !strncmp(name, XATTR_SECURITY_PREFIX,
>>> +                     XATTR_SECURITY_PREFIX_LEN) &&
>>> +             security_ismaclabel(suffix);
>>> +}
>>> +
>>>  /**
>>>   * simple_xattr_list - list all xattr objects
>>>   * @inode: inode from which to get the xattrs
>>> @@ -1460,6 +1469,17 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>>>       if (err)
>>>               return err;
>>>
>>> +     err = security_inode_listsecurity(inode, buffer, remaining_size);
>> Is that supposed to work with multiple LSMs?

Nope.

>> Afaict, bpf is always active and has a hook for this.
>> So the LSMs trample over each other filling the buffer?

The bpf hook exists, but had better be a NOP if either SELinux
or Smack is active. There are multiple cases where bpf, with its
"all hooks defined" strategy can disrupt system behavior. The bpf
LSM was known to be unsafe in this regard when it was accepted.

> There are a number of residual challenges to supporting full stacking
> of arbitrary LSMs; this is just one instance. Why one would stack
> SELinux with Smack though I can't imagine, and that's the only
> combination that would break (and already doesn't work, so no change
> here).

There's an amusing scenario where one can use Smack to separate SELinux
containers, but it requires patches that I've been pushing slowly up the
mountain for quite some time. The change to inode_listsecurity hooks
won't be too bad, although I admit I've missed it so far. The change to
security_inode_listsecurity() is going to be a bit awkward, but no more
(or less) so than what needs done for security_secid_to_secctx().

>>> +     if (err < 0)
>>> +             return err;
>>> +
>>> +     if (buffer) {
>>> +             if (remaining_size < err)
>>> +                     return -ERANGE;
>>> +             buffer += err;
>>> +     }
>>> +     remaining_size -= err;
>> Really unpleasant code duplication in here. We have xattr_list_one() for
>> that. security_inode_listxattr() should probably receive a pointer to
>> &remaining_size?
> Not sure how to avoid the duplication, but willing to take it inside
> of security_inode_listsecurity() and change its hook interface if
> desired.

>
>>> +
>>>       read_lock(&xattrs->lock);
>>>       for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
>>>               xattr = rb_entry(rbp, struct simple_xattr, rb_node);
>>> @@ -1468,6 +1488,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>>>               if (!trusted && xattr_is_trusted(xattr->name))
>>>                       continue;
>>>
>>> +             /* skip MAC labels; these are provided by LSM above */
>>> +             if (xattr_is_maclabel(xattr->name))
>>> +                     continue;
>>> +
>>>               err = xattr_list_one(&buffer, &remaining_size, xattr->name);
>>>               if (err)
>>>                       break;
>>> --
>>> 2.49.0
>>>

