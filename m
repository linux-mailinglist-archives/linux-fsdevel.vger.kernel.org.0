Return-Path: <linux-fsdevel+bounces-16427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C6A89D57F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 11:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FEC1F235F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD580024;
	Tue,  9 Apr 2024 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7LLmFqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E86E80BE3
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654719; cv=none; b=eqad/VZD2ylmJ5rUgn9PtvG1Lm9227k7aGRDSA0S81HC+XfFt7NxmL0XGDVSlL+E4sKKjiJfGynW9mCy7ERjztuDnwdBXhSZPd9vGsiHmqDjXu0egQhc3WGwxEgjd8ex5VApaogkMvlUNyoCTyjLB3Ik//bPLpNIKWmNVC5+0YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654719; c=relaxed/simple;
	bh=vnGkmIWoIYEmrAdX9megm4OhgCceUQ+L4jjabBd+It4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me+u9vGaT8qYEBZN19lxhY7dSP2Juot7ZgINALLqRS/3LQdSof3nIwyKg9wJ+NNmNny+90M/Gc5GhtZBSEZeE9yuV+MgQq7pDTtNExMPeGng2aPY5BP3YgzqNSYzQoMRSJ3p4VtiBkIWK7X7rI5ioB7VarIL4HUnjcq82W54cZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7LLmFqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8746DC433B1;
	Tue,  9 Apr 2024 09:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654719;
	bh=vnGkmIWoIYEmrAdX9megm4OhgCceUQ+L4jjabBd+It4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7LLmFqDALeIOf7PtosZVbynhKtz7YhNr9bka5w9HWeSdVVy4WTk76rxbdbpK6vyp
	 mX5cCB/b5aOr7tAYgki/zJxFnWA9oQXpBqCdjRDhFRb3eX//luotdW0/fa/2m/YVTU
	 Ag1tA4bXHkjTj8jYSASApQPNGgdWN8h46TU44dTfDAYZvOHD/c0pTng+IAIcPzOXSy
	 F4PI8otMv/oWBYgXdw9gW8zNrwlvoKcfbWQxmC4wWkCkKbOMnkCUBCnVe54hE075En
	 h3EXigL3wGusXdsqi72UmzS8Zy9hyOEdSshokzVB8vrK9pf5Ja0T9C5nzaWpTg7FXu
	 Ly2yHMRSAn1Kw==
Date: Tue, 9 Apr 2024 11:25:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 5/6] do_dentry_open(): kill inode argument
Message-ID: <20240409-zuziehen-setzen-accbcc032bd3@brauner>
References: <20240406045622.GY538574@ZenIV>
 <20240406050156.GE1632446@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240406050156.GE1632446@ZenIV>

On Sat, Apr 06, 2024 at 06:01:56AM +0100, Al Viro wrote:
> should've been done as soon as overlayfs stopped messing with fake
> paths...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

