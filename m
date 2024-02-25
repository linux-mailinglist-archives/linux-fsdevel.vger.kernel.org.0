Return-Path: <linux-fsdevel+bounces-12689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32B38628B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 02:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D111C20EF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 01:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82EB4437;
	Sun, 25 Feb 2024 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da1Igk7N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C71373;
	Sun, 25 Feb 2024 01:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708823799; cv=none; b=mjiNY0xBOc4f5GH8GdhJdcBMQ47jx4Z8sWUXq0KuzmI0xsKneYwFFDiGvzmuNa8R8zgo4QP0EDSH51IBPk4MMhqS3yQV56joe8+iu9eqDxQC/5KkvDr4lmqALwfWRSXlqCZkuQJlSCPqIPYpMsQF5Nxe2AOIEy056Rp/Cz3sL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708823799; c=relaxed/simple;
	bh=UvqWIJWk/fKmC0BgCEtyiPa4PvBytvqSC43sVrKiOgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/gI4StVtbS8ztNq+UYR+JFXA7wDETyQlLmV+YR/QigeQsis0FhiAuQ4p689xvpcg++DQK0emGnb+MaKQNbTdBS7QmNcSD9Cq5F1ChtVGeTeBYX82nV4uSDNTgD03IbnNgnYP2/fLC/DR4ztgn2fQlLOYSop5Mm676FXi6x3Y5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da1Igk7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C934FC433F1;
	Sun, 25 Feb 2024 01:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708823798;
	bh=UvqWIJWk/fKmC0BgCEtyiPa4PvBytvqSC43sVrKiOgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Da1Igk7NHNuZm9g1sN22OdkASAO7uh6lKWNADPQmJcSPNa0T9ZwgT01TREmmGXPSY
	 chnsLNbuInqOM8GBZ5f+nGjCEDBNP2pqmkG04gTJrlpLj2hnQfCEjWF6Ssh/sc7pu/
	 khzVGwLhuPeDeCd78OeSRdpVezGztcSwRBSxD6fzMXqwMWxRzhCmPc2/apNABjA7Sp
	 DWl+kuYw5y/+pIJ0WewuorxfuWJpGYF6rlousBSB9pxSKgZeSo2/S6T6E9j158atbt
	 2wKNo/BhVqx8JhAq4vRiLj9/N8PeaLDm6xRRDHdCShtNwkUNAzCMU/IioObwAUBj0v
	 37YHGueFwB94Q==
Date: Sat, 24 Feb 2024 20:17:51 -0500
From: Al Viro <viro@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matt Heon <mheon@redhat.com>, Ed Santiago <santiago@redhat.com>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Paul Holzinger <pholzing@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] 6.8-rc process is unable to exit and consumes a lot
 of cpu
Message-ID: <ZdqVP7q8iTJAdIbG@duke.home>
References: <6a150ddd-3267-4f89-81bd-6807700c57c1@redhat.com>
 <652928aa-0fb8-425e-87b0-d65176dd2cfa@redhat.com>
 <9b92706b-14c2-4761-95fb-7dbbaede57f4@leemhuis.info>
 <e733c14e-0bdd-41b2-82aa-90c0449aff25@redhat.com>
 <f15ee051-2cfe-461f-991d-d09fd53bad4f@leemhuis.info>
 <c0cbf518-c6d4-4792-ad04-f8b535d41f4e@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0cbf518-c6d4-4792-ad04-f8b535d41f4e@leemhuis.info>

On Sat, Feb 24, 2024 at 08:00:27AM +0100, Thorsten Leemhuis wrote:
> On 21.02.24 17:32, Linux regression tracking (Thorsten Leemhuis) wrote:
> > [adding Al, Christian and a few lists to the list of recipients to
> > ensure all affected parties are aware of this new report about a bug for
> > which a fix is committed, but not yet mainlined]
> > 
> > Thread starts here:
> > https://lore.kernel.org/all/6a150ddd-3267-4f89-81bd-6807700c57c1@redhat.com/
> 
> [adding Linus now as well]
> 
> TWIMC, the quoted mail apparently did not get delivered to Al (I got a
> "48 hours on the queue" warning from my hoster's MTA ~10 hours ago).
> 
> Ohh, and there is some suspicion that the problem Calvin[1] and Paul
> (this thread, see quote below for the gist) encountered also causes
> problems for bwrap (used by Flapak)[2].
> [1] https://lore.kernel.org/all/ZcKOGpTXnlmfplGR@gmail.com/
> [2] https://github.com/containers/bubblewrap/issues/620
> 
> Christian, Linus, all that makes me wonder if it might be wise to pick
> up the revert[1] Al queued directly in case Al does not submit a PR
> today or tomorrow for -rc6.

See #fixes in my tree.

