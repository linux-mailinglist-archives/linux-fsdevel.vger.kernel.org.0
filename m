Return-Path: <linux-fsdevel+bounces-5831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29770810E23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 11:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C46F1C20381
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F2222EE1;
	Wed, 13 Dec 2023 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN9F2qWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B3224E3
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 10:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127B4C433C7;
	Wed, 13 Dec 2023 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702462515;
	bh=BTwkCDF6j4V1ri2o7T7fV1zwgHRy2Zj5Vzv2QOjcckI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cN9F2qWO/RcSxSEUILn89hMSiuSM53g0vOpeYMfeK+7XqBjlgTd0b+noDlyKYKeFY
	 yNqrJZIuSwZY7Lc+87O7EW1KJn/xRZ3gneO8WTBZMk9xJikuLuL/mcalV2Is0xK411
	 xEVAGYMmnyd2yjFwi+AqUmHjjJIm551lpdLEKvCFeLso564T5qqMoM9b4Gne0NIzZN
	 RaC84zaw2Ib+hsWiR6TVhDWi46A4pSkn/ck8b5Smqw2msWN6EB783HRqG7wy4L03QK
	 v1D3Cx0fFHlp3otR7hlgtZK9kcWxH7u82lpRD+0yINfOPon4wWvtIXdH3yrNhj/fWO
	 rz909SVU0mmYA==
Date: Wed, 13 Dec 2023 11:15:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] statmount: reduce runtime stack usage
Message-ID: <20231213-wirrungen-angetan-6556786f194b@brauner>
References: <20231213090015.518044-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213090015.518044-1-arnd@kernel.org>

On Wed, Dec 13, 2023 at 10:00:03AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> prepare_kstatmount() constructs a copy of 'struct kstatmount' on the stack
> and copies it into the local variable on the stack of its caller. Because
> of the size of this structure, this ends up overflowing the limit for
> a single function's stack frame when prepare_kstatmount() gets inlined
> and both copies are on the same frame without the compiler being able
> to collapse them into one:
> 
> fs/namespace.c:4995:1: error: stack frame size (1536) exceeds limit (1024) in '__se_sys_statmount' [-Werror,-Wframe-larger-than]
>  4995 | SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
> 
> Replace the assignment with an in-place memset() plus assignment that
> should always be more efficient for both stack usage and runtime cost.
> 
> Fixes: 49889374ab92 ("statmount: simplify string option retrieval")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I folded this patch and placed a link here. Thanks!

