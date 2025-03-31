Return-Path: <linux-fsdevel+bounces-45388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F7CA76FAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 22:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE95188601D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 20:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17A21ADD4;
	Mon, 31 Mar 2025 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8LUdss4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E1214A7B;
	Mon, 31 Mar 2025 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454156; cv=none; b=ksE5UD/ehz+ikSbo1d6+AvypITg+j2h5bZION9lDwOiRb/vv9QZZj32BOHH8HhxE39R+sjtQ9TI0zN/bUvjE9nTK4m1n+UjcFQ7Y9OrHcQF1T2LxWMS1W9g+8YXKUk94F8+5naZIIQcuMvc8lknLqo4bncRgyuWum0KkqZLYk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454156; c=relaxed/simple;
	bh=Zuyvkaus9ewz8j94k6nzMD+kOEvczQsm1hQlczpTEak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7WlCdxElqmi/2K6eGKWhoYYS0cIl4neNaO/N7hBNdqI/FRFjcJ06OZr8+PUwVLI5VbnkBi0nipQZNb9kARb6TU+QmohLfALzTOntv9Vx1xexiwsH/BgrDFFYKTDQskrVbBD4nYxb6jxcEDF+DiB+60Oo0zZgWJjmvb7e/yy0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8LUdss4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E29C4CEE3;
	Mon, 31 Mar 2025 20:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454155;
	bh=Zuyvkaus9ewz8j94k6nzMD+kOEvczQsm1hQlczpTEak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8LUdss4E5AxEZy8XEcjSklmagmZAUi4p9h5yIettaAJls0JLcXdCSlEHWFx6gTAD
	 YW3gey9S/iApGusZAZPbY0N+a3q72ewx08QMttiuq7dTkUHuzJWJQaIO0pegONx8wF
	 HWCSJVWudEeWC2cS0mwC7dFrEfkuyC7UA9aiGCTh6l301WLCnNJHsFzrrX+CRZZWSi
	 cniPvo/SbmUd12U3cr3qiLUzHxhdUUkASMy68+G7i95IAkthh3dRrvWfZ2L31f362x
	 I/8B6uy/nL5YQ5yD2C4kxeu3YbvDJHE5pqJly2PbiFw4LIXDa82wPNXmfaAytm1iiP
	 2CZYH67vbUVvQ==
Date: Mon, 31 Mar 2025 22:49:13 +0200
From: Daniel Gomez <da.gomez@kernel.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	gost.dev@samsung.com, Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH] radix-tree: add missing cleanup.h
Message-ID: <ce6fw6aeumyl6dmxqd7xop2ovut2k2raekxfng45piotv5flxv@qpp5qpb77eaw>
References: <20250321-fix-radix-tree-build-v1-1-838a1e6540e2@samsung.com>
 <a79a9854-5449-4460-ab57-214c51095f10@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79a9854-5449-4460-ab57-214c51095f10@oracle.com>

On Mon, Mar 31, 2025 at 02:21:50PM +0100, Sidhartha Kumar wrote:
> On 3/21/25 4:24 PM, Daniel Gomez wrote:
> > diff --git a/tools/testing/shared/linux/cleanup.h b/tools/testing/shared/linux/cleanup.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..6e1691f56e300b498c16647bb4b91d8c8be9c3eb
> > --- /dev/null
> > +++ b/tools/testing/shared/linux/cleanup.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _TEST_CLEANUP_H
> > +#define _TEST_CLEANUP_H
> 
> are these header guards needed?

I think that is correct, it's redundant as of now. Perhaps it could be removed
when/if merged?

