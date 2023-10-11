Return-Path: <linux-fsdevel+bounces-26-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52757C4825
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 05:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BF32820A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 03:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B14612B;
	Wed, 11 Oct 2023 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4GW7n2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5206106;
	Wed, 11 Oct 2023 03:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8BEC433C8;
	Wed, 11 Oct 2023 03:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696993608;
	bh=zcsVFpW9VLyMPFD7tqkCxIR2MRFUnQPc2SsPeS78L0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4GW7n2F1o8I/2ixJJmELu6wEdrpK+3YiId36NQ75+IfTaq0IZPUiCV8KkoWwv6wG
	 osXVi4pdfmp21JNP3nH3dWRPj0lg3A8w1Ar9i2xvxK7c8YkWJZOkpFk3T5WK1u5hSH
	 WVvaWfcjhaDTuzAbCdbZgOs42FkUgNVvp+KDVN1ktAZjyUk4kPZKj98ttwOwjqK5qK
	 De5ZiuYywWkpndR1+bm5K/u+zpIogtgIswZuoDiPFX1IkHf7fwyjQu2bx8kf6qTJSO
	 0Gryks1lmlwfhWMtBi3GzS2jCrkXha7f30PCPRgLpWxKKw3gXCbbLwMR57gTS0+NQH
	 2f0ddtE/os6tQ==
Date: Tue, 10 Oct 2023 20:06:46 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 06/28] fsverity: add drop_page() callout
Message-ID: <20231011030646.GA1185@sol.localdomain>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-7-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-7-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:49:00PM +0200, Andrey Albershteyn wrote:
> Allow filesystem to make additional processing on verified pages
> instead of just dropping a reference. This will be used by XFS for
> internal buffer cache manipulation in further patches. The btrfs,
> ext4, and f2fs just drop the reference.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/verity/read_metadata.c |  4 ++--
>  fs/verity/verify.c        |  6 +++---
>  include/linux/fsverity.h  | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 5 deletions(-)

The changes from this patch all get superseded by the changes in patch 10 that
make it drop_block instead.  So that puts this patch in a weird position where
there's no real point in reviewing it alone.  Maybe fold it into patch 10?  I
suppose you're trying not to make that patch too large, but perhaps there's a
better way to split it up.

- Eric

