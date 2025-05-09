Return-Path: <linux-fsdevel+bounces-48580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6714AAB1168
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFA998543A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE528E594;
	Fri,  9 May 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtoVJfi0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A196228C99
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788568; cv=none; b=WZWRjNJAcM4iB7OR2XeUb2Rok5Yta1oCBT5fxYqP1l0YG+ggkDF1Dre/90AYZO5Y7mZhaHMXLTOHRA6Dtjrf9X6uevyGCZk/TccwALEdQjOcdnpPK01bzfJI/Koc30ne0UwRAA0tqjeinJHbbQPRcvvC0FrEzOTxkP1Tf/w9JBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788568; c=relaxed/simple;
	bh=IbBPHAXivCFFLZjWVbWCOMuil2jNnFck1yVqVqKNNnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWk0900gkH++lR0SDobnO6GZmJAqtgQ1PHT5y6E1cN/6tlNL8l4KuXIYRuuzkoWYlRpB4DCmtwGf4oNRntzk8MxDz15LAa4S5UtU6BzRhUgL0ADD39T11t9V4FFPxUD68wKIsqUTGMYlZgO40VRBFjVbV27/5mdM4fSKs/L/RKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtoVJfi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE77C4CEE4;
	Fri,  9 May 2025 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746788567;
	bh=IbBPHAXivCFFLZjWVbWCOMuil2jNnFck1yVqVqKNNnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtoVJfi0zuxE4TaiZO8gNuQRrsNvePckplK5//iN3lehGCrBU0D87ziOfeExuTkAj
	 lxEqnmPlQcRhMKMopndegl7p7BtFJRYyuw0nPie7BL6yvwQKtUoX3MQxHRvy7m8weg
	 bhmE+oZNJGCBLFDws5B2khVIGnUji7SU0GP2UrP/CLS2T3a8KrS2V8ELIhqYqusdvq
	 vXEs3NFBKIdD8EBrVe0uEyvQICrnxTf7KTp6hXTzsIm6cw0ejw6KohizSZYj0896he
	 t/aAgykHnnX2/qKt5vvCftufUOEYY/Kkqqbi37OLtQB9+W8rj7SJGsIj5kiG3YXLS1
	 4F/EpqMx53Z5A==
Date: Fri, 9 May 2025 13:02:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] __legitimize_mnt(): check for MNT_SYNC_UMOUNT should
 be under mount_lock
Message-ID: <20250509-saatgut-zweirad-3cc51ba0bc0e@brauner>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
 <20250508200053.GD2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508200053.GD2023217@ZenIV>

On Thu, May 08, 2025 at 09:00:53PM +0100, Al Viro wrote:
> ... or we risk stealing final mntput from sync umount - raising mnt_count
> after umount(2) has verified that victim is not busy, but before it
> has set MNT_SYNC_UMOUNT; in that case __legitimize_mnt() doesn't see
> that it's safe to quietly undo mnt_count increment and leaves dropping
> the reference to caller, where it'll be a full-blown mntput().
> 
> Check under mount_lock is needed; leaving the current one done before
> taking that makes no sense - it's nowhere near common enough to bother
> with.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Thanks!
Reviewed-by: Christian Brauner <brauner@kernel.org>

