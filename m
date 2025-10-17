Return-Path: <linux-fsdevel+bounces-64470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF2ABE8330
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E4A6E3D6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B73831DD9A;
	Fri, 17 Oct 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="tn4aYz9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3031BC94;
	Fri, 17 Oct 2025 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698317; cv=none; b=gs/i601HRGFAHvYzAfWbBc9F6IIoSESkkhkHtnEPxnD9YKkphKsrWXAbn6yx2SpPymwCPQKJaIRleVC8ztYaRORHeXJPv8PJV9N29CyNZh5Cdb36Cty2ec4NiahQSzSUxdyBM97J31XKBIAgdDAiHSwqNrveQ9wC3X1LWcSaN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698317; c=relaxed/simple;
	bh=fMPKXdNY2FwPTY1ab30JP2n3709l1BR0etSRjYvT2no=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DNUetc42BeZyqwHbAO/O48DibHW0fbZe9HkOEcndTXFMCnUsqzoxlNqxCCeTDGid5mvj0NFwW1KBpMtvtyesDSqcklK/8I9Q1a7L7BflaFCE+x+9py/6LDr00VE+d3YgPBBqYJL2JY2yAaTSAPqbZoQrv52b/yEGnYr6KS/6cVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=tn4aYz9l; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XK6rShI1laVwxqZnNYg1sUJOrdVDcwamBttA7hfuCSM=;
  b=tn4aYz9lmkDrc4N/iK2W/dM81CNjYMahGWFcq4rSfyrAOMJ30S0qvU5x
   DDrS1DB49dy9J+mDsmpdTC6EmQpk42hAVCNU91tBng/7RP3/kJKfUQYys
   dvZSuay+w3oYltOCgaKnt47F1KY4PVI6Z3oE5kX432CUOCAhWVjp27mxF
   g=;
X-CSE-ConnectionGUID: TVVds0QUR5GM1FOFhwN2PA==
X-CSE-MsgGUID: 9dq6U7JzTjaJHe2aNq8FFA==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,236,1754949600"; 
   d="scan'208";a="128490637"
Received: from bb116-15-226-202.singnet.com.sg (HELO hadrien) ([116.15.226.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 12:51:38 +0200
Date: Fri, 17 Oct 2025 18:51:31 +0800 (+08)
From: Julia Lawall <julia.lawall@inria.fr>
To: Thomas Gleixner <tglx@linutronix.de>
cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, kernel test robot <lkp@intel.com>, 
    Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
    Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
    Heiko Carstens <hca@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Andrew Cooper <andrew.cooper3@citrix.com>, 
    Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
    Davidlohr Bueso <dave@stgolabs.net>, 
    =?ISO-8859-15?Q?Andr=E9_Almeida?= <andrealmeid@igalia.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [patch V3 09/12] [RFC] coccinelle: misc: Add scoped_masked_$MODE_access()
 checker script
In-Reply-To: <20251017093030.378863263@linutronix.de>
Message-ID: <46ea566b-6c42-a73-31da-ba15ed82aaf@inria.fr>
References: <20251017085938.150569636@linutronix.de> <20251017093030.378863263@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 17 Oct 2025, Thomas Gleixner wrote:

> A common mistake in user access code is that the wrong access mode is
> selected for starting the user access section. As most architectures map
> Read and Write modes to ReadWrite this goes often unnoticed for quite some
> time.
>
> Aside of that the scoped user access mechanism requires that the same
> pointer is used for the actual accessor macros that was handed in to start
> the scope because the pointer can be modified by the scope begin mechanism
> if the architecture supports masking.
>
> Add a basic (and incomplete) coccinelle script to check for the common
> issues. The error output is:
>
> kernel/futex/futex.h:303:2-17: ERROR: Invalid pointer for unsafe_put_user(p) in scoped_masked_user_write_access(to)
> kernel/futex/futex.h:292:2-17: ERROR: Invalid access mode unsafe_get_user() in scoped_masked_user_write_access()
>
> Not-Yet-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> ---
>  scripts/coccinelle/misc/scoped_uaccess.cocci |  108 +++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>
> --- /dev/null
> +++ b/scripts/coccinelle/misc/scoped_uaccess.cocci
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Validate scoped_masked_user*access() scopes
> +///
> +// Confidence: Zero
> +// Options: --no-includes --include-headers
> +
> +virtual context
> +virtual report
> +virtual org
> +
> +@initialize:python@
> +@@
> +
> +scopemap = {
> +  'scoped_masked_user_read_access_size'  : 'scoped_masked_user_read_access',
> +  'scoped_masked_user_write_access_size' : 'scoped_masked_user_write_access',
> +  'scoped_masked_user_rw_access_size'    : 'scoped_masked_user_rw_access',
> +}
> +
> +# Most common accessors. Incomplete list
> +noaccessmap = {
> +  'scoped_masked_user_read_access'       : ('unsafe_put_user', 'unsafe_copy_to_user'),
> +  'scoped_masked_user_write_access'      : ('unsafe_get_user', 'unsafe_copy_from_user'),
> +}
> +
> +# Most common accessors. Incomplete list
> +ptrmap = {
> +  'unsafe_put_user'			 : 1,
> +  'unsafe_get_user'			 : 1,
> +  'unsafe_copy_to_user'		 	 : 0,
> +  'unsafe_copy_from_user'		 : 0,
> +}
> +
> +print_mode = None
> +
> +def pr_err(pos, msg):
> +   if print_mode == 'R':
> +      coccilib.report.print_report(pos[0], msg)
> +   elif print_mode == 'O':
> +      cocci.print_main(msg, pos)
> +
> +@r0 depends on report || org@
> +iterator name scoped_masked_user_read_access,
> +	      scoped_masked_user_read_access_size,
> +	      scoped_masked_user_write_access,
> +	      scoped_masked_user_write_access_size,
> +	      scoped_masked_user_rw_access,
> +	      scoped_masked_user_rw_access_size;
> +iterator scope;
> +statement S;
> +@@
> +
> +(
> +(
> +scoped_masked_user_read_access(...) S
> +|
> +scoped_masked_user_read_access_size(...) S
> +|
> +scoped_masked_user_write_access(...) S
> +|
> +scoped_masked_user_write_access_size(...) S
> +|
> +scoped_masked_user_rw_access(...) S
> +|
> +scoped_masked_user_rw_access_size(...) S
> +)
> +&
> +scope(...) S
> +)
> +
> +@script:python depends on r0 && report@
> +@@
> +print_mode = 'R'
> +
> +@script:python depends on r0 && org@
> +@@
> +print_mode = 'O'
> +
> +@r1@
> +expression sp, a0, a1;
> +iterator r0.scope;
> +identifier ac;
> +position p;
> +@@
> +
> +  scope(sp,...) {
> +    <+...
> +    ac@p(a0, a1, ...);
> +    ...+>
> +  }

This will be more efficient and equally useful with <... ...>
Using + requires that there is at least one match, which has a cost.

julia


> +
> +@script:python@
> +pos << r1.p;
> +scope << r0.scope;
> +ac << r1.ac;
> +sp << r1.sp;
> +a0 << r1.a0;
> +a1 << r1.a1;
> +@@
> +
> +scope = scopemap.get(scope, scope)
> +if ac in noaccessmap.get(scope, []):
> +   pr_err(pos, 'ERROR: Invalid access mode %s() in %s()' %(ac, scope))
> +
> +if ac in ptrmap:
> +   ap = (a0, a1)[ptrmap[ac]]
> +   if sp != ap.lstrip('&').split('->')[0].strip():
> +      pr_err(pos, 'ERROR: Invalid pointer for %s(%s) in %s(%s)' %(ac, ap, scope, sp))
>
>

