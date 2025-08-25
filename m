Return-Path: <linux-fsdevel+bounces-59066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19373B340BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FED41886295
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8766DA927;
	Mon, 25 Aug 2025 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlbQjBpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71934A0C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128695; cv=none; b=kxIpB3oeV2iEV9GpTuMzQLaw28n57uVxt8MdO9+Fi951C8bStYAba5eIZokurBkaewDPIyB5PvrivA6cbmhoMoefIovK+xH5Fd/BmKeTWp/H+S9ivIrG+HS1HcAjNxnLbi1D5fI5O+YZUPn/BCxIwyebjnsd2rq8gR60bUb3jP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128695; c=relaxed/simple;
	bh=tf5XtWSexVvZP75xzFYi2jFKEz5Q8Dk3gkD4LpNZ0AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdWhcD6CvwqcWTGpfJG51V6ZWPW2/Y3FJa15pvBRhWvI2I4j28UwB22z80kVj/bwn8xyKg3yvUR/BP5IOgQ/57jICTsffNvD1baiaNN1oqoPvg2U98zfLXIC4bdw0fdjnIeOUuNt03y5DgB82kYd4OqwDrFnmWTGj98XY7isZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlbQjBpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E17C113D0;
	Mon, 25 Aug 2025 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128694;
	bh=tf5XtWSexVvZP75xzFYi2jFKEz5Q8Dk3gkD4LpNZ0AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlbQjBptDSBBOw5owTPXDyrXOvTgmR3xYrjJ/5WOXb2U0gKEuCQBoeAMIOQX/NdSU
	 SqqCR3vncVpd9pwt70NMFtPE7nwBpeMt2XiZ2uDDZ8Q23SWsVIeCtUAyZOGebWDhHt
	 BD6lASXgi8Be94EHt4vwOvSDx8VHGZIggwJ/ol7yVS9elZ/izmJsSCSFCwlZV+HYsP
	 FkVVrADY9LBfelQNmY6qUrZPe/OmQnXR3HK+KI+R5DvurwhilJeZnEgzbtDZmAmKyG
	 n9pLXxp+heXdI+ot/vJzZJo19XBNacmugwoTMdfrIzxABsU71I46nd+1T0J6TZnYqe
	 4ctIg6abWUWNg==
Date: Mon, 25 Aug 2025 15:31:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 43/52]
 do_{loopback,change_type,remount,reconfigure_mnt}(): constify struct path
 argument
Message-ID: <20250825-backblech-hiesig-e9da4e25b6e4@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-43-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-43-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:46AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

