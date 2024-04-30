Return-Path: <linux-fsdevel+bounces-18374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5208B7BD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73F51F22FFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD2171E6E;
	Tue, 30 Apr 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2vBVEtY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C21527AF;
	Tue, 30 Apr 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491404; cv=none; b=HBC9s0mC24/5oBKxCc1QSwRX271LPHpWmvBfBS3oRS+ny0zwIVXd+gOyOX5vhBr7HEJY66bF2JDNAiqsheBxlrWe6ObA+xkrOrJqOvYerlZJXL7ZnT0XgoSP+FfiJAYXkq6WFTCv63onERBPHvvmMYtg0PIcflEX+N4k+wbDZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491404; c=relaxed/simple;
	bh=xRH/A/MmxvcESuREKxHJJnxBGZpqPUsyLqmvwkDeLTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV4JnMjw1l2g6b69ZU1P9FSst+XRb6RVDOErHhhGxHHY08JnR+ptTNN+4wDQWSNKZfkxkgC9FIXrKs3ije7F25hb66R0/viwOnkM8yxO4Bg5UKxQaHhZbpMB+0vmz/jRqrUs08RZPNVU2vvDEAhPWMZyBrXL4n/kzuWzZ0Mh+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2vBVEtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33371C2BBFC;
	Tue, 30 Apr 2024 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714491404;
	bh=xRH/A/MmxvcESuREKxHJJnxBGZpqPUsyLqmvwkDeLTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2vBVEtYY5+fTBTAeOSDzMM/m0OkbxIMoZd7YR24ftTt3xuPpSPdCBgY5tWEN9tGq
	 XtIDn3RXL2tRHlqC0U5LMOhj4n/rH67OS4jKudT7Pu/vLVyADJEzsKIuhDARibaRYu
	 uSbmJQ/9dftv7zx7yFfayihmgyy68qAk3oRQYIzPNrbRUBUydeHgUG1RPOsHqizj/g
	 hVDJdOrvNgWzvMv+DdhcVg0DGHb+I+KTokg+8MK2DE8QfoPomLWJIW369nt8ZIUzX2
	 ptlkjKy1fDg+2GwcZ1o2FQmafxAyB0Rx4X1GZhU9z4S09otiRNv13Vi5jQC38xDfxr
	 xoHYDHd/OZSbA==
Date: Tue, 30 Apr 2024 08:36:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, guan@eryu.me,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/6] xfs/{021,122}: adapt to fsverity xattrs
Message-ID: <20240430153643.GJ360919@frogsfrogsfrogs>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688009.962488.1019465154475766682.stgit@frogsfrogsfrogs>
 <52muvsk2z6c4gg7pghusidtu4ntot4l3unplgdvgcugll24syz@i5d2usji2wce>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52muvsk2z6c4gg7pghusidtu4ntot4l3unplgdvgcugll24syz@i5d2usji2wce>

On Tue, Apr 30, 2024 at 02:46:18PM +0200, Andrey Albershteyn wrote:
> On 2024-04-29 20:41:19, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Adjust these tests to accomdate the use of xattrs to store fsverity
> > metadata.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  tests/xfs/021     |    3 +++
> >  tests/xfs/122.out |    1 +
> >  2 files changed, 4 insertions(+)
> > 
> > 
> > diff --git a/tests/xfs/021 b/tests/xfs/021
> > index ef307fc064..dcecf41958 100755
> > --- a/tests/xfs/021
> > +++ b/tests/xfs/021
> > @@ -118,6 +118,7 @@ _scratch_xfs_db -r -c "inode $inum_1" -c "print a.sfattr"  | \
> >  	perl -ne '
> >  /\.secure/ && next;
> >  /\.parent/ && next;
> > +/\.verity/ && next;
> >  	print unless /^\d+:\[.*/;'
> >  
> >  echo "*** dump attributes (2)"
> > @@ -128,6 +129,7 @@ _scratch_xfs_db -r -c "inode $inum_2" -c "a a.bmx[0].startblock" -c print  \
> >  	| perl -ne '
> >  s/,secure//;
> >  s/,parent//;
> > +s/,verity//;
> >  s/info.hdr/info/;
> >  /hdr.info.crc/ && next;
> >  /hdr.info.bno/ && next;
> > @@ -135,6 +137,7 @@ s/info.hdr/info/;
> >  /hdr.info.lsn/ && next;
> >  /hdr.info.owner/ && next;
> >  /\.parent/ && next;
> > +/\.verity/ && next;
> >  s/^(hdr.info.magic =) 0x3bee/\1 0xfbee/;
> >  s/^(hdr.firstused =) (\d+)/\1 FIRSTUSED/;
> >  s/^(hdr.freemap\[0-2] = \[base,size]).*/\1 [FREEMAP..]/;
> > diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> > index abd82e7142..019fe7545f 100644
> > --- a/tests/xfs/122.out
> > +++ b/tests/xfs/122.out
> > @@ -142,6 +142,7 @@ sizeof(struct xfs_scrub_vec) = 16
> >  sizeof(struct xfs_scrub_vec_head) = 40
> >  sizeof(struct xfs_swap_extent) = 64
> >  sizeof(struct xfs_unmount_log_format) = 8
> > +sizeof(struct xfs_verity_merkle_key) = 8

Whoops, this change isn't needed anymore.

--D

> >  sizeof(struct xfs_xmd_log_format) = 16
> >  sizeof(struct xfs_xmi_log_format) = 88
> >  sizeof(union xfs_rtword_raw) = 4
> > 
> 
> Looks good to me:
> Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
> 
> -- 
> - Andrey
> 
> 

