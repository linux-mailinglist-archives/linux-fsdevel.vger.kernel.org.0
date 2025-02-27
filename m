Return-Path: <linux-fsdevel+bounces-42783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE257A4887F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 20:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65103B8BF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCD426B95F;
	Thu, 27 Feb 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDOvpApd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E5817A313;
	Thu, 27 Feb 2025 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682970; cv=none; b=bob+S+cbSJyB4pjm72XstwvEI0WM0n0Y7/uYRLnJjgaSgunAQTQy0EU7V0AptdQjz7n3eOu2/Pnj06I07Ixh+xxlDEGlj0uXCPWG0whxv6mzfmeOMnFuDrMMkOVHcNAKSA/dNYEPxLODkpEjiy2O+AWGNB3l9Ec8CdA5UMfW4dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682970; c=relaxed/simple;
	bh=lr8OD/cMnrFoxrLKGbUht4AEc4gitX1kJNyvDvjqWvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2w4Te3NbwZNNRaG0VYhsFc/krbUO1hwUVi5zkKMijerppy+5Y+WhnKFCqHnE+VYFTCmXuQi5UnDbDW00bc1+aoYcv0OVwtHG7mLy0j0G5WAwl4a83Yj10fTR5r2tTxiZQI2QTLalevRFYRFB4BAtTBjiK35an3PKU0fY2qgk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDOvpApd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18C0C4CEDD;
	Thu, 27 Feb 2025 19:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740682970;
	bh=lr8OD/cMnrFoxrLKGbUht4AEc4gitX1kJNyvDvjqWvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDOvpApdyymL8nnu4OHG8tGJTMPUCMOpi9GGiNTg2kjF/upOTlqV2TgzflgfNMYjt
	 so/x/a3Qwptq0Evkh0IQSdAKDhSGsO6+3GJ7MEV1L5FrKa2pOyEbeM3NAqGtluNE+G
	 hsTQSPCcwj6x0Pdk3xIfkdTX0zzyM2BnNuxZ0ntsKkZu+/6pLGlEyJXgDJEIFmOJVE
	 4YQaTrJS9l0QIfyEifTjSewCZau/kTxCK06ZfNRjx+b9S/PdQLG/bdawGQ3Ru8YoBW
	 KENFbt69F5/7BGf/wkfYaMeYlQA/PRJmH5dtUav+NhfGM5sGKJ6ynfJlGy39ij1lNu
	 yxRHVLC5+jq6Q==
Date: Thu, 27 Feb 2025 20:02:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6 v2] Change ->mkdir() and vfs_mkdir() to return a
 dentry
Message-ID: <20250227-besten-havarie-9a8288ff4e80@brauner>
References: <20250227013949.536172-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227013949.536172-1-neilb@suse.de>

On Thu, Feb 27, 2025 at 12:32:52PM +1100, NeilBrown wrote:
> It is based on vfs/vfs-6.15.async.dir plus vfs/vfs-6.15.sysv: I dropped the
> change to sysv as it seemed pointless preserving them.

I added that change so there's no dependency between the vfs-6.15.sysv
and vfs-6.15.async.dir branches.

