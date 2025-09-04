Return-Path: <linux-fsdevel+bounces-60240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A8B430AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 05:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1ED17EE1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 03:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493E42264A1;
	Thu,  4 Sep 2025 03:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4SggvOd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4600F9CB;
	Thu,  4 Sep 2025 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756957964; cv=none; b=n5NUioE1NICm559bIycGCYy3dt72b/2VeaBXe0lSQuRHio7s5w0KY/qhFMQA3yHbo4NtpOEdFUzT37niwsez9Q5Ba+Q6NfLFMG7OfmAS5IHz2rTKDxnE87q2V+dqs0cKS9U98/K+Sziyo/yo+Re84ryylA383wIWTqQ/MoNsY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756957964; c=relaxed/simple;
	bh=dW3DY0tGbJhPve03HuDNPrD6QxC9sjo3oWoZbh4z3oI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dK/A+20NHJ/cJHlnqW96+kRo3IjJzpcVDDSmb9L62kuVPdmmjIBVmK9wrZk6dV8lKhD9Z76s25ppv/Qf5RrzyY+9f1OdnfwHR47TE9MhxSnPPVug+s6neRucni3CSFvcVAlMMfFNynNOiRCPAR2rZF/3fJgv7I1YIJScsdf4G2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4SggvOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7225AC4CEF0;
	Thu,  4 Sep 2025 03:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756957964;
	bh=dW3DY0tGbJhPve03HuDNPrD6QxC9sjo3oWoZbh4z3oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4SggvOd4BbUbbGwaWFPdPRseaOkhRGGpexIV08g70d9iEWifpyMcHKg1LDKhagxb
	 X73aX3cyNra2YQJQYXiUrPpRXEjmEImKKuMFsLhD62OU6yN1wmci+wvDeF3PkMUota
	 NnzUIVAAyJ5GmDDpNPiAQvA2UKguSTveJwuqMti483XoZH4JtePjPcbk0fG8QozNWM
	 rfYDgshAh+BKzbWevQChmBmw8nuwjdklhR0lGWT53q7FGw3IjDG/pKVPiIzKATwmxI
	 WtyuT5A0cPe2iwRRD+02ucfirVq48nuR2WihTkaDccXlV3ixklm/IyUa94iEQo6mur
	 NMLqBhZPXxLMA==
From: Kees Cook <kees@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Svetlana Parfenova <svetlana.parfenova@syntacore.com>
Cc: Kees Cook <kees@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.f,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com
Subject: Re: [RFC RESEND v3] binfmt_elf: preserve original ELF e_flags for core dumps
Date: Wed,  3 Sep 2025 20:52:40 -0700
Message-Id: <175695795639.3712216.15743949549231818751.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901135350.619485-1-svetlana.parfenova@syntacore.com>
References: <20250806161814.607668-1-svetlana.parfenova@syntacore.com> <20250901135350.619485-1-svetlana.parfenova@syntacore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 01 Sep 2025 20:53:50 +0700, Svetlana Parfenova wrote:
> Some architectures, such as RISC-V, use the ELF e_flags field to encode
> ABI-specific information (e.g., ISA extensions, fpu support). Debuggers
> like GDB rely on these flags in core dumps to correctly interpret
> optional register sets. If the flags are missing or incorrect, GDB may
> warn and ignore valid data, for example:
> 
>     warning: Unexpected size of section '.reg2/213' in core file.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] binfmt_elf: preserve original ELF e_flags for core dumps
      https://git.kernel.org/kees/c/8c94db0ae97c

Take care,

-- 
Kees Cook


