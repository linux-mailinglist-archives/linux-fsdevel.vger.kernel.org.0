Return-Path: <linux-fsdevel+bounces-50620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CBAACE0AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041D47A8956
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 14:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F489291866;
	Wed,  4 Jun 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QeE5WgSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056AA291861;
	Wed,  4 Jun 2025 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048355; cv=none; b=t4ixFh0WGyyuR5/tZ/023rL3GOD36kyf+rG9bM02MdGDT2m3LwdXqS07m9Qb1BD9qmwUTaYD2HLefx1XmXfAPkTycGra+K85JzAKuSn0sQufaulodygrqw4upqwnqwINfaDV7sGNHdgcGmhzMtExZQ8HhM0nbajXo6jPNVDQ5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048355; c=relaxed/simple;
	bh=5wKoX9vgVar/8xSs4aFnYVGmM1We5/c0MjsDQr+v6jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcdBCjWTW6pZoKFOmrw6JPJ3wSgVFzcKQp8q2Fw5UryybOyR3yqWmHlKeu2AV/HHyi+L6/m7QgXgUZD9/OnRS4CF1xw3oVO8B6MP36XmmNtT7pVeUDCWDDZ0ryO1fu66Gtz4sVvL9Smzica92/8Y619L1Uo7Us/uGQb43XkZrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QeE5WgSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0CDC4CEE4;
	Wed,  4 Jun 2025 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749048354;
	bh=5wKoX9vgVar/8xSs4aFnYVGmM1We5/c0MjsDQr+v6jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QeE5WgSvoMpNlWTtYYYaDvRGXIOzYJl+s2xM5m8O3Q2Rr5A+8vgpmsXf9fc0crfFM
	 lfR5vBf/v9uQfWEVsjGfDNXmu3VzujYfIiSR/gLX4ivQYUKTS9bIxJj9mXhcuUkYfw
	 Yd0kesqK7XCojupWvSC8OOoR2/wjpctvHC0fvBb0=
Date: Wed, 4 Jun 2025 10:45:49 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Luka <luka.2016.cs@gmail.com>
Subject: Re: [Bug] possible deadlock in vfs_rmdir in Linux kernel v6.12
Message-ID: <20250604-alluring-resourceful-salamander-6561ff@lemur>
References: <CALm_T+2FtCDm4R5y-7mGyrY71Ex9G_9guaHCkELyggVfUbs1=w@mail.gmail.com>
 <CALm_T+0j2FUr-tY5nvBqB6nvt=Dc8GBVfwzwchtrqOCoKw3rkQ@mail.gmail.com>
 <CALm_T+3H5axrkgFdpAt23mkUyEbOaPyehAbdXbhgwutpyfMB7w@mail.gmail.com>
 <20250604-quark-gastprofessor-9ac119a48aa1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604-quark-gastprofessor-9ac119a48aa1@brauner>

On Wed, Jun 04, 2025 at 09:45:23AM +0200, Christian Brauner wrote:
> Konstantin, this looks actively malicious.
> Can we do something about this list-wise?

Malicious in what sense? Is it just junk, or is it attempting to have
maintainers perform some potentially dangerous operation?

-K

