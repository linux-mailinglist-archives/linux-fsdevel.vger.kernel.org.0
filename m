Return-Path: <linux-fsdevel+bounces-43029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E981A4D1BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 03:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB15418979F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0900189BB1;
	Tue,  4 Mar 2025 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CCS25n5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2432CCC5;
	Tue,  4 Mar 2025 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055822; cv=none; b=IMIjDpJqayJB/usfq5OHT+tjPFlOjS4ggtuqBLbThFkaBMW8UnNyIYRgiKovYdGuhA1IlXHBD3IJzMResSMxA7PTORIZBEKXBFjAOar3bTY1kz5T5KjmCGzT9RTdloIEr5/G59fADCXSN8h20O6Ln1mGlooJmxEWDQnn/Z3zEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055822; c=relaxed/simple;
	bh=r+u+SDpxZAlaUfmN/RqhvJgErVPdeQzLaIabC9Bq1wc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mcJO+sSYgeDwa+nbidUMHzYSiliqNHamBofJmrifHGdBz8IeD+2wwvkYWUz1SOdQlWjvlpyh8AMPQh2sVcuYGJXdiDgzXVSA5YsubO5Tn1AFEtfQ8BTn0mH2KSCtGtLRJF5VqNvHDSHQ8K2FWKQN1qmyoo4NV6kcXEyYig9SIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CCS25n5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929C3C4CEE4;
	Tue,  4 Mar 2025 02:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741055821;
	bh=r+u+SDpxZAlaUfmN/RqhvJgErVPdeQzLaIabC9Bq1wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CCS25n5RNCKIWp352AQEuH/sqPYbkZOEKTZM2vKeebUvFrvGK6SRBsjAz5a9kiUKC
	 uaO63fKrgpNkvwzv9Jt6pzQDLmW7/WHCApbRVs3U3eyNQbWPeVWlll7220mzNIEwk9
	 TM6Mhe/yF0LvcMAWmyraoBeVWSU7KSupMpuSqG3A=
Date: Mon, 3 Mar 2025 18:37:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 tytso@mit.edu, willy@infradead.org, mjguzik@gmail.com, david@fromorbit.com
Subject: Re: [PATCH] [v2] filemap: Move prefaulting out of hot write path
Message-Id: <20250303183701.36624c484c54c2c3c6b470a5@linux-foundation.org>
In-Reply-To: <20250228203722.CAEB63AC@davehans-spike.ostc.intel.com>
References: <20250228203722.CAEB63AC@davehans-spike.ostc.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 12:37:22 -0800 Dave Hansen <dave.hansen@linux.intel.com> wrote:

> There is a generic anti-pattern that shows up in the VFS and several
> filesystems where the hot write paths touch userspace twice when they
> could get away with doing it once.
> 
> Dave Chinner suggested that they should all be fixed up[1]. I agree[2].
> But, the series to do that fixup spans a bunch of filesystems and a lot
> of people. This patch fixes common code that absolutely everyone uses.
> It has measurable performance benefits[3].
> 
> I think this patch can go in and not be held up by the others.

I'll queue this in mm-hotfixes with a view to sneaking it into 6.14-rcX
as a basis for others to work against.


