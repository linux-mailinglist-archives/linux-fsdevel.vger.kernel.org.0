Return-Path: <linux-fsdevel+bounces-69098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B0C6F2C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E8365029F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3CB35A95B;
	Wed, 19 Nov 2025 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg1Dom/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBCA31B10F;
	Wed, 19 Nov 2025 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559795; cv=none; b=kaKDLWA+l6Tc5paxgXJ+2HAdjzXFClFzyiflcNO89hK3pueojrr1RVZPR4hf3k9pTEwJE+tfThSn1JtSb/qM7h+iNdsl0I3iCugPauBD6tNkekboy/STfPCJOLh7GfbAYEyM/N+01OT8+7xwtOGB+j2vXjAAWGBnkrdWg0P8nlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559795; c=relaxed/simple;
	bh=B2+t/ydmQGd9jARd3qvkhHqftY4Xz7xPvMnaCDhBov8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFOqVtZKS4rjs65ZgSZkSlfntf85zp5gAMqZL6ec1dGUQC6QryrMbwNGkEc6npPfaDcdKBvveTuZ7F/kUuZEHt+nobj2VwaigO3sBIOhpQceJk+xH4PkWkRd1S5h1xFPyvgfk7ynfzUL5B9HPNR85dLY+CDElfyt7OPNEUQMcP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg1Dom/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347C4C2BCB1;
	Wed, 19 Nov 2025 13:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763559794;
	bh=B2+t/ydmQGd9jARd3qvkhHqftY4Xz7xPvMnaCDhBov8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tg1Dom/MdQWOwV2cPF2GX71c0rTsXwj4kalpxyTcDf/RoYee8cJm7CQ4rbvjc8WG7
	 AQKT0q+C6GI06J32ncJ0N0adNKFZrdidKfDqhYR1uWFN8so4fB3QXWBr3n2gb23At6
	 TCArIWSq9wZN3Qp2PUp/xYuyrT58pEfI8twWd07IC1Oxn4W76kbCw8VgqcuYpBLV1x
	 Gn3tSHg6xPQ/kCaNZU333Egyn2JZ24tdA58U8eK137aPR1Y808tUA0HdnTfXOgz1cO
	 Ez5m01KlXuCCyQULsH8Mu8gRkHifssFtzj5bY2iOko5h8cARghFmGx2AIdekDNx68u
	 /lVqDcF6Wc10A==
Date: Wed, 19 Nov 2025 14:43:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com, 
	frank.li@vivo.com, glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/super: fix memory leak of s_fs_info on
 setup_bdev_super failure
Message-ID: <20251119-leitmotiv-freifahrt-c706880c1f0b@brauner>
References: <69155e34.050a0220.3565dc.0019.GAE@google.com>
 <20251114051215.526577-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251114051215.526577-1-mehdi.benhadjkhelifa@gmail.com>

On Fri, Nov 14, 2025 at 06:12:12AM +0100, Mehdi Ben Hadj Khelifa wrote:
> #syz test
> 
> diff --git a/fs/super.c b/fs/super.c
> index 5bab94fb7e03..a99e5281b057 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1690,6 +1690,11 @@ int get_tree_bdev_flags(struct fs_context *fc,
>  		if (!error)
>  			error = fill_super(s, fc);
>  		if (error) {
> +			/*
> +			 * return back sb_info ownership to fc to be freed by put_fs_context()
> +			 */
> +			fc->s_fs_info = s->s_fs_info;
> +			s->s_fs_info = NULL;
>  			deactivate_locked_super(s);
>  			return error;
>  		}

#syz test: https://github.com/brauner/linux.git work.hfs.fixes

