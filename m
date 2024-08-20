Return-Path: <linux-fsdevel+bounces-26396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FA9958E76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 21:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8B9B2240E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0E156F55;
	Tue, 20 Aug 2024 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLYcu0V5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01641547E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181061; cv=none; b=YZ84hala4arEaFAqZ3YM4p4q80TbQTysU4NCtECTqV/U3Mwhl7DHbaPj3ZS91SaafbpC4V81iheQBg/ZNY2LjYVRainCA3A8wRn6TKmM+pelxhXFkUj9itWcjYOf3wjxjpZATCctHK/T7OiWS7Qm2EpuEAvFoQJtWroRVEV5mEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181061; c=relaxed/simple;
	bh=10+Vuj/pofVPMG7PlqdNBBM8Mf2EqUDf4yp5tzK5/Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa5sDFFr2zuL9Wm5TiJVGatvQSXPjkHJ6XqWJsiEACLgyP7+yp9JqvTbaFhJeeviPrkILVc39HzNJQVwZso3CqtSwOG5tG/6dWQ+i80XJQbFmvIw3jXTEbU2qIZSWJnw69X+K29xn4jROZKp/r3zzahpRXo6rTcxHPRUtpu8qcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLYcu0V5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C298C4AF17;
	Tue, 20 Aug 2024 19:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724181060;
	bh=10+Vuj/pofVPMG7PlqdNBBM8Mf2EqUDf4yp5tzK5/Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLYcu0V5EwXQEYd/t2Eace4k7FC/Ibgg/YB79DFbBTNOPU0L6nmUnGAHxuFgTNufE
	 NbiuTKawWSIjL1hpfKnk8pnhgF6TIlLDtjM7AQWYe6ND9wOd9q5xuF/QOmOKL8mlsE
	 YaYmJF64zA0Jzj0plssUgjnrW/6PDC4oS58rdrxJQ0N1PtrNhG25S4N30G9lo6UzMr
	 5khic/d8H41hhrhzeKyr//97R2Yt0OQb9II3AufwpQiYLlJOTvfeXf6c4xOYYlxxAR
	 RrKfyvEbqJgikGy0nOYpvPDGFhimiBt2f+bTus6icatzN5WjVz9J59IgALO8673GN8
	 HgrJljzN5ghDQ==
Date: Tue, 20 Aug 2024 21:10:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 1/5] fs: add i_state helpers
Message-ID: <20240820-zeigen-exponentiell-c53cb0ee7f0d@brauner>
References: <20240820-work-i_state-v1-0-794360714829@kernel.org>
 <20240820-work-i_state-v1-1-794360714829@kernel.org>
 <CAHk-=whU6+8ndPZjXnebdW-LK+oVnp07e7EfY1M3yhdDpcinLg@mail.gmail.com>
 <CAHk-=wgxDM_g+PHPriey7J8OEy49dAKx2D5ASFXPuaed=x86-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgxDM_g+PHPriey7J8OEy49dAKx2D5ASFXPuaed=x86-A@mail.gmail.com>

On Tue, Aug 20, 2024 at 10:19:11AM GMT, Linus Torvalds wrote:
> .. and one more comment on that patch: it would probably be a good
> idea to make sure that the __I_xyz constants that are used for this
> are in the range 0-3.
> 
> It doesn't really *matter*, in the sense that it will all just be a
> cookie with a random address, but if anybody else ever uses the same
> trick (or just uses bit_waitqueue) for another field in the inode, the
> two cookies might end up being the same if you are very unlucky.
> 
> So from a future-proofing standpoint it would be good if the cookies
> that are used are always "within" the address range of i_state.
> 
> I don't think any of the bits in i_state have any actual meaning, so
> moving the bits around shouldn't be a problem.

Yeah, I reordered. I did not think this too big of an issue but you're
right.

