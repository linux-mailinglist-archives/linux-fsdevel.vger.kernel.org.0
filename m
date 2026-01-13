Return-Path: <linux-fsdevel+bounces-73464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE942D1A26B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3BC730940FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8407B38F258;
	Tue, 13 Jan 2026 16:14:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA743816F0;
	Tue, 13 Jan 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320887; cv=none; b=JsBjnSC4FbUu7I4z9gJir+bGhsaOuIzX0SQuOsvOcyZplgfhtDOl9HdNGBcQ1tl27pSN1shmkmgD5ZfHTPEljXFzJhsHwMLed7YTDTwsOVyR+j1/Th7m3nYrhd93fvq6tNS3J7BJA/aJMr5ye84gUAHrhiVBNDd8iIrZ8WuaAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320887; c=relaxed/simple;
	bh=/WhFFKmi4vMeX8//VkaPq2CQsBARcTawoElEjGkX2NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj/Evy5zaxb42RCc0EkNUfIShHRAhk/vsmLej05pbso7gIsapkYDPq+2Ut79i3MZ3RlLg8JWeA1BcYfD1I6HfWkwQk4lliSYEIn+AhtODBXg3Kdn5M/SvIZFF0eQlevH2dzN+w+f9WEkHNrvAJ55GP/9S/GtaM+R8OBcen6jAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A3584227AA8; Tue, 13 Jan 2026 17:14:42 +0100 (CET)
Date: Tue, 13 Jan 2026 17:14:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/11] xfs: convey filesystem shutdown events to the
 health monitor
Message-ID: <20260113161442.GE4208@lst.de>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs> <176826412835.3493441.7037634047704901774.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176826412835.3493441.7037634047704901774.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 04:34:07PM -0800, Darrick J. Wong wrote:
> -		/* mount */
> +		/* shutdown */

huh?

> @@ -497,14 +498,13 @@ xfs_fs_goingdown(
>   */
>  void
>  xfs_do_force_shutdown(
> -	struct xfs_mount *mp,
> -	uint32_t	flags,
> -	char		*fname,
> -	int		lnnum)
> +	struct xfs_mount	*mp,
> +	uint32_t		flags,
> +	char			*fname,
> +	int			lnnum)
>  {
> -	int		tag;
> -	const char	*why;
> -
> +	int			tag;
> +	const char		*why;

I like this cleanup, but it seems to be entirely unrelated to
the rest of the patch?

