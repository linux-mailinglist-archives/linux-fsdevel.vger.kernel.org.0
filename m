Return-Path: <linux-fsdevel+bounces-59042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D361B33FE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A081A84557
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8D1DF723;
	Mon, 25 Aug 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHxmCk70"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD851D31B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126126; cv=none; b=cL+ScItYKIqDBIJfhRWRQUi4dUg5+MxHdr166fX4IdHTwStqcp6YuFyWFFnFJCQNC0msK0R76KmANUFX1yW0Mw4YlKNDk6kkuXIGuoDptShgJPqcAKibrmALgf08AtPzDqbF8q0GhOEH/zoupkvR2jz2OWn5DHlpqLfgeSc70t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126126; c=relaxed/simple;
	bh=IZmg2vpGJZ3BNcgT3e/A5MYvST32CuvMaXtkjelbGZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e01VyYBzL+Pnscmd7RJgVHG1CkgLZZKvc0Mp9t6lIvb/tALlo+Dp8wToQEGmw6qcGDzLKbpl5kUhp/pzT+A9KIzPYUXKPQprPFPgfe5c0ol7NlH7zhfZEDoXXlC2ree9MM2VC35/YAWGt5LTFqP1JHtycOZFEnMoUioMzNJjzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHxmCk70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09FAC4CEED;
	Mon, 25 Aug 2025 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126126;
	bh=IZmg2vpGJZ3BNcgT3e/A5MYvST32CuvMaXtkjelbGZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHxmCk70MZL+uGJMStSaUdbPQ59NtgOje/6XfSdtPuJtR+JgrEQFkxQh8ul45eeGA
	 +a0Bf9DEbATfMZf0t4TF5L0ILXm0/5JpBiEF8PB/fkZvQxEdoI1ojQiKxxdtC6tvv1
	 YJzH4rwskbXeFGbH4SZajJOqU713bmmM8YyKBLHyZ9ynPKfX6paoZVw9OvjIyD3sCv
	 Jw7mCQd6pKzF/yiqDV0jX69bYvlHN6hs+7BAlNZCO3BFSSuNUpiK+3PLvmBIH2w6H7
	 fzBJqppAQtB8554FLr1ikyHgJfZU3BQ2VgxPUC5TwdwmA6SQ9B9wjfRdhlBF9MOBRf
	 fbyikXl995n5A==
Date: Mon, 25 Aug 2025 14:48:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 11/52] check_for_nsfs_mounts(): no need to take locks
Message-ID: <20250825-begnadet-lageplan-ad709e089343@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-11-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-11-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:14AM +0100, Al Viro wrote:
> Currently we are taking mount_writer; what that function needs is
> either mount_locked_reader (we are not changing anything, we just
> want to iterate through the subtree) or namespace_shared and
> a reference held by caller on the root of subtree - that's also
> enough to stabilize the topology.
> 
> The thing is, all callers are already holding at least namespace_shared
> as well as a reference to the root of subtree.
> 
> Let's make the callers provide locking warranties - don't mess with
> mount_lock in check_for_nsfs_mounts() itself and document the locking
> requirements.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

