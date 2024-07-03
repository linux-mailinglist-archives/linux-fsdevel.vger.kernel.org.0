Return-Path: <linux-fsdevel+bounces-23042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F71E9263B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0692D284D8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2B017C7C4;
	Wed,  3 Jul 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="tteoUKrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D29A17C212
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017835; cv=none; b=cKkvZe58Ne3LBol0fITw8rWAmOXTuUocES8G0rf+k3VXAY6HUOCb4wkLr2SL5wZju+g3pl4Gciqz1H2DwTxB6lZG5ArQcJpa4W19YR71k2wTdSkDJblgMpJnWFSNWBEeNfLBA/7/r4XAHkkiOod/0lX4Yp66/vGMVMByvsP8VRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017835; c=relaxed/simple;
	bh=b5lhBqWBS+UOnk+7E38JG0t/gdoge7ByHz/rKz3mGKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+IuSiSj7y1Yw48UC9NcwNiYhnBipbtRopZIdjubrrDK9NybAsCE7zqwUowZrkVGfQmWD4uHDH3ozMxiHAg4ZvrmjVEr23sNP3KR0bZv2jpdLdKPEdN1Ey25DBAwU94w2XkSC4gJTzIUeFneYlMp26F2Fgi/vmoye274nRe6WUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=tteoUKrB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b42574830fso24964386d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 07:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720017832; x=1720622632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AViRFNF3RbRw5tmiYfTqe5Z9RHXQgjVDhtZFlV5tAWw=;
        b=tteoUKrBzMXISe1gSxYflkrC0MXTrDmpL98k3b3cJ4IS01B9gZIbamdGdUHJcrJbs5
         ToaEtKsPqyfp5xdAqDUVz7loL0EsiG/l9FTGHvOzgv1pIu+7JIrJbP/B00HvIzjilFwQ
         jYRS80zfQK5/BGSUzvUMATSSFE2Kh8lOmU5rRxbJod9YfFYhy5HnfLO2IBFmToEItwtG
         VbVN2Xi3AKNzOGfTTwtumkevzSjM90r1X7wJjzkwOurptTYPfWOql/oYYR86fKq4x7xk
         MFtjWrPVCz47IZnPe8pwrIDjMjmisoN3SCHFELMzbUTSIZ7sZzq1cuxolQ44lG4Ox1RB
         DjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720017832; x=1720622632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AViRFNF3RbRw5tmiYfTqe5Z9RHXQgjVDhtZFlV5tAWw=;
        b=s6LkW1UHhLxQD0AdYzSUHxQ7nKqtgLp+4VST1OUJwbwX5UcrP0D+R5J+CRc1aMqubk
         Nos7R9pTzivXjC3n6n1lVpNhkIgkMtg6bcm1DTh6IbiePP8HCI01DbJqwAVzmDUYsd2L
         joCEco6iafrplIYSad9VIsCiYhze2eOVodtD8GxP2R6pljKydBciRrTJsTqrnRP++Nnq
         emY31dgCRQ3MHPPp0/fuE7+t0oWi7AqvOVXunUCzrgtD64w81mQLh1xyZsaoZk5QvYUS
         WFMZYUnA879jwlT58R2z1D7/crJLAXLKP8SHuyMIg4EUgFmtTih6/Kz1FNxG/issiU0e
         8Mng==
X-Gm-Message-State: AOJu0Yx8h+xnzvYLGdmVi32UzBi1N2E+UpJz/8r81r12ffRIZzwxiCXO
	TFZTbUWNqGtISJt3Y7CPvjqK7Jah0/vLv4oD9FmbmWF3d+tFKbpBrkhMXbFK0pk=
X-Google-Smtp-Source: AGHT+IGcW1om/D9BbXr7PzXJ7mVDYtsOHqbYVyyEW7PaTui9Zjb/hWyDdIPTQDmXmk9M7CvmcDfBGA==
X-Received: by 2002:a05:6214:5010:b0:6b5:50:4427 with SMTP id 6a1803df08f44-6b5b704ee85mr124413136d6.12.1720017802577;
        Wed, 03 Jul 2024 07:43:22 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e578436sm53785436d6.63.2024.07.03.07.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 07:43:22 -0700 (PDT)
Date: Wed, 3 Jul 2024 10:43:21 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Ian Kent <ikent@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] vfs: don't mod negative dentry count when on shrinker
 list
Message-ID: <20240703144321.GA734942@perftesting>
References: <20240703121301.247680-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703121301.247680-1-bfoster@redhat.com>

On Wed, Jul 03, 2024 at 08:13:01AM -0400, Brian Foster wrote:
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
> Fixes: af0c9af1b3f6 ("fs/dcache: Track & report number of negative dentries")
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Acked-by: Ian Kent <ikent@redhat.com>
> ---
> 
> Hi Christian,
> 
> I see you already picked up v1. Josef had asked for some comment updates
> so I'm posting v2 with that, but TBH I'm not sure how useful this all is
> once one groks the flags. I have no strong opinion on it. I also added a
> Fixes: tag for the patch that added the counter.
> 
> In short, feel free to grab this one, ignore this and stick with v1, or
> maybe just pull in the Fixes: tag if you agree with it. Thanks.
> 
> Brian
> 
> v2:
> - Update comments (Josef).
> - Add Fixes: tag, cc Waiman.
> v1: https://lore.kernel.org/linux-fsdevel/20240702170757.232130-1-bfoster@redhat.com/

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks!

Josef

