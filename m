Return-Path: <linux-fsdevel+bounces-59057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840EDB34063
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E01485B79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D532203710;
	Mon, 25 Aug 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgyEDlz/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96402200127
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127362; cv=none; b=XGel0hvHgOGhGWqEJXlBg7FYjBIxwIBLfPS4YXMdWC+xd+xJKlbww9lUSddN+Lvx+cVxod8ytsuHj1oOC+0ANB9pWHxJ1oHQTvgDTNiwGcSfCL7zjXPZcTM4+RVsIA46h+Ie8qttTe50LVPyYdejfPrTHAKJquKgJmvqkuiKRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127362; c=relaxed/simple;
	bh=PhLh/r6+ZkgjLmiNEYKUnhMO1xrFnyJnSoWVhHasIS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipDgOzECQm2YtnJ/MfKae+sej4VGQr89Dkgs8v/+BaAAIV6COWRPiMKkPsPoynV7Q66p1nkwkBUl6FBhk9fu0mSphvURlxUMwh8Yr40iYZzl//9wyPitVHMCCY3UdYbHJ3/r8C0RcMUnutnAhsu1j1n62rchHRxG2DsFvqgP6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgyEDlz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA61C4CEED;
	Mon, 25 Aug 2025 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756127362;
	bh=PhLh/r6+ZkgjLmiNEYKUnhMO1xrFnyJnSoWVhHasIS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgyEDlz/dLFKhjD5KXg+3fPqmTYYpJvqzJPOmpJBkWM/HFUZSmEZMSAdTnrhrX3d8
	 lB6S4xgbTrFRjs0GYp0hA+oJOKbAAg/XXdrVv1+pwoEaAxXPLtpne4LWvY/GO+2N3Q
	 AJBBbxPrXt1qxol6ileWz63Fh4uEbHQE86qZhFdoWlwfZIDFm+TVWU0rRVH1Q8ObtK
	 Ee9R7cWfNZobNeEfIHeRGWfjHISSrxm1DNxqOUfG02lYzhvbvfYX55T2XNg90s/X+z
	 betLjpj/Pum4X21oiZfYXS+NCnc90Ah2pQIeJBLFoz/mmjGiDs9jrpFVIunDaE0xYv
	 hNYa5eFNZ4Fxg==
Date: Mon, 25 Aug 2025 15:09:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 26/52] finish_automount(): use __free() to deal with
 dropping mnt on failure
Message-ID: <20250825-wurzel-zirkulation-338458103a91@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-26-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-26-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:29AM +0100, Al Viro wrote:
> same story as with do_new_mount_fc().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Ah right, here it is what I suggested earlier,

Reviewed-by: Christian Brauner <brauner@kernel.org>

