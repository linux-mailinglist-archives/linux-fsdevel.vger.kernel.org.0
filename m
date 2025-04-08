Return-Path: <linux-fsdevel+bounces-45935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07737A7F807
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75ADA7A2BA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 08:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E3263F3E;
	Tue,  8 Apr 2025 08:37:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE720B7EC;
	Tue,  8 Apr 2025 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101434; cv=none; b=cnuAZaY9KC7rJ3aUrftQ16Ajbn/uRR2R6x4Hm5G0VG1gbPw+Xyt36v1ZHgdpxS45O5aCjT5kG7/qIymsIJSxPpzz42oOnNIOfVDpeFSjHp4Khk+EYn1bZkfCGcconBc9brFLiZ18CNMazBbgK+oubLbgTWyg9efKVKqTt1NNiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101434; c=relaxed/simple;
	bh=K9C0JphMEsB+BGyp/ZiBIvH6E0mI+CzVtAzpoaBH0Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSEgAw+dRTpgKrGy7RLZMJt2ghxTovBWq+5w945YpUi/+lNZwTdkvSM2RFp7nk/iSeErzO2UcolT2DFaVpencARzRzy20J7B9IDu7fjfsgutI86KwvjxgGGbc5BxhuAiEeJMgf05srCBy3qOE3nzETXkpz2YmNl8uV1017lDvSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34BE243291;
	Tue,  8 Apr 2025 08:36:53 +0000 (UTC)
Message-ID: <d5684f27-9676-4393-833a-390ccc244b73@ghiti.fr>
Date: Tue, 8 Apr 2025 10:36:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 26/28] riscv: Documentation for landing pad / indirect
 branch tracking
Content-Language: en-US
To: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-26-e51202b53138@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250314-v5_user_cfi_series-v12-26-e51202b53138@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddviedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeegledprhgtphhtthhopeguvggsuhhgsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsp
 hesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: alex@ghiti.fr


On 14/03/2025 22:39, Deepak Gupta wrote:
> Adding documentation on landing pad aka indirect branch tracking on riscv
> and kernel interfaces exposed so that user tasks can enable it.
>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   Documentation/arch/riscv/index.rst   |   1 +
>   Documentation/arch/riscv/zicfilp.rst | 115 +++++++++++++++++++++++++++++++++++
>   2 files changed, 116 insertions(+)
>
> diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
> index eecf347ce849..be7237b69682 100644
> --- a/Documentation/arch/riscv/index.rst
> +++ b/Documentation/arch/riscv/index.rst
> @@ -14,6 +14,7 @@ RISC-V architecture
>       uabi
>       vector
>       cmodx
> +    zicfilp
>   
>       features
>   
> diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/riscv/zicfilp.rst
> new file mode 100644
> index 000000000000..a188d78fcde6
> --- /dev/null
> +++ b/Documentation/arch/riscv/zicfilp.rst
> @@ -0,0 +1,115 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Author: Deepak Gupta <debug@rivosinc.com>
> +:Date:   12 January 2024
> +
> +====================================================
> +Tracking indirect control transfers on RISC-V Linux
> +====================================================
> +
> +This document briefly describes the interface provided to userspace by Linux
> +to enable indirect branch tracking for user mode applications on RISV-V


s/RISV-V/RISC-V and add a dot at the end of the line.


> +
> +1. Feature Overview
> +--------------------
> +
> +Memory corruption issues usually result in to crashes, however when in hands of


s/in to/into?


> +an adversary and if used creatively can result into variety security issues.


"into a variety of security issues" ?


> +
> +One of those security issues can be code re-use attacks on program where adversary
> +can use corrupt function pointers and chain them together to perform jump oriented
> +programming (JOP) or call oriented programming (COP) and thus compromising control
> +flow integrity (CFI) of the program.
> +
> +Function pointers live in read-write memory and thus are susceptible to corruption
> +and allows an adversary to reach any program counter (PC) in address space. On
> +RISC-V zicfilp extension enforces a restriction on such indirect control
> +transfers:
> +
> +- indirect control transfers must land on a landing pad instruction ``lpad``.
> +  There are two exception to this rule:
> +
> +  - rs1 = x1 or rs1 = x5, i.e. a return from a function and returns are
> +    protected using shadow stack (see zicfiss.rst)
> +
> +  - rs1 = x7. On RISC-V compiler usually does below to reach function
> +    which is beyond the offset possible J-type instruction::
> +
> +      auipc x7, <imm>
> +      jalr (x7)
> +
> +	Such form of indirect control transfer are still immutable and don't rely
> +    on memory and thus rs1=x7 is exempted from tracking and considered software
> +    guarded jumps.
> +
> +``lpad`` instruction is pseudo of ``auipc rd, <imm_20bit>`` with ``rd=x0`` and
> +is a HINT nop. ``lpad`` instruction must be aligned on 4 byte boundary and
> +compares 20 bit immediate withx7. If ``imm_20bit`` == 0, CPU don't perform any


s/withx7/with x7

s/don't/doesn't


> +comparision with ``x7``. If ``imm_20bit`` != 0, then ``imm_20bit`` must match
> +``x7`` else CPU will raise ``software check exception`` (``cause=18``) with
> +``*tval = 2``.
> +
> +Compiler can generate a hash over function signatures and setup them (truncated
> +to 20bit) in x7 at callsites and function prologues can have ``lpad`` with same
> +function hash. This further reduces number of program counters a call site can
> +reach.
> +
> +2. ELF and psABI
> +-----------------
> +
> +Toolchain sets up :c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_FCFI` for property
> +:c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
> +
> +3. Linux enabling
> +------------------
> +
> +User space programs can have multiple shared objects loaded in its address space
> +and it's a difficult task to make sure all the dependencies have been compiled
> +with support of indirect branch. Thus it's left to dynamic loader to enable
> +indirect branch tracking for the program.
> +
> +4. prctl() enabling
> +--------------------
> +
> +:c:macro:`PR_SET_INDIR_BR_LP_STATUS` / :c:macro:`PR_GET_INDIR_BR_LP_STATUS` /
> +:c:macro:`PR_LOCK_INDIR_BR_LP_STATUS` are three prctls added to manage indirect
> +branch tracking. prctls are arch agnostic and returns -EINVAL on other arches.
> +
> +* prctl(PR_SET_INDIR_BR_LP_STATUS, unsigned long arg)
> +
> +If arg1 is :c:macro:`PR_INDIR_BR_LP_ENABLE` and if CPU supports ``zicfilp``
> +then kernel will enabled indirect branch tracking for the task. Dynamic loader


s/will enabled/will enable


> +can issue this :c:macro:`prctl` once it has determined that all the objects
> +loaded in address space support indirect branch tracking. Additionally if there
> +is a `dlopen` to an object which wasn't compiled with ``zicfilp``, dynamic
> +loader can issue this prctl with arg1 set to 0 (i.e.
> +:c:macro:`PR_INDIR_BR_LP_ENABLE` being clear)
> +
> +* prctl(PR_GET_INDIR_BR_LP_STATUS, unsigned long arg)
> +
> +Returns current status of indirect branch tracking. If enabled it'll return
> +:c:macro:`PR_INDIR_BR_LP_ENABLE`
> +
> +* prctl(PR_LOCK_INDIR_BR_LP_STATUS, unsigned long arg)
> +
> +Locks current status of indirect branch tracking on the task. User space may
> +want to run with strict security posture and wouldn't want loading of objects
> +without ``zicfilp`` support in it and thus would want to disallow disabling of
> +indirect branch tracking. In that case user space can use this prctl to lock
> +current settings.
> +
> +5. violations related to indirect branch tracking
> +--------------------------------------------------
> +
> +Pertaining to indirect branch tracking, CPU raises software check exception in
> +following conditions:
> +
> +- missing ``lpad`` after indirect call / jmp
> +- ``lpad`` not on 4 byte boundary
> +- ``imm_20bit`` embedded in ``lpad`` instruction doesn't match with ``x7``
> +
> +In all 3 cases, ``*tval = 2`` is captured and software check exception is
> +raised (``cause=18``)
> +
> +Linux kernel will treat this as :c:macro:`SIGSEV`` with code =
> +:c:macro:`SEGV_CPERR` and follow normal course of signal delivery.
>

