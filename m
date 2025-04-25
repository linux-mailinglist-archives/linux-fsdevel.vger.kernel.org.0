Return-Path: <linux-fsdevel+bounces-47419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE94A9D514
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C2C1BC2DEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 22:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AA3226D12;
	Fri, 25 Apr 2025 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Qa/sCaQe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C29221DAA
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618807; cv=none; b=LhKF/fCXV1daGAW9oIRuilAdvkiRiqdiQdJ2TpiQ8Q7fW33K6fNFSnaMV9CqYRFLvCQR/RXjL3cAY8iIme6kD+EJ+VpjRojC8zk6f+dvTvYQV85JJOpt9+UUaC0LWIjIzllyZQU3AxC7tEgrGRPwO54l/e7nYF7qDDjA11lFCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618807; c=relaxed/simple;
	bh=FD9UoTPNTxeWCWvRyNfuGa6M5OjdSFZB/fg3a7X1Qyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0pEKDuaCRB2Rl9dY4x7FmlBqQ5BYjMQJWjp/BsYvWDqL/Js0lrzH89wHbW7CNZ2KyOXkedMXEEsl+o7tKjnY2zv+R5PoyJpJPQRaA1n8DqZBwAPzHDUttC6N+12zD7RNjWS4EtHes7fWSrtAwYdhr2LWe2qUNIjBNNiUi6nYhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Qa/sCaQe; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745618802; bh=8rGCB975TyQpK1p5+Dcc4mGhyRUGsaDR3PeF2jwJfWg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Qa/sCaQeaAAqOOtgWTgubpxi0oWEqPpWR3eae9Ix+yDHZi/DL7/wwN3nUrCi/4Dzi7vUUxHupOyBO/e84pR/L5aOD/7nxnIOBf69OHiVbSs7oYFvMfntiu522yW+DGdWSlLdyiqqd7dZAVQxiSRVB8N+gKmh28bpKgKtylym7Uhxn66diBIxFhaoU51pTDMwWtlNaUXqAVEnNy9onKzgR5OIaSGPDSnBsm76vVIjoob3hPEjAX9iBfNZCLkESMdjsEKIOXa8ZEN9AZ6xMXd1klZ5BtZoeds7XDeDuIDhqk/ITwfyGY0zM63QEwpJHe2G/Z+cRyoUei3m5zzf/tKwBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745618802; bh=YRLSaA1LsZ8S54E6tjqJfczLuN6gwYDmeLaRCagCb4X=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ic+wWZhoa+9D4jMszl+WKJA8ILMXw62C4rUN2b2PY/B9/uOvFJKWdk+wX1kB3+dpADGU6MA5iHhhCV8GyLY/4w2BNEmp4Wt9BgY1pWKpTHFbD2DvkbvvhFsAawdg0/+ueze1tbmRhz+SHp+KD8q9ICyM0i4C5QfcK+hONo9M0KwC57VPkzio8LNZbQrAVNthbJDwU5i/z5HlZjtVXFsc3rB1JZA8IVTxSxolsYzNdVXgPDMA2dMySYl2s5uPy/OAXU6ZCkf+56TCW3tXFoyk7gsbSAV15R1Ns60RR6rGsGozZmYrMd9r+BckYp1S3mJMtgAztbxWvI74HS9jk2qxvQ==
X-YMail-OSG: adXwKNQVM1nB_H3l9KGnpQ4jxN_kHEWZXuFWCLcgBDVDHwr4AIi_4JGfEigNmkX
 I8JArQezKlq35HzlOJezs7hqYDqcLgqrUO0Y033NBVkfMD1V_cage5dt5t0aZwB5qL4McVz3c_mo
 FwYwF0QRYc4Ctr4RTKjA9wp3I5bP4d2wzeuRVtkitbhRWZhQU2TwekYQaXnngLJEYInSjYDXzjZR
 P57SXNy8275uAvwhZWZqjYl0XKtj6S6.Si6ocPI9hRS0MFcDmB5BsSV9b5wwv9XPofQKTPC8sPM7
 I2GK_IpYqQYBIXdd37voHSsYRO5prGZJwETK.eIyiE9LdV._WuSN.U_wr8cDBwsRXfuEI3xgQ06o
 DlMhFWsMGWGz3iVkOoUxhAO9JgH_j4Dw6SFSQsuyYwYlryQAaVV_ccmGd0fewTqleKJuaUGDcYJr
 aZeEUIiuZexs1AUY45Ch3lOU9fOztors3KBQi5_x_GubxPRao5nkA3Eef8OGChZVq1Xpjn0sBPaP
 pbtxLex2y1hZz3mM.FWXWoUdnHDoLDtBtpHCn_3kjkCOHeEDlj9AtGjAKO84AhJOfsZupi_6mOSg
 1hwSb0QfsxbSl6wARYGHlpzYEnrjjbQz36EcdMtQL6jl62W1BSiAcAmmwzBBeyDFPrkl7sySFxc.
 aHaNEC3pwR2hu.4vLbZXkzpyghAPeFJJDdJ0A7yRfux9zoEpdnO1Mzd9x7UV37xwdAi6ILTv9rUd
 LD6nuiLZg3AZCDyITZHql7WbGYTJCIoj1ZoevNQ.rZXFg6qzVio7SsI4CaiSfCSHG8wzWaPJxaoR
 TbnkUBz87KtW6pXwAPbR5DMNWLjZYI44fDUhx0jg5UlZA74J4YCgSU3D8hz_5xxkZQ_LhmtbRI2O
 DPie.sdmN.MHqlADLcZIg.FmQUG_AfLgNZGl2V9VUbliOeKKg1f9mFRTHCmKTYhnB9LruBtVwAPP
 EewpEcqD5ISgbeNkQlVKMtGx3ppVPEFKQ4hrrRH5L.znIpbYVZCw2hPbsJ_xc132eJvy1LfIwVVN
 mr8ZKZ3a8fYpg_k3V9WND7CunkSXbQBZ9FEvMuf06BPWWXgQqA8NZzvNIjAjNf_gewrsqJyfFxLX
 mWsSA.LVP1fAKP0F.UOEAyn8gJkS5VLgd78B2qSxxSK2G5x5hxAEkN9PMV.zLd8qdALlpjJHPXmU
 5bTwn3ILFWUqfnw126qtFQUFpg5xBaOzcEjHpm3OONaypW1Yy0D2G42EQ78OIBBozRgyHc8kTe1e
 jfA.yo6J2KeGNKifKfccwr6F9ylSswcZNmm0ATp_W86CkWWgTmkDriKIn49j4D9Z42fpDvVxRdgB
 7X2v8IFo6vo_gMjMGjvhoNCnaKXygzaKc5CRJx62bgWGtwOmd0nyAVjyM5nyDfZLYpdRYOrNnovE
 1Afyo6pNCog4w66itaLRX05Knwifg2QAhg31B3eQ9_YGqRpAtMg1I7P6xmxqFK0tKMzuoLhm77Rc
 EVvIBYH2rbZayZBbqAVsV7lFlLsQD6ih3pAmnoPx5QPuCxW71csEmpDiFIU_NtBkMbKHOukw5XBM
 C_7j_mtX4fNUYfFjpOnzeeWCA1OIDcKDGligPaOkT6fgeGDTlRsw5HfEgdLhUsjuXyoIz4LU8bJx
 uIdXToF3AJGwMrHZL2XZDRNtREq5RdwRo32ABU6vC3M4gcufWbTwzdspCQZqY29jbDS5OQVxUqIL
 lfXG.0RQar3Q7o33.nA_PjgF2EsZED4ifhfaILwhwgGV8vgnu4SPj8BzSjujcpW8jNjo.G.BYEWd
 ODueo3IvrtQc6FhTU7SY0jZ0zs0SA1gRGia92x8DBJHZX70R6HCDB3xnbnhXeKkt9vwAcWjyLOOO
 SA5MeiQHVaMjuGYuPiaET9YH_rTGV3VBiK7ETxQLSDD6e8JLYuiknZsyzv_khLMEyDtRXIvdtmmM
 c.D1jrb7sAXcEqMYvL3mmsoe6kPVMY8dSOxHnK_R_1WmHqzxM.KRHsOHsyhYtb9siy7qwDROKm51
 ZklOZPEEEktWsRmLFnoagA6lItcKyxxU4FQ6h9sKyU8QDB6nfrDF7AT06HduSJrVnJR46POdXvI5
 mZ.tldn04zyQ1GWDS5TQjgnVqKN8ApkHhfKZ295bECGP7gY8Nnr.K6x34QtVJRiRj_S0MhBxWbSG
 O9_Wa6nQhWxv55lORMdzqK1vTHUWK6uu17sI6I0.o5V.3pfZ9dDU3Wp6UxhmkcKjvGUrH1mKVd0d
 yhbL0yW1DPeOB2cM4A59P.3aG5VTHBj8ccxwK2eCU6J3BDmpODRJzC4dv_I8uLVx98UNBgxYCaFf
 vP9aLX6vkPrtm_8I0PiaNFx8Wyy.cBQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 502d9744-4a62-448b-9fe5-daad2ed73d2e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 25 Apr 2025 22:06:42 +0000
Received: by hermes--production-gq1-74d64bb7d7-45lk9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 817f7de0afdf3a62eaa48c0c7512c01b;
          Fri, 25 Apr 2025 22:06:39 +0000 (UTC)
Message-ID: <5313c22e-b69e-4e6d-b938-5780774c51eb@schaufler-ca.com>
Date: Fri, 25 Apr 2025 15:06:38 -0700
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
 <184c3ed7-5581-4bdf-99ea-083e28e530a8@schaufler-ca.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <184c3ed7-5581-4bdf-99ea-083e28e530a8@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23737 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/25/2025 10:21 AM, Casey Schaufler wrote:
> On 4/25/2025 8:14 AM, Stephen Smalley wrote:
>> On Fri, Apr 25, 2025 at 5:20 AM Christian Brauner <brauner@kernel.org> wrote:
>>> On Thu, Apr 24, 2025 at 11:28:20AM -0400, Stephen Smalley wrote:
>>>> The vfs has long had a fallback to obtain the security.* xattrs from the
>>>> LSM when the filesystem does not implement its own listxattr, but
>>>> shmem/tmpfs and kernfs later gained their own xattr handlers to support
>>>> other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
>>> This change is from 2011. So no living soul has ever cared at all for
>>> at least 14 years. Surprising that this is an issue now.
>> Prior to the coreutils change noted in [1], no one would have had
>> reason to notice. I might also be wrong about the point where it was
>> first introduced - I didn't verify via testing the old commit, just
>> looked for when tmpfs gained its own xattr handlers that didn't call
>> security_inode_listsecurity().
>>
>> [1] https://lore.kernel.org/selinux/CAEjxPJ6ocwsAAdT8cHGLQ77Z=+HOXg2KkaKNP8w9CruFj2ChoA@mail.gmail.com/T/#t
>>
>>>> filesystems like sysfs no longer return the synthetic security.* xattr
>>>> names via listxattr unless they are explicitly set by userspace or
>>>> initially set upon inode creation after policy load. coreutils has
>>>> recently switched from unconditionally invoking getxattr for security.*
>>>> for ls -Z via libselinux to only doing so if listxattr returns the xattr
>>>> name, breaking ls -Z of such inodes.
>>> So no xattrs have been set on a given inode and we lie to userspace by
>>> listing them anyway. Well ok then.
>> SELinux has always returned a result for getxattr(...,
>> "security.selinux", ...) regardless of whether one has been set by
>> userspace or fetched from backing store because it assigns a label to
>> all inodes for use in permission checks, regardless.
> Smack has the same behavior. Any strict subject+object+access scheme
> can be expected to do this.
>
>> And likewise returned "security.selinux" in listxattr() for all inodes
>> using either the vfs fallback or in the per-filesystem handlers prior
>> to the introduction of xattr handlers for tmpfs and later
>> sysfs/kernfs. SELinux labels were always a bit different than regular
>> xattrs; the original implementation didn't use xattrs but we were
>> directed to use them instead of our own MAC labeling scheme.
> There aren't a complete set of "rules" for filesystems supporting
> xattrs. As a result, LSMs have to be creative when a filesystem does
> not cooperate, or does so in a peculiar manner.
>
>
>>>> Before:
>>>> $ getfattr -m.* /run/initramfs
>>>> <no output>
>>>> $ getfattr -m.* /sys/kernel/fscaps
>>>> <no output>
>>>> $ setfattr -n user.foo /run/initramfs
>>>> $ getfattr -m.* /run/initramfs
>>>> user.foo
>>>>
>>>> After:
>>>> $ getfattr -m.* /run/initramfs
>>>> security.selinux
>>>> $ getfattr -m.* /sys/kernel/fscaps
>>>> security.selinux
>>>> $ setfattr -n user.foo /run/initramfs
>>>> $ getfattr -m.* /run/initramfs
>>>> security.selinux
>>>> user.foo
>>>>
>>>> Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
>>>> Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.smalley.work@gmail.com/
>>>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>>> ---
>>>>  fs/xattr.c | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/fs/xattr.c b/fs/xattr.c
>>>> index 02bee149ad96..2fc314b27120 100644
>>>> --- a/fs/xattr.c
>>>> +++ b/fs/xattr.c
>>>> @@ -1428,6 +1428,15 @@ static bool xattr_is_trusted(const char *name)
>>>>       return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN);
>>>>  }
>>>>
>>>> +static bool xattr_is_maclabel(const char *name)
>>>> +{
>>>> +     const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
>>>> +
>>>> +     return !strncmp(name, XATTR_SECURITY_PREFIX,
>>>> +                     XATTR_SECURITY_PREFIX_LEN) &&
>>>> +             security_ismaclabel(suffix);
>>>> +}
>>>> +
>>>>  /**
>>>>   * simple_xattr_list - list all xattr objects
>>>>   * @inode: inode from which to get the xattrs
>>>> @@ -1460,6 +1469,17 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
>>>>       if (err)
>>>>               return err;
>>>>
>>>> +     err = security_inode_listsecurity(inode, buffer, remaining_size);
>>> Is that supposed to work with multiple LSMs?
> Nope.

Oops. I'm wrong. More below ..


>>> Afaict, bpf is always active and has a hook for this.
>>> So the LSMs trample over each other filling the buffer?
> The bpf hook exists, but had better be a NOP if either SELinux
> or Smack is active. There are multiple cases where bpf, with its
> "all hooks defined" strategy can disrupt system behavior. The bpf
> LSM was known to be unsafe in this regard when it was accepted.
>
>> There are a number of residual challenges to supporting full stacking
>> of arbitrary LSMs; this is just one instance. Why one would stack
>> SELinux with Smack though I can't imagine, and that's the only
>> combination that would break (and already doesn't work, so no change
>> here).
> There's an amusing scenario where one can use Smack to separate SELinux
> containers, but it requires patches that I've been pushing slowly up the
> mountain for quite some time. The change to inode_listsecurity hooks
> won't be too bad, although I admit I've missed it so far. The change to
> security_inode_listsecurity() is going to be a bit awkward, but no more
> (or less) so than what needs done for security_secid_to_secctx().

Turns out I spoke too soon. The existing implementation of
security_inode_listsecurity() works correctly today, even in the
face of multiple LSMs (e.g. SELinux and Smack) being active. As
for security_inode_getsecurity(), there's no issue as the attribute
name desired is passed.


