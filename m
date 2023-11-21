Return-Path: <linux-fsdevel+bounces-3277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A487F2380
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 03:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66CA1F26572
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 02:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F2134BC;
	Tue, 21 Nov 2023 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fh+Iz59m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0809485
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 18:03:30 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-82-21.bstnma.fios.verizon.net [173.48.82.21])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AL22s5b004315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 21:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1700532178; bh=RI/R/dL+OK3InX9FiqKDXHPEN021Sx3jNB6FQIcl/vA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fh+Iz59mAaEhYI6Rnl1Ws5eNRCdm8wGGiPBNrtSex6iEN3evmaEE4VQ38o7HziJIX
	 1oE53Yx5gx4QD+4kGuf0DRlqTlOmzTWeEI2U3lwozuid2nmQUf3gYQ2cFfVX58ObIS
	 AOF5SVofHZTGGj/d41vBKcNaXkE103Uvrh87PK5pi0LdMGHs5Xqj6zMO4rTyX9usd9
	 drGCCLumglHiyBKsUPqRzlaLSTktuNh3kOnfULa7loj6SCmki5AcJ9s3b1I/ItdyGj
	 OJ8dmIFQVzZuLCX6BAwNAawsKR4kbHK+H0hmI1SBGThTTmsfe2NgCjRISca5zfG2+N
	 +bR7dioZFi29A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A86F715C02B0; Mon, 20 Nov 2023 21:02:54 -0500 (EST)
Date: Mon, 20 Nov 2023 21:02:54 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
        linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231121020254.GB291888@mit.edu>
References: <20230816050803.15660-1-krisman@suse.de>
 <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>

On Mon, Nov 20, 2023 at 10:07:51AM -0800, Linus Torvalds wrote:
> Of course, "do it in shared generic code" doesn't tend to really fix
> the braindamage, but at least it's now shared braindamage and not
> spread out all over. I'm looking at things like
> generic_ci_d_compare(), and it hurts to see the mindless "let's do
> lookups and compares one utf8 character at a time". What a disgrace.
> Somebody either *really* didn't care, or was a Unicode person who
> didn't understand the point of UTF-8.

This isn't because of case-folding brain damage, but rather Unicode
brain damage.  We compare one character at a time because it's
possible for some character like é to either be encoded as 0x0089 (aka
"Latin Small Letter E with Acute") OR as 0x0065 0x0301 ("Latin Small
Letter E" plus "Combining Acute Accent").

Typically, we pretend that UTF-8 means that we can just encode é, or
0x0089 as 0xC3 0xA9 and then call it a day and just use strcmp(3) on
the sucker.  But Unicode is a lot more insane than that.  Technically,
0x65 0xCC 0x81 is the same character as 0xC3 0xA9.

> Oh well. I guess people went "this is going to suck anyway, so let's
> make sure it *really* sucks".

It's more like, "this is going to suck, but if it's going to suck
anyway, let's implement the full Unicode spec in all its gory^H^H^H^H
glory, whether or not it's sane".


					- Ted

