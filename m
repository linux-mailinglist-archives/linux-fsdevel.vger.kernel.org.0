Return-Path: <linux-fsdevel+bounces-28215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E710968236
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 10:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6F81C2074A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 08:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5161865F6;
	Mon,  2 Sep 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GO/WB/vC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9E16EB76
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266496; cv=none; b=RZnCsMb2xUcMwZ4g1te0s059Go6jhZD0tIVGM5w0hpGpI5H1pfLwokE71IqHstqI0C9+PxcxlTSo7mCgCNsCUtVAw13O3IupfxMpC6EGyeqfrq30s7uah0IxQ3zcFO/SqIFEFYtAJ6nFm8YuQZ1ZZXdVOkIOSGue0OEzVgYm84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266496; c=relaxed/simple;
	bh=U4pH9n5opeXrTqy96OEvKqqGlgFtHFsAUi+KLg73r+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcpnvTCHy62y55kGQFSSF7LiE3hMyNnrwlPuC46e0mpxT/MovDC+5oT9401K+Z0Pj36Gkb5w8nzytuDd0eKdQnmu6vpcmVSJ9EwpTuIAJ2RGebUVMKKbb+ayUOau9TLlzIrnP53s8dwS+EOv7zXDtOk5JrDos5QQQAi4vvCPTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GO/WB/vC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a866cea40c4so451187466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Sep 2024 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725266493; x=1725871293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Utp1RoWfhaGakPbnKMVk3xSbFrGMSY4DPD6Mxcnr7vM=;
        b=GO/WB/vCGGjNzm79oYQK5rjK14AoxVVXyRbSHsv+UDfpqclVn2OXYVfU0mT4Un6ATu
         E9ikzfDEiM8/b60Rxp5ByyPv8kMv+1tAQCf2do9qpF8MoXa9Ks4W/wQQcYE9gjO/8pI2
         HI2p7tCZTrXM9OGLI8UGhkaMj9zHjEg99SDnQy8sj+2RRswxa7RE7ny3pMBAebsza0fa
         q3OFXxILxNuRgK2Ldqbj56nCd0qbsaSivRp1Ut/K1o6XE6u3sDBUatpBGHd4SrAz3Aa6
         i0VnIziTb/CP4w6oSKlMCILJexkykGQf7VbCJIieezvN9x78c81dUFlcZGMYlxOq+lpi
         nZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266493; x=1725871293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Utp1RoWfhaGakPbnKMVk3xSbFrGMSY4DPD6Mxcnr7vM=;
        b=suq0gcX0iik7unhqSZT5XeX8orHU9F1TT+JrqHN18Eo0veFQgVBapGWG/J0RwyDEeq
         KTY/8sfZ23TZ1F3awhnpIfhjJpYmX8DvdkVomby6krc4YN+tkB37wfVIRGnuNljV1gsz
         8UM4Sq+2b/JjH7m4dCAnz6mX4atzfmPmOr04MtsL5gpf3e+JbyN9p5zS3RhAxaltFPCt
         RQ8ArUYr3PpxL8yCmOZDfBb2Pp6PACjHmLcL3+sTUfFdvEeAjiz/Z1WthSK8049pul6j
         +hmmBKeNNujZfMgukoaoidDSy2cM38mPKz2QEIBtXLIhdQotv9q0QoH3UGWrphA3KOCb
         nhlg==
X-Forwarded-Encrypted: i=1; AJvYcCW/j1rY9LsvN7PBWsV51yn4vqivhuxv3c2OvP28l8qiN/yOTYZDvavsULmEz5//jOXcbmBj6aXPMFq2Hufs@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5CEK0HrKIPdzCxmhlOW+b68eamf83hqjMaWbzCfmzxqOk0nG
	Df5XTcMxq2s0A9i7a4DY1lEZptPgYBfXJhLROOxeOha7TRhvEgosI65xLTjjVP8=
X-Google-Smtp-Source: AGHT+IH0oa4HGDBaWmEW2YFqYs/c/VIYcD3KLgtz3Ns27MTTgp0m3AKBLw/5R/bF6mlCHND1zKa/NA==
X-Received: by 2002:a17:907:60cb:b0:a86:8169:f3d6 with SMTP id a640c23a62f3a-a897fa6bb2fmr1161343566b.49.1725266493202;
        Mon, 02 Sep 2024 01:41:33 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6d36sm535496866b.149.2024.09.02.01.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:41:32 -0700 (PDT)
Date: Mon, 2 Sep 2024 10:41:31 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <ZtV6OwlFRu4ZEuSG@tiehlicka>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>

On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
[...]
> But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
> in the case of bugs, because that's going to be an improvement w.r.t.
> system robustness, in exactly the same way we don't use BUG_ON() if it's
> something that we can't guarantee won't happen in the wild - we WARN()
> and try to handle the error as best we can.

We have discussed that in a different email thread. And I have to say
that I am not convinced that returning NULL makes a broken code much
better. Why? Because we can expect that broken NOFAIL users will not have a
error checking path. Even valid NOFAIL users will not have one because
they _know_ they do not have a different than retry for ever recovery
path. 

That means that an unexpected NULL return either means OOPS or a subtle
silent error - e.g. memory corruption. The former is a actually a saner
recovery model because the execution is stopped before more harm can be
done. I suspect most of those buggy users will simply OOPS but
systematically checking for latter is a lot of work and needs to be
constantly because code evolves...

I have tried to argue that if allocator cannot or refuse to satisfy
GFP_NOFAIL request because it is trying to use unsupported allocation
mode or size then we should terminate the allocation context. That would
make the API more predictable and therefore safer to use.

This is not what the allocator does today though. Atomic NOFAIL
allocations fail same as kvmalloc requests which are clearly overflows.
Especially the later could become a risk if they are reachable from the
userspace with controlable allocation size.

-- 
Michal Hocko
SUSE Labs

