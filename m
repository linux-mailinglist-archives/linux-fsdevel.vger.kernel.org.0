Return-Path: <linux-fsdevel+bounces-14394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E7E87BBA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 12:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F48A1C20D7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6BF6EB4C;
	Thu, 14 Mar 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+O4TJjq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8441A80;
	Thu, 14 Mar 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414178; cv=none; b=UU6tjPhQxIKavpC/B7y4FdnG10pQaSP/AMYtLbKHg1MSD/TmUghU/cn4KMu4LxlLgL7gBlKH4AEmTe7+eBV2r45lHExwHLHO6WnDrxyYoZvdtHJHTZAS6HiOAkc25q8+wgB4ad4qc2EV5aJyVqSNucjxcowf/kyqDrDU6FFrRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414178; c=relaxed/simple;
	bh=ypNQm1x/wVwp5seE+51R8mzKk819kWlnKERf+xaQDx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gkp/rs1skGoP8OU34T0XZoqkhOVTDtlLRHAHw8T12EQ9U6sGaP1H8HMTD0ZnqSz6XwJi4rUPPou4YNzoB740iZDb0pUJ+31R5UnYgyjFvgkmxbVPCvHkJqZsCT1tUs0wI25fTv/gx7qZ6PXQ0nvpJYiGUIIs0TYBCkeQShO4Dik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+O4TJjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8102C433F1;
	Thu, 14 Mar 2024 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710414177;
	bh=ypNQm1x/wVwp5seE+51R8mzKk819kWlnKERf+xaQDx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+O4TJjqjBbPI4/XeuAwdl/w6GSAwBAEWOaOLJJCLPJkqv4wmViAmFAKczVYo1NXw
	 88Sl5KqkDP3upeE+iTBsSz69JRF/ZaWnMoIjQFDVNzlEv0AdOxAxlOak/YPTcARlSc
	 apQ+EE3n6BXCXQspOBvyZr6H8W5wkPZngnpzZISTT9P9Wp/D9lUyF86LuZyAq0rwTe
	 ZypUH5fgo91dAgzFL/neRA84T2VepVPwFX5poxMmCmjP3/K8vDrK6VqPGGkbu7ZA65
	 oe7BQAPk6b/lHyR24yffYE0orwvchexXvpEA/o+IB7BXLVQ6AcFVIMeUuwKSLVLTHB
	 6hcy+BlnCWhFg==
Date: Thu, 14 Mar 2024 12:02:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] libfs: fix warning in stashed_dentry_prune
Message-ID: <20240314-loten-ankommen-49028aaadff6@brauner>
References: <0000000000003ea6ba0613882a96@google.com>
 <tencent_938637BC4BA674C576F366443D5336109609@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_938637BC4BA674C576F366443D5336109609@qq.com>

Thanks for the patch. However, this is already fixed upstream already.

