Return-Path: <linux-fsdevel+bounces-59032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C13B33FA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2599E7B38EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118FC25A340;
	Mon, 25 Aug 2025 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yzceo8HW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75311713
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125311; cv=none; b=VMH35ijRZv1AX+IeAvAeAjhdBxESGBqx05SKoXVdCxU6loBNYokN36HUw8tQpgzDD0zxYiZ5BSTR+AQPO/QUT6uJ3oCbYAivmv/xi4g68vBoYWzLL/3uvBw4aU6xkennTvtYkB0J8yo4ssO2Eq9VKD1ahGGyMaujCOvRIwlRomk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125311; c=relaxed/simple;
	bh=f52gmChvSaEKFPLRW//szbjKTARe9eiyYzeDPWqlp7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBJ0/Cg6K2UWb0bUuPFZuX5uKbK9Smdgemn3LhehCC7BcX12eXqtpqmClDmGi31qs3KwMNyAkmo6DRld9SojN1zUHyzhCXF8bVH0h+0FF2K9hX4DWQmSxbWz2X7HbofKA1ejSzvw3WrwxaB93A59+gwHCVMfNrfKHipWla5VdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yzceo8HW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E98C4CEED;
	Mon, 25 Aug 2025 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756125310;
	bh=f52gmChvSaEKFPLRW//szbjKTARe9eiyYzeDPWqlp7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yzceo8HWGpb6saG61FAz/8BBah2hTv16bSC7r6YchH9anEoynonTV4iyKNXbTO+du
	 u9+gTl+p0fbg6P172faI7Z/YKM8O71eIVH7h9mZ2V5tGYNZ9/Ozx1CKVgHf5V0sLKW
	 KleObI7+9RVmS98qX8IkkfcCo+ZKudspCGIduSvlC63wnH8krMN80SThVByVvouF8P
	 oUCt7oVmd4bwEIx5U9HKpDr0PgtUCySu6jdowMHdeQeN6zkKrXLknNDo1IqfyDoNdO
	 /ySogW6es8QBWIll93Plg8riWSuelAgZR1HVhOsINCs3GMBcMiha7O0XnPrOLKwlVH
	 Jdt9/46TMJSJA==
Date: Mon, 25 Aug 2025 14:35:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 07/52] do_set_group(): use guards
Message-ID: <20250825-sauer-festbesuch-1b7766854b12@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-7-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-7-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:10AM +0100, Al Viro wrote:
> clean fit; namespace_excl to modify propagation graph
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

