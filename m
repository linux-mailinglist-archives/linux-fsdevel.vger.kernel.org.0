Return-Path: <linux-fsdevel+bounces-3286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095D47F251C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 06:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E69C1C21645
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 05:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89B318621;
	Tue, 21 Nov 2023 05:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Um42NUha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492ECDC
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 21:12:48 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-82-21.bstnma.fios.verizon.net [173.48.82.21])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AL5CFRR025396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 00:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1700543538; bh=6uSNTF4gBA2mBMIlInFqz++irtP7bRP60ummCQhH030=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Um42NUhanFatTa+1jqPuCLUYty2ATWUCBuWm8YpeFYYKfK5UUs0HKRpVD4imsmJNV
	 x7JOR/FgtbjoZsfqxykX2b3XgR32OWQ5PINc9aUIuzmXLZG0Irnb0SYI51LeD9enjy
	 UrJBL3wN0yyOoFm2B4ttvmgRnqk5rEp1xeJyacx0igObUTwOALdAuqQhgTJ1P8Qrqj
	 qiG0W2d9z+yVrsAhmyEw3XAbftuTPO/mdMxN8aKpTkUi7/BKVT44zqjPRR7/5l8qUh
	 GzZ87cv+wdd4RYxhZVvVE7MqT2Mr+yDtLALuqxJhLZroOVEeSrg7ZGMd1hiECK7acM
	 Uanm2L3MmZy/A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2024415C02B0; Tue, 21 Nov 2023 00:12:15 -0500 (EST)
Date: Tue, 21 Nov 2023 00:12:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
        linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231121051215.GA335601@mit.edu>
References: <20230816050803.15660-1-krisman@suse.de>
 <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121020254.GB291888@mit.edu>
 <CAHk-=whb80quGmmgVcsq51cXw9dQ9EfNMi9otL9eh34jVZaD2g@mail.gmail.com>
 <CAHk-=wh+o0Zkzn=mtF6nB1b-EEcod-y4+ZWtAe7=Mi1v7RjUpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+o0Zkzn=mtF6nB1b-EEcod-y4+ZWtAe7=Mi1v7RjUpg@mail.gmail.com>

On Mon, Nov 20, 2023 at 07:03:13PM -0800, Linus Torvalds wrote:
> On Mon, 20 Nov 2023 at 18:29, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It's a bit complicated, yes. But no, doing things one unicode
> > character at a time is just bad bad bad.
> 
> Put another way: the _point_ of UTF-8 is that ASCII is still ASCII.
> It's literally why UTF-8 doesn't suck.
> 
> So you can still compare ASCII strings as-is.
> 
> No, that doesn't help people who are really using other locales, and
> are actively using complicated characters.
> 
> But it very much does mean that you can compare "Bad" and "bad" and
> never ever look at any unicode translation ever.

Yeah, agreed, that would be a nice optimization.  However, in the
unfortunate case where (a) it's non-ASCII, and (b) the input string is
non-normalized and/or differs in case, we end up scanning some portion
of the two strings twice; once doing the strcmp, and once doing the
Unicode slow path.

That being said, given that even in the case where we're dealing with
non-ASCII strings, in the fairly common case where the program is
doing a readdir() followed by a open() or stat(), the filename will be
byte-identical and so a strcmp() will suffice.

So I agree that it's a nice optimization.  It'd be interesting how
much such an optimization would actually show up in various
benchmarks.  It'd have to be something that was really metadata-heavy,
or else the filenamea lookups would get drowned out.

   	    	      	      	    	- Ted

