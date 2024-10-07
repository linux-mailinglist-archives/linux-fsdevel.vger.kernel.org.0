Return-Path: <linux-fsdevel+bounces-31239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D0A993558
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9869D2838A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA9B1DDA0D;
	Mon,  7 Oct 2024 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm8yUbHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A71D7E52;
	Mon,  7 Oct 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323278; cv=none; b=JMylX6OTmNar3okweT4rz7DxvcW1ELYgQavGPN1Q1OLjPsKylqOodoopCr7qV0mD5sz6BExmYyyYl+wvHV9iUbT6KDkhjZruRakTvUiICoJXNk2HgS5gYTqQFKZ5DTd2+a1blPoJnPTN0Am99SZbgxSBnbza926/8KVOgqX/mW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323278; c=relaxed/simple;
	bh=SRqPr4qhMn8zuFr8OhxsX6E3UszADQY+tQn2vxDgDmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY3/Nlk/d9el27WqnUuI9ayt+AQlg3kLEi752FfHMRShkDB2bwzUt/z4ZmngcVWxVL52Bvj/CKTMePuvkJs2y1aG7Fv/nQQ6MiUzIM8KmxCV3rhUniDkecrMif+bCIgW5CVXTuUquVdxJIDrfmStgTzNud29ITyMFpTRCLQCFoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm8yUbHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FE3C4CEC6;
	Mon,  7 Oct 2024 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728323278;
	bh=SRqPr4qhMn8zuFr8OhxsX6E3UszADQY+tQn2vxDgDmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mm8yUbHnbTojpzwDrQXC1bY4ZGlrOsIQOV7GFXK8PKcPqDpxmWz5HAzzW64UAE0Uj
	 +zQoDRUdR6OtMVfJoyU+tORzbfnRxtXQe3C4o5BcdV2rGq3O3tyBZ8U3GAnStqQWGn
	 UAXd0oB9VKsJ52kIpdokuW376ODD8Iz5wJWxp5G4AxiycUBqRMESV92ggM+ald6e58
	 DjGyYkHewICwarWkGJNMCFaTIGH+Zxdpr7JJT2H11iMfA86/0iZouojTlRFlKhq8oC
	 3oeWl5rdFogNaok8fpUHq5Uz9dx/WkbTY+BM5MraE0nVg105r1ei6c8eTNwpWcNX11
	 Jy9MS+Z6Qxxug==
Date: Mon, 7 Oct 2024 10:47:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 06/12] iomap: Introduce read_inline() function hook
Message-ID: <20241007174758.GE21836@frogsfrogsfrogs>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <8147ae0a45b9851eacad4e8f5a71b7997c23bdd0.1728071257.git.rgoldwyn@suse.com>
 <ZwCk3eROTMDsZql1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwCk3eROTMDsZql1@casper.infradead.org>

On Sat, Oct 05, 2024 at 03:30:53AM +0100, Matthew Wilcox wrote:
> On Fri, Oct 04, 2024 at 04:04:33PM -0400, Goldwyn Rodrigues wrote:
> > Introduce read_inline() function hook for reading inline extents. This
> > is performed for filesystems such as btrfs which may compress the data
> > in the inline extents.

Why don't you set iomap->inline_data to the uncompressed buffer, let
readahead copy it to the pagecache, and free it in ->iomap_end?

> This feels like an attempt to work around "iomap doesn't support
> compressed extents" by keeping the decompression in the filesystem,
> instead of extending iomap to support compressed extents itself.
> I'd certainly prefer iomap to support compressed extents, but maybe I'm
> in a minority here.

I'm not an expert on fs compression, but I get the impression that most
filesystems handle reads by allocating some folios, reading off the disk
into those folios, and decompressing into the pagecache folios.  It
might be kind of amusing to try to hoist that into the vfs/iomap at some
point, but I think the next problem you'd run into is that fscrypt has
similar requirements, since it's also a data transformation step.
fsverity I think is less complicated because it only needs to read the
pagecache contents at the very end to check it against the merkle tree.

That, I think, is why this btrfs iomap port want to override submit_bio,
right?  So that it can allocate a separate set of folios, create a
second bio around that, submit the second bio, decode what it read off
the disk into the folios of the first bio, then "complete" the first bio
so that iomap only has to update the pagecache state and doesn't have to
know about the encoding magic?

And then, having established that beachhead, porting btrfs fscrypt is
a simple matter of adding more transformation steps to the ioend
processing of the second bio (aka the one that actually calls the disk),
right?  And I think all that processing stuff is more or less already in
place for the existing read path, so it should be trivial (ha!) to
call it in an iomap context instead of straight from btrfs.
iomap_folio_state notwithstanding, of course.

Hmm.  I'll have to give some thought to what would the ideal iomap data
transformation pipeline look like?

Though I already have a sneaking suspicion that will morph into "If I
wanted to add {crypt,verity,compression} to xfs how would I do that?" ->
"How would I design a pipeine to handle all three to avoid bouncing
pages between workqueue threads like ext4 does?" -> "Oh gosh now I have
a totally different design than any of the existing implementations." ->
"Well, crumbs. :("

I'll start that by asking: Hey btrfs developers, what do you like and
hate about the current way that btrfs handles fscrypt, compression, and
fsverity?  Assuming that you can set all three on a file, right?

--D

