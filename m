Return-Path: <linux-fsdevel+bounces-2512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1C77E6B75
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 14:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC03B20E34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA311DFF2;
	Thu,  9 Nov 2023 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju6GFo+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE71DDFC
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 13:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EE8C433C8;
	Thu,  9 Nov 2023 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699537703;
	bh=qOtJJVAMG/MLh09z0hjgMluvi5i19gCPgp4fxqWW+YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ju6GFo+B7QjYc5oe7ssrxNDBrKPNEf6e71FtPF/GfzstGjeOtoYXuRh3ctv1ShOAn
	 D+pSG55Zteh4Wue7b3dXvO669loP4LPgNQvt4afbXYywWYLulBx9Wq5NobkwrDunhK
	 hcW/Qq5KFCCrnlIwQCc6I3Jaxhr9mlcqrfUPznNtkzwmX5kq9dNagUmiWqSkgu+Qr+
	 ZqBFVJohUcf0h5+DnVomT/yEbxwRdjxMP37vkQafBv4OozdgNvYoK0gzXUnPoVcZxd
	 rt7ClI9mU42BCpdgFeXUVXPjH3fSt6dDK4cnDRTpYZ4/OzZ5oGd/ysTSZt8eL7dGuW
	 Ci352Ox4NV+2w==
Date: Thu, 9 Nov 2023 14:48:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/22] dentry: switch the lists of children to hlist
Message-ID: <20231109-ausnehmen-machen-dbeafa47e9e6@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-4-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:38AM +0000, Al Viro wrote:
> Saves a pointer per struct dentry and actually makes the things less

Which you're giving back to DNAME_INLINE_LEN.

> clumsy.  Cleaned the d_walk() and dcache_readdir() a bit by use
> of hlist_for_... iterators.
> 
> A couple of new helpers - d_first_child() and d_next_sibling(),
> to make the expressions less awful.
> 
> X-fuck-kABI: gladly
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Nice, gets rid of that do-while(), while () stuff,
Reviewed-by: Christian Brauner <brauner@kernel.org>

