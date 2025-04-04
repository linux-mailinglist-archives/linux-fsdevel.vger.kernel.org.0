Return-Path: <linux-fsdevel+bounces-45786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEC1A7C25E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 19:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCA63ADB15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1F521505E;
	Fri,  4 Apr 2025 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlXchcGY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C08B13D539;
	Fri,  4 Apr 2025 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787481; cv=none; b=W4FTS6vP+Wwx5SWqEixJcxhISjwzf+W8oOVrdQraxp++Cy6/hH18iAOynjekcTRzKW37+UCc8GHddAvGe6asLgL4dODmsUuLXOtRzMGvkv518JrBVtSjzND/VC6rwbLgM/xntRcrKB4eIovUCLMztiJEFdsOCTrGFDqtPej7KcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787481; c=relaxed/simple;
	bh=likuG5BOuOReaswjoND3u+xsF3i14STI5Fea/gpcC5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvYCUqfWtb7/0ReKNKFQ068WM+oWBJ8w7GegBFgF2c6yAiP8jTgGdZx0SFTQ4YKY4j63ngNBMpNy6cJ4ATa6xJIwi7FhvaTXP3jQ1/YyILVxfNabm/XDWApcBKJ7+99cNerAKRsIFHYxcdzJKmyz7zImaSRxGqt4KUqQ7THWcFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlXchcGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8E1C4CEDD;
	Fri,  4 Apr 2025 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743787481;
	bh=likuG5BOuOReaswjoND3u+xsF3i14STI5Fea/gpcC5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlXchcGYRc/LjxHDDVnmqx+0pinPANAoiXsH7QW3d8AnFaphuO+kMOZ/nPKdLl5D1
	 2Cdb8SqSNYg1B49ux57Ok0RbA3bZcAsIKCH0I3mNJtBLbICleWhem9exV1x402tJhn
	 er5S+GhcXGVzdzC4EEeh9kfPAoSQ3acWzax6jS8tHluVmOSYrSeWGf6Fa6PnE7bQwM
	 7r2f9nVL6qnQ4X1m3lWbNC3PXbCEALUnK2LvdYfnDHztkq+uDomrUEp25vkoEGGKVN
	 cc2VUD5sI27C2W6bX0LWyjz0wuRBThrCEYrsQxyoFdBQHIAZCTzSDega5vsKpRs5gM
	 ed2ckaivBzB1w==
Date: Fri, 4 Apr 2025 10:24:38 -0700
From: Kees Cook <kees@kernel.org>
To: Bhupesh Sharma <bhsharma@igalia.com>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	oliver.sang@intel.com, lkp@intel.com, laoar.shao@gmail.com,
	pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
	juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Subject: Re: [PATCH v2 1/3] exec: Dynamically allocate memory to store task's
 full name
Message-ID: <202504041023.A21FA17DDC@keescook>
References: <20250331121820.455916-1-bhupesh@igalia.com>
 <20250331121820.455916-2-bhupesh@igalia.com>
 <202504030924.50896AD12@keescook>
 <3202d24e-b155-ab0a-86cd-0a3204ec52dd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3202d24e-b155-ab0a-86cd-0a3204ec52dd@igalia.com>

On Fri, Apr 04, 2025 at 12:18:56PM +0530, Bhupesh Sharma wrote:
> In another review for this series, Yafang mentioned the following cleanup +
> approach suggested by Linus (see [0]).
> Also I have summarized my understanding on the basis of the suggestions
> Linus shared and the accompanying background threads (please see [1]).
> 
> Kindly share your views on the same, so that I can change the implementation
> in v3 series accordingly.

In thinking about this a little more I think we can't universally change
all the APIs to use the new full_name since it is a pointer, which may
be getting changed out from under readers if a setter changes it. So
this may need some careful redesign, likely with RCU. hmm.

-- 
Kees Cook

