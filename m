Return-Path: <linux-fsdevel+bounces-61338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8315BB579CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C9166463
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232DB3043AB;
	Mon, 15 Sep 2025 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8oCrFVS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA3C30216B
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937826; cv=none; b=WZzlFDD5SpMjZbUf4+NKPzxCzuoFA7Q1bOok9YA6CBfBkzaDpzej/DZV77tfez6jvg0ybejM7XK4FF/tnjjGkPydM9me5gSG2mKnAv2GMlQHKVDnpG9nIRvjxHQbj7GopKxB+IERbWn5l+wR8FuQf+yZEjmTxjcv2p+MB6Rfwhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937826; c=relaxed/simple;
	bh=86bXeOMAFiqoxIPmHszU3TPon/2EO5RTGyZwDv+ARDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+bVn4VyVuhrSUi6GReEo97kPZV73PBwWLwMTamt5fBH/V3QyiAwPptFMnQcRSzhF7P0fDGddLl5lmkEwGAAdgJpFe90a82CRs8bFm/YUiYK9OrrGjmnv8ASqc+v3EfmBf3dfVTh5xfAVBeO/I+IGI4A/KR+p7ucptlLoakEdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8oCrFVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418A4C4CEF1;
	Mon, 15 Sep 2025 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937826;
	bh=86bXeOMAFiqoxIPmHszU3TPon/2EO5RTGyZwDv+ARDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8oCrFVSXtPvOdZBZyQeuSxwBNLU7hNvXsIEsh4JCyoaKgPdy0cIIR92o7hrH13fY
	 9g3JxuiM+DgLu/wSv39xBCWPRbT0wljvMjguRIK6YOgoLSgaQK+bMXWPQwBJBprXHv
	 aLcMEaPxemd0ecWR+9M0rQXM1VOw0hEZDH/Jd/90BdgnTskZXcKK7bubCGWM8Zj92a
	 IyHIGUgDA1TBZUk4gxBP6vyujQA+dt4RWYRcF1MU3XakFi+xrkngPBkKLjq4lf8otP
	 85iskCuK37ftc7A3TetMK6B7ZoJtsTsk2mopkyVMuInZ8n9J6I/BgAaP0OENnjLiGp
	 y5olXemPPS7hg==
Date: Mon, 15 Sep 2025 14:03:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 10/21] ksmbd_vfs_path_lookup_locked(): root_share_path
 can be const struct path *
Message-ID: <20250915-ranken-glasfaser-5fc369576d8e@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-10-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-10-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:26AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

