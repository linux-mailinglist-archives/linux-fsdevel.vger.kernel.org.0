Return-Path: <linux-fsdevel+bounces-39186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E8A1130D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C52A1889BC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5722116F5;
	Tue, 14 Jan 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyPyx6Fc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23632080DA;
	Tue, 14 Jan 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890187; cv=none; b=huo0t3gm4uZJ4oZGFAOxA75mwMGJZ7hIvEclbhUmTAmPItAk5XMyVdFdIwI78QyA1m31aQ4QT1VvJsizM6a+LHHBFVGoNwzk/Jfp7/PuWn5UalH1C/W3JM4AO2jsrEW8/9dpCbiFcXljqtMnILC/s574OI24IXEy9M6JgL2HAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890187; c=relaxed/simple;
	bh=GDCH+gXK17HExiT6MBZmGoMVMGZ0xZVZIB80Lo0ibpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlF2XQ2eSm+K9GOqjiLtdf+78EXO3S4+5K5/mfRBS+0NL4gTH2zu81+GbarvTmqonzx1L/YZ8sojMYgRw25rnjNqhnUX6JyNKm1SfVVT3dulO+m16NG2Q/E/ahTJb5CM0c6hm+Id4PFfD6csz30xi81oxJiPYuMC9im/njZ2+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyPyx6Fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7722FC4CEDD;
	Tue, 14 Jan 2025 21:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736890186;
	bh=GDCH+gXK17HExiT6MBZmGoMVMGZ0xZVZIB80Lo0ibpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyPyx6FcucZYtWR/w+1lVsusiOjnoFt2yPh6drz+yvZ1dfhQfmzo9hi+8oshpz970
	 7G+TX3wWYj17ec/evgLifYYH4+MQyUTr7yremtOTWMcktWDY92RfDFnjY1ESW0vjzY
	 Tu+2TD2/sDDtaVIvCdCmG0aFD+arog21YVO6ISQWskBLViQ5uOkXTTuQ6RYYIY+/eJ
	 LFV7mHO19kaAAmiuod3cU1EKzcZHpvgVyIWQPOKeA7aTmVPoQVMcpotAhUMIdrF0tq
	 cy7du9LMt8L/sIDZd+IxtZxBreH8wjTD6XsMma10Xs+Te+r4A+mehbmqJQK0QOEfYf
	 eF7+l/WOPGQ3A==
Date: Tue, 14 Jan 2025 13:29:44 -0800
From: Kees Cook <kees@kernel.org>
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
	kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
Message-ID: <202501141326.E81023D@keescook>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
 <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
 <202501061643.986D9453@keescook>
 <e8d21f15-56c6-43c3-9009-3de74cccdf3a@lucifer.local>
 <CABi2SkV72c+28S3ThwQo+qbK8UXuhfVK4K=Ztv7+FhzeYyF-CA@mail.gmail.com>
 <Z4bC1I1GTlXiJhvS@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4bC1I1GTlXiJhvS@google.com>

On Tue, Jan 14, 2025 at 12:02:28PM -0800, Isaac Manjarres wrote:
> I think the main issue in the threat model that I described is that
> an attacking process can gain control of a more priveleged process.

I understood it to be about an attacker gaining execution control through
a rewritten function pointer, not that they already have arbitrary
execution control. (i.e. taking a "jump anywhere" primitive and
upgrading it to "execute anything".) Is the expectation that existing
ROP/JOP techniques make protecting memfd irrelevant?

-- 
Kees Cook

