Return-Path: <linux-fsdevel+bounces-46123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66114A82D8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 19:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E517A73D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618C276049;
	Wed,  9 Apr 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYC6KdqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56926E143;
	Wed,  9 Apr 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219619; cv=none; b=PdYmtuvVHt9Xkb3jXguOa3da51jZFDXrPU3SwoJSgPtFke9p/VtP9jOBYBgV/eGz2565+92rKPKlbREdrZCVA6DZz1Oegr57rZaYh/4fTIH0y4btT54s61GFSxA5pQaesuCqaP4fwVC/SshW2tDhvbSByZvpDNOPWN4LLH43I6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219619; c=relaxed/simple;
	bh=4cE3ikxzQkLEyV7rkhTFdWv+Qyfv6keFT8/eBBjAhZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/F97R6nUrjaCLQImHXu2Dl/gFu/vviSDTtyemPf4xHlYgpGfaM1QaDjT4DFmPzISAvN384DrdUpee5YZ3FjTBCfhGsIoxODdV2aW1BOCG99/FFDZq+rk5TOhesHgX3sCy6SYZVPTxCz8eDqCL77WTOeGNlT1YymhzGVSZ4u9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYC6KdqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21365C4CEE2;
	Wed,  9 Apr 2025 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744219619;
	bh=4cE3ikxzQkLEyV7rkhTFdWv+Qyfv6keFT8/eBBjAhZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYC6KdqJt4RFGGFPtu/ik51HXgvpTIVHF34pbK/3XtcwcHmcs5YSmjrJouHQGQrc+
	 MmsK5WUVNAwXkS7mYUYMhHjZaRlEQEgIcVcYdek5BaeB++qKPFAx9MupiOY/x04NZg
	 6gioCrKWH5/rUgo4FSEshEFNl8njFmqwB2BQswAgHYWZhzr4rRq8n/ttEmvSB3qXsm
	 MbrUCqGdQ3IrPO+qcqouLbeY2jdgu2JJCVxrDDNs3a+Og7qmDpWXh15uxxf52T3GMx
	 awp0Ask9g31o7fusZTOuk9lKstDC81qBY4hqvtzpEy9os3n1QKl4SojY743RitVeig
	 xx3LTZWv9DJEQ==
Date: Wed, 9 Apr 2025 10:26:56 -0700
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, John Sperbeck <jsperbeck@google.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/4] sysctl: move u8 register test to lib/test_sysctl.c
Message-ID: <202504091020.3A06E6C548@keescook>
References: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
 <20250321-jag-test_extra_val-v1-1-a01b3b17dc66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-jag-test_extra_val-v1-1-a01b3b17dc66@kernel.org>

On Fri, Mar 21, 2025 at 01:47:24PM +0100, Joel Granados wrote:
> If the test added in commit b5ffbd139688 ("sysctl: move the extra1/2
> boundary check of u8 to sysctl_check_table_array") is run as a module, a
> lingering reference to the module is left behind, and a 'sysctl -a'
> leads to a panic.
> 
> To reproduce
>     CONFIG_KUNIT=y
>     CONFIG_SYSCTL_KUNIT_TEST=m
> 
> Then run these commands:
>     modprobe sysctl-test
>     rmmod sysctl-test
>     sysctl -a
> 
> The panic varies but generally looks something like this:
> 
>     BUG: unable to handle page fault for address: ffffa4571c0c7db4
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 100000067 P4D 100000067 PUD 100351067 PMD 114f5e067 PTE 0
>     Oops: Oops: 0000 [#1] SMP NOPTI
>     ... ... ...
>     RIP: 0010:proc_sys_readdir+0x166/0x2c0
>     ... ... ...
>     Call Trace:
>      <TASK>
>      iterate_dir+0x6e/0x140
>      __se_sys_getdents+0x6e/0x100
>      do_syscall_64+0x70/0x150
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Move the test to lib/test_sysctl.c where the registration reference is
> handled on module exit
> 
> 'Fixes: b5ffbd139688 ("sysctl: move the extra1/2 boundary check of u8 to

Typoe: drop leading '

> sysctl_check_table_array")'

And avoid wrapping this line for the field.

> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Otherwise looks good to me.

Reviewed-by: Kees Cook <kees@kernel.org>

(And I should  note that there is a push to move kunit tests into a
"/tests/" subdir, but that's separate from this series.)

-- 
Kees Cook

