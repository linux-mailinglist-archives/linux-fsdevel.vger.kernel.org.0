Return-Path: <linux-fsdevel+bounces-23400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F52B92BCAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 16:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F031F21392
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0002F18E76F;
	Tue,  9 Jul 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="c0diSghb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jaHTw5Cm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BDA14B092;
	Tue,  9 Jul 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534622; cv=none; b=AMs7mxtb/GIn5Pusymjy8qknqC2aQrzdzYyUuOX6XkNuQnNOUqFG8+vdpxefkrIb8QHaYJEvzCs9PyD4IZ/lheHC5mu8TmYtiNy39weYJN3GnUvePeomYAAXcztYi3qGe7xAo3XQq5t9pSygK4mOGLE0GmAkLL03cr+SpJK7lzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534622; c=relaxed/simple;
	bh=a1//xVVk/p+X87Fx+350qQgEPBj2+So1siWWSQlf/qI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=KP43DBo5ps06hEu47MWOgqCqUYJUfAkvQCe84yVoZX4li1iUOl8j5rcG5BnV3EnEp4sUG2gJ/BDPFYvTHZhNnVMYz1OuPlFPL3jqVWtEc1Y13HV5BVAqhaxFGEx20IFWCQfWZq12Cz6HVqpnzu58iXDO47vMnix8LKVFsmGq10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=c0diSghb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jaHTw5Cm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D70F3114157F;
	Tue,  9 Jul 2024 10:16:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jul 2024 10:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1720534619;
	 x=1720621019; bh=ke9rb34FJJV4rF+MkKIiP0p8Y0EQuq37lQsJeEBjSeQ=; b=
	c0diSghbFlSVyS0R4qPlm97JqWt/eHeSU07qcmYe8WabLBgr2UcwFI5WmVZi80Fk
	Nd0/hAgAhIyZnC0YANT+DDi8be9vvjOJ72rGEWiPoqzrnU4JTQFWWFGxCGZZV753
	ahiMnpdP5xcEyrFKnTH+Z7+SevcYwSsXLRURT6FU8FqcH82f9ckTT+VaEpOBnPUQ
	bTeBV/Ei/6qfjLddTPeIUVY5Nyk0GyUhMRgyRuvpJmwX++28bK79bHSDREEg2cTv
	8a/esi4WwveO7GBZg9KH6ntT1ufyJgkM5hYU/7dQWz6cDYbnUGyZfNiIdZr/Mu8z
	PW0A/VzbaaraVWMN1z+Ahw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720534619; x=
	1720621019; bh=ke9rb34FJJV4rF+MkKIiP0p8Y0EQuq37lQsJeEBjSeQ=; b=j
	aHTw5CmK8/5xqJqz5b8lxqcYMBOBD30p1lvSj7U3qpHd6mKe8JVbN7TEeZ/0MrF5
	Th2DccGXcWN5w95/F7M2f6FIipYAVmPjmX6hrqEDJ5Y4dYKPJvHhBs3kMvhSl/1n
	acGzv55+wLrtD7c1HGEEfLqrGupiZOPUrCr1nIah6pRS06CRiJ7eTAEfBzqE7bCS
	1rOfxw/paDP6FJB+DNqGyqY3tfaRwREqpF4mBi5kF1E+Yrl+E8aZf0gpW2T5zbxx
	tcgb/aV4VWOKEXO8XtxHqVQYVrDMMOBZUMz800qwLa1o2woWZawtrDfD00KOmq36
	t36VB65PatlpizNx4AhOA==
X-ME-Sender: <xms:WkaNZlZr-ZQkULrvzFP9m46jgGqOi0l4aO3hLjKEy_IUPiJHKAE8wQ>
    <xme:WkaNZsYT4FNYbgTKtJzD6NZ1jVl5QulGwfi-FZDr7nyOes8Lvubswp7Bl_t1uDIbc
    8-7wtE6BK6fRn0yhW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffeigedtuddtkeevuedvueeuhefhhedvueekvdekkeekuefhtedthfetveej
    feetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:WkaNZn-nFO6hRIfj_HoTc-3dyjdmtQ5tuxU2mKEvJvoZbGMVIQtnAA>
    <xmx:WkaNZjrXPr1tt6kFy17V90KPTKev9nlf3AYVcyeAlfLsGz6LuQUF9Q>
    <xmx:WkaNZgqE2_orJFt-Yci95RJXAVGSDdn1UKTNeQzPpoZQUf_xl8Y8Dw>
    <xmx:WkaNZpTQNu5fSzN72wbHXC3dreOmpolit72_XiXZQJ9acBJpMMEvWg>
    <xmx:W0aNZpmu1Z0-eiLc8-dbr28l-81QR--OKBsmeif5mOq1ivdfPej592bO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 67875B6008F; Tue,  9 Jul 2024 10:16:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c4df5f73-2687-4160-801c-5011193c9046@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdVsDSBdz2axqTqrV4XP8UVTsN5pPS4ny9QXMUoxrTOU3w@mail.gmail.com>
References: <202407091931.mztaeJHw-lkp@intel.com>
 <c1d4fcee3098a58625bb03c8461b92af02d93d15.camel@kernel.org>
 <CAMuHMdVsDSBdz2axqTqrV4XP8UVTsN5pPS4ny9QXMUoxrTOU3w@mail.gmail.com>
Date: Tue, 09 Jul 2024 16:16:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Jeff Layton" <jlayton@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [jlayton:mgtime 5/13] inode.c:undefined reference to
 `__invalid_cmpxchg_size'
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024, at 15:45, Geert Uytterhoeven wrote:
> On Tue, Jul 9, 2024 at 1:58=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
>> I've been getting some of these warning emails from the KTR. I think
>> this is in reference to this patch, which adds a 64-bit try_cmpxchg in
>> the timestamp handling code:
>>
>>     https://lore.kernel.org/linux-fsdevel/20240708-mgtime-v4-0-a0f3c6=
fb57f3@kernel.org/
>>
>> On m68k, there is a prototype for __invalid_cmpxchg_size, but no actu=
al
>> function, AFAICT. Should that be defined somewhere, or is this a
>> deliberate way to force a build break in this case?
>
> It's a deliberate way to break the build.
>
>> More to the point though: do I need to do anything special for m86k
>> here (or for other arches that can't do a native 64-bit cmpxchg)?
>
> 64-bit cmpxchg() is only guaranteed to exist on 64-bit platforms.
> See also
> https://elixir.bootlin.com/linux/latest/source/include/asm-generic/cmp=
xchg.h#L62
>
> I think you can use arch_cmpxchg64(), though.

arch_cmpxchg64() is an internal helper provided by some
architectures. Driver code should use cmpxchg64() for
the explicitly 64-bit sized atomic operation.

I'm fairly sure we still don't provide this across all
32-bit architectures though: on architectures that have
64-bit atomics (i686, armv6k, ...) these can be provided
architecture specific code, and on non-SMP kernels they
can use the generic fallback through
generic_cmpxchg64_local(), but on SMP architectures without
native atomics you need a Kconfig dependency to turn off
the particular code.

     Arnd

