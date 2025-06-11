Return-Path: <linux-fsdevel+bounces-51302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78563AD534D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38DC97A8763
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7882E6119;
	Wed, 11 Jun 2025 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlAiuhSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488172E6107
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640320; cv=none; b=Vc1VStCfDtmWxr4h9RBy3u52YwAgvTEj4sw1UQPBIlHqSmzxbzMcqhdCJDS5h0QUgkfWRRIRbThg56PytJK1Ma9RTtWga2x4bBpg0YoYaGTxHCLglh7L/36uxXK6St4SDNHkY4aeav8F9WCc4WvBKpZFZrP+Ig5lYPG6gD+pwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640320; c=relaxed/simple;
	bh=x9U4R0QcoRctNxbgmMLKJbq2tOaGx9g1BKoe9g3ZoV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPXl3x51PaVn40wXzEaMPyVt8O7LzklM7hxNzMH5FbHYEi35mioU735SbWbgjm1jxP0kkfehY815AJD+LxcgSGtSfVtxa9IjhWkys9iaEARQmBnMoGxG0Hzhw5rYBSKjx3K+lSwnpNo8wFCfYlCpfIIFSGvj/1bN9HZvJke7GoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlAiuhSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74813C4CEEE;
	Wed, 11 Jun 2025 11:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749640319;
	bh=x9U4R0QcoRctNxbgmMLKJbq2tOaGx9g1BKoe9g3ZoV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlAiuhSLKvmBW/Aw9UfOW7IYHy79Scjoiv2ZrSGVUERnLlX1FjgGbkNOpbUHrh7cT
	 nwncWJM65uESlk8KiqjZMmIr0wz9HaGB2EoD0RJ/WswoDXaboNp/in4dise5zQVbH6
	 Y8FPOTRrcC1tpqkS7yRIbpB5ogOXKxAYVyUg4h7yJNi82kHPhYUuN7rQ6/zMXrMYh7
	 iYnPfxd5VGr8XFQX1wh2hEqfJQ+52Znb7AfMPmz9AVGjIE2c1piTZsYkj3iBt3IUEt
	 Rduca4fzzNsstl15v/pNQgfZfc5TRBEy+sIWngRjdc54EYK6S4nybPl7WmZWRPo3AH
	 TuE2rPQLkxSWQ==
Date: Wed, 11 Jun 2025 13:11:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 23/26] pivot_root(): reorder tree surgeries, collapse
 unhash_mnt() and put_mountpoint()
Message-ID: <20250611-gefrieren-lektion-e841724332fb@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-23-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-23-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:45AM +0100, Al Viro wrote:
> attach new_mnt *before* detaching root_mnt; that way we don't need to keep hold
> on the mountpoint and one more pair of unhash_mnt()/put_mountpoint() gets
> folded together into umount_mnt().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

