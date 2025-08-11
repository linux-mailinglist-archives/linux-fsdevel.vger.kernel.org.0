Return-Path: <linux-fsdevel+bounces-57387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 292D1B210BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A931418A6755
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB03D2E92B6;
	Mon, 11 Aug 2025 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw3QAD2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0FB2E92AD;
	Mon, 11 Aug 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926704; cv=none; b=tzKsQtHhepkmV1sBc5XKen6EwlVazm/zyZpJgdoh1xHGNyp/l6B3TOjHAo16gwAP+cIGFaJ6B2kB8lK2Hozjmn0DFHwD7/AxVshfAg0NzaosXOr3RybRqshIQTLAf1zIkhfqP3YamiNPElS1xkwezcrQ+4aIUzEZqw+oqYWD/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926704; c=relaxed/simple;
	bh=GeWuknlfFgAJsGUf9dlyyJbNRzQgCCg7mlxqSPsoH1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1e4laSVj963kedB2vU2gTPDYbqixbJg0ROvUzVZIzOh+YPGnrC9V/2AUn4Wj5oNnv2cV9V8dBGo3CShc7GNOCiQrC+m5M6LGJ4PQTmEHnNICMVt53i0kyV3cjjPhnNs2TcP6Hl6d6qpoMCKRfyzinmWVlyiA1u3zKTXfBBIgu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw3QAD2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90027C4CEED;
	Mon, 11 Aug 2025 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926703;
	bh=GeWuknlfFgAJsGUf9dlyyJbNRzQgCCg7mlxqSPsoH1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pw3QAD2vnypwGbaIGQPLUzCHUHmLNCEdcJSflXMOZJqnwTZxqpHK01BGsbil5gvJd
	 SvlcTHJ9JKBI7FtkRqkKGCbEaqrAIFwf+fN+HuuXRbQ5QwfnvnAGU912cZDYvqHEoA
	 NMVgBeUsByYu4LqOSDWqNehiW4CGVyoLsJANaoCNL+DJhpwMwfWTUVAH2mvgc80ea2
	 ntyAJkEtRmdOHa4Gb7wTieBlm1REQ4tYe6i/0CpY1k5rC3FuFli591xE6fLDYFV+qM
	 6XaR88UckCXsalfYxevNSVy1z+Da+Mk7NEH77wioNVu4NYZtG5VKkT4gvJTxIHDfiF
	 oNGbFv7WvW/Kg==
Date: Mon, 11 Aug 2025 08:38:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	david@fromorbit.com, ebiggers@kernel.org
Subject: Re: [PATCH RFC 12/29] fsverity: expose merkle tree geometry to
 callers
Message-ID: <20250811153822.GK7965@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-12-9e5443af0e34@kernel.org>
 <20250811114813.GC8969@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811114813.GC8969@lst.de>

On Mon, Aug 11, 2025 at 01:48:13PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 28, 2025 at 10:30:16PM +0200, Andrey Albershteyn wrote:
> > From: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > Create a function that will return selected information about the
> > geometry of the merkle tree.  Online fsck for XFS will need this piece
> > to perform basic checks of the merkle tree.
> 
> Just curious, why does xfs need this, but the existing file systems
> don't?  That would be some good background information for the commit
> message.

Hrmmm... the last time I sent this RFC, online fsck used it to check the
validity of the merkle tree xattrs.

I think you could also use it to locate the merkle tree at the highest
possible offset in the data fork, though IIRC Andrey decided to pin it
at 1<<53.

(I think ext4 just opencodes the logic everywhere...)

> > +	if (!IS_VERITY(inode))
> > +		return -ENODATA;
> > +
> > +	error = ensure_verity_info(inode);
> > +	if (error)
> > +		return error;
> > +
> > +	vi = inode->i_verity_info;
> 
> Wouldn't it be a better interface to return the verity_ino from
> ensure_verity_info (NULL for !IS_VERITY, ERR_PTR for real error)
> and then just look at the fields directly?

They're private to fsverity_private.h.

--D

