Return-Path: <linux-fsdevel+bounces-3790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B2C7F86BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 00:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD95282658
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80AC3DB80;
	Fri, 24 Nov 2023 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGeu7lTC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2C171A4;
	Fri, 24 Nov 2023 23:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED29BC433C7;
	Fri, 24 Nov 2023 23:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700868760;
	bh=ciMi0fW0vmaEQdB5oP+4F9FjMlcGm67TteZhpJJLhrE=;
	h=Date:From:To:Cc:Subject:From;
	b=mGeu7lTCmeR3++Kl4BaId33/4oki04qRD89AqWGQUyrGzjoIWHM6QCwuwg02Modhw
	 yBba+hpngDJepj4F9OXHWXGTm+NWzqYrrDu+KZUlj8L3MBMnsVnOYKWbSWj47H8y22
	 3n6KV10yFoDTGXw2v3dA1C6hentaWGnalPgahrzeEbSMCC3q9hQxP++5lfkFO//r1/
	 wn/ohH73wlSWPWDOexldD8+ifpTMwMRq+Pke43neC/RUHA9WnR7byDj5VugqUwNE5K
	 MstGbOnF08gEp5FCttvk5XH7m/OkTbxcDggVX+4fKrL3ZFZWP1IN8ib+e6bAjR7pYn
	 W0sUcKJb4qFHg==
Date: Fri, 24 Nov 2023 15:32:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>,
	Chandan Babu R <chandanbabu@kernel.org>
Cc: xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Catherine Hoang <catherine.hoang@oracle.com>
Subject: Re: [MEGAPATCHSET v28] xfs: online repair, second part of part 1
Message-ID: <20231124233239.GJ36190@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

[this time not as a reply to v27]

I've rebased the online fsck development branches atop 6.7, applied the
changes requested during the review of v27, and reworked the automatic
space reaping code to avoid open-coding EFI log item handling, and
cleaned up a few other things.

In other words, I'm formally submitting part 1 for inclusion in 6.8.

Just like the last several submissions, I would like people to focus the
following:

- Are the major subsystems sufficiently documented that you could figure
  out what the code does?

- Do you see any problems that are severe enough to cause long term
  support hassles? (e.g. bad API design, writing weird metadata to disk)

- Can you spot mis-interactions between the subsystems?

- What were my blind spots in devising this feature?

- Are there missing pieces that you'd like to help build?

- Can I just merge all of this?

The one thing that is /not/ in scope for this review are requests for
more refactoring of existing subsystems.  I'm still running QA round the
clock.  To spare vger, I'm only sending a few patchsets this time.  I
will of course stress test the new mailing infrastructure on 31 Dec with
a full posting, like I always do.

--D

