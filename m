Return-Path: <linux-fsdevel+bounces-40719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 480CEA2701D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE101885AC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D7E20ADD6;
	Tue,  4 Feb 2025 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4WIWnQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D262920127B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667995; cv=none; b=ExpcbD8ayfDBS2KNpCvYZwMOWCTb0VWbElDVQmYEyx1oFBUB9QfChnSMBQKT9QrZPNB2UIZVL5z9NwrFWwwktduum7NvIv+aZQBpMLX+rK/xl1ff1WPxuSV6mbOs9wVzmic/5kcY8wJ+2G7duk6UqwzF0LPB4jCd9ARvgR5mLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667995; c=relaxed/simple;
	bh=Aiu0gdOIT+paF770yAsSuocUe5gSQw4u7zqlPQ8FDhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2gWWUQRgD/AXMSvPz/mO46n3gJg+YZ16AbC4AWz/Rmn7I8syFo3+hgiW8FRqJM816PfAcxxvg0U0AlhhRai81h1DPPZKpkcld7KJ70nu8lbipWi5TyDdVGYpXoH+fZn4E4lpksIFmdEk3oNH6OTa+gp20ggkMNjjvSuZfx+iSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4WIWnQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103FEC4CEDF;
	Tue,  4 Feb 2025 11:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738667995;
	bh=Aiu0gdOIT+paF770yAsSuocUe5gSQw4u7zqlPQ8FDhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4WIWnQgZSPVLrNy+Eo2Q7FQvXFGjf15wOtpn63tPhqukwiePdloLObiECehs3/Da
	 dMVNT6DwtEIi27Ldj1icS5qOye/+JJP2PJSQHZIbFr3jjasYNLTUku5zDRGdXB3z5H
	 8ck9URz0Z3kMcn3yDQjyQ5ae//sAUUqSfUSkHgoBiE8hlPwNkwJK8NmvEaSQkfUkVO
	 zESpyFv9I4FqeW2eGCdwFbMP7Y9cYKwQ+ijuYZQ7lBW7IuPOpZTl8X1Wqj197VNV3x
	 px45ZvU9qFljqetZfFkjPE8dd6DI1CkWcFQPaqo/JcUYCDytsZf8GyOvVM+bSz28Mc
	 Jw6LjGIP9GuIg==
Date: Tue, 4 Feb 2025 12:19:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	lsf-pc@lists.linux-foundation.org, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [LSF/MM/BPF TOPIC] Removing writeback temp pages in FUSE
Message-ID: <20250204-lerngruppen-wohltat-9556f80a0089@brauner>
References: <CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com>
 <CAJfpegsDkQL3-zP9dhMEYGmaQQ7STBgpLtkB3S=V2=PqDe9k-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegsDkQL3-zP9dhMEYGmaQQ7STBgpLtkB3S=V2=PqDe9k-w@mail.gmail.com>

On Tue, Jan 28, 2025 at 12:10:04PM +0100, Miklos Szeredi wrote:
> On Mon, 27 Jan 2025 at 22:44, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > Hi all,
> >
> > Recently, there was a long discussion upstream [1] on a patchset that
> > removes temp pages when handling writeback in FUSE. Temp pages are the
> > main bottleneck for write performance in FUSE and local benchmarks
> > showed approximately a 20% and 45% improvement in throughput for 4K
> > and 1M block size writes respectively when temp pages were removed.
> > More information on how FUSE uses temp pages can be found here [2].
> >
> > In the discussion, there were concerns from mm regarding the
> > possibility of untrusted malicious or buggy fuse servers never
> > completing writeback, which would impede migration for those pages.
> >
> > It would be great to continue this discussion at LSF/MM and align on a
> > solution that removes FUSE temp pages altogether while satisfying mm’s
> > expectations for page migration. These are the most promising options
> > so far:
> 
> This is more than just temp pages.  The same issue exists for
> ->readahead().  This needs to be approached from both directions.
> 
> This year I'll skip LSF but definitely interested in the discussion.
> So I'll watch LWN for any updates :)

We can figure something out so that if you want to you can try and
attend that session virtually provided it's not an insane timezone issue
for you. Just offering, no pressure.

