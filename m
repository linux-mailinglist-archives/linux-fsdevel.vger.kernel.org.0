Return-Path: <linux-fsdevel+bounces-57162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F31B1F078
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 23:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DDA5A441D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC6728A1D3;
	Fri,  8 Aug 2025 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVVTUjxC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82854289E39;
	Fri,  8 Aug 2025 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754690072; cv=none; b=eJBPElJjjbtpbNJvoUpW8ZXiMpwrqjSCIHhQsipgkyBYXfxNhwmUL8RMK5LBC6b7v4uGjwtSaehyId8OjW0yJd63K/l7fObODFJxqO3l5yVJtClJgaizQU7TdvQkgzDx/K1Ze7hXjAeKYpKBJi2deryjzr1VdWN1YiHsoIi145U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754690072; c=relaxed/simple;
	bh=Sk0RhaleF2RIU09BBqLOrUl5UPl07KM3dUhbhqtgkag=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nQyuf1/FpUNJ7A1WqIeIWUDFUax4TqxRUeqA87Jo0bRn15Km76xUzqFJEqjBwzW30MYr3gDiXP4Q09GusR9QYAruIXKP6Xd/VDQH3MLWVErDmJBrzwEk3IlZb/xkrTbndA5Zu46Zg9stCOEpxFs+WIU3gdxO78/y0W9zdBJiZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVVTUjxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000A4C4CEED;
	Fri,  8 Aug 2025 21:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754690072;
	bh=Sk0RhaleF2RIU09BBqLOrUl5UPl07KM3dUhbhqtgkag=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FVVTUjxCNz77vH66MSZoU+W7PXOPNb+1m/0XKTr2fwBbmvDyORIHe0M3rrJaUFFEe
	 7Usf7CjO0FS1cPleSpveZNoNbMjtbo+e+pPL413HRY8q7yt2zceJF2K+VmzkURiN4B
	 JIf2PtnjPkq0DWX6672gNEpvi6+HwrdTr4pFa+2LkPs8p9VI6z3lA0MFtNztWoA/aj
	 d3gZtjUJqKIWtmJOCzL6S9TGMc/LgzzvjFvqBN70pYe58h/EsYOOAVJeoMRnje0xHZ
	 t5sNDtTe/pVozca+LgqopzDPVyu5zaleFqDZG7vigEj3okac4+Fiai+1253xcD8OUN
	 svLXA+KH8rm0Q==
Date: Fri, 08 Aug 2025 14:54:32 -0700
From: Kees Cook <kees@kernel.org>
To: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
CC: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_RESEND=5D_binfmt=5Felf=3A_preserv?=
 =?US-ASCII?Q?e_original_ELF_e=5Fflags_in_core_dumps?=
User-Agent: K-9 Mail for Android
In-Reply-To: <2c196c3f-4d49-494c-898e-8a1f6249ce24@syntacore.com>
References: <20250806161814.607668-1-svetlana.parfenova@syntacore.com> <202508061152.6B26BDC6FB@keescook> <e9990237-bc83-4cbb-bab8-013b939a61fb@syntacore.com> <202508071414.5A5AB6B2@keescook> <2c196c3f-4d49-494c-898e-8a1f6249ce24@syntacore.com>
Message-ID: <86553D38-36C1-4EBB-9732-A2C593A76260@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 8, 2025 8:54:30 AM PDT, Svetlana Parfenova <svetlana=2Eparfenova=
@syntacore=2Ecom> wrote:
>On 08/08/2025 03=2E14, Kees Cook wrote:
>> On Thu, Aug 07, 2025 at 07:13:50PM +0600, Svetlana Parfenova wrote:
>>> On 07/08/2025 00=2E57, Kees Cook wrote:
>>>> On Wed, Aug 06, 2025 at 10:18:14PM +0600, Svetlana Parfenova
>>>> wrote:
>>>>> Preserve the original ELF e_flags from the executable in the
>>>>> core dump header instead of relying on compile-time defaults
>>>>> (ELF_CORE_EFLAGS or value from the regset view)=2E This ensures
>>>>> that ABI-specific flags in the dump file match the actual
>>>>> binary being executed=2E
>>>>>=20
>>>>> Save the e_flags field during ELF binary loading (in
>>>>> load_elf_binary()) into the mm_struct, and later retrieve it
>>>>> during core dump generation (in fill_note_info())=2E Use this
>>>>> saved value to populate the e_flags in the core dump ELF
>>>>> header=2E
>>>>>=20
>>>>> Add a new Kconfig option, CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS,
>>>>> to guard this behavior=2E Although motivated by a RISC-V use
>>>>> case, the mechanism is generic and can be applied to all
>>>>> architectures=2E
>>>>=20
>>>> In the general case, is e_flags mismatched? i=2Ee=2E why hide this
>>>> behind a Kconfig? Put another way, if I enabled this Kconfig and
>>>> dumped core from some regular x86_64 process, will e_flags be
>>>> different?
>>>>=20
>>>=20
>>> The Kconfig option is currently restricted to the RISC-V
>>> architecture because it's not clear to me whether other
>>> architectures need actual e_flags value from ELF header=2E If this
>>> option is disabled, the core dump will always use a compile time
>>> value for e_flags, regardless of which method is selected:
>>> ELF_CORE_EFLAGS or CORE_DUMP_USE_REGSET=2E And this constant does not =
necessarily reflect the actual e_flags of the running process
>>> (at least on RISC-V), which can vary depending on how the binary
>>> was compiled=2E Thus, I made a third method to obtain e_flags that
>>> reflects the real value=2E And it is gated behind a Kconfig option,
>>> as not all users may need it=2E
>>=20
>> Can you check if the ELF e_flags and the hard-coded e_flags actually di=
ffer on other architectures? I'd rather avoid using the Kconfig so
>> we can have a common execution path for all architectures=2E
>>=20
>
>I checked various architectures, and most don=E2=80=99t use e_flags in co=
re
>dumps - just zero value=2E For x86 this is valid since it doesn=E2=80=99t=
 define
>values for e_flags=2E However, architectures like ARM do have meaningful
>e_flags, yet still they are set to zero in core dumps=2E I guess the real
>question isn't about core dump correctness, but whether tools like GDB
>actually rely on e_flags to provide debug information=2E Seems like most
>architectures either don=E2=80=99t use it or can operate without it=2E RI=
SC-V
>looks like black sheep here =2E=2E=2E GDB relies on e_flags to determine =
the
>ABI and interpret the core dump correctly=2E
>
>What if I rework my patch the following way:
>- remove Kconfig option;
>- add function/macro that would override e_flags with value taken from
>process, but it would only be applied if architecture specifies that=2E
>
>Would that be a better approach?

Yeah! Let's see what that looks like=2E :)


--=20
Kees Cook

