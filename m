Return-Path: <linux-fsdevel+bounces-3278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916CA7F23F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 03:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE67281B35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 02:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DBD154B6;
	Tue, 21 Nov 2023 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AETveS0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631E2138;
	Mon, 20 Nov 2023 18:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pAfw17aMAXO5jNA5wNi4EQEUNYP31ut+8Y9AyC6qrR4=; b=AETveS0/spmd3pq0pAjwyZKShu
	tTeHavtT/gA+L4dHwyYTyK6rUDhxbOCURftxNAGCXud042shrupW8lwe2qo9/h2ypa8tab3dD4rO9
	oX3P8AJRMLpJaOQcc5pNl8OJ/6L4Q1ffJ2sfK5A9wjhyVsO41T2Hss/TOD/hDbNIfjDygAEK7wSyu
	K9mp0GPMbw3EutV72rle1DncPk898z76DHRjLyuQ16eHbBw9/UKSNqv4eBiVBoy2eC/11xfu5BXqT
	JLQSAsphb6iW722vNGnMbBhmIPS8a17bXLScTxDEgsznFKy2Ckn6kt/e77jIUL30U9RqSqZOMEznS
	9oS6N6Vg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5GUA-000z3m-0x;
	Tue, 21 Nov 2023 02:27:34 +0000
Date: Tue, 21 Nov 2023 02:27:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Gabriel Krisman Bertazi <krisman@suse.de>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231121022734.GC38156@ZenIV>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 20, 2023 at 10:07:51AM -0800, Linus Torvalds wrote:

> Well, we all know - very much including Al - that Al isn't always the
> most responsive person, and tends to have his own ratholes that he
> dives deep into.

FWIW, the right now I'm getting out of one of those - rename() deadlocks
fun.  Will post that, assuming it survives local beating, then post
the dcache stuff and other branches (all rebased by now).

Other ratholes - d_name/d_parent audit is about halfway through -
we do have fun shite in quite a few ->d_revalidate() instances (UAF,
etc.); RCU pathwalk methods need to be re-audited; the fixes caught
in the last cycle are either in mainline by now, or rebased.

But that stuff is relatively easy to suspend for a few days.

> Of course, "do it in shared generic code" doesn't tend to really fix
> the braindamage, but at least it's now shared braindamage and not
> spread out all over. I'm looking at things like
> generic_ci_d_compare(), and it hurts to see the mindless "let's do
> lookups and compares one utf8 character at a time". What a disgrace.
> Somebody either *really* didn't care, or was a Unicode person who
> didn't understand the point of UTF-8.
> 
> Oh well. I guess people went "this is going to suck anyway, so let's
> make sure it *really* sucks".
> 

> The patches look fine to me. Al - do you even care about them?

I will review that series; my impression from the previous iterations
had been fairly unpleasant, TBH, but I hadn't rechecked since April
or so.

Re dcache conflicts - see #untested-pile-dcache; most the dcache-affecting
stuff should be there.  One intersting exception is the general helper
for safely picking parent/parent's inode/entry name for ->d_revalidate()
use;  we have the parent-related part boilerplated, but the name side
tends to be missing.  That's still being tweaked, looking for sane
calling conventions.

