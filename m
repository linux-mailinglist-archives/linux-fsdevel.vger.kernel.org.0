Return-Path: <linux-fsdevel+bounces-71453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB41CC196C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 09:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 714D43086EE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A733B6EB;
	Tue, 16 Dec 2025 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aiqWz1aT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A904431DD90
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765873156; cv=none; b=OZgOR3NTbZrOVoqGNnPCJ1Q/xnx+RTL5QahTusRS+gIO/wNb3Ck0oQzlC0qwcu8AVWko7dWh2E9WL5iQabXf96Ed0DnHAl5Ok2h2Wdg2608adxU5VenfAiv0Q+jUXukf08ucM/Yvxwi4yyiHxxKbyYLhzWNQstV/sbsnH3DhFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765873156; c=relaxed/simple;
	bh=QIhu7VMDbWX4Oj+wWXaWb7QolcvllwxdiICL/KbOq2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F2ZHB0xtY/8ERLsNdwGbJo7Tv9QtCbarMmV0Ft1A0PiejDHwTazfgQnddPTlBzzRhKnSQYw0R4Z1pXAiucND9a4STNQ9urXcN5pkYNImeoPUSR/AKCSsJn/2EoCD2LSaxKubwNvd48Emc7zfjh1a+fWUkEunyzPjddPcTtLNacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aiqWz1aT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+lfV1Jj25Cfwg9pVZgdYzGEsU/0bn2SzEW8frgbPimM=; b=aiqWz1aTnp+1LLjH3HzsC4oFAf
	f6pnrhDZZjuU4P9wjdItyd3bF53np6yPRxDARjIc7XQCzx6zrjhUwvpxfAXiIu+hWrWUKlI8zD3k4
	GwNRm8a5DpT1ci53yPv5VbdHXNCLsCUknys0uA6hwqD4/aRzUizFMgjTjvpk75MnVhRbk4AhE/WtQ
	DHvTETk0lqG+kxPruWcVIz72wDYr91jDNH/t+8zRLLkCJuoUjukt1LdL0Tw9SDc/oNWoK2dxwIwsJ
	fXL9QUuF6gJB58xn9+Wg2hbnEfJELQab9cos8kA8Tsis0rSUUWaJYBX8fppW+qQ06F2faG/FRcG13
	Is0yZKPA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vVQHT-00000003yMy-2t3z;
	Tue, 16 Dec 2025 08:19:39 +0000
Date: Tue, 16 Dec 2025 08:19:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [RFC][PATCH] get rid of bogus __user in struct xattr_args::value
Message-ID: <20251216081939.GQ1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	The first member of struct xattr_args is declared as
	__aligned_u64 __user value;
which makes no sense whatsoever; __user is a qualifier and what that
declaration says is "all struct xattr_args instances have .value
_stored_ in user address space, no matter where the rest of the
structure happens to be".

	Something like "int __user *p" stands for "value of p is a pointer
to an instance of int that happens to live in user address space"; it
says nothing about location of p itself, just as const char *p declares a
pointer to unmodifiable char rather than an unmodifiable pointer to char.

	With xattr_args the intent clearly had been "the 64bit value
represents a _pointer_ to object in user address space", but __user has
nothing to do with that.  All it gets us is a couple of bogus warnings
in fs/xattr.c where (userland) instance of xattr_args is copied to local
variable of that type (in kernel address space), followed by access
to its members.  Since we've told sparse that args.value must somehow be
located in userland memory, we get warned that looking at that 64bit
unsigned integer (in a variable already on kernel stack) is not allowed.

	Note that sparse has no way to express "this integer shall never
be cast into a pointer to be dereferenced directly" and I don't see any
way to assign a sane semantics to that.  In any case, __user is not it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

PS: one variant we might implement in sparse is a type attribute similar
to __bitwise__ (__affine__, perhaps?) such that
T + integer => T, as long as integer type promotes to base type of T
T - integer => ditto
T - T => base type of T
T <comparison> T => int
and perhaps
T & integer => integer, for the sake of things like alignment checks, etc.
any other arithmetics on T => error
cast or conversion from T to anything other than qualified T => error
cast or conversion to T from anything other than qualified T => error
force-cast to or from T => allowed
Then we could have something like __encoded_uptr declared as __u64 with
such attribute in addition to __aligned(8) we already have on __aligned_u64,
with
static inline void __user *decode_uptr(__encoded_uptr v)
{
	return (__force void __user *)v;
}
with that helper used instead of u64_to_user_ptr() fs/xattr.c currently uses
for those.  It's not that hard to implement, but I'm not sure how useful would
that be...

diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index c7c85bb504ba..2e5aef48fa7e 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -23,7 +23,7 @@
 #define XATTR_REPLACE	0x2	/* set value, fail if attr does not exist */
 
 struct xattr_args {
-	__aligned_u64 __user value;
+	__aligned_u64 value;
 	__u32 size;
 	__u32 flags;
 };

