Return-Path: <linux-fsdevel+bounces-63474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B0BBDD36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599233B64B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424662676DE;
	Mon,  6 Oct 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgJdzb/4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F57212569
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748627; cv=none; b=tklkW04QiGP2ghkxkzSs33cclGOvfLwVK7LqCji/H12yfoN+KTM9WPRwd4tBlzqijgCthGryi1AXulb6zx0T9fonnHrf/ZWnFOR6bWOgyVEAcY8l8Ut4lipSJx2nZ8JJyA8c1VCT8Js9CiZD9GMad9oxHrd4pyCZY9G0uVZckc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748627; c=relaxed/simple;
	bh=Rx2ReYS2wYTkDL8dB3SRW+8m4lgK9aanrbr9NDu7dDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clHZNFRvEVmibSD9nJwS8pjGMVSiLUIlhNDe5ue/e18lSlbT6t4A250uhtk14T/vAe2IXOJGujf0O57nLfCYccj11TYHCQQwZfDbOOpRSFnrphYDsp93KTgEw6ZTVzOqZn0c6+rUHlQC4Zg7fdmwhbZish9vGqItED92rzkWU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgJdzb/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB52C4CEF5;
	Mon,  6 Oct 2025 11:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759748627;
	bh=Rx2ReYS2wYTkDL8dB3SRW+8m4lgK9aanrbr9NDu7dDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgJdzb/4UzejDFkdoeq/Iaz6/QMbPPaI2/Xj/vZMQ0aXp/XjrUsuonHTIsW7/8TG9
	 MKhoa3x7IqLygBq1luI1ZxIuB6BNzKQxypm8EUCwGGG9j1PPUteoXVghrsBAVEbEWK
	 cSWVCuUzEEqEsgjcx7wiArypZRJoYC6KfbbF8Vcod0xgwZob5imoQue8cdn4jE9pQw
	 X1bm6yifxWpAoTAU3QQFpISC+4hwgZW2kcGLzbAKK84FbPINjgMy2nBZT1SWaz7bo6
	 09ipuMoJvNhuFuy/lOrhx4FxxfAzfjLxjITrZeZ6L5DZBHFvAxsMagTErPfNCng9wO
	 FmtIFnDNXbaKg==
Date: Mon, 6 Oct 2025 13:03:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, 
	syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com, syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
Subject: Re: [PATCH] ns: Fix mnt ns ida handling in copy_mnt_ns()
Message-ID: <20251006-gehasst-tulpen-ae452dfff0f7@brauner>
References: <20251002161039.12283-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251002161039.12283-2-jack@suse.cz>

On Thu, Oct 02, 2025 at 06:10:40PM +0200, Jan Kara wrote:
> Commit be5f21d3985f ("ns: add ns_common_free()") modified error cleanup
> and started to free wrong inode number from the ida. Fix it.
> 
> Reported-by: syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com
> Reported-by: syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
> Tested-by: syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com
> Fixes: be5f21d3985f ("ns: add ns_common_free()")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Thank you for catching and fixing this!

