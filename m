Return-Path: <linux-fsdevel+bounces-2594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607777E6E74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2396028111F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0412231A;
	Thu,  9 Nov 2023 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUVVYj5n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CA21A16
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 16:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDB2C433C7;
	Thu,  9 Nov 2023 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699546660;
	bh=obg1w5XRVAzlNTTNB54KYG68chI/sPv+hG+BlObL8R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUVVYj5niOja0Pg3uFZhOix9+LDWOW0it+R/YlXx6K4dBKLOh97xqAdmoCk5VQPLN
	 G1AM8KnF4XuoAhXlEuAd+TuXyIQeIJZr39IGUaLoMoywclS9kWA7eZs4pMBx7DfgMA
	 sRe029UomRjK4PTNqhKuWQP79kb0VqENJH6xZjXYUq4MUfzSA0H/b4DuXkj91VmoR1
	 qjYESnMnGp5dReOpTMe7BqNxhBsGJjTVrE26SOn8j6o5JrR4Wr+ElXC6mEZEr5QKSh
	 8bHqqF0dZOCjrjQQR8Yv31AglekuThc6ca8fQjJZm2L9RmmQFCIrtp4HVte4wyM/az
	 W1rTR8NK21nZA==
Date: Thu, 9 Nov 2023 17:17:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/22] fold the call of retain_dentry() into fast_dput()
Message-ID: <20231109-ohrfeigen-kurieren-0e1f6867fbf1@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-16-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-16-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:50AM +0000, Al Viro wrote:
> Calls of retain_dentry() happen immediately after getting false
> from fast_dput() and getting true from retain_dentry() is
> treated the same way as non-zero refcount would be treated by
> fast_dput() - unlock dentry and bugger off.
> 
> Doing that in fast_dput() itself is simpler.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Slight context change in that retain_dentry()'s now called with rcu read
lock held. Not that it should matter,

Reviewed-by: Christian Brauner <brauner@kernel.org>

