Return-Path: <linux-fsdevel+bounces-75933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XRWcKMxPfGmXLwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 07:29:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17040B79F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 07:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B4A3018760
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 06:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F383330EF86;
	Fri, 30 Jan 2026 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="pWISEaO1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bhSLP7kQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77101B4138;
	Fri, 30 Jan 2026 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769754560; cv=none; b=i01P2ZFORc6j3dveKwRjS3e76eb+LfAEEPiLD+cMU/5MIc8nJIo4l1liJXss605EBGa+MRKZ/Wq8ZeHKZVnF4AC5BOzqtPZyBxdyGCHlFHsukbVKGQvcdSlwsXV+QhRQ6/wzoVzmR7297L+Lx5rZFzD14uFsJNFJ/lcnY/Ux6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769754560; c=relaxed/simple;
	bh=w54IxspeN3fLL2D+iwnbPctrlMMkB5z1LDosoHBglnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1lWxaDAfnegS9jnFBG9gS+ZuKuNIlG5a1nCya6T0jWgM4q6YhRnCFmR9VBwvKUFyvOuSSkW1LhuUyHOm6Jz8RxtaLJYGdV9Q2q716mE+UIwhcvxrFU2bUo+2ky5MWRWWeMujtxezMZcf738bGxZA1o0C3qbx+sM6pd7emYIPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=pWISEaO1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhSLP7kQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 030BBEC057E;
	Fri, 30 Jan 2026 01:29:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 30 Jan 2026 01:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769754557; x=1769840957; bh=fUPIyT+rPH
	X0V/WdjcrHYaPNcQildwdoXm5TyattcY0=; b=pWISEaO1HTaMMayXTs4e8zgwgL
	zukdqUIZSOGw0ARPEjkP1nyq+QbMQ4VCf8nfX0FHJC80/x1URm4+CpY/2/WCDaJ5
	PnuP76D6I96MTmPnnXTvdMErZalQq/cVHS03pw3PBQDHFj7ViRKZ8DRHDv72mF/a
	WaFq90U/oSpvGsApmNmI8wjPMLkGC9OM+QyypGOQcA33Ai/csxYCgUyNDJWb1YRS
	E9CFop3tc65VOBnzRTevQqfLA7PCssnH0GOYcyJwq7dREhdQkV2jZRoR6ea4UcGB
	06VUsK/GJ/zWR72xK0EfNf/S9S67rjghRu48UbzkUaOj37nSir7VuNkwS90g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769754557; x=1769840957; bh=fUPIyT+rPHX0V/WdjcrHYaPNcQildwdoXm5
	TyattcY0=; b=bhSLP7kQyizgI0nXnwdibvVaZ1wKPS1mBQqODKWyKk5YbA3+Ix+
	6Uxg/9/3YXfBdBHpjTRIUehyGGsCNdE5KPvoPPF73oG9pIpGo1kc68g8ulEpNd6M
	nTXPue3SjEkdxzl7r1SRTC1vBut76VRteCYKptpceaCDRCN6CeCiFVHRUH489BhA
	+fI1x7XFXKVIwiFJ+RaWY5nw45izedkf0DRXdac3u32pLO2eI5Xbk9I8hP3Cm5gW
	LIwyV/u23rRxanPeGvaeDiWXicMxMipeZt+mMRClWCoh5gmzPohaH6uFQycj9O33
	PmkkQCBaTB9SOyOVoVG9UGqteXM+kofPNPw==
X-ME-Sender: <xms:vU98aUL30npbhut49jc5yevh6MmgiuA0nkN1orBpBYH5cyqJYCfZdg>
    <xme:vU98aUlJchR99GdawuNr5xDMyqYT6ZqJuT11KMcR0NoQ6VwizXVVZOwjTnMP9Ftil
    pmr1AqoptTxLEM-9XfMkrSjBByF_gDmiD1MeVSL8zD4meKzfvOZnY0>
X-ME-Received: <xmr:vU98aVbG0winMxBpwMcM899ZUHEHXnfVFXEcMWE1-G13jg1OyIxbRdqHrZrb87vYU-COZ-OV5NgU8sJNqvPGStXWWvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieekfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevudeihe
    eiheetleeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehquhifvghnrh
    huohdrsghtrhhfshesghhmgidrtghomhdprhgtphhtthhopehinhifrghrughvvghsshgv
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegtlhhmsehfsgdrtghomhdprhgtphhtth
    hopegushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhr
    fhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdht
    vggrmhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vU98aY-dcOkcrU0sN31GH6wyhhNQynF3RqXIlhozjA0ON89Isbw_5w>
    <xmx:vU98acbI-0flTJJv9ZyQiuGmpPVHOat0vc-3pH8wAVM6LKFTLTDj-A>
    <xmx:vU98aadhk9fpEu7B5alAib5hdysmdke6eJccsNJ2EIc31bDuiqtKQw>
    <xmx:vU98aRl2jmeFFEC4bpKWcmQcZNpv2SqvHuarRX9sZ8rraM9b_l2MEw>
    <xmx:vU98aUj-uab92rcgsGHGmGsjcArSxFJSXn1B3X649rEejdx82w3ubbu3>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 01:29:17 -0500 (EST)
Date: Thu, 29 Jan 2026 22:28:48 -0800
From: Boris Burkov <boris@bur.io>
To: Matthew Wilcox <willy@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, JP Kobryn <inwardvessel@gmail.com>,
	clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: defer freeing of subpage private state to
 free_folio
Message-ID: <20260130062848.GA863940@zen.localdomain>
References: <20260129230822.168034-1-inwardvessel@gmail.com>
 <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
 <aXw-MiQWyYtZ3brh@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXw-MiQWyYtZ3brh@casper.infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,gmail.com,fb.com,suse.com,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-75933-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,zen.localdomain:mid]
X-Rspamd-Queue-Id: 17040B79F0
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 05:14:26AM +0000, Matthew Wilcox wrote:
> On Fri, Jan 30, 2026 at 01:46:59PM +1030, Qu Wenruo wrote:
> > Another question is, why only two fses (nfs for dir inode, and orangefs) are
> > utilizing the free_folio() callback.
> 
> Alas, secretmem and guest_memfd are also using it.  Nevertheless, I'm
> not a fan of this interface existing, and would prefer to not introduce

From the VFS documentation:

"free_folio is called once the folio is no longer visible in the page cache
in order to allow the cleanup of any private data."

That sounds like the perfect solution to exactly the issue JP observed.
So if it is not intended to be used in this way, I think it would be
beneficial to more accurately document the proper (never?) use of
free_folio() to avoid this pitfall.

I will also point out that the usage in orangefs closely matches this
one in spirit: kfree-ing some longer lived object tracking ranges in the
folio.

As for this patch, do you have any suggestion for how to handle the
problem of freeing allocated memory stored in folio->private? To me, it
feels quite wrong to do it in release_folio() if that can end with a
folio that can still be found in the mapping. Should we have all users
that find and lock the folio detect whether or not private is set
up appropriately and re-allocate it if not? Or should we only lookup and
use the private field only from VFS triggered paths (rather than btrfs's
internal relocation stuff here)

> new users.  Like launder_folio, which btrfs has also mistakenly used.
> 

for context
https://lore.kernel.org/linux-btrfs/070b1d025ef6eb292638bb97683cd5c35ffe42eb.1721775142.git.boris@bur.io/

IIRC, the issue was that we call invalidate_inode_pages2 on outstanding
dirty folios while cleaning up a failed transaction which calls
launder_folio() and release_folio(). At this point, btrfs does not have
private set on the folio so release_folio() is a no-op. So I used
launder_folio() to clean up otherwise leaked state that was 1:1 with
dirty folios, so it also felt like a "natural" fit. I apologize for
this undesirable usage, but I was genuinely trying to do the right
thing and take advantage of an abstract interface that very cleanly
modeled my problem. At the time, I interpreted the existence of an
interface that neatly fit my problem to be a credit to the design of
VFS. In the future, I will make sure to cc fsdevel before adding any
new usage of the VFS.

At a high level, would it be reasonable to mark the page private when
it is dirtied and the qgroup reservation is made, so that we do go into
release_folio() via invalidate_inode_pages2? I can look into that.

Ultimately, cleaning up qgroup reservation accounting while aborting a
transaction is hardly the most important thing in the world. It's just
something that looks messy while cleaning up the filesystem. So if we
want to get rid of launder_folio() even if I can't figure out how to
make it use release_folio(), all we really need is for someone to ask
nicely and I can probably come up with a hack. :)

Thanks,
Boris

