Return-Path: <linux-fsdevel+bounces-68947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 758BCC6A0E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 756D14FAFB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51DF32ED2C;
	Tue, 18 Nov 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEKPZFD8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/sRwr7x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257322BEC28;
	Tue, 18 Nov 2025 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476174; cv=none; b=L8OrEyRXAXw/N5cHkOnL+LBkqSNBYoKyL/dsPOkxZgICXzqxDgJzd/UWNzg7enibXyFU7Xbq8dCvETNfjRdAoqie4jiS3lkiz26HgvO5fArqd7NBaXakJgezfsn2Qp62vnOjQ2twPByi7UalwRoRv8Z6JJqv0CLRlXcaAc2IVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476174; c=relaxed/simple;
	bh=bsTGiYCeUGyKymNT/zymuRlkd9lPzEB0+jj26ocRViM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nn7LEjuUpkZTK+P5ch77gWpWvUC/094llUhjvllCE2VhsrzdlNID8KC6qq76YZrZA3TsbOHTvVp1ipkGiX/Otkhyl0WA7IzCbPozbVGBWr/eqDn9P7Hl8/gUtNtNhQvhCs/IJN9lKEUjeJXkWPDK9SzBp86DEFW5Ze7cqWjnJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEKPZFD8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/sRwr7x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763476171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0n9UnbJWA0qi+JmKy/6pHK84BHEidvZ9wIicmRWTn88=;
	b=UEKPZFD8IIH9dBvKhwzK+fXlmTby97FDKBDH31b76QtLz4uD0gbhWa+W7SG6f2imgKHsWF
	nu7N2cXnD+OCXTKolN3SzKUxx0O8+YMYrf0DJRqkmvAsYU7YQt4xMRIRn31eSNTDdyUdTG
	IT2upU2s7XedV+LOJih1/IaYmQwaNjbWORnGZX5SwX7NuvSC4KD3ikvjJIvhOM46GhQd01
	52oJbqmp9xU9wMBK5pfo+VUj795hv5/+DoNV18rIIGuY7Np5J8ffKQgUsoL/5nUfJg3+NS
	VL74Yn4la+CYnL9s6qvPYaEX2wHWgAZZrqm1x678CcgHB2dDbTcn5wYaPqQxpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763476171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0n9UnbJWA0qi+JmKy/6pHK84BHEidvZ9wIicmRWTn88=;
	b=h/sRwr7xzeJWCEHSEV2dmP1lyM8HmabFe+SrA74S6/B5KUksS4LoIrxmGid+rFGCLsbVgL
	qsdlJxY2x7xXHyBw==
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida
 <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, Eric
 Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Dave Hansen <dave.hansen@linux.intel.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nichlas
 Piggin <npiggin@gmail.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 0/4] uaccess: Prepare for masked user access on powerpc
In-Reply-To: <cover.1763396724.git.christophe.leroy@csgroup.eu>
References: <cover.1763396724.git.christophe.leroy@csgroup.eu>
Date: Tue, 18 Nov 2025 15:29:29 +0100
Message-ID: <87y0o35s8m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 17 2025 at 17:43, Christophe Leroy wrote:
> This is v5 of the series "powerpc: Implement masked user access". This
> version only includes the preparatory patches to enable merging of
> powerpc architecture patches that depend on them on next cycle.
>
> It applies on top of commit 6ec821f050e2 (tag: core-scoped-uaccess)
> from tip tree.
>
> Thomas, Peter, could you please take those preparatory patches
> in tip tree for v6.19, then Maddy will take powerpc patches
> into powerpc-next for v6.20.

I've applied them to tip core/uaccess, which contains only the uaccess
related bits. That branch is immutable and could be consumed by PPC if
required.

Thanks,

        tglx

