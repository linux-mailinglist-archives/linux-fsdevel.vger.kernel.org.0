Return-Path: <linux-fsdevel+bounces-51303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C44AD5391
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CE01887A30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE47D2E6115;
	Wed, 11 Jun 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scci8TSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1132E6106
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640354; cv=none; b=piohin2mMJKV5Pf3hQdd46Eq/NP+4tb6Jl4D5Zrua/zivZGM8rzjuHCWH9Gjd0AyoXsCVOHJow93lWez9AmwGjXH9vDoKHbbI5/y/r8G/nYJP7dGSAOaspchnHNwB/R47MO9mp1Wg2orGMfbSW0EfoEJYGGJ9kud3NLLXAOfTeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640354; c=relaxed/simple;
	bh=sFxjagp3I5XgVbiW5mLlYPJTputc4K0CJq3YkIZcocc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnrPjSqj7H39BjmHoCyj195vuYJEf9ihAAyJ5ssSzR/1S3DDkNhcV92i7OSwVYgRG0PwWv3nmjJtikGennvGGrtVKYJzt65m7OCtV2aBNIwxHjub+GIxGwjxtAyvlAM9muT2patr5rX0wwleCUXZ976BZPnfsmRUvxIj9Pg48Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scci8TSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2726DC4CEEE;
	Wed, 11 Jun 2025 11:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749640353;
	bh=sFxjagp3I5XgVbiW5mLlYPJTputc4K0CJq3YkIZcocc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scci8TSbxTvHt0KcSyiO2ltL6Gs4T4rKQG0Y2YF04vEipLqTK67rdu10C81IyeHqO
	 tR+iFdYaiUiFCMzocRSptYtJrZUZ+5wMpV4wBxgFTPmXOxeXvqQqk3mbzqoLsCJk5V
	 AuhWRvOy78e9XN2tEeKgfSMbUKnyQspA02GbhUVD628y7mMGAJZ5EwYdbjVYm89Kom
	 DeINusUyxE5Vq+ShRQAn/Qi+QfN8hHurYubTz0pnhM8s3yqqNjNq9yRK4HAUZjhr8s
	 3+8p6gDZbpLSR7xvCfs9Odw3OPJ5Nh2bSaxz9OJBMirQb1yCGCq8bYZfnSDCsxLNyf
	 ysbByYBM87/HA==
Date: Wed, 11 Jun 2025 13:12:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 24/26] combine __put_mountpoint() with unhash_mnt()
Message-ID: <20250611-penetrant-verlosen-d3ac986bd510@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-24-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-24-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:46AM +0100, Al Viro wrote:
> A call of unhash_mnt() is immediately followed by passing its return
> value to __put_mountpoint(); the shrink list given to __put_mountpoint()
> will be ex_mountpoints when called from umount_mnt() and list when called
> from mntput_no_expire().
> 
> Replace with __umount_mnt(mount, shrink_list), moving the call of
> __put_mountpoint() into it (and returning nothing), adjust the
> callers.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

