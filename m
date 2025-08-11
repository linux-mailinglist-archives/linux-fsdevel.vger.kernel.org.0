Return-Path: <linux-fsdevel+bounces-57330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB6AB2082F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7201A7A5B16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF12D29D8;
	Mon, 11 Aug 2025 11:48:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541F25393B;
	Mon, 11 Aug 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912899; cv=none; b=ouLywpBuVcK48bg8btUISpbIuOubSAn1Gh1SIS9Jg9w0+rz2brVU0qtlDpD93lCMTARGJfiLTZor84F4lNdA0hlhu65WROVRd7h38lPpg5a3prj1oRDPyaM2HQOLFm52gBmnU7CzBbJ2c9ZQX1SNVQMPv4lZmGZaLNrAlRifaF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912899; c=relaxed/simple;
	bh=tRbMDcNQ0vtPKuZP5lOrlXscoR4bTElRU9QwEMRI3cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/tJufyE4C4fe0vRA33PI8NbYwS9jkaituLHjlC9Twbydxu6antOmJTeeVKluttFvfhaYSHBWpu7UiVVbziyhl65yKWPOeFXlp3lFZaOCmNvyxZ5KrqtWSVcpifcMob3NjJkT4mBbvKDqKiXBVa0f4ZPxVLPOaEFpe9S66VuEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E962468BFE; Mon, 11 Aug 2025 13:48:13 +0200 (CEST)
Date: Mon, 11 Aug 2025 13:48:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org,
	ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH RFC 12/29] fsverity: expose merkle tree geometry to
 callers
Message-ID: <20250811114813.GC8969@lst.de>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org> <20250728-fsverity-v1-12-9e5443af0e34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-fsverity-v1-12-9e5443af0e34@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 28, 2025 at 10:30:16PM +0200, Andrey Albershteyn wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Create a function that will return selected information about the
> geometry of the merkle tree.  Online fsck for XFS will need this piece
> to perform basic checks of the merkle tree.

Just curious, why does xfs need this, but the existing file systems
don't?  That would be some good background information for the commit
message.

> +	if (!IS_VERITY(inode))
> +		return -ENODATA;
> +
> +	error = ensure_verity_info(inode);
> +	if (error)
> +		return error;
> +
> +	vi = inode->i_verity_info;

Wouldn't it be a better interface to return the verity_ino from
ensure_verity_info (NULL for !IS_VERITY, ERR_PTR for real error)
and then just look at the fields directly?


