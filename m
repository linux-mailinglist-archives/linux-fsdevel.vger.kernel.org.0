Return-Path: <linux-fsdevel+bounces-62487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9016DB94EEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 10:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5935B1885915
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073063195F4;
	Tue, 23 Sep 2025 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CUu1lvbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB31DD877;
	Tue, 23 Sep 2025 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615045; cv=none; b=r3tteOj7d+0lItUbMxO/sGoS6sPCplEno0o8e0v8gxZ12KXB93QjvrYmrDRlLjEZQD5z4A86Dp2AK1wQo9zb3KzJhPwmmMG0udWTeLGDnJR32EKhB1fqdyLYNLetl5ArBM9+X40iCICkunUdmR5P3um/77mV6hseu0x3Rrrbo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615045; c=relaxed/simple;
	bh=iW3WPoagLwoxw6Vm11W1B8DLUUbl+cSm5INVhgNbxS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxxCBmAUtgjaJ75GnklGnDBN+f5Bre5lBmBbir4gnKx4XcvpttWhMwNDQLkBfvgHWi79nniVG7QbNGSpQ8pJ0fLDISsyd2KPmqALfhe5BJith8GaA+9BYFSN7AMvIuYI9e7Y/piNKc84rGzi+HfhOMfTw8+zTPLBoXH9S1Joe6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CUu1lvbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF88C4CEF5;
	Tue, 23 Sep 2025 08:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758615044;
	bh=iW3WPoagLwoxw6Vm11W1B8DLUUbl+cSm5INVhgNbxS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CUu1lvbZ9Vi1eiQbP9TyKCBWnxSO+wgYt1w5dZjQNLBYdyQNp1x8oj13nSFHO0dgh
	 sjOnfLjfTdgRefJ7Ti7MyNKmVPU7anyFQuO3d/EvN39oDlbBs+7nY2MgKdB0As76IL
	 NzTQk5WZKpQpx4s86jlO4XYnqAhAVOnyTfn93l2U=
Date: Tue, 23 Sep 2025 10:10:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, borntraeger@linux.ibm.com
Subject: Re: [PATCH 19/39] debugfs: remove duplicate checks in callers of
 start_creating()
Message-ID: <2025092331-magnolia-educated-cd0f@gregkh>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-19-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920074759.3564072-19-viro@zeniv.linux.org.uk>

On Sat, Sep 20, 2025 at 08:47:38AM +0100, Al Viro wrote:
> we'd already verified that DEBUGFS_ALLOW_API was there in
> start_creating() - it would've failed otherwise
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/debugfs/inode.c | 15 ---------------
>  1 file changed, 15 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

