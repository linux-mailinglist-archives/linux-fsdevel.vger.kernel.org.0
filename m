Return-Path: <linux-fsdevel+bounces-22970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C03A924622
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FBB1F20ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71041BE849;
	Tue,  2 Jul 2024 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HEmhEdLq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1B63D
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941491; cv=none; b=IGAtF7c4oH6Ng76X3ET4Z1sFY0Vkr/YPONZLhnWRO+l55Ioq5t/Us7xDcyga7KnWXDV4eakJkGGPaEf24cVwsN3qBWBOiQ3RImTQslg7pj/kayMTWTnlYzbSjxGtyxw/qDTyWU7HDK1eDFjYc9SoGC08vspy8pt3sz0avYO2hlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941491; c=relaxed/simple;
	bh=r/YhrAHWUbPKoglqJ1ZtsVDgH66uphx2N/55Lrvzi80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrmY8wovOFw3Mxqd6SHiyu2Q8EzvI2M+sXDOVVXPjGclVrZyKosrFHfog5CCqtTqXA6lRaloJL5171+Q1ouiBUE2RGdf2LSGR1vrY6R5UBuMmZ4zwEHBDWW8TCdMPjnMSc5kn/tT0BvLyn212ZooWtjeytMHIv85aqco/ieMbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HEmhEdLq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b4fec3a1a7so22147726d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719941488; x=1720546288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQVZExdhIfPvtCyWWYiD53zNV4LuZxhlBVYH64erQ1s=;
        b=HEmhEdLqI/s+KW5dTPFgfM1ZGsvB7A6ZdCAqn7BgUZulWu/P/oXwu0UOtyVLS8BoLK
         NTy+qFkmT6mYXFBc9nCQk9K6z1o/PIjCaYdZw7lPuaoHVjS1WC81hQKDPygozgqX3lUB
         zIIj5DQLwwNl7Y8QQTBACr0uSAw3isIHfOhEAFln2Uuc/YZhxxdCMrOOEf+/avluCmli
         Sgs3ym4/jfTWwWDtGlbF8Wyqa6EP3XIH/9nsORh9qKvo5rz9ZxH5kxdGP33THNkqyZCT
         95a9VHW3vBnkOrgb6uGJ1gNh6JJpe95tLY4vELG8BS+4N5UCH7k4z1kiAa+uKWyuNI8X
         O26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719941488; x=1720546288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQVZExdhIfPvtCyWWYiD53zNV4LuZxhlBVYH64erQ1s=;
        b=vImyRAyimi+hngXMhpJiYz2OA3pNqOaMdAOcB8cnoh+2viPr5SZ8cDuR92NwNZwthE
         2qVXCE69cKHxwosSmxJeLBRiiWCtCT4ldsAOhb+fvMUSRiilSxvxiVhfXLAWq49uKDAq
         1taZkvPer23CqBOb1klEXPZhAVsqlxNdgsFtWdTkxjCWOc0gXc99cKgzwKHNQh9b5kHq
         j8boZAiKkWxxbYSf2RXD7DWr3zdacwtE3fPrS7UZShgEVRUcd5UaHRO1UA3gEIjhbe9L
         9qQzRcgNWTySvDFtz2CNo7O8XZ3eAtDLk5Dsnlooe5aCVoON89vvZIRqUmGUd0dumzHQ
         nYQw==
X-Gm-Message-State: AOJu0YwoaPBGBojmH4OseQoBrKbaTPwZrnZGSarjlSm5Tngui1gP57u0
	oGvDiGGmxMoCC1Lf4iAzemPPheI8yuUe+TDFvB1o7AX8MymCmrqxl9/0ZJJHXE7vz1WftwS689z
	g
X-Google-Smtp-Source: AGHT+IEXQV2jlAlR+74PYVK6+4bK+ZVftttcy566mS3QaUdhxdryhPLleK+HGS7/XFrWT2elq04V2Q==
X-Received: by 2002:ad4:5aaa:0:b0:6b0:77fb:8f24 with SMTP id 6a1803df08f44-6b5b70bcbc0mr116835296d6.17.1719941467188;
        Tue, 02 Jul 2024 10:31:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5ba68d03esm31259496d6.112.2024.07.02.10.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:31:06 -0700 (PDT)
Date: Tue, 2 Jul 2024 13:31:06 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Ian Kent <ikent@redhat.com>
Subject: Re: [PATCH] vfs: don't mod negative dentry count when on shrinker
 list
Message-ID: <20240702173106.GB574686@perftesting>
References: <20240702170757.232130-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702170757.232130-1-bfoster@redhat.com>

On Tue, Jul 02, 2024 at 01:07:57PM -0400, Brian Foster wrote:
> The nr_dentry_negative counter is intended to only account negative
> dentries that are present on the superblock LRU. Therefore, the LRU
> add, remove and isolate helpers modify the counter based on whether
> the dentry is negative, but the shrinker list related helpers do not
> modify the counter, and the paths that change a dentry between
> positive and negative only do so if DCACHE_LRU_LIST is set.
> 
> The problem with this is that a dentry on a shrinker list still has
> DCACHE_LRU_LIST set to indicate ->d_lru is in use. The additional
> DCACHE_SHRINK_LIST flag denotes whether the dentry is on LRU or a
> shrink related list. Therefore if a relevant operation (i.e. unlink)
> occurs while a dentry is present on a shrinker list, and the
> associated codepath only checks for DCACHE_LRU_LIST, then it is
> technically possible to modify the negative dentry count for a
> dentry that is off the LRU. Since the shrinker list related helpers
> do not modify the negative dentry count (because non-LRU dentries
> should not be included in the count) when the dentry is ultimately
> removed from the shrinker list, this can cause the negative dentry
> count to become permanently inaccurate.
> 
> This problem can be reproduced via a heavy file create/unlink vs.
> drop_caches workload. On an 80xcpu system, I start 80 tasks each
> running a 1k file create/delete loop, and one task spinning on
> drop_caches. After 10 minutes or so of runtime, the idle/clean cache
> negative dentry count increases from somewhere in the range of 5-10
> entries to several hundred (and increasingly grows beyond
> nr_dentry_unused).
> 
> Tweak the logic in the paths that turn a dentry negative or positive
> to filter out the case where the dentry is present on a shrink
> related list. This allows the above workload to maintain an accurate
> negative dentry count.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

This is sort of a subtle interaction, it took me a bit to piece it together,
could you add a comment to the sections indicating the purpose of the extra
check?  Thanks,

Josef

