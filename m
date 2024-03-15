Return-Path: <linux-fsdevel+bounces-14523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18687D381
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 19:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DEFB23419
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E1F4F211;
	Fri, 15 Mar 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dG3NQMde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3E4E1CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526943; cv=none; b=leewP+X0K6i0+QQTAvvWlInFAw5/kkoaD7PrJBxW5tf1yb9d5xuBygeVbtLmwu0Ha4eoBESG0vgLGFNL0bUKnaetlrPP9E+7gihAxXrgxF00Sm7eGLpRYzhgwYvNlyA4aPx6cik7YFvq9rV2MCPq0hqky4GkzF9kBSymvts3QtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526943; c=relaxed/simple;
	bh=KulROZfKAzwLrswj4Z6VQWYRAG7n2mLv/ruBxZuOPk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUk5nJ70kbvIE0vFCuygRYm567rN96EMb3O6wTmtOaIffFsSh2pUThqX1mxg3HU6H3Q3oS26hKXb0xbkYxUd/qNqJIg/edaR8Ps7k/1foBQ+3erMIDWNiibniJo0IDaklA3qkt5U3UADrNaE+NQl6Rc8TmOglXWrlvyv2sq8acw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dG3NQMde; arc=none smtp.client-ip=66.163.191.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710526932; bh=IcLWcAwh7sO6qGb3KzfOR+SqxYFTY+EU4o/Haleqnr8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dG3NQMdedq/3xZ0AmufPK7uJPf8qknlRFSRtpbPufTzpxl6L5XVXZUCw/ljUnDmtK1uAU7ZCk/DPZdlLAB2VSrw+ccpFuGBupK9Do6K2ecWOX1HjHu/S0MkZlCVlYXoHDTswO/uGKiF3F8NwnKU2hFr0gUWzrRt/SDveRlcDfdUDQbUIoXD7PC8ScXGMQe0WPd90ZexHPw97SjUOGUYCna1N4/nbt6LryLzwQuv/T+LQPPs2ilbkKl83PWUhRW32A9135SjZZ3GiHlQ27aJq74uRsT0AcUfLHAW/EZpvPV8KRCe+5N39UhQi6lSBqUJBiZEoHPdBl6SG3lyo8rqDFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710526932; bh=dDwZDOhUfANnYv5RBF+A42YU0fEwj7j7747ZXF9h2pP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IGt+HWB647vioG+O1iXUnbWwocLWHfBhJjiLIi0lPwS2uD1fDnqaB0nPmCc4UNGKhDOOjvtky4Re6obGWfHQ6LpqcQPdJoL0vnnqi/j4NCzwkuzJ3ij2JdTIf2JaBiVHRxuUKzWAVf8hvw7BtIaLytvk+b47s2MsElkCc+Wza/UHlavoH+z2rWVr+AjbMi0A+/b/aI5BKmMsKhKMBwaCIMLQMets6QLF5JKWYUZFp8EA9Djx22ynzN/LVl8AZLcyzSWiUyCQQd/Gv4QEPWgqXzhs2MK2Dr5JE41xMJnOj14zKekP2bLl9djl43JDDVGN0w+5rR2aR75uMH4ID8PEOA==
X-YMail-OSG: 2ozgzP0VM1kchnzeWVCectdYHBQ6XkZUD0js43FPQ..LwyHz1xnZzLLk8DiLue.
 thkTfVnoT432L4NRN.F1m3GmmpWd_3T9p6nogtMKRStFaEsIwq3RBuw3qbDZxcRDrvdsvyO.X7.H
 gZ7vdX1hbrNEkTUYeusBZzb.9kHSQ9IFQzfii78KOw6RtFjgSiGXBAeO2xCTxXDuCr2X2GRSoP1r
 kvJ7QLDk537c_dGyBuDJQjA0dxh9lUc_4G1okKY_0uVBrVwogDdPhNIo5o0pxIEWb.94Qiyx4Dv2
 fibJyEoDEXA7hXi04Z4AtVLFqhKtiVan1ax7jR5JIynR9fi472mjX7eeap0_YaYXERIZIKsTHme3
 9xl9p4mRShF7A2oGuemgaKmYEbTCCYSaCm89BZXDq.Jt6Jyas0DYDi4cqqJmKRt9T1ZfSmlge8Cl
 Tu9I0OKnwzlalqpXH0tWTH3z3tnTXlwd_imCxUwqnPnUjrTtXiwCjjYgMz3KeiDQFyUyJgAMmEfH
 y3dcJLeLNdX1UPMkCpEY1fp5ICGgiiTVbbF4u4d6j1lYgd7FFcbVUE2plb1ZzA63TZNPl7A4U9MC
 cIaA8gvF5MNMPAunYsz7rXjTDMa8coVufpTy8jf4.3AU98kKQAjsVSRNfx0F3D7A4c1gxZVVPcmO
 qZ7.kgwvx1UFEbDOh3QBrtd6NnG7xVRvxg6ux7.9s5dyL.tc6336DCUM66HcSSf70FVnQOoy9W5D
 WaNZbJwUjl_hVWf6sESXa41VSlLPsVfJw4wUcubNz2kXHnmGf4ZlrkBgIjcusL5YtW.V3kQMLaCl
 LSKuJf8_TT_SIei_LuoMqtDaagJt7pk5w3E_3Qr1Drt6FG0a_8SLxPai7r29eTZIEhjrinIIUWFD
 GKc.NOvY7fUmWIieKs6Cuh5GRt4YPhiXD5VAb.UlRVh8UPE9B99rOKhx3tpQFT35evXN8RVR5DHC
 ZrJlGDyqUwmgscb312ftoJiWo37ti6HjdRXz1kbmT99y3Toan1eLoCcZfHPYSyxv3UBqWVHrgACK
 VzuDT_jrYhuA7P.kot2CtQay9yPyfYWVfwk_wIE3adcL0.upaRGIctCvc5AanZ3SbLf07aWNdxQL
 eLTHf3C8BaRompNlmtXsV30tyL6jl.rDWKy55kdC_RJUfQzzIJUzm_e5r2gJW2LCHI3AoLa61b9L
 CVjGsYYEt1BdY4OAK33LZAEcIZIrp340Q4iTrBmwwg8yVKIrNOXppy36sXzesJNXjHRffkIiIjYU
 of4SAcsMPRrBG49qVMdniC0m6idyhpNMIM5A3L2pf0d2DZvqf6SG8Euu3ODur9za5FHWZK21yutI
 TStKm8klw326vc3eJ0RSHA5e5HBLdtcOccw2SahPr14cUT6m2l4SNeHdKASk6fvna4YXluYko7Q0
 B3GEwQcv1_5LtyPaU8NbBtKJPX68r1vvSXwWxIr7vbvRNo95xp5DHdyvr.twHpeKAD.YqCJak46Z
 AoCK0n4hOYdr1VMOoFN1ADftffImrxMgFcLrqr1ZzW_OKXUsXzwxyYXAfIoMzYMOzGk9mMaa0HwD
 3Ud0lRMC5UEFwqQpmHX4gpU5TY1CocaBXsBBPpAM.pQAL4mcBs0hKSB8RuzEqZfjFaRm7mdPPceM
 s0A4yE9H4XEOvKvqphogE4yOmwrDyBsvpanoTYY3Bc0M2wcvdz6ew54snq0ADbgDWLffRu2uqo6u
 j.YzE5NPYkhXeh4AfX2qFbllYynoVnpJjKmmED6hXzXBqThzGnrJAudvfwbJlw3mevfFteljqEWO
 lN_vOLb8ix0W09O.8U2BaK9CtYusPpaicylAsfDjUG.7QCs.nkkIn3ufQWl6K_6UTOU8AnuMIjJ3
 t_CBaeXoXzWI6iukuXDKFVQE0XpicvscSljrfr4ShesEZUzVCR8_eWylhhxK1s6oTwgwnEpWPyc2
 SkIHXqgfeHCDq_D8.gHyCtOKJhEWSALB5P071L0Hs3WOC6BVgshtn7ha1KmuLg19xcHyxeinsU0Q
 TqnoJhj2mpukYeLlYV.FurVfDpTbOLbiPacNP5qIPbK2zgL0yjwHPC0jfjJrOjPjZFBJZDBLaZfG
 OQDI8HS9ee4.Axx58TLFCYHe8n.J7FxVuDvFe6TlbIZN0W555yr9HFIIcgohjoCdmDIiipsudBFO
 XpjqbqGdZ29s3KwYnDIpdVCmnqQCx1Px5wYRgvI_m_TX54ZZM0kS8c96C1SQ6KryJTRdYSktx0ie
 lB9kVIOhm74GOhHe200fi5y5yZHewDEfhbFq_QaSTnyW7nKZe95..SqpkT86MQg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e650a4e6-a765-40e7-b88d-02be5f049f41
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Mar 2024 18:22:12 +0000
Received: by hermes--production-gq1-5c57879fdf-p26ct (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce6ad3d26e81771d69316a3d04363fb1;
          Fri, 15 Mar 2024 18:22:06 +0000 (UTC)
Message-ID: <f6d1b9fc-dfb1-4fd8-bfa0-bd1349c4a1c1@schaufler-ca.com>
Date: Fri, 15 Mar 2024 11:22:05 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] lsm: introduce new hook security_vm_execstack
Content-Language: en-US
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-security-module@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, Alfred Piccioni
 <alpic@google.com>, John Johansen <john.johansen@canonical.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240315181032.645161-1-cgzones@googlemail.com>
 <20240315181032.645161-2-cgzones@googlemail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240315181032.645161-2-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/15/2024 11:08 AM, Christian Göttsche wrote:
> Add a new hook guarding instantiations of programs with executable
> stack.  They are being warned about since commit 47a2ebb7f505 ("execve:
> warn if process starts with executable stack").  Lets give LSMs the
> ability to control their presence on a per application basis.

This seems like a hideously expensive way to implement a flag
disallowing execution of programs with executable stacks. What's
wrong with adding a flag VM_NO_EXECUTABLE_STACK?

>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  fs/exec.c                     |  4 ++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 13 +++++++++++++
>  4 files changed, 24 insertions(+)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 8cdd5b2dd09c..e6f9e980c6b1 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -829,6 +829,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
>  	BUG_ON(prev != vma);
>  
>  	if (unlikely(vm_flags & VM_EXEC)) {
> +		ret = security_vm_execstack();
> +		if (ret)
> +			goto out_unlock;
> +
>  		pr_warn_once("process '%pD4' started with executable stack\n",
>  			     bprm->file);
>  	}
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 185924c56378..b31d0744e7e7 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -49,6 +49,7 @@ LSM_HOOK(int, 0, syslog, int type)
>  LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
>  	 const struct timezone *tz)
>  LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
> +LSM_HOOK(int, 0, vm_execstack, void)
>  LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
>  LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
>  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d0eb20f90b26..084b96814970 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -294,6 +294,7 @@ int security_quota_on(struct dentry *dentry);
>  int security_syslog(int type);
>  int security_settime64(const struct timespec64 *ts, const struct timezone *tz);
>  int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
> +int security_vm_execstack(void);
>  int security_bprm_creds_for_exec(struct linux_binprm *bprm);
>  int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file);
>  int security_bprm_check(struct linux_binprm *bprm);
> @@ -624,6 +625,11 @@ static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  	return __vm_enough_memory(mm, pages, cap_vm_enough_memory(mm, pages));
>  }
>  
> +static inline int security_vm_execstack(void)
> +{
> +	return 0;
> +}
> +
>  static inline int security_bprm_creds_for_exec(struct linux_binprm *bprm)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 0144a98d3712..f75240d0d99d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1125,6 +1125,19 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  	return __vm_enough_memory(mm, pages, cap_sys_admin);
>  }
>  
> +/**
> + * security_vm_execstack() - Check if starting a program with executable stack
> + * is allowed
> + *
> + * Check whether starting a program with an executable stack is allowed.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_vm_execstack(void)
> +{
> +	return call_int_hook(vm_execstack);
> +}
> +
>  /**
>   * security_bprm_creds_for_exec() - Prepare the credentials for exec()
>   * @bprm: binary program information

