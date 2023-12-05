Return-Path: <linux-fsdevel+bounces-4872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635738054EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 13:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68E6B212F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B45C8E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWF7d+Kk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2A697A1;
	Tue,  5 Dec 2023 11:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A4AC433C8;
	Tue,  5 Dec 2023 11:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701776320;
	bh=HpQfzKH9PkcgbFsZNKCTx0ikve2nD8WgZ8kDoy0hkBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWF7d+KkggDuCYM2ZU8EJIKTxe7uCccNTV72qrVHVEt6Q9Uuc/a6adZQAXfD9uQQR
	 mrajWEOGXEhUvJssq7ok9NsIqToNwgakLRba7uZJ83ee2M1NxubiYugKhck/WOeVUd
	 i3cD/49HSP56/Iqhx048G0eA3fX1z0WC80CDeqYTU8WrLbajgyLEG9ZVfokcGO90pq
	 a/05lO9I274mHG7GxzwCX2xReZI4E5QKDm88rskarGW+U2KLvySzitr6m6e5aoPhX0
	 XAqVcx6W+IP7Usyp9EOdajaLItYeRdvsxLzsHOpMXDpdKz2lDfxNGxytfdmiWqMHSL
	 J5CS2r67Mm8Aw==
Date: Tue, 5 Dec 2023 12:38:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Message-ID: <20231205-horchen-gemieden-8013e0f30883@brauner>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-3-keescook@chromium.org>
 <20231202212846.GQ38156@ZenIV>
 <202312021331.D2DFBF153@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202312021331.D2DFBF153@keescook>

On Sat, Dec 02, 2023 at 01:34:32PM -0800, Kees Cook wrote:
> On Sat, Dec 02, 2023 at 09:28:46PM +0000, Al Viro wrote:
> > On Sat, Dec 02, 2023 at 01:22:13PM -0800, Kees Cook wrote:
> > > Allow __free(iput) markings for easier cleanup on inode allocations.
> > 
> > NAK.  That's a bloody awful idea for that particular data type, since
> > 	1) ERR_PTR(...) is not uncommon and passing it to iput() is a bug.
> 
> Ah, sounds like instead of "if (_T)", you'd rather see
> "if (!IS_ERR_OR_NULL(_T))" ?
> 
> > 	2) the common pattern is to have reference-consuming primitives,
> > with failure exits normally *not* having to do iput() at all.
> 
> This I'm not following. If I make a call to "new_inode(sb)" that I end
> up not using, I need to call "iput()" in it...

If we wanted to do this properly then we would need to emulate consume
or move semantics like Rust has. So a cleanup function for inodes based
on scope for example and then another primitive that transfers/moves
ownership of that refcount to the consumer. Usually this is emulate by
stuff like TAKE_POINTER() and similar stuff in userspace. But I'm not
sure how pleasant it would be to do this cleanly.

