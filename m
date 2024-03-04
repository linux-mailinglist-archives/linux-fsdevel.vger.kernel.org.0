Return-Path: <linux-fsdevel+bounces-13454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4308701F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7141C2191D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD23D55F;
	Mon,  4 Mar 2024 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="J775hL3H";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="FPwlQoLT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829593D542;
	Mon,  4 Mar 2024 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557375; cv=none; b=U49Fg7Uu3GC1pyVbMLUH9S2knRsYvxhD956dKBjIoqeYRTgAG/zVl3CzOZcgBwnPWUoHFo3u4cvd281WvZFbNxm33VVPEMZWHoT264J7CqR5k0EKHNY+Qq4kBEZEFtE5GBRiMoVEA/3Xr6afTjeQJcqMugVR8SwqhKPGOrT271Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557375; c=relaxed/simple;
	bh=B3K21OgLoz1W5sfrl2E27+1K7ioRlos5ZCdVDYriGdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhpjWOzOlG1tkPfGG8/U1i/c+LPPQFGo1euiBoxxWP8IrUy+kO7vcNXc9sVipZcEsbtJXP2pZFkMHSLNZhXVzIhX4rJy6yH2weBjWOyW/AWdnCzQSp+0QEbSC07qgwbhke0D54GjZN/DCCOo9wx3JrhAAkxO+sYC0fgpU9hULGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=J775hL3H; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=FPwlQoLT; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 2D2E7C01A; Mon,  4 Mar 2024 14:02:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709557372; bh=8rQDbUg4RJu/7k91VfbHeq15VU8NDHILv/3Ta8lMlPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J775hL3H666TqcYafAW6nPLUlBwCi5BPIgQGaRMNENlN9ZxRMIl4NkyE6828ENO//
	 3UtRFgfqc9kjt2i0et95Y4VVq/giBtAAqVlITPkbgUT+MyI6TcQ8F5doWclmzbOoZ+
	 0j2CMxby+i71kzPIaeJXMC+MBUcq+/kSIHLIwiJ2HgFKWBESfh7mUO3HtOkWPE0R2W
	 41TiYBY2lgkV9blyfJMkDwmkEaBGjWwp0xkZSfON7dHcJOsAYLaT/X41ADHHZ4uidh
	 q8+fD9iKBYvY0YyYK8pNZsFZHCnW/jQaZkyKzxYH3C9rM8cABs54cXIuRGUuq6o0ob
	 BlFrLUNw4MYuA==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 9D91BC009;
	Mon,  4 Mar 2024 14:02:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709557371; bh=8rQDbUg4RJu/7k91VfbHeq15VU8NDHILv/3Ta8lMlPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPwlQoLTbRX1K7l+u0Ctk3mgREi6ZbFt+BJ72Fkor1L122gf3OZtU0UmEzyX7GIWd
	 QnCtvmqLNkbq7LqoKcptWW0WXpnWBcmgTuzGn/ykKgAlQZJW9XS2pzfuA/4hLwIWwN
	 3gKlMKl+GS2Szu+gfg/jns+UTybgpmhTR37r8ikiqZF0fvPjfxQsLf1bVuvzghnH+M
	 wqZvuwOTQnGYdvZOh9VuUIDGWfOcWK3bSBJ7qj+BaKIi+Corxg9wWvK6l+bicANhhl
	 U4cpe3/ohhioj5HUh2Z2yQwOfpPxUghBAO5Cr9jwFKZg6sPk2lU5j4OGy2+rZGEBQ7
	 TmaANxm+Yf0Cg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id affe790f;
	Mon, 4 Mar 2024 13:02:44 +0000 (UTC)
Date: Mon, 4 Mar 2024 22:02:29 +0900
From: asmadeus@codewreck.org
To: ericvh@kernel.org
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Subject: Re: [PATCH next] fs/9p: fix uaf in in v9fs_stat2inode_dotl
Message-ID: <ZeXGZS1-X8_CYCUz@codewreck.org>
References: <00000000000055ecb906105ed669@google.com>
 <20240202121531.2550018-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202121531.2550018-1-lizhi.xu@windriver.com>

Lizhi Xu wrote on Fri, Feb 02, 2024 at 08:15:31PM +0800:
> The incorrect logical order of accessing the st object code in v9fs_fid_iget_dotl
> is causing this uaf.

Thanks for the fix!

Eric, this is also for your tree.

> 
> Fixes: 724a08450f74 ("fs/9p: simplify iget to remove unnecessary paths")

(careful if you rebase your tree as this commit isn't merged yet)

> Reported-and-tested-by: syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique Martinet | Asmadeus

