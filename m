Return-Path: <linux-fsdevel+bounces-51281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A0AD51F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E7816B98A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2DF276047;
	Wed, 11 Jun 2025 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyGUZpWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F727144F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637953; cv=none; b=ErZFk2KFocaMMyUplnrR7JRPvwGKh6HLvfEbe55SDLRtrHdznpYB+PWdBWcmJ39cs1rNARRF4rOngcKeAWkm1rY30tvEKDkV/avi07U9PvAMcIt+u1XUzQSDR/x+DrUZKTDZQLwy9wz7sT4aiYtBS8uQIsr9Eulv93uDpN4dVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637953; c=relaxed/simple;
	bh=gjn1WIYIwLQEByp92bh8jxYRbSCKqduqr1u4JyfodK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnRt9KTEiJBwzXElnGpdB1PGvXwpEsgQejiJgq0Sz/pF3xckeu9z+LbdsLMv4o7fhgPbJJ7jbaRlyJIE5BebgwPAye/Cpe/oHwny75+mqxdwk/ztT4H5sEXov7lOABPb1Gf04iO49UHmdXqT6uM941DgU/zeX54hcf+KzQf2p8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyGUZpWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117B6C4CEEE;
	Wed, 11 Jun 2025 10:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749637953;
	bh=gjn1WIYIwLQEByp92bh8jxYRbSCKqduqr1u4JyfodK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VyGUZpWm52BWo3O7J5fHOVj5nuYwEAT0vLP/3hHG9i8tCpVhEL3sbl2IShGKblGgy
	 /OB8OuxiCPqEj0IrtqVde07B7B47xpSG0mPWg+ZLpmxRjqTXCNHhDb65oUvp/mxePm
	 or2enf1TAYwnhhKTXof6uuaam/vN6+cZ/DZGGujx7BifqJnQrNbLVxO5BD6qVJUsgY
	 yhX22BUEwvY0unO2jY9jk3psNw6yY18wdjBoGL1E4ocIMMz/c7QSNETbcjzBKhxDyZ
	 hGeBIjJ2m674odq+Vn5ryUW2BNqKD9ThnjYV+YVPWs0wUW6/hY8jscfCOu7nFIWH3P
	 OvbECboC/zong==
Date: Wed, 11 Jun 2025 12:32:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 04/26] new predicate: mount_is_ancestor()
Message-ID: <20250611-kaufen-galaxie-d5bb703fe530@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-4-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:26AM +0100, Al Viro wrote:
> mount_is_ancestor(p1, p2) returns true iff there is a possibly
> empty ancestry chain from p1 to p2.
> 
> Convert the open-coded checks.  Unlike those open-coded variants
> it does not depend upon p1 not being root...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

