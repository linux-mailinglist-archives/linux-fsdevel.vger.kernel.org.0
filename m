Return-Path: <linux-fsdevel+bounces-59051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A10B34043
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806B1178A10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821571D54E2;
	Mon, 25 Aug 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcIe1s1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE60827455
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126932; cv=none; b=Zgu5Wb7Fvh4THFRHlGsD4AJoiw5n5f7Ln+7pHPP+nTu+J2uQTy5Th6dbYyHzD2I58bl7mBVxTbGs3U/m3VsRpLGozn49/sJxBfPX9T/SjcG3G4q81i7KVMnThNJ5eGkSXmJIyef+BpEePI9i7Lt76jT2AXPN1XvSJZIxSqsuvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126932; c=relaxed/simple;
	bh=FaFuEPwjH1P8kWnhIL5ATPIMZEunr0mxs3o80GVkeec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2bLVCVRN1X0ROfYeoPz+R8WTePSEW7CfYlJe0n1K4trF5fKkyk0sNjdiHkT4FBbZt4PPf+I3MQ+qWw1khAv/c0lhvAJDqMHj9gF1E3DD91iynBNB9Sh9uSBxfNMzFgCxTUueB1L9+PO7gCh4f0QDgoiq6T/VXXHIpOxh7vgfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcIe1s1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C688C4CEED;
	Mon, 25 Aug 2025 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126932;
	bh=FaFuEPwjH1P8kWnhIL5ATPIMZEunr0mxs3o80GVkeec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcIe1s1yNJTqXZRCxBdChM1gVIyHn6MBP6LZyHA8m0IgTLNpkPdt3ATEIXjBwl+6d
	 wn6FOlwYuUf9mGW2JJDEHlLXcdDFvaFLDYEKTJub43DE0t9ZIn+QKpelokzp+LSAc5
	 1zwv8If2RKJlkft07hZfmtCg9yALjvxd5XVcSvgEuR64s73fj+AmdGAc4QnpyJGaqj
	 fLcraBMHa04StS6IvPWSELAhDWGqWOyOe7C3HpnrwI76cEas1gRU3XfrGPLcCatcvO
	 B+OfquPP5bdjKjVmytP4merG7/TF/TsD7HHGxmK6M7GWRXc+53Q9pp3L9G94shzGS9
	 MlDrNSahd2e8w==
Date: Mon, 25 Aug 2025 15:02:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 20/52] move_mount(2): take sanity checks in 'beneath'
 case into do_lock_mount()
Message-ID: <20250825-wahnwitzig-komponente-3b4b7d36900a@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-20-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-20-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:23AM +0100, Al Viro wrote:
> We want to mount beneath the given location.  For that operation to
> make sense, location must be the root of some mount that has something
> under it.  Currently we let it proceed if those requirements are not met,
> with rather meaningless results, and have that bogosity caught further
> down the road; let's fail early instead - do_lock_mount() doesn't make
> sense unless those conditions hold, and checking them there makes
> things simpler.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Well, do_lock_mount() was already convoluted enough that didn't want
that in there as well. But I don't care,

Reviewed-by: Christian Brauner <brauner@kernel.org>

