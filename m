Return-Path: <linux-fsdevel+bounces-32657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3629AC942
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544771C216BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 11:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043351AB50B;
	Wed, 23 Oct 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5x+071z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A3134BD;
	Wed, 23 Oct 2024 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683695; cv=none; b=c8O2XVKN8M5MrYjBnWzx3YFuTkUsBkMS6wMEMvdenAftDmfF3RK30Nk6/wb7h4N4P5bMQFJlw779QRvYqJ9hG2SGQSjJqt9u6vR4xzEH3AMYaq+3HIGUDqICTJoZ0idZRTF/ST040+rrZc55mieAd/8fxJ/TM0/uf0Yv+tStE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683695; c=relaxed/simple;
	bh=OKXQS4ygVGvLAMLaf78m5yuEb8FH+2TrRxZhgrF97N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gmb4kB5Ek40n9/OPizoQ8SXeZtUp6Muq2tcbNTqMOqVS/P14Auud/8ut6yGfmukRwFmWF936918gWp7XhF/Gsl5CnkrX19w1DbPbBOXpTFeSWJEB7Pwf/hg5wLgVNPkwH4P8CL3MdzC9dL6ktW0xrW7k/ayBJd5u2utS0EhFYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5x+071z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E98C4CECD;
	Wed, 23 Oct 2024 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729683693;
	bh=OKXQS4ygVGvLAMLaf78m5yuEb8FH+2TrRxZhgrF97N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5x+071zTbgZ87ZJfrp/30BhU6bb5X1XlWPOMy81sus4RTlOV/p1V9aC4t8jNOS/0
	 SiThhFPhwDhhjtBiforR5cw6CjmjX3SX0EBebLwj4fD2C2qUP9j8Xpt1chOqYY/APg
	 MzUuDiSwSCySfmTJWjxBiyQdGpBnzQoS+khc7xPb5MlkK0Q4BckoPv2BI8Vpmpcpz/
	 wd2kTxFZ9+DqZTIIVkzlCQNNe8rF3yI/jzX2+gEoV7z7+jTj0mFZP9eHLU9v8GSjNy
	 BwuhzayzsAyfVBuvhi6Ym8uNRDjvi+80EIn7D+9eBUuBNJ8FY5xmIhvOKdBVDYj1sV
	 vP5+YwrukH15A==
Date: Wed, 23 Oct 2024 07:41:32 -0400
From: Sasha Levin <sashal@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kees@kernel.org, hch@infradead.org,
	broonie@kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc5
Message-ID: <Zxjg7Cvw0qIzl0v6@sashalap>
References: <rdjwihb4vl62psonhbowazcd6tsv7jp6wbfkku76ze3m3uaxt3@nfe3ywdphf52>
 <Zxf3vp82MfPTWNLx@sashalap>
 <20241022204931.GL21836@frogsfrogsfrogs>
 <ZxgXO_uhxhZYtuRZ@sashalap>
 <87iktj2j7w.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87iktj2j7w.fsf@mail.lhotse>

On Wed, Oct 23, 2024 at 09:42:59PM +1100, Michael Ellerman wrote:
>Hi Sasha,
>
>This is awesome.
>
>Sasha Levin <sashal@kernel.org> writes:
>> On Tue, Oct 22, 2024 at 01:49:31PM -0700, Darrick J. Wong wrote:
>>>On Tue, Oct 22, 2024 at 03:06:38PM -0400, Sasha Levin wrote:
>>>> other information that would be useful?
>>>
>>>As a maintainer I probably would've found this to be annoying, but with
>>>all my other outside observer / participant hats on, I think it's very
>>>good to have a bot to expose maintainers not following the process.
>>
>> This was my thinking too. Maybe it makes sense for the bot to shut up if
>> things look good (i.e. >N days in stable, everything on the mailing
>> list). Or maybe just a simple "LGTM" or a "Reviewed-by:..."?
>
>I think it has to reply with something, otherwise folks will wonder if
>the bot has broken or missed their pull request.
>
>But if all commits were in in linux-next and posted to a list, then the
>only content is the "Days in linux-next" histogram, which is not that long
>and is useful information IMHO.
>
>It would be nice if you could trim the tail of the histogram below the
>last populated row, that would make it more concise.

Makes sense, I'll do that.

>For fixes pulls it is sometimes legitimate for commits not to have been
>in linux-next. But I think it's still good for the bot to highlight
>those, ideally fixes that miss linux-next are either very urgent or
>minor.

Right, and Linus said he's okay with those. This is not a "shame" list
but rather "look a little closer" list.

>>>> Commits that weren't found on lore.kernel.org/all:
>>>> --------------------
>>>> e04ee8608914d bcachefs: Mark more errors as AUTOFIX
>>>> f0d3302073e60 bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocations
>>>> bc6d2d10418e1 bcachefs: fsck: Improve hash_check_key()
>>>> dc96656b20eb6 bcachefs: bch2_hash_set_or_get_in_snapshot()
>>>> 15a3836c8ed7b bcachefs: Repair mismatches in inode hash seed, type
>>>> d8e879377ffb3 bcachefs: Add hash seed, type to inode_to_text()
>>>> 78cf0ae636a55 bcachefs: INODE_STR_HASH() for bch_inode_unpacked
>>>> b96f8cd3870a1 bcachefs: Run in-kernel offline fsck without ratelimit errors
>>>> 4007bbb203a0c bcachefS: ec: fix data type on stripe deletion
>
>Are you searching by message id, or subject? I sometimes edit subjects
>when applying patches, so a subject search could miss some.

Both, and also by patch id, so if you just change the subject it should
still be okay.

We'll see when you send your next PR :)

-- 
Thanks,
Sasha

