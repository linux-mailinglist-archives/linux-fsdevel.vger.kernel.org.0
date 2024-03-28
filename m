Return-Path: <linux-fsdevel+bounces-15601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B6F8908EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA52B1C2CF5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 19:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51A013792C;
	Thu, 28 Mar 2024 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KvJB7SoZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B986168C
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653312; cv=none; b=QLft/3loDA9XEDrtIGlUXlRbocoYgZQ1bRKQMYYXT+ajHH2m8rkRBpmMopaBlTB5Qk3qK6q5OT0Nu4ru+JC5Wvy5/zbHipa6peMWA1QsNLvp3cEIgbjtuzCSnLJmtcbIYAZGptteKEzeE4PADxcrjB0FI7+vTWI9/rhm8FjnVAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653312; c=relaxed/simple;
	bh=zM7PQiHxWzOWOO4OCrDwshJ55wl6Sv3jEAqMenXlYfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is2FC4mJCTBfCgympXEv4Z9w05+kKwUCgCz/W0r4lVnA/kiXNkG7zEfBA8rbn5/2zGK+JfFhRPWUxHZcFNxIafVy+/d2snQS/hMe6zMJmPpKkXbJnLqwRwnbqaNjUehT8WI8DeEV4ksudaFNHWFfPS6g9WbD4Hja4koVKEIPuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KvJB7SoZ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Mar 2024 15:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711653308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UiiYaB+fnO7Vb9P9+KhFx8SmJF7I5vpoUotl6zT2/zs=;
	b=KvJB7SoZJKVuzlqFVWM0vRr2iWIHkYGpJutBec/Y0CDeoRB3ZqbEZnoiYkOlkksKTFjkgc
	ZCl0V6MkQaKz+XlvCm77TLAL4XRYFaNjdlbdfH1ZqLGFKR/WklakWlabZ6DvLfZlpu8cMo
	T9CtcB9YVXDlDIj6D7xWNsnofVKorJA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, willy@infradead.org, 
	jack@suse.cz, bfoster@redhat.com, tj@kernel.org, dsterba@suse.com, 
	mjguzik@gmail.com, dhowells@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <kind5tn6ythzjca3r5wrshjyveawm7il7ng4n6zyfwctafmqwo@eldoiinbwtbn>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327104010.73d1180fbabe586f9e3f7bd2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327104010.73d1180fbabe586f9e3f7bd2@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 27, 2024 at 10:40:10AM -0700, Andrew Morton wrote:
> On Wed, 27 Mar 2024 23:57:45 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
> > This series tries to improve visilibity of writeback.
> 
> Well...  why?  Is anyone usefully using the existing instrumentation? 
> What is to be gained by expanding it further?  What is the case for
> adding this code?
> 
> I don't recall hearing of anyone using the existing debug
> instrumentation so perhaps we should remove it!

Remove debug instrumentation!? Surely you just?

I generally don't hear from users of my code when things are working, I
only expect to hear from people when it's not.

