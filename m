Return-Path: <linux-fsdevel+bounces-35776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F709D84DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D9CB29454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E620199920;
	Mon, 25 Nov 2024 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R27xY46C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8C376E0;
	Mon, 25 Nov 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535164; cv=none; b=giQXHk/a1QgHkOHcH45gA5HNYTB8oaTYeGhlpg3KI5j6PDlsgbO9DODAL9m5Islt4t+gw27A/OY/ufQmQepBWq6x/2uZjUdaVgM6llXCIDJ7za00NnC/iFDmYH3QNuuS2p1PS9C7An7GIy9mnrKxxmzM/TatfLK5LgqGmuagfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535164; c=relaxed/simple;
	bh=4kJj/N7ipQFo9oiOGTpWNMZDlhMP3dAw8rGgNbYzVnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+AALsS8IaiADHU65fAPOO3/9kA5DUCCHb2nVJZOIGQQG4Go2627m7Q+1lWlGIG0TIpXy6cpslEMPp1BAWF6p0Tpmsbx6pgkcz3kEBaDrsHEWXzAvnlZuTxnf9ET/RQcYfpfE2vR0Ovkl4vlPY41vrSoPXDuhOjMKGll4BXutkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R27xY46C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F44EC4CECE;
	Mon, 25 Nov 2024 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732535164;
	bh=4kJj/N7ipQFo9oiOGTpWNMZDlhMP3dAw8rGgNbYzVnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R27xY46CQBdJq9mJGJLdwt9yK2sdWfkTYNWs8WfDYlu/QOxs1nguGYszzWXOJuaZX
	 UOkIPx4o7ZL5ANoe8ZUi9Rio/xSFv2QW8098/eHKi33vaWMEcrnVhHUZdoJzYpxTjT
	 kJlyXr6JXJNlwanys72zuB4XkvDlgWqiMlbpirKKVt1VutbQ5h0F3ZgSpmbm+apAtE
	 JsCvpb8MTq/lyz3kytWkASk52H74M1NxexqL1IS3N7G5phiVmbRLe/F1kYN13+n2ra
	 SPtxqg69OSyaMmCIOhM+e6VKXEG6BpN+QmZf8/yPrv1UTwf5aJjvxx6ZwynR/a+eY/
	 1cX3eikpUpc/A==
Date: Mon, 25 Nov 2024 12:46:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/26] cred: rework {override,revert}_creds()
Message-ID: <20241125-mitverantwortlich-bauphase-34b1b97190bc@brauner>
References: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
 <20241124-work-cred-v1-0-f352241c3970@kernel.org>
 <CAHk-=wi5ZxjGBKsseL2eNHpDVDF=W_EDZcXVfmJ2Dk2Vh7o+nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi5ZxjGBKsseL2eNHpDVDF=W_EDZcXVfmJ2Dk2Vh7o+nQ@mail.gmail.com>

On Sun, Nov 24, 2024 at 10:00:24AM -0800, Linus Torvalds wrote:
> On Sun, 24 Nov 2024 at 05:44, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This series does all that. Afaict, most callers can be directly
> > converted over and can avoid the extra reference count completely.
> >
> > Lightly tested.
> 
> Thanks, this looks good to me. I only had two reactions:
> 
>  (a) I was surprised that using get_new_cred() apparently "just worked".

There's only one case and that's io_uring where we can just cast because
we only need it temporarily during the conversion part of the patch
series. Later we don't take any reference count anymore in io_uring.

>  (b) a (slight) reaction was to wish for a short "why" on the
> pointless reference bumps

Yeah, sorry for some of the patches I just quickly jotted down the same
line in the commit message. I updated all those commit messages with
actual explanations why that's safe.

> But not a big deal. Even in this form, I think this is a clear and
> good improvement.

Cool.

