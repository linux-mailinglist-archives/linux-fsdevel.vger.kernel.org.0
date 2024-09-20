Return-Path: <linux-fsdevel+bounces-29756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40BD97D700
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377491F2487B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB3517C9AB;
	Fri, 20 Sep 2024 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEKp4pNy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB2617C7A3;
	Fri, 20 Sep 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726843048; cv=none; b=ULiUDVP3FFwNeD+1SuG8lUYhJFjYJ0PqSIaZ6jXlVeghN4gPV3qJJxEuonoRyeZfZR3T0dGMhyc4YJblO6WVarLtgcz1KtnC2sQE0EdjolLdRO5zwpcPTbqtTEiOEkcCuVcjp2czX0JFiZ+CO53MKpliCwUuCP+i2DZUFGH9Z/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726843048; c=relaxed/simple;
	bh=4MmuP1VrfpfdaU8HY/8diO4pRICsfkeZDrcLId9WLfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N10RhppkyyNDGTFn/9xdv7m3vT30/3KV+7CkOJodoeZSCtMWT8yAjjJOMsDzyC7zbmhta8FHPLNysdf7nSuQKh/yhYWs9b1QxJBukYZPM1u/Ply2CZYZ3FObAR+Kb98yB258cWbGxIPGYLWMAlGOIk1R7FZbdPVB00eC7DJsAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEKp4pNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38ECC4CECE;
	Fri, 20 Sep 2024 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726843048;
	bh=4MmuP1VrfpfdaU8HY/8diO4pRICsfkeZDrcLId9WLfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEKp4pNy/zIFKL6nxbqcOwK3IaUCNSnQUgRFFFw2MsinqXSpW11807Okxi+Gduasf
	 nUx+rSvlsR6y48Z6EW36WJhnCeWQBq84Zt1K0nHfe3mTLlTEQpJrk038A5CpNytmke
	 5rZpaWH9SpycwrrR1/NmcIg6JmItlh2RQzPuEXWMgmpDDGjt6dVJief8spE7SjQ7ur
	 ZnKzwZ/A4+qSuoozjMptzh+fBhqPQjtTr9dVmiE+nCtO5IhNlw9TUWGtwiZFA8tkb9
	 sfhLpnPV5djM4YqPxsm343lYhT12izhzb32y7fXn7D1zN876f7XDSr6pigmMOax2g2
	 tv4P33hZrx1hg==
Date: Fri, 20 Sep 2024 07:37:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Julian Sun <sunjunchao2870@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] vfs: return -EOVERFLOW in generic_remap_checks()
 when overflow check fails
Message-ID: <20240920143727.GB21853@frogsfrogsfrogs>
References: <20240920123022.215863-1-sunjunchao2870@gmail.com>
 <Zu2EcEnlW1KJfzzR@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu2EcEnlW1KJfzzR@infradead.org>

On Fri, Sep 20, 2024 at 07:19:28AM -0700, Christoph Hellwig wrote:
> On Fri, Sep 20, 2024 at 08:30:22PM +0800, Julian Sun wrote:
> > Keep it consistent with the handling of the same check within
> > generic_copy_file_checks().
> > Also, returning -EOVERFLOW in this case is more appropriate.
> 
> Maybe:
> 
> Keep the errno value consistent with the equivalent check in
> generic_copy_file_checks() that returns -EOVERFLOW, which feels like the
> more appropriate value to return compared to the overly generic -EINVAL.

The manpage for clone/dedupe/exchange don't say anything about
EOVERFLOW, but they do have this to say about EINVAL:

EINVAL
The  filesystem  does  not  support  reflinking the ranges of the given
files.

Does this errno code change cause any regressions in fstests?

--D

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

