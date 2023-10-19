Return-Path: <linux-fsdevel+bounces-730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935047CF412
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F59B21245
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E692171DD;
	Thu, 19 Oct 2023 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Akk8XbjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7ED171C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 09:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8202C433C8;
	Thu, 19 Oct 2023 09:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697707761;
	bh=pxF/qlOAYAx3vhRa3N2z4pQJEwL4Rx1j8JuRrkeWQ9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Akk8XbjDzYlsS3LMaveazcyIGPYT4DucacgiYEdLUsG9DE37MYww77gNzF8oD0aIz
	 ivYs6S62MDqSkKZ2FSGs0EmDEo8tocNJK8foS47nkvwPPrwXEYbvlmNJREcl85jaSo
	 W2BVMZYKsVeUTLgaD8Glg3bCDKmcsXMB4TQ+drVb8NJMw3lHm496br86KHTQZ/8Zyb
	 g/RsWsns1nYNpbj9jPm/YNq9u/5F+tr6mqZODsyxp9EIv/pRppQ674gaTd+0b+V+Cj
	 snsoxrWMyEcUDbEv+U6dRWrQlgFx/kgAx8uWCE3zgeH8LlxfATd2AlTC/m2t5XRPaa
	 Uokex6cURRqGw==
Date: Thu, 19 Oct 2023 11:29:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <20231019-fluor-skifahren-ec74ceb6c63e@brauner>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
 <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>

> Back to your earlier point though:
> 
> Is a global offset really a non-starter? I can see about doing something
> per-superblock, but ktime_get_mg_coarse_ts64 should be roughly as cheap
> as ktime_get_coarse_ts64. I don't see the downside there for the non-
> multigrain filesystems to call that.

I have to say that this doesn't excite me. This whole thing feels a bit
hackish. I think that a change version is the way more sane way to go.

> 
> On another note: maybe I need to put this behind a Kconfig option
> initially too?

So can we for a second consider not introducing fine-grained timestamps
at all. We let NFSv3 live with the cache problem it's been living with
forever.

And for NFSv4 we actually do introduce a proper i_version for all
filesystems that matter to it.

What filesystems exactly don't expose a proper i_version and what does
prevent them from adding one or fixing it?

