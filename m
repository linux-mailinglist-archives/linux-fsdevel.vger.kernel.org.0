Return-Path: <linux-fsdevel+bounces-45497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D44A7891C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 09:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3203AA074
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D05233724;
	Wed,  2 Apr 2025 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Veke8DoD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA41362;
	Wed,  2 Apr 2025 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579996; cv=none; b=kZk5r8iGAMfJP0l5j2oWjQl5hXGt+DnU/LerVhgCg+EKp4JvX7EKPcM68ue/CT2hxHnO0MVquEI/OZtp/2F28SwdT5QE8iViWJe1ike8OrHVvlVCFqVLPpZ+BzVPHozdSk5F8o4rzzi2xgAp5ALlMPcAh7DHaQ1Us+okiZUqi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579996; c=relaxed/simple;
	bh=0CyNYZbp3M9spA2X7521UflkqjTTBTzPZEk3HRxyFLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u11R8zqPXt9H//83uLnXou/69S5UhBrxEcW8TCC8Jq8Ew8MT7brgfLXY7vSMt7GSD0o8bdDhzpzkTWb2pJvzaUh//0orESbYgy17hD+hiDHJ3hS1hEo29q9zJ+1EKM00s1BZKbeSxQi31y4k4qBSRxJhglSNetQj4ZfOxhbmB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Veke8DoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00019C4CEDD;
	Wed,  2 Apr 2025 07:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743579995;
	bh=0CyNYZbp3M9spA2X7521UflkqjTTBTzPZEk3HRxyFLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Veke8DoD/W1xjnE/1pEkqK9yPlVbXAfGzjnEc/vCPg8ZiziFAGPIzFjLqdcTBFcgH
	 tZ1CRC6EcRKXEONk8qCHBYOpNlNQmYZG/TSDdn2MW7St4w1HvzZr/iDOuxjRMukVDE
	 k4XvYQ8C95pgEpK9VV2gBc1eJvRnmGVLuqMUH6dxQhlo+CodTl7kskiiKET0qj3+eo
	 cG8pem0DQXgeDhdxNOOtcg0Axx9JZBU4GqqQAG7etDQvdBt1amyScW3VL/kVRECWxG
	 FcXBCp/c2NsMaKHj6IfAAo/nDuuRzzfThnh0suFt2nW7gBLwhHEDF1IADhgn2lpBAH
	 mFTzJDd7Nu5Xg==
Date: Wed, 2 Apr 2025 09:46:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, rafael@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, djwong@kernel.org, 
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com
Subject: Re: [PATCH 0/6] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <20250402-radstand-neufahrzeuge-198b40c2d073@brauner>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <ddee7c1ce2d1ff1a8ced6e9b6ac707250f70e68b.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddee7c1ce2d1ff1a8ced6e9b6ac707250f70e68b.camel@HansenPartnership.com>

On Tue, Apr 01, 2025 at 01:02:07PM -0400, James Bottomley wrote:
> On Tue, 2025-04-01 at 02:32 +0200, Christian Brauner wrote:
> > The whole shebang can also be found at:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.freeze
> > 
> > I know nothing about power or hibernation. I've tested it as best as
> > I could. Works for me (TM).
> 
> I'm testing the latest you have in work.freeze and it doesn't currently
> work for me.  Patch 7b315c39b67d ("power: freeze filesystems during
> suspend/resume") doesn't set filesystems_freeze_ptr so it ends up being
> NULL and tripping over this check 

I haven't pushed the new version there. Sorry about that. I only have it
locally.

> 
> +static inline bool may_unfreeze(struct super_block *sb, enum
> freeze_holder who,
> +                               const void *freeze_owner)
> +{
> +       WARN_ON_ONCE((who & ~FREEZE_FLAGS));
> +       WARN_ON_ONCE(hweight32(who & FREEZE_HOLDERS) > 1);
> +
> +       if (who & FREEZE_EXCL) {
> +               if (WARN_ON_ONCE(sb->s_writers.freeze_owner == NULL))
> +                       return false;
> 
> 
> in f15a9ae05a71 ("fs: add owner of freeze/thaw") and failing to resume
> from hibernate.  Setting it to __builtin_return_address(0) in
> filesystems_freeze() makes everything work as expected, so that's what
> I'm testing now.

+1

I'll send the final version out in a bit.

