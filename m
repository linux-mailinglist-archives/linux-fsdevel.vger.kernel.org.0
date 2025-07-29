Return-Path: <linux-fsdevel+bounces-56255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C409BB15029
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 17:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EC217A800
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 15:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36975293B46;
	Tue, 29 Jul 2025 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0D+XaCe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E78C1A23A5;
	Tue, 29 Jul 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802920; cv=none; b=IaBNHp02e07lddG4CJ2fDGVbnhUZgNpUaxXAown7NMtjXAEcqzTMES54XbDoKsbaW4RhSY1GTslLDGroPykE+8Xgryc4VpZkGkPvAUZMJm0d9cogrRDnIlkMXIgiSbprSkitV6nV34H34zrH+jhZX+qmyjqhMk12jAIfy9JXK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802920; c=relaxed/simple;
	bh=imj0Xnn77C0P9RrgqOaapYr87u2R8WwKoXYbTpeH8m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiN7rZkYuG4lYzMgH976ky1JDsrEYs36Xpm44lrztLj+UBxFXjTalxMkMgZuc2HTXKwhMLrrE6Zx9TYU2DwFJ+Rk3U6ACbF3d/4FUBzZp+8bsK1SkSAiFZyJFcsM4sGd+6BzYwz8B2eZs7DcgaLzYVF75pK8oNZmMxc7ILk7sVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0D+XaCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D77C4CEEF;
	Tue, 29 Jul 2025 15:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753802920;
	bh=imj0Xnn77C0P9RrgqOaapYr87u2R8WwKoXYbTpeH8m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0D+XaCeJxQ5Zv3dlttMj4HWY3BVNGoFD6k89e4Js+oN6GkNi1cbDRzJ4a3wXtasU
	 bwZOiZw6o0+F1uyxxeB2Kt5NMxFZpvglGiQolXJp0h/UyzVgq//dsc0kNqIJ39uV1u
	 9u61tyEga4ais5JJGKMiYwUI/uKWWpUjKnJYaTmslMbiqi2602Spu7N0gKFfgmGyvB
	 my+ZnVRRYc0aMulpNzgCNiRabXR56mAZKaA47ct3rtzyGCrWe4A0yvDADhpcoyf53F
	 8IOnU9UtvU33a4zV38Oyi0cMYlbrQ5RGhPdYhLr5H3MBq4bWEAiunsQfOxY6eE9dm3
	 3lPUMRsfWk0aA==
Date: Tue, 29 Jul 2025 08:28:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 26/29] xfs: fix scrub trace with null pointer in
 quotacheck
Message-ID: <20250729152839.GC2672049@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-26-9e5443af0e34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-fsverity-v1-26-9e5443af0e34@kernel.org>

On Mon, Jul 28, 2025 at 10:30:30PM +0200, Andrey Albershteyn wrote:
> The quotacheck doesn't initialize sc->ip.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks good,
Cc: <stable@vger.kernel.org> # v6.8
Fixes: 21d7500929c8a0 ("xfs: improve dquot iteration for scrub")
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/xfs/scrub/trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
> index d7c4ced47c15..4368f08e91c6 100644
> --- a/fs/xfs/scrub/trace.h
> +++ b/fs/xfs/scrub/trace.h
> @@ -479,7 +479,7 @@ DECLARE_EVENT_CLASS(xchk_dqiter_class,
>  		__field(xfs_exntst_t, state)
>  	),
>  	TP_fast_assign(
> -		__entry->dev = cursor->sc->ip->i_mount->m_super->s_dev;
> +		__entry->dev = cursor->sc->mp->m_super->s_dev;
>  		__entry->dqtype = cursor->dqtype;
>  		__entry->ino = cursor->quota_ip->i_ino;
>  		__entry->cur_id = cursor->id;
> 
> -- 
> 2.50.0
> 
> 

