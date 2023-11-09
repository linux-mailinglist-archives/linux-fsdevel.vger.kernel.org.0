Return-Path: <linux-fsdevel+bounces-2593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138B7E6E4C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7047B20BD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8521A12;
	Thu,  9 Nov 2023 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGac4xmv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B412136B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 16:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43443C433BD;
	Thu,  9 Nov 2023 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699546168;
	bh=c28CDmzh71vgQdI2HUkxWegwpFVvA4nIP43w6UwKIac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGac4xmv98VCPbO9Q3rUwt7LCGen14GYqwxfrQ4jbm2imzQSDH8HuDQPuGMDzPIPi
	 rV5yTywMqqIupvTk0u4CeDI3y1hBRq3g94Jlu3nlOoKfgmCv8AdKmP6oR//ARx46tJ
	 W+5yy25bSE06qxY6jJkbhcBGclFiD2XVPlIKFaAnbA0EUgyiH0v5oabuUKlLQ1iXf6
	 G83kwUlakS9BqUjS11lrJ2dsr41QdWwwVosZlUh9XTPlB7gm6+cwVaMKCZDoelnKd4
	 LWXEieOeG63jK8hngxJCnsM996HTZu8U0+/sjP2HiKCgQGixEub6Kqb3fsantLEVKW
	 zfdaxqIlMyMVw==
Date: Thu, 9 Nov 2023 17:09:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/22] Call retain_dentry() with refcount 0
Message-ID: <20231109-spontan-besonderen-834264dab89a@brauner>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-15-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109062056.3181775-15-viro@zeniv.linux.org.uk>

On Thu, Nov 09, 2023 at 06:20:49AM +0000, Al Viro wrote:
> Instead of bumping it from 0 to 1, calling retain_dentry(), then
> decrementing it back to 0 (with ->d_lock held all the way through),
> just leave refcount at 0 through all of that.
> 
> It will have a visible effect for ->d_delete() - now it can be
> called with refcount 0 instead of 1 and it can no longer play
> silly buggers with dropping/regaining ->d_lock.  Not that any
> in-tree instances tried to (it's pretty hard to get right).
> 
> Any out-of-tree ones will have to adjust (assuming they need any
> changes).
> 
> Note that we do not need to extend rcu-critical area here - we have
> verified that refcount is non-negative after having grabbed ->d_lock,
> so nobody will be able to free dentry until they get into __dentry_kill(),
> which won't happen until they manage to grab ->d_lock.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

