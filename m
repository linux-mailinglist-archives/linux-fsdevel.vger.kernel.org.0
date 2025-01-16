Return-Path: <linux-fsdevel+bounces-39429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C0BA141BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 19:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81406168FF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE4022BADF;
	Thu, 16 Jan 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jsYDbTm/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CFD4414;
	Thu, 16 Jan 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737052608; cv=none; b=En8nYOjWTfPmQfOjuKRCjE6bFqaHAxuIJIq3ZFV034LXrf7tOfNeHYNX8rUnfaVYzIeLwLK1NN9MO66UstWnfHL7rlBz+i4s5ORLyPbsydgz1N2spzmVzpqSAVagfP09OCU1pBIOR3/q6D38rVTRTluvglF+cdeg/ABVMhINmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737052608; c=relaxed/simple;
	bh=HD0RdyPzkslappbK9+JzUWR12Ko6tewBYw/NQeCIO84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPRx7tf5AEINBaJV6XRVsbSlR2aEMz1NokyhVsszjwF/osjKfWAxejknH9WM5HO3i0lBygqv5T0ClbhEDcty/opfAjUW42UfOaAExb0k165cDGWBtwYtjbwYdBUYIm6HBiFZAxQQvYAGUT6xcmPZYt1bi17eUU8ZvnYn6D530QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jsYDbTm/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+kDz/g2xO34EEN3fR+fQLCHEPP1BxAQBwVnR/lIICEc=; b=jsYDbTm/Lsta9X9fYIy2G8zkgK
	Pqczw+bOd3s9Uf1kHM1EOftzX4JAP2vf6nF4CZUe705pm1rEfSqcc3lfzPnlL9N7YKIc7tH5Wxq48
	fKTQ/fNRG0y8j9n4mcsZz65uRWD0VGA2osxbbrYsDRiw59iOjTeWQUg1XAXg7lnXDw9NS1/+eKzW/
	BZ4boAcrDqiOoOd8lDbRsLbpoNgUAKeeZ5yUhKgcofzLEBfJNUfUU84cRRoP8cIuqa4a0HGYHY18e
	gQY+tBgA4Bk0C4U8c5CMv+0nwH5XKmBTNGEli1rH2mNdy1Kc2WNGnAm7y05OYuqe0flMS4KDo0dPF
	lX17GQjQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYUjT-00000002Xqd-405i;
	Thu, 16 Jan 2025 18:36:44 +0000
Date: Thu, 16 Jan 2025 18:36:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 4/6] efivarfs: move freeing of variable entry into
 evict_inode
Message-ID: <20250116183643.GI1977892@ZenIV>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
 <20250107023525.11466-5-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107023525.11466-5-James.Bottomley@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 06, 2025 at 06:35:23PM -0800, James Bottomley wrote:
> Make the inodes the default management vehicle for struct
> efivar_entry, so they are now all freed automatically if the file is
> removed and on unmount in kill_litter_super().  Remove the now
> superfluous iterator to free the entries after kill_litter_super().
> 
> Also fixes a bug where some entry freeing was missing causing efivarfs
> to leak memory.

Umm...  I'd rather coallocate struct inode and struct efivar_entry;
that way once you get rid of the list you don't need ->evict_inode()
anymore.

It's pretty easy - see e.g. https://lore.kernel.org/all/20250112080705.141166-1-viro@zeniv.linux.org.uk/
for recent example of such conversion.

