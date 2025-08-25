Return-Path: <linux-fsdevel+bounces-59053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6070FB3404B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8001A84611
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86681F460B;
	Mon, 25 Aug 2025 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D54UhFYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A91D54E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126976; cv=none; b=HmbWDbJsOZdKWNHkkqInkTs1Xbt7EHGVM8RgKSNnDFh5HcDdlEPWpO3Qq7XsXmgx+FNoeD/lv37XP9xvp1lGEDrxND0WHzDxtDLDai2d/zKWG3/gXmqUEuRuP3CDEFVvQGkcLiqC/Jxc6MlJV16ICsX6uzqgmZjokWs6qDyF2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126976; c=relaxed/simple;
	bh=L7a0h4R7riDVbyLCur8w1vUYhfmxec+e9tlHwPgbnbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+yzjkbMCOZsmFV9UuT26rUIFedjWDF9l+CeqWxCLzLbKTukFeD0mvFSScBDco+Hm2ICjTuvRxOIffaVRa6QK7l3KV/+CfHJo1a80I17UG28shVzUKQK2WT4m1K8yZ8/yiNjOEDvjxPe3B4MgE2nlV5uImV6fWJr7AZjXlYh1pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D54UhFYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9064FC4CEED;
	Mon, 25 Aug 2025 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126975;
	bh=L7a0h4R7riDVbyLCur8w1vUYhfmxec+e9tlHwPgbnbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D54UhFYVH4ZP2o0H32KK3Ekw/IpebTy3eGbfliforlWSJXZQ//kHVkU4klQOfPxjJ
	 6PBeI1ZublZVSRm7eFYLO1n4uG3wG2pUvuAEwDICAUGN1WbIZqA38hL6jT9WJgM954
	 3Wh2qijjqDM6axHI4YQe1xf91rRukwD2yjXcwCv6hnhwkgBRsmCdil7m9Zuza3+Hjj
	 UngXwLSICnFrMC1r2jZER3h9kuNCxEhRc98g5IcxAPlMQ5uQJhy7nya8JXD1YOh7gm
	 +DbtrfqbH0mMqoQlGL2/60Z5rh3vlMOfKaT95xvELnneHFoaPJJPY+z4YWQya1vDtp
	 R1KVbBcld0WCw==
Date: Mon, 25 Aug 2025 15:02:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 22/52] do_loopback(): use __free(path_put) to deal with
 old_path
Message-ID: <20250825-vernommen-fledermaus-3917c2718ad2@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-22-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-22-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:25AM +0100, Al Viro wrote:
> preparations for making unlock_mount() a __cleanup();
> can't have path_put() inside mount_lock scope.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

