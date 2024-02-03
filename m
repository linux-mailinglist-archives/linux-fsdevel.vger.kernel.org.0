Return-Path: <linux-fsdevel+bounces-10193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F50848819
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 18:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B991C22943
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE095FDB1;
	Sat,  3 Feb 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="SSiVdQgy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BB85FB9F
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Feb 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706983089; cv=none; b=FWgewuZggodpsgzLGfoUeUnhr/kousl4mgXEnE1lPNxq86AL3zOK/NqMT1G2KbcUEI93EFKs/DCkMXq0qdF2bE5vJTTyuumR1oxBzZGoscGd6QKgevaEwcCZtqhipCZ0SM3xMfrNYoqk1tI18/lHZYFmR1pwbA7nDX4iiGN1r1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706983089; c=relaxed/simple;
	bh=5+XzlAwnVCFv70Ro0EjvOwnKj1A6wybqH/l1KAjYwRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XThR0Wm8bRwWtflqCYmXx8xb6AxzeC9RX+r2us8dWKkH3bdZgPBwFerMRxkaC58L2zgAP7vI77fPVQpM3EHPn+iOWsZ5vf3uxYtb8j3zUP+kARZS5Xm6eNhiXWN/yHtcojc9a7yw4h/gH6+tFbGWysZWmth26J54wU6Z14T/NCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=SSiVdQgy; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 413HvSjx017208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 12:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706983051; bh=99dxy2PFAEd7Ric/sKT9cxcAPUbPHecGHYu/LOqgnzI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=SSiVdQgy+T3CGwQlxhTgGe+KTMtd3GMBDDA0ppa6jXfL2WsmsfVPMQRezrSvtqcqL
	 eEcVfIGsSL6XNXvnt8vMxzHoDkPUFUOHHq2wLqe1BsASbU736Ko7lRHNXVt+UECGhU
	 BA1euK/3icFNIgYc4x4/uHB2nLhVL9lwo+0R/BcmIyqquwT8dfYi2z32KW5YbX5KuT
	 6Wq+f7hnSTXpi3kN20vQvqsPKq2YBW47DRM/4mBoEi4aMDwGRWX0dKdXPnoAjAN7dD
	 QwEsVu18cNa691rlaR6nK01ikJx/aeAgQcba3yz0GJn8yGC4cu4pf4l6UlTLW1RE7U
	 9XeVlSstdb0DQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2482315C02FC; Sat,  3 Feb 2024 12:57:28 -0500 (EST)
Date: Sat, 3 Feb 2024 12:57:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        hch@infradead.org, djwong@kernel.org, willy@infradead.org,
        zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 06/26] ext4: make ext4_set_iomap() recognize
 IOMAP_DELALLOC map type
Message-ID: <20240203175728.GI36616@mit.edu>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127015825.1608160-7-yi.zhang@huaweicloud.com>

On Sat, Jan 27, 2024 at 09:58:05AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since ext4_map_blocks() can recognize a delayed allocated only extent,
> make ext4_set_iomap() can also recognize it, and remove the useless
> separate check in ext4_iomap_begin_report().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

