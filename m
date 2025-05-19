Return-Path: <linux-fsdevel+bounces-49429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C803ABC2D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 17:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F7217FC44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E432857F2;
	Mon, 19 May 2025 15:48:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516772820D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669695; cv=none; b=KaT4bhsJ29xpGmsrapYCsKNuVh4AeognqkVW2qFpYhyabS1ukSW9Z3SmocRg3K90+HifM6JM48tLZN1cUEaf2rNsFFY5aM0Kj0oGd5UzLQXC7eanhtUxgU6aYuXprzQGDfOLRmFBeDyt/IIAAP1wpvmPxifv0jx8EiRTnCDca8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669695; c=relaxed/simple;
	bh=i/TEzOxZq8ZPSh0BGuxJ9vEl1OKjCILM/KJe/XrNNVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdV73WWa7dk4xFxogIRV7xqQhxydsVNMVXFm/cQwkRJ62phUftB1W+k82B9TP5T9YRR7lEpHnWBznG88xzxrjzBetphYCkBV9s7HcNxB0ytqZKJ/8ilmuUKqouL92z4LD8VRlW/CEjdjpPRV4TkLDClvo4Su57vDU3plIjnk+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54JFlswL016846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 11:47:55 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D3D2D2E00DD; Mon, 19 May 2025 11:47:54 -0400 (EDT)
Date: Mon, 19 May 2025 11:47:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
        djwong@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 0/7] ext4: Add multi-fsblock atomic write support with
 bigalloc
Message-ID: <20250519154754.GC38098@mit.edu>
References: <cover.1747337952.git.ritesh.list@gmail.com>
 <877c2cx69z.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c2cx69z.fsf@gmail.com>

On Mon, May 19, 2025 at 03:37:52PM +0530, Ritesh Harjani wrote:
> 
> So, thanks for taking care of that. After looking at Zhang's series, I
> figured, we may need EXT4_EX_CACHE flag too in
> ext4_convert_unwritten_extents_atomic()....
> 
> Other than adding the no cache flag, couple of other minor
> simplifications can be done too, I guess for e.g. simplifying the
> query_flags logic in ext4_map_query_blocks() function. 
> 
> So I am thinking maybe I will provide the above fix and few other minor
> simplfications which we could do on top of ext4's dev branch (after we
> rebased atomic write changes on top of Zhang's series). Please let me
> know if that is ok?

Sure, that would be great.   Many thanks!!

						- Ted

