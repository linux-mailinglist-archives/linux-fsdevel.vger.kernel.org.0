Return-Path: <linux-fsdevel+bounces-63733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCA4BCC79E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612F7423741
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26902ED854;
	Fri, 10 Oct 2025 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Y/gMdJQ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sXhKftPZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB826FA77
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091053; cv=none; b=hnkx+Lv53hOIRJi199LuIbIZ+MBh5AdV8iyXfFik1m4nRZy145ccKRdhGIrao/yvISGkD5IuQHlss5IuWogwN4AjH/QwPJ/pReL305LIgAffrrXrra2Wj8NUMbjWN9+21nq/oWfSmR0lWxQwlfNfp7J/oVzUM7uXConC8N7FQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091053; c=relaxed/simple;
	bh=Mw1mWIT0BtR440CjDV2Aid/L0BJu3yx632sxF2/7qXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt+jc8muBObLYshnVJ6iSjqVxRw1kJxfbpwxxaB74GOlwZJ453E+FdJ+gqkfb9W7ytn2j/3wHB2NkJDfeW3s0j8W2cz89K9AtbmGHqJxCA4vcQgZWtrQ5CUwldFhhfZ3OcPGgIwaFdwV0GpKlYTdMrpU8LN+XS1yB67cUNNgOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Y/gMdJQ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sXhKftPZ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 072E77A0030;
	Fri, 10 Oct 2025 06:10:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 10 Oct 2025 06:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760091049; x=
	1760177449; bh=XfIFhXkqL2PFnCgdILYUcOyv0W/EfJPQuh46n0RKDcg=; b=Y
	/gMdJQ7dmpRjmxhGyjGVTvs+cMiTiVrBW3nVQ9p1Y2S++vPFL8oFpl51HWPnMZRN
	jHc2hKABIujbKs5Equp0lGTYxsgKJ+3rNUCK4V49nEpNWRfQOaWjZlUTBFKRoyLc
	xYTpc6uT/+/1yUk2K5biHstrf+zOYicuvAq251pcn1g8WtGjsjMmH4GZKZpB0AvI
	tzYm9EJjO95PehQ9tLmRGqmeP2g7PdhXNV6OrTDSjwZOPvpbdZVAsKXX7rAkgJop
	vA8dPytPMXZA1RUtuWgbVjOLFeiKvXXwirMUS0CW/mdLRLkrXuPQILPkWl5UfdZc
	lwnS26/V+3zbwwQKXmx/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760091049; x=1760177449; bh=XfIFhXkqL2PFnCgdILYUcOyv0W/EfJPQuh4
	6n0RKDcg=; b=sXhKftPZZQZuAqpgzn7uqlV9dsaBAyflc0xFVZwUDMUN3KP1KDE
	pcLP8r05ZPWL6q9JoEw/I4ZG2sQzzMtyrVtG80NceRqYVZDoiBg6oOoeEBaTUKgT
	crJnLSZThPN+LI7l5YgUnyvqwvcYFStAqvt98Q1Jge4iU7c+AGPsL3a7L4dbqgk6
	Jtj8OYbALjj07qzIWK2ZQz41LtikEEBz98hSRQryQQ6hbLlWz/s4c/wz6e/Spil6
	xL46C6zF4BfAXKBEpBBm0Ww1QhzbdJaWs0XGZJv0gPWPvb9br8D4nvUezP3eRRt4
	ofZom/XoszK9wtWhnfOHJFUjp8gnj3QPm6g==
X-ME-Sender: <xms:qdvoaLTA0DmiR3A3Jimuzh4CNm1ic2qaQP6iJQL25his8fzI1Agnng>
    <xme:qdvoaP3FaBkHrNo4e_y5HdYfbmBKBH99pcwA0vPGN9nmSPP293zgLOTxpSKfE88rz
    VJx-OQkwsYhHZiYcwLfWUyT33MBnPLYYp_eKce4zJx0lFDc8O6RBic>
X-ME-Received: <xmr:qdvoaLdy1zoJHdAIGUOBYLCDmzZVNPeeiFiEzl2fr5CrGBKeb1sSHkNYcVLIdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlihhnuh
    igqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgr
    uggvrggurdhorhhgpdhrtghpthhtohepmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qdvoaHO5gur1DQ1oEMhP4W-DDHCjRSZEF0BneZVG0LWmjdiOg1u75g>
    <xmx:qdvoaPWwCpB4MOxR9IlBV3-7164wSNVyyjNrQ-mTkM7QXyQNhc-Nqw>
    <xmx:qdvoaPyG10ko6xwXsU6aZtRSlHpwkA0Dj3hjZyoCXerPdpDx9luIaQ>
    <xmx:qdvoaG-j1ZUNz8qfhIA0LAVA1xy5okBB7R6Z22jOcWIEcn27Y23Vhg>
    <xmx:qdvoaP2TgJhEvd9Z6dnWteQPHeb02xh6RqJCVwIcmM8eDZyxlparZvbP>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 06:10:48 -0400 (EDT)
Date: Fri, 10 Oct 2025 11:10:46 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Optimizing small reads
Message-ID: <qasdw5uxymstppbxvqrfs5nquf2rqczmzu5yhbvn6brqm5w6sw@ax6o4q2xkh3t>
References: <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
 <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
 <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
 <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
 <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
 <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
 <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>

On Thu, Oct 09, 2025 at 10:29:12AM -0700, Linus Torvalds wrote:
> On Thu, 9 Oct 2025 at 09:22, Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > Objtool is not happy about calling random stuff within UACCESS. I
> > ignored it for now.
> 
> Yeah, that needs to be done inside the other stuff - including, very
> much, the folio lookup.
> 
> > I am not sure if I use user_access_begin()/_end() correctly. Let me know
> > if I misunderstood or misimplemented your idea.
> 
> Close. Except I'd have gotten rid of the iov stuff by making the inner
> helper just get a 'void __user *' pointer and a length, and then
> updating the iov state outside that helper.
> 
> > This patch brings 4k reads from 512k files to ~60GiB/s. Making the
> > buffer 4k, brings it ~95GiB/s (baseline is 100GiB/s).
> 
> Note that right now, 'unsafe_copy_to_user()' is a horrible thing. It's
> almost entirely unoptimized, see the hacky unsafe_copy_loop
> implementation in <asm/uaccess.h>.

Right. The patch below brings numbers to to 64GiB/s with 256 bytes
buffer and 109GiB/s with 4k buffer. 1k buffer breaks even with
unpatched kernel at ~100GiB/s.

> So honestly I'd be inclined to go back to "just deal with the
> trivially small reads", and scratch this extra complexity.

I will play with it a bit more, but, yes, this my feel too.

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..ae09777d96d7 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -612,10 +612,12 @@ do {									\
 	char __user *__ucu_dst = (_dst);				\
 	const char *__ucu_src = (_src);					\
 	size_t __ucu_len = (_len);					\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+	asm goto(							\
+		     "1:	rep movsb\n"				\
+		     _ASM_EXTABLE_UA(1b, %l[label])			\
+		     : "+D" (__ucu_dst), "+S" (__ucu_src),		\
+		       "+c" (__ucu_len)					\
+		     : : "memory" : label);				\
 } while (0)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

