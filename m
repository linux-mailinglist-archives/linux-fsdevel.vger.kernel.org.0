Return-Path: <linux-fsdevel+bounces-20259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A198D08D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D30BB28BD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0AB155C94;
	Mon, 27 May 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAZ5gP7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C061FE5;
	Mon, 27 May 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827533; cv=none; b=YvVfwsffydLU2zhVzdTd8cUPOrSA9vZ8gXQIEvjGttKUw7GanHcHjuHw6ZcU19vL3SG7bg+MiNl5/Rb+jiE+WUlpohI7ISGkXkHKBwjNG4jaF4170L7l6NoNdbPCLYDe0yiLEuWc6xbmFAYe3ZA/NbwtGVR0ijKIWu/tDqajoJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827533; c=relaxed/simple;
	bh=DNt0Dh22pTekgmdMN3R8pCvCQ6794P7yP++KToqrJ6c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=i+v5MsiRKI9dYR7aK5l2dMwEDvDzhpDYd5plShxWslHQpa8DEe3kOkDPjlRQwZ5/hxPJ2rJEzr3I5gge1Y67qasGRL3mLmEI/76XxNyEEFJu7GjLsqvQ64rxbPrLfHahVQD5Uki2FN7bQT4fd34xa7Qf0+CX78N4uEZOhAxX/s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAZ5gP7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35A0C2BBFC;
	Mon, 27 May 2024 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716827532;
	bh=DNt0Dh22pTekgmdMN3R8pCvCQ6794P7yP++KToqrJ6c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fAZ5gP7L/bpEQiNYnCKxA1zrJPwpwbz+r2vt/Uuid0n//IqCLA+IkAacwVu/pH+EL
	 54TvL7f1Hm+t93mVqp7u59XUA6NFVbeekNtOjh2ZhuepAVtTZFhChJ3GwD1ogeZzHF
	 B90lfC/mSPDnw4hJdy206TP4rl0+i2oLIMq85/G1KxhxzLyRpi5KCIUNhwFvpKOYuG
	 fhVxnO5HXwncThmL/AdIfiPqRc/gJYlQ7M8Vn7edHKuJsTTeiia2JmBFa/67PpyTWD
	 mhVzTBGkNimvk39hKaNZjO2XKROrgOzhIwT+3f10abKo2laedmIlDAwHcMCtD2ml5E
	 KtIdN/f0XfX8g==
Date: Mon, 27 May 2024 09:32:13 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
CC: Kees Cook <keescook@chromium.org>, y0un9n132@gmail.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_AUTOSEL_6=2E9_12/15=5D_binfmt=5F?=
 =?US-ASCII?Q?elf=3A_Leave_a_gap_between_=2Ebss_and_brk?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240526094152.3412316-12-sashal@kernel.org>
References: <20240526094152.3412316-1-sashal@kernel.org> <20240526094152.3412316-12-sashal@kernel.org>
Message-ID: <B4568D76-34A6-40F2-936A-000F29BC42B1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Please don't backport this change=2E While it has been tested, it's a proc=
ess memory layout change, and I'd like to be as conservative as possible ab=
out it=2E If there is fall-out, I'd prefer to keep it limited to 6=2E10+=2E=
 :)

-Kees



On May 26, 2024 2:41:44 AM PDT, Sasha Levin <sashal@kernel=2Eorg> wrote:
>From: Kees Cook <keescook@chromium=2Eorg>
>
>[ Upstream commit 2a5eb9995528441447d33838727f6ec1caf08139 ]
>
>Currently the brk starts its randomization immediately after =2Ebss,
>which means there is a chance that when the random offset is 0, linear
>overflows from =2Ebss can reach into the brk area=2E Leave at least a sin=
gle
>page gap between =2Ebss and brk (when it has not already been explicitly
>relocated into the mmap range)=2E
>
>Reported-by:  <y0un9n132@gmail=2Ecom>
>Closes: https://lore=2Ekernel=2Eorg/linux-hardening/CA+2EKTVLvc8hDZc+2Yhw=
mus=3DdzOUG5E4gV7ayCbu0MPJTZzWkw@mail=2Egmail=2Ecom/
>Link: https://lore=2Ekernel=2Eorg/r/20240217062545=2E1631668-2-keescook@c=
hromium=2Eorg
>Signed-off-by: Kees Cook <keescook@chromium=2Eorg>
>Signed-off-by: Sasha Levin <sashal@kernel=2Eorg>
>---
> fs/binfmt_elf=2Ec | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/fs/binfmt_elf=2Ec b/fs/binfmt_elf=2Ec
>index 5397b552fbeb5=2E=2E7862962f7a859 100644
>--- a/fs/binfmt_elf=2Ec
>+++ b/fs/binfmt_elf=2Ec
>@@ -1262,6 +1262,9 @@ static int load_elf_binary(struct linux_binprm *bpr=
m)
> 		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
> 		    elf_ex->e_type =3D=3D ET_DYN && !interpreter) {
> 			mm->brk =3D mm->start_brk =3D ELF_ET_DYN_BASE;
>+		} else {
>+			/* Otherwise leave a gap between =2Ebss and brk=2E */
>+			mm->brk =3D mm->start_brk =3D mm->brk + PAGE_SIZE;
> 		}
>=20
> 		mm->brk =3D mm->start_brk =3D arch_randomize_brk(mm);

--=20
Kees Cook

