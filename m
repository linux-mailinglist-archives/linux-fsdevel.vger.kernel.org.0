Return-Path: <linux-fsdevel+bounces-48577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1241AAB1162
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D974C4B3A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1FF28F514;
	Fri,  9 May 2025 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCY+ja7y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD6228ECE9
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788510; cv=none; b=FhDWTGTbgJFvImN7uwxhyr2559JUjrhE8lmt0jX1zxZtRC9+ps/iHSxOwjOUyp4pd7a9HJheul4mpHco2dEbusRKhnCqUh5+SXPXhwH906PhKTAd/35EmO2o/EhOG9OhGG4xtU3FdnbZMy40yimnAnzncjtnDTg8xDaeZiQnu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788510; c=relaxed/simple;
	bh=FNk2tQh1MoHNjYbVhW1G30NhcU2JsP5V6nheUX2TNR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awX+oOfQtx/M1WpZAlk8luxDiSY9t59tcvuMrrrMONUhiVNy4Euz/n5h2Qzo3OVrxWEmFIa4iIpYdWrgnhxBGYogLPJeBlFvcAcex9o6RK8K+r3Cc+uKyaQfWz5rsJre+ItJX461HzuWxL5UWwV6NGKYCKF/iHRdVAucIdAk6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCY+ja7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9448EC4CEE4;
	Fri,  9 May 2025 11:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746788509;
	bh=FNk2tQh1MoHNjYbVhW1G30NhcU2JsP5V6nheUX2TNR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCY+ja7yFMH3rqrJ8sCA1KfLCru0JEOu+TCRpkaq3CKwSjmM/Pcnu1Cv0J1DgTTqJ
	 3viTqq+8le3Q1CC+rGmS1YdaFPx7mN/MzqU9ne3MNFskbyIPgKxOiF8tU/mkxCFzqg
	 4oDWiIuCz78t/6BsFwReOD7CnwO1gN7h1KLkBzRiFXmXqYcTmuZ9ONcPgfU/wpcyGX
	 K60OMSrf4Sn4Qb1Q8uUaEygOC2Y6i8avp9qEWnXIV4ASTcixixw1cL1lYjRe9Ba50B
	 PPGWU8QLAE5w2Ig8Ws7hMFI+wJ6fiHkmbbVe9Zn6bORJ2ywcpDrwj6buYI7Xl9ZjtR
	 cviFB0ZoDekhw==
Date: Fri, 9 May 2025 13:01:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] fix IS_MNT_PROPAGATING uses
Message-ID: <20250509-grabstein-erosion-5897a3698d43@brauner>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
 <20250508200242.GG2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508200242.GG2023217@ZenIV>

On Thu, May 08, 2025 at 09:02:42PM +0100, Al Viro wrote:
> propagate_mnt() does not attach anything to mounts created during
> propagate_mnt() itself.  What's more, anything on ->mnt_slave_list
> of such new mount must also be new, so we don't need to even look
> there.
> 
> When move_mount() had been introduced, we've got an additional
> class of mounts to skip - if we are moving from anon namespace,
> we do not want to propagate to mounts we are moving (i.e. all
> mounts in that anon namespace).
> 
> Unfortunately, the part about "everything on their ->mnt_slave_list
> will also be ignorable" is not true - if we have propagation graph
> 	A -> B -> C
> and do OPEN_TREE_CLONE open_tree() of B, we get
> 	A -> [B <-> B'] -> C
> as propagation graph, where B' is a clone of B in our detached tree.
> Making B private will result in
> 	A -> B' -> C
> C still gets propagation from A, as it would after making B private
> if we hadn't done that open_tree(), but now the propagation goes
> through B'.  Trying to move_mount() our detached tree on subdirectory
> in A should have
> 	* moved B' on that subdirectory in A
> 	* skipped the corresponding subdirectory in B' itself
> 	* copied B' on the corresponding subdirectory in C.
> As it is, the logics in propagation_next() and friends ends up
> skipping propagation into C, since it doesn't consider anything
> downstream of B'.
> 
> IOW, walking the propagation graph should only skip the ->mnt_slave_list
> of new mounts; the only places where the check for "in that one
> anon namespace" are applicable are propagate_one() (where we should
> treat that as the same kind of thing as "mountpoint we are looking
> at is not visible in the mount we are looking at") and
> propagation_would_overmount().  The latter is better dealt with
> in the caller (can_move_mount_beneath()); on the first call of
> propagation_would_overmount() the test is always false, on the
> second it is always true in "move from anon namespace" case and
> always false in "move within our namespace" one, so it's easier
> to just use check_mnt() before bothering with the second call and
> be done with that.
> 
> Fixes: 064fe6e233e8 ("mount: handle mount propagation for detached mount trees")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Thanks, looks good.
Reviewed-by: Christian Brauner <brauner@kernel.org>

