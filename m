Return-Path: <linux-fsdevel+bounces-68476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9C4C5CF47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 834763583EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE3231618E;
	Fri, 14 Nov 2025 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9Ef10ed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC15315D3C;
	Fri, 14 Nov 2025 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121335; cv=none; b=HLXr5EhZ34LusmwRxDzfMfJnAcSysuMTvOxsUxQaekrX5jdI7O140NplPu7xmvPx2RvL/I2/O9O81IGstbLIxT73dGUhb02YrPkBisSOs6Sfjx6ligs9d/Q/HScYKv+zgo7oFmmZ1RC39JzaXDYxHGSLcvVCCv02DbU3vz5HQzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121335; c=relaxed/simple;
	bh=kWS2g9uobQcSMWaRK6+f5epOJXTydewjCkz/xa2Ty7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq30+X1SQRdtQ2E3OrARl92KWk2DYTqnk/e3Pe00RG3YEzb7MrqsTuN0VnRtnKXmCNVOsy+275+IfEiFC/SaDY4YTNi6misxkKTfh4AFF6QTJqMelkWK7b0GFV+JVwCe5hn+ChsjpaSdMpUTSyLvbmMAwN0R77zpiYcA3e5sI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9Ef10ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9839C4CEF8;
	Fri, 14 Nov 2025 11:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763121334;
	bh=kWS2g9uobQcSMWaRK6+f5epOJXTydewjCkz/xa2Ty7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9Ef10ed7E939LBIiLNNQNbW7Oyd2imP7WKdua9Otju1fUrVYOtzjBISL5g5zr+rm
	 Zi7Qr2mHSc1JTfAPFod0BpCTSPnNvzPj9s0ZuN85ofb2gHSIfSYEHHcmVp0jfDFVVT
	 xe8ZywgTNLnuHuPGGaVxDlB3LDu2ih31qWui6w6AvwdxH9uX2xxkmwI7veKHUWkOkW
	 n0pbyvr6mshNdtwJUEVTCUmoRLKIgRjb16mEVEIW+Mfxa4p2Q77ypfYsqxkniYvq3B
	 ysCmZjRU4njJQbQ5bI6twSnD2JHDBk+Gtf4froO/wbfCeoSdp3ymdXnIcLNZ3G2Fex
	 XWMsg5D0qoabg==
Date: Fri, 14 Nov 2025 12:55:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com, 
	frank.li@vivo.com, glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/super: fix memory leak of s_fs_info on
 setup_bdev_super failure
Message-ID: <20251114-raubt-benoten-bf2d8f2317b2@brauner>
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
> -- 
> 2.51.2
> 

No, either free it in hfs_fill_super() when it fails or add a wrapper
around kill_block_super() for hfs and free it after ->kill_sb() has run.

