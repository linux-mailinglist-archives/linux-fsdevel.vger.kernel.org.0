Return-Path: <linux-fsdevel+bounces-966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3297D42BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 00:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9CA1C20AAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 22:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5220317;
	Mon, 23 Oct 2023 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRkQ20xP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C52257D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 22:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D2AC433C7;
	Mon, 23 Oct 2023 22:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698100691;
	bh=vA1Y4ccV01ZF/Fj23s9wmH5FgbkPa7s6VyAtYkdRKC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRkQ20xPU/elTUdrd+KM4t6GWLWv9jE3rnYI4d59+cHIJHwIjacqA5/nOoP3SzaSO
	 YRW8CBaIN++fYnnZsyTgHE5Q/yLMfK1k2m6x1NKjIrFeIAb+Hz2RVpttxGpN6kUsM9
	 Q/D+VHG6VwvKN5LbT7c/EMSMAtdv7c1SO5fmLZMCsuNVKuR+Wxk/bzlTJcpoGqb2o4
	 8tiRN0BJAzq9GMUnsw5CxXYMK7J4jaMcdh22zxtUcPC/ciKZp0CF3TLNz32PM97SAs
	 GIidOj1cXJxJ6iwVowSGbViuS/i0HFWaSaA0k+D/0bmeGHFoQmFj1r4+tPH8RxGKLt
	 erF5PZgHN+BVA==
Date: Mon, 23 Oct 2023 15:38:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Shirley Ma <shirley.ma@oracle.com>
Cc: hch@lst.de, jstancek@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc7
Message-ID: <20231023223810.GW3195650@frogsfrogsfrogs>
References: <169786962623.1265253.5321166241579915281.stg-ugh@frogsfrogsfrogs>
 <CAHk-=whNsCXwidLvx8u_JBH91=Z5EFw9FVj57HQ51P7uWs4yGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whNsCXwidLvx8u_JBH91=Z5EFw9FVj57HQ51P7uWs4yGQ@mail.gmail.com>

On Sat, Oct 21, 2023 at 09:46:35AM -0700, Linus Torvalds wrote:
> On Fri, 20 Oct 2023 at 23:27, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Please pull this branch with changes for iomap for 6.6-rc7.
> >
> > As usual, I did a test-merge with the main upstream branch as of a few
> > minutes ago, and didn't see any conflicts.  Please let me know if you
> > encounter any problems.
> 
> .. and as usual, the branch you point to does not actually exist.
> 
> Because you *again* pointed to the wrong tree.
> 
> This time I remembered what the mistake was last time, and picked out
> the right tree by hand, but *please* just fix your completely broken
> scripts or workflow.
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git iomap-6.6-fixes-5
> 
> No.
> 
> It's pub/scm/fs/xfs/xfs-linux, once again.

Sorry about that.  After reviewing the output of git request-pull, I
have learned that if you provide a $url argument that does not point to
a repo containing $start, it will print a warning to stderr and emit a
garbage pull request to stdout anyway.  No --force required or anything.
Piping stdout to mutt without checking the return code is therefore a
bad idea.

I have now updated my wrapper script to buffer the entire pull request
contents and check the return value before proceeding.

It is a poor workman who blames his tools, so I declare publicly that
you have an idiot for a maintainer.

Christian: Do you have the bandwidth to take over fs/iomap/?

--D

> 
>                  Linus

