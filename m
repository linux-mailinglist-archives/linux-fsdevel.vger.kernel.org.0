Return-Path: <linux-fsdevel+bounces-26395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC5958E74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 21:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607FE1F23E67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299EB156228;
	Tue, 20 Aug 2024 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb54F4wL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33E14C5A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180930; cv=none; b=DGNy46YZf1ov0Axkh1vpK8fsqsazJ0JUckKGGoGmsc1Tv7TsqaInBwJOb+X+6IoPoK6VAjZd8BEbgzIdDN5SIX5MYuvzhq5xPX0eSWORChIzQRzt1uD4RKFZBEzpOK7IE10eGidryiabjbuLldxNakaGrACgbJbuWvzVilhXlok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180930; c=relaxed/simple;
	bh=CNTPW2qU5TZgT1iggrsTLErpP9LgjndcV8pKcrUThyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQkcCWpotpsc3QRxIv73w7JMR2O18OFJVfln26hsgx16gWfYRFbfWuhg8ZRQxVYxiQLMuy0ziClYhYIq0sJzE9CvD8Xt9lJrr7qAerCdzYfJeW1W/BVlbCP6aMjqIs6hLrHoiwrRLPujMvson2DCPb+MLzW4/Wv7tuvAdjBA4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb54F4wL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37925C4AF13;
	Tue, 20 Aug 2024 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724180930;
	bh=CNTPW2qU5TZgT1iggrsTLErpP9LgjndcV8pKcrUThyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cb54F4wLNGiw2aYLCd3l+A0v+PzC+VDtt07DAtb2bv88FYEHuMtIaYC1Tl6ui36HL
	 LL3tu2Y08lROz5tmN4hvzZmvliUnMv/noZf4uqEqHEnn34hm4P0EegWqT0dh9PTaox
	 q/GSAXkcyq4Xnn8kh8DWvCQTHCY6Sflh87BJaKAlv1PuYnq3hzvRAn58Gs63FJEUrM
	 wK24VlpMpZksN8XDUOyPWefjtIpad38s7ZLS0283aq8KUzKCTjBKUKOEz38bTHnc7H
	 mOV1W9lejMJGfFIXJbN5t/Bg1pnlhprarl5tO8d2YAnA26SxYvQCRSeEaYMb+DObrz
	 x9Kd05yTZzBvw==
Date: Tue, 20 Aug 2024 21:08:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 1/5] fs: add i_state helpers
Message-ID: <20240820-nachkam-verruf-b101caaa84e2@brauner>
References: <20240820-work-i_state-v1-0-794360714829@kernel.org>
 <20240820-work-i_state-v1-1-794360714829@kernel.org>
 <CAHk-=whU6+8ndPZjXnebdW-LK+oVnp07e7EfY1M3yhdDpcinLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whU6+8ndPZjXnebdW-LK+oVnp07e7EfY1M3yhdDpcinLg@mail.gmail.com>

On Tue, Aug 20, 2024 at 10:10:51AM GMT, Linus Torvalds wrote:
> On Tue, 20 Aug 2024 at 09:07, Christian Brauner <brauner@kernel.org> wrote:
> >
> >
> > +struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
> > +                                           struct inode *inode, int bit);

Bah, I sent from the wrong branch. This is the branch where I even
forgot to remove that godforsaken ; at the end here...

> > +{
> > +        struct wait_queue_head *wq_head;
> > +        void *bit_address;
> > +
> > +        bit_address = inode_state_wait_address(inode, __I_SYNC);
> 
> Shouldn't that '__I_SYNC' be 'bit' instead?

Yeah, that's also fixed on the work.i_state branch. I sent from
work.i_state.wip... :/

