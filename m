Return-Path: <linux-fsdevel+bounces-67104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C2DC35603
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36C644F91FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C402630C350;
	Wed,  5 Nov 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGTh17TR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E72192F9;
	Wed,  5 Nov 2025 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342368; cv=none; b=NeJ61nSEBoVLfNC7kCjDJbm239toWkb2KivAIkg3zfo+GLFIve4SmkmUauw4pHX08QdNU/ShLSIou8J3y39czTO9dvgkwWPbqm448IxrWkZADgsgliaPMY/iFiv1SFvwFCM/4VnRu+QxGfrhbL8wn/UKOQ/OO5ndIERn6RiQHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342368; c=relaxed/simple;
	bh=Tfi10fkzsZ3Q9MbW9Z557c9dyifcpTcdXY4ETbmZWcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZK2AA14pIiI7RgcJBQ9Sy+LoxvqHc4Wr5qtsdOA9yraxcT9ZG5CL4X2iQEKuB7PtWBr6YDelzhN51jG1D1ljgmAdpoPDknxPJodprYvn17d2GarCAK8R3tprnOtDO9gOJ4dT0a7a25glVGsWtmhXsFRad1skHA1ItvLrWNg/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGTh17TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E342C4CEF8;
	Wed,  5 Nov 2025 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762342368;
	bh=Tfi10fkzsZ3Q9MbW9Z557c9dyifcpTcdXY4ETbmZWcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGTh17TRitiDNoK802K4njGG2alXOIuSh3/tN7UixoBNvoXIq35LkvQYIsuU9Wzch
	 lS1XRxKFuH9Zr8uujZeuVfgIIehzyUfDlRU+CLzdRIuVKiU6zzHEubA/Sd/igp/xBK
	 FSXbPzi1yKHOjd2GaH1VVcT89E7Qd9M6+xkywRQ80anPCa1bCF/fi+mFfASzE9HB1Z
	 5ftWFGDCsgoYdHzA/r2GrtfET3+Z6VM3KDvupsoMVV7hBRE0vctcQtI2C3xy/eD8QK
	 vD0wHWl9g51bq9o4HhhG8vCa9CxsiZI4WlEYjf9byKBE8s5OsWlXSgAi5E2VBbSyOc
	 yxZQttdvDQlKA==
Date: Wed, 5 Nov 2025 12:32:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@infradead.org>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Askar Safin <safinaskar@gmail.com>
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
Message-ID: <20251105-libellen-genutzt-2133e1086dc5@brauner>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
 <aQiYZqX5aGn-FW56@infradead.org>
 <cbf7af56-c39a-4f42-b76d-0d1b3fecba9f@suse.com>
 <urm6i5idr36jcs7oby33mngrqaa6eu6jky3kubkr3fyhlt6lnd@wqrerkdn3vma>
 <l4nrvt3dxy3wstryugdevnjub6g6e4qzsrpnqpdb2xo5qidxh2@yxcosrvhx6rh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l4nrvt3dxy3wstryugdevnjub6g6e4qzsrpnqpdb2xo5qidxh2@yxcosrvhx6rh>

On Tue, Nov 04, 2025 at 09:39:14AM +0100, Jan Kara wrote:
> On Tue 04-11-25 09:28:27, Jan Kara wrote:
> > On Tue 04-11-25 07:25:06, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2025/11/3 22:26, Christoph Hellwig 写道:
> > > > The emergency sync being non-blocking goes back to day 1.  I think the
> > > > idea behind it is to not lock up a already messed up system by
> > > > blocking forever, even if it is in workqueue.  Changing this feels
> > > > a bit risky to me.
> > > 
> > > Considering everything is already done in task context (baked by the global
> > > per-cpu workqueue), it at least won't block anything else.
> > > 
> > > And I'd say if the fs is already screwed up and hanging, the
> > > sync_inodes_one_sb() call are more likely to hang than the final sync_fs()
> > > call.
> > 
> > Well, but notice that sync_inodes_one_sb() is always called with wait == 0
> > from do_sync_work() exactly to skip inodes already marked as under
> > writeback, locked pages or pages under writeback as waiting for these has
> > high chances of locking up. Suddently calling sync_fs_one_sb() with wait ==
> > 1 can change things. That being said for ext4 the chances of locking up
> > ext4_sync_fs() with wait == 1 after sync_fs_one_sb() managed to do
> > non-trivial work are fairly minimal so I don't have strong objections
> > myself.
> 
> Ah, ok, now I've checked the code and read patch 1 in this thread. Indeed
> sync_inodes_one_sb() ignores the wait parameter and waits for everything.
> Given we've been running like this for over 10 years and nobody complained
> I agree calling sync_fs_one_sb() with wait == 1 is worth trying if it makes
> life better for btrfs.

Agreed. But emergency_sync() is really just a best-effort thing and I'm
rather weary accumulating complexity for it otherwise.

