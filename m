Return-Path: <linux-fsdevel+bounces-8247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F3C831B4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023521F26EC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC0428DAE;
	Thu, 18 Jan 2024 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH2RHRMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74528DA5;
	Thu, 18 Jan 2024 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588024; cv=none; b=qRNCh3AGMR9crXaB+7HG2clNf5GaSKQf+cKlJhKifaGQRzVNJ03vgNeUEnHTr37BXSd2Gi0lBwnS0Ts1CmsNbSZKz0f+gNq4PisQasw/A3WlVjoac91RoxnAPI4btS7rpKwN5z7cD6ZKY+pOB6sN26ek3FfncPwVIiT8ppYSyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588024; c=relaxed/simple;
	bh=YmGrZjWGN6bhVc62uzAhw2r6YpLLQ2rytwNdVlCo1/M=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=bKhx9iYNCO40Eo37HX6JMcnKB1CeOx1ipSA4Vsw+sMppF9T/DqJsnEsPsbb4R4Wg8DS3Kb37Uj60N5O0ubs2obF8HD7uBWfAKfM4N/S/zEHeHGeP3hBgRYa61PDib7BwpfAiYMSNgYLLaWIi4mxWYc9JJSlcPeJL6w2BkW49c1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH2RHRMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FBBC433C7;
	Thu, 18 Jan 2024 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705588023;
	bh=YmGrZjWGN6bhVc62uzAhw2r6YpLLQ2rytwNdVlCo1/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HH2RHRMN+Y7+lj4he2mWElpSDJ0MublcMwlr55tUM8QobMsA6lNCoeYvWviSAOOUW
	 BtTxP2ba+8RN6ZGheqMnxTjTa+0OmZ5S730EKWDtXRSZgvaIY+r3r9jj6mbFJmPz91
	 FMm3HgnYKa18q02+fWR93xSVJVLWvUbdLJpWPfzpyTdCO1J/oeEm9hZ2NgIq7REmRN
	 RMcT9mcamKsvr0SB89zW2x1wg3tNawoghLeJX5ROKQE3+xTbXsSEyzvPOxkCpawdag
	 ougFQkrQs7ZtfAlTsHaKwu2oWJgvfNtnhmQLF12gwtyBZo1paXJAZGDo6AwQ2s0NWo
	 mcfvAH4Hb7X+g==
Date: Thu, 18 Jan 2024 15:26:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-btrfs@vger.kernel.org, 
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <20240118-lodern-einwohner-4b94d4153fd4@brauner>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
 <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
 <20240117143528.idmyeadhf4yzs5ck@quack3>
 <ZafpsO3XakIekWXx@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZafpsO3XakIekWXx@casper.infradead.org>

On Wed, Jan 17, 2024 at 02:52:32PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 17, 2024 at 03:35:28PM +0100, Jan Kara wrote:
> > OK. So could we then define the effect of your desired call as calling
> > posix_fadvise(..., POSIX_FADV_DONTNEED) for every file? This is kind of
> > best-effort eviction which is reasonably well understood by everybody.
> 
> I feel like we're in an XY trap [1].  What Christian actually wants is
> to not be able to access the contents of a file while the device it's
> on is suspended, and we've gone from there to "must drop the page cache".
> 
> We have numerous ways to intercept file reads and make them either
> block or fail.  The obvious one to me is security_file_permission()
> called from rw_verify_area().  Can we do everything we need with an LSM?
> 
> [1] https://meta.stackexchange.com/questions/66377/what-is-the-xy-problem

Nice idea and we do stuff like that in other scenarios such as [1] where
we care about preventing _writes_ from occuring while a specific service
hasn't been fully set up. So that has been going through my mind as
well. And the LSM approach might be complementary. For example, if
feasible, it could be activated _before_ the freeze operation only
allowing the block layer initiated freeze. And then we can drop the page
cache.

But in this case the LSM approach isn't easily workable or solves the
problem for Gnome. It would force the usage of a bpf LSM most likely as
well. And the LSM would have to be activated when the filesystem is
frozen and then deactivated when it is unfrozen. I'm not even sure
that's currently easily doable.

But the Gnome use-case wants to be able to drop file contents before
they suspend the system. So the thread-model is wider than just someone
being able to read contents on an active systems. But it's best-effort
of course. So failing and reporting an error would be totally fine and
then policy could dictate whether to not even suspend. It actually might
help userspace in general.

The ability to drop the page cache of a specific filesystem is useful
independent of the Gnome use-case especially in systems with thousands
or ten-thousands of services that use separate filesystem images
something that's not uncommon.

[1]: https://github.com/systemd/systemd/blob/74e6a7d84a40de18bb3b18eeef6284f870f30a6e/src/nsresourced/bpf/userns_restrict/userns-restrict.bpf.c

