Return-Path: <linux-fsdevel+bounces-52719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE4AE6029
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A06403224
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A982F27A123;
	Tue, 24 Jun 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKCIYozF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B719CD01
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755918; cv=none; b=S10WiHmpNK4aD6X0R2A1dl+0iYSsja/JJ6gKg9VhJOmZ0XjXXJJ5MuJJieIO+3bS9M8y/sz7ehln8xnkZCn7E7eAGa/ZbXRmDQtM9UMt4n0DeeJiUxk/9DXrJGjmFnUJQpYDItk5+JyuAyX9ojKSjY6GbV2SuXixxGtf3kk0vhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755918; c=relaxed/simple;
	bh=gDN9dGo/OmCBZIz4G08Hhp8ME/29Kt5PDU8u+PUS7xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/FSm1HLE3cz4hLdfdRt5kNQDIL4DuaQ0ceh2YwGsyCThu36tWToUs5J5APtkytIkDHNU/RYljone+j5T3MIoPYRDrLtaBVt4ykkh3TDK5VhkEXiTm7xJyhdHu83yACcY74Sr+n1VIO/TciTvUli2TNHqdA6UsDKgc3FEFoBWEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKCIYozF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09C9C4CEE3;
	Tue, 24 Jun 2025 09:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750755916;
	bh=gDN9dGo/OmCBZIz4G08Hhp8ME/29Kt5PDU8u+PUS7xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKCIYozFEaFNliTf2psJD7AOWQQHsAM3a22QB+If/Nf5BMlRjU9rWTEVfdpfzNSTy
	 GSBjJlQHP6HUx7XMU8ZcFKSDILn26REzILwpFzxDIl+ZwDW7sG5qc+2Yn21RRmYKD5
	 KiZZ96+wC0KFPNo9FqfQm1SHecyvag1crpik9Grz36OIjXnmZZ8CLjhgLaiS3rtSIU
	 07+jnlKTObO+AgZgXP+z5U+ezMg5jw1mITuXLvBHnxUBfZpPyXZQMPHKmwO4/XH3o1
	 yYSRCNjK3xxv3K+s1bgXRLDjFv5XpwD5wAGavyA8WHpuCSfcyHPnQB1W3poKz9LUtm
	 Erz+xmzVcXXSg==
Date: Tue, 24 Jun 2025 11:05:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] userns and mnt_idmap leak in open_tree_attr(2)
Message-ID: <20250624-datieren-zertreten-1adad2cedd63@brauner>
References: <20250624065746.GM1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250624065746.GM1880847@ZenIV>

On Tue, Jun 24, 2025 at 07:57:46AM +0100, Al Viro wrote:
> [if nobody objects, I'm going to throw that into #fixes and send to Linus
> in a couple of days]
> 
> Once want_mount_setattr() has returned a positive, it does require
> finish_mount_kattr() to release ->mnt_userns.  Failing do_mount_setattr()
> does not change that.
> 
> As the result, we can end up leaking userns and possibly mnt_idmap as
> well.
> 
> Fixes: c4a16820d901 ("fs: add open_tree_attr()")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Sure, thanks!
Reviewed-by: Christian Brauner <brauner@kernel.org>

