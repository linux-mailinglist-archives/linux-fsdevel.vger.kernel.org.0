Return-Path: <linux-fsdevel+bounces-71681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB4CCD088
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 18:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3926302E146
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733062C21D8;
	Thu, 18 Dec 2025 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQBQJgmT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C0263C8C;
	Thu, 18 Dec 2025 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080345; cv=none; b=ivAAWhSqHi8UQq/Aw2zbzitiQwtEV11h44Jf9T/DgwNRb4souhQsj0LAracV4P23jbyBS8j4+tIvg64PRUtLOCWl9EjAAXEcte+7bi7ik+tfPgdc/HgJQ8WF2eIt5rDpxAhK8mZ8hHsdSEygWmDLtEKJSWbRIiZ9SfN9e2YRd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080345; c=relaxed/simple;
	bh=GjRj8GD9Ct5gFbZm6q4oGHIUirMQ9WFABQyjT5hk/8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdn29/CG6HPedVn++6OkqG/gSHJgs902f/vQvJvpSlB2gMiQlun04zvKLpz0x2lJ9BrRKNxM2RV9/t/6zQbcIfxpIfAUAHZPDXjtI1uSrjCyjaAE1PkKgEtp2CCU79PcylDnY7RvmMfB9z4y1jmiETc4ovYjL+4rBWE+OQqYP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQBQJgmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A5CC4CEFB;
	Thu, 18 Dec 2025 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766080345;
	bh=GjRj8GD9Ct5gFbZm6q4oGHIUirMQ9WFABQyjT5hk/8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQBQJgmT/Mx2fvuJyG1dgT7PQ50moCTuiJkwykU7l8MLHoPXdfihZLmS7XhlBUaEd
	 pcvXsvoBILIBD5Z+/ASRm8/wS7Xd+mpju6+XGKxzF+q7u56r6L/DMeVSL9Llo0OlAD
	 FcylYfoziAht4aFfWGZmXJ3ZyTb3B4HFfTxvH9JbYKdsZUR3c+QgLO36UKBakR63mA
	 cu1NeU/u3Qb7ViYyKS5atFmFttLWirxWiCet5sU4FBy4UH5lFikkwlekDfetRVwgZQ
	 pKvEA5u/QJMnPnw6KwmC0OxoWP6MZWWMLEl2fBNRUMi/f9LEkylzxXhEtgbWTH/CHk
	 QU9gjKcD220HA==
Date: Thu, 18 Dec 2025 12:52:23 -0500
From: Sasha Levin <sashal@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	syzbot@syzkaller.appspotmail.com, Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] iomap: adjust read range correctly for
 non-block-aligned positions
Message-ID: <aUQ_V2O7yDhT1ynN@laps>
References: <20251203202839.819850-1-sashal@kernel.org>
 <CAJnrk1aSf+bTiRE40BSM72y8p_0CZjeJ4AHF78QbxxPicmPMXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aSf+bTiRE40BSM72y8p_0CZjeJ4AHF78QbxxPicmPMXw@mail.gmail.com>

On Wed, Dec 03, 2025 at 03:07:12PM -0800, Joanne Koong wrote:
>On Wed, Dec 3, 2025 at 12:28 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Joanne Koong <joannelkoong@gmail.com>
>>
>> [ Upstream commit 7aa6bc3e8766990824f66ca76c19596ce10daf3e ]
>>
>> iomap_adjust_read_range() assumes that the position and length passed in
>> are block-aligned. This is not always the case however, as shown in the
>> syzbot generated case for erofs. This causes too many bytes to be
>> skipped for uptodate blocks, which results in returning the incorrect
>> position and length to read in. If all the blocks are uptodate, this
>> underflows length and returns a position beyond the folio.
>>
>> Fix the calculation to also take into account the block offset when
>> calculating how many bytes can be skipped for uptodate blocks.
>>
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> Tested-by: syzbot@syzkaller.appspotmail.com
>> Reviewed-by: Brian Foster <bfoster@redhat.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>
>> LLM Generated explanations, may be completely bogus:
>>
>> Now I have all the information needed for a comprehensive analysis. Let
>> me compile my findings.
>>
>> ---
>
>I don't think any filesystems had repercussions from this. afaik only
>inlined mappings are non-block-aligned and the underflow of length and
>the overflow of position when added together offset each other when
>determining how much to advance the iter for the next iteration. But I
>have no objection to this being backported to stable. I think if this
>gets backported, then we should also backport this one as well
>(https://lore.kernel.org/linux-fsdevel/20251111193658.3495942-3-joannelkoong@gmail.com/).

Sure, I'll grab that one too. Thanks!

-- 
Thanks,
Sasha

