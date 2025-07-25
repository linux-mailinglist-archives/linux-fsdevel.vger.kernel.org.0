Return-Path: <linux-fsdevel+bounces-55997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18383B1156D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D5F1CE04D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 00:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1243816EB42;
	Fri, 25 Jul 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1ex95+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7215B54A;
	Fri, 25 Jul 2025 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404380; cv=none; b=V/aofFANjc8Gis+mNTDhqmI/HztNmSe6KvIoN3b7S7I+1lUY3EFI4PrDkoRglx9xlOoxGpi7uLUHswl1EeqZVETHsMvzwxM+UQQJrYho4XzQIXIMU7partnnY7FAwQoKejampVyJYjzDOID/p7FrnQRrAfEtIYvejdrGu0nBwho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404380; c=relaxed/simple;
	bh=EoXK/+GRCSPa9B+s1+CqZKcm0++9gFRWdVcWk+vSczY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUAxcbZ4DgsCQRaqzzurcAAcIe9QAnW8093l/KXK9asKPOJV5Fzqvrp2BLngM3u8eI1XxOV8RPVy8fNaIgMQ9bolm789IpyEFfqiHVBvsaoQ5TMLx6fZrF7azAf9QP42CBUNLBBW5+GmpTaj0JRezBRAi995H9y0vY5WFENO8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1ex95+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9805EC4CEED;
	Fri, 25 Jul 2025 00:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753404379;
	bh=EoXK/+GRCSPa9B+s1+CqZKcm0++9gFRWdVcWk+vSczY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1ex95+Uh+/wRjpfvDw9QA9P3sCYrh6qPOE+FZ0oobjZMa3GYkCT79Zz6pAJUf6ym
	 kr/RRb1u5WYPSOEhGbXfCqUT4bYBAjUn5tgh1SOI1YAZXtFhJUa9f8+IZRa0vmgJvj
	 ydJoIVHv0HiEccs8OSMxQbkzd+l6Add0TX3VwVtVklpoh9b7Sp+hf5NsRUvoBZh8K/
	 g0H0fZ2+lDy7G4r0dJEWE24NbXar+F+4SMrD2wEedtX/TB/kPC9bkDKlgtK2JpX46S
	 nVuLzFXy6c8iHHfVPl0YY1TySZtmsqT0/uc2Ljx7C+nxBVCjj55ZH1dneldbmfYIYZ
	 chTGkloEb75Dg==
Date: Thu, 24 Jul 2025 17:45:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v4 09/15] fs: add fsverity offset
Message-ID: <20250725004529.GG25163@sol>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
 <20250723-work-inode-fscrypt-v4-9-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-work-inode-fscrypt-v4-9-c8e11488a0e6@kernel.org>

On Wed, Jul 23, 2025 at 12:57:47PM +0200, Christian Brauner wrote:
> +	/**
> +	 * The offset of struct fsverity_info from struct inode embedded in
> +	 * the filesystem's inode.
> +	 */
> +	ptrdiff_t inode_info_offs;

It's the offset to the pointer to the struct fsverity_info, not the
offset to the struct fsverity_info itself.

Similarly for the fscrypt patch.

- Eric

