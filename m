Return-Path: <linux-fsdevel+bounces-57563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D53BB23797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFF23A00DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB902F8BC3;
	Tue, 12 Aug 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jipRQzwQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD629BDA9;
	Tue, 12 Aug 2025 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025958; cv=none; b=blzdW90SGnlw3MoXWmFQuk7fpkXyFYg/pzIO+sgAbr4PFF/Jc7Xtd0ALx3xrt1pb7RGoG3NOYwQVi8PnNsxWoxEDll3ugwzqL7ggUvtXvzeng41gs5Zlft/sxOBpzUD/eEXAv7/BZdZ9UfxiuSHdS/BqTb1enCL0vn8xQJxQqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025958; c=relaxed/simple;
	bh=DpoTEKy4v+FhF+Rdzb5QvpMIc7TgjXtUHfHsKHTVbi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9e+Zd1SUtWhK6lttVBUwwBNbKYwvoCkOz++xS0KRr0GdYFA/lCy+vQXHq+/v0FmQG6CmaQ3UfzDN78WnwjaWfT/EucAREinVdtJZ4x+b0ecJpAtnYXFmDFqLwn2T+JnrpJFNH74ZcG26HVXDEc0++pG37xqsxPgxPno75P1S7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jipRQzwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594A2C4CEF0;
	Tue, 12 Aug 2025 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755025958;
	bh=DpoTEKy4v+FhF+Rdzb5QvpMIc7TgjXtUHfHsKHTVbi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jipRQzwQcG2lITKhdApHE6xkrLO3VMgdo1LdGC3qXsNRbdRsczY4zv2BLP73fUY7I
	 keYph2kC7i6h1/4EkeMPf5+FRIg2FU+Dozyv2667dfLa4JfcMA05h3vCzFMrugx+yv
	 4Nwq1V2yTptPniUlqtiMzFHMqU1Qh1X42tb3gdoNbgrhK3orwEfrRhYB4gZ+5FbuXR
	 jv6PsYyYSSU+3jTDFnQ30ebizo40vKT3NToP+6oRd8e4SRziAxRVbeFHde1w8bwPIP
	 LxSlqBi3qRu/yKZjLOrs+9hn/uZxgEKGXVmVZ2JYRweU8c4+TXF7Bn8RYSDOFZ0LC2
	 xLFkUMJVOdbkw==
Date: Tue, 12 Aug 2025 12:12:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	david@fromorbit.com, ebiggers@kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 14/29] xfs: add attribute type for fs-verity
Message-ID: <20250812191237.GO7965@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-14-9e5443af0e34@kernel.org>
 <20250811115023.GD8969@lst.de>
 <je3ryqpl3dyryplaxt6a5h6vtvsa2tpemfzraofultyfccr4a4@mftein7jfwmt>
 <20250812074415.GD18413@lst.de>
 <radr4lpyokwvxdduurafrfu4l2uwisrbbggdt3m7afcutmezwv@tj334pmh4pgk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <radr4lpyokwvxdduurafrfu4l2uwisrbbggdt3m7afcutmezwv@tj334pmh4pgk>

On Tue, Aug 12, 2025 at 07:11:24PM +0200, Andrey Albershteyn wrote:
> On 2025-08-12 09:44:15, Christoph Hellwig wrote:
> > On Mon, Aug 11, 2025 at 09:00:29PM +0200, Andrey Albershteyn wrote:
> > > Mostly because it was already implemented. But looking for benefits,
> > > attr can be inode LOCAL so a bit of saved space? Also, seems like a
> > > better interface than to look at a magic offset
> > 
> > Well, can you document the rationale somewhere?
> > 
> 
> We discussed this a bit with Darrick, and it probably makes more
> sense to have descriptor in data fork if fscrypt is added. As
> descriptor has root hash of the tree (and on small files this is
> just a file hash), and fscrypt expects merkle tree to be encrpyted
> as it's hash of plaintext data.

To cite my own sources, the last Q in the Q&A in
https://docs.kernel.org/filesystems/fsverity.html#faq

states that:

"ext4 and f2fs encryption doesn’t encrypt xattrs, yet the Merkle tree
must be encrypted when the file contents are, because it stores hashes
of the plaintext file contents."

So on the grounds that we're following the ext4/f2fs merkle tree layout
model to keep our options open for fscrypt later, I think we need the
verity descriptor to be in the posteof file data, not an xattr.

--D

