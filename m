Return-Path: <linux-fsdevel+bounces-59058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A0B34075
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 025637A215A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48401FF60A;
	Mon, 25 Aug 2025 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxQucU9M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161BEDF71;
	Mon, 25 Aug 2025 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127694; cv=none; b=ormHSOVFYySaahz9C2iUz+lLhtMDfSGe7fLDE9RnoxQtNx+xseESazQNqXltFDH5cn9oyZPgAMmQtGLqCrvyE/ih7pvA5gcDuDeTAHAAaeCQ90U91bctSXdVBWLNA41q8JaTch4v4UQ/SHR9uel3QfqOJCWUTVk/k+cH8Lomymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127694; c=relaxed/simple;
	bh=5zMXK+mlZFNma3gJEndOhDDPwfxNjOAVz0/p9JD6wJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NejHFllx5VOL5jQ19oOWqCrn1aVR0b49eSfKq34q/TwgCR6nf/NzPaSsw23GWUHofAVvR2P8U0ZamDZvqsh5u1Wyh2QgVwDl/0RGmDXOa/BJ9Ffrchr4jXrOS5Z1T5/YKs+qgs5Z/O5VGxPC2HvMoeO+LGEZm1oB01l0myRphs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxQucU9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3625C4CEED;
	Mon, 25 Aug 2025 13:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756127693;
	bh=5zMXK+mlZFNma3gJEndOhDDPwfxNjOAVz0/p9JD6wJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxQucU9MGpEKJinxjV8SzQ+jYJdobmsejsaICYu99+loMGXs7KDUMIv9c59D6FBlq
	 QXHd6OWxgq6jK1P/4hypVueVd8JUvbLQ/em5LhW5Hgxlp8HDKmF4ErOfNIdZhkAC3l
	 e02NnOFNRyDr6mwKtpVbMbBqgt45egu7a58SphQHwD8mpDY8yQagN2+n94mTBqSlMO
	 mu+ktLnqhmavwHTWgBTgD9yoeuFaoqhTFEh+4FqTrfMIn1LmGjhx+jel+NQQtIUdIY
	 bxu59gbU4gL9rJD6ERzBBPTvJJvMqkKfvdiw4NThgeBcmcN9AF5ulBdi6UR5dgXrJG
	 QwLmi7PqtZ8Ig==
Date: Mon, 25 Aug 2025 15:14:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, David Howells <dhowells@redhat.com>, 
	autofs mailing list <autofs@vger.kernel.org>, patches <patches@lists.linux.dev>
Subject: Re: [PATCH 0/4] vfs: if RESOLVE_NO_XDEV passed to openat2, don't
 *trigger* automounts
Message-ID: <20250825-wimpel-umschalten-e1159287e5b4@brauner>
References: <20250817171513.259291-1-safinaskar@zohomail.com>
 <2025-08-18.1755494302-front-sloped-tweet-dancers-cO03JX@cyphar.com>
 <20250819-direkt-unsympathisch-27ffa5cefb4e@brauner>
 <198e1441f72.ff66ccf525195.4502015239657084211@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <198e1441f72.ff66ccf525195.4502015239657084211@zohomail.com>

On Mon, Aug 25, 2025 at 04:46:34PM +0400, Askar Safin wrote:
> 
>  ---- On Tue, 19 Aug 2025 12:21:33 +0400  Christian Brauner <brauner@kernel.org> wrote --- 
>  > On Mon, Aug 18, 2025 at 03:31:27PM +1000, Aleksa Sarai wrote:
>  > > I would merge the first three patches -- adding and removing code like
>  > Agreed.
> 
> May I still not merge these patches?
> 
> All they may (hypothetically) fail on their own.
> 
> If they do, then it will be valuable to know from bisection which of them failed.
> 
> Let's discuss them one-by-one.
> 
> The first patch moves checks from handle_mounts to traverse_mounts.
> But handle_mounts is not the only caller of traverse_mounts.
> traverse_mounts is also called by follow_down.
> I. e. theoretically follow_down-related code paths can lead to problems.
> I just checked all them, none of them set LOOKUP_NO_XDEV.
> So, they should not lead to problems. But in kernel we, of course, never
> can be sure. They should not lead to problems, but still can.
> 
> The second patch removes LOOKUP_NO_XDEV check.
> This is okay, because if "jumped" is set and "LOOKUP_NO_XDEV" is set, then
> this means that we already set error, and thus ND_JUMPED should
> not be read, because it is not read in error path. But this is not obvious, and
> so Al asked me add comment (
> https://lore.kernel.org/linux-fsdevel/20250817180057.GA222315@ZenIV/
> ), and, of course, I will add it in the second version in any case.
> So, ND_JUMPED should not be checked in error path, and thus this should
> not lead to problems. But still can.
> 
> The third patch makes traverse_mounts fail
> immidiately after first mount-crossing
> (if LOOKUP_NO_XDEV is set). As opposed to very end.
> This should not lead to problems. But can.
> 
> So, again, any of these 3 patches can (hypothetically)
> lead to its own problems.

You can send them separately if you like but I'll still reserve the
right to squash them when applying. I don't see the value in these
minimal changes yet and the regression potential is completely
theoretical so far.

