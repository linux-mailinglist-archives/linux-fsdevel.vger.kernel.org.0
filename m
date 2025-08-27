Return-Path: <linux-fsdevel+bounces-59404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FA6B38765
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 18:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6559B3B1F43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2800343D7D;
	Wed, 27 Aug 2025 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="HHL+i8Qb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BD304BBF
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310928; cv=none; b=dfzvp1sfyMgADRpkMJNNWSywkZhgr3c5PuvI3RZSrtVY5c5h16yFQ0bvWTNQHpr0vkB6QuQavanP0dcQvC3eXa5SQifsjergyisuR44tLvcVevqWm+erFh8/OMHBtByqbtNyw5UcHJAy3Lg+wxnRl64kI22sPClrV65E+JgE3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310928; c=relaxed/simple;
	bh=1J49svBdPM1VsPk/B72U0p4aTK9KkUwye6nSh+AaCGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hN1HtndAMbYnTYvAvsG1zpvJpz7Tt2Ql20XM2lapof+pkoeADG2VW0KVfN0usRqdv8Fn2myYppC+SzzWQHmGYc+CRRBWvcFIw0D/fQSvW++yAKio/g7ZPhlKIyQa9efL5xQ8KRFEueiDNlbzTd9LUT9/bvBp7/X2v6iLSj1jQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=HHL+i8Qb; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e953dca529dso3775994276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1756310925; x=1756915725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F8MBCOALyLW29tRaKLBmkUdjU0e3m81ua8qM6QlxUc0=;
        b=HHL+i8Qb7TjRo63pGyUAf/QBI3i8b+LbB5ClIfySonbFJLPphyvz6fbpxfI+4XTmvi
         x/HeVAhiJhGSd+lkAihoEOLEBMVa8qn6iuywEC7eaeZOxz5EXgHv/rLSvs1RvENrv1Af
         xUMjIK2b1i02uyJFNniB9wlv63A2IMOG+5RoZ0k66RoUiZj0B9uXRf5sUHOKZ0iLGiuK
         pRQVc7EIvcW2q2nL+W1eZ6qPvKpYY/iC+zJVEJzSlIO+ogcbgSxtSKO+MO1tGHq/iXUs
         akyUEI1PxTccrbNO/QQtRqJhGKZCdGb5bf+FGSsD0rITcQV+TPtqkKNBcj/cd0BLEax3
         FRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310925; x=1756915725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8MBCOALyLW29tRaKLBmkUdjU0e3m81ua8qM6QlxUc0=;
        b=Tkxl8iE+aMCRhApdQQzypX93lJmnT5qOAB8XlfbKOvmcDvg/ZdNSd5bQ5vYPqxrH/S
         BmwJwmoXiQRMoQa/ugqlXM0Mv/ih1MBlxCRLwUvPh3T/QPcDG7SbtXGuxRGEbbKRT5n+
         5La/+eK5Bp/IEgvxxa0fKSk5j7Av61tqMEqk9XacJ7d7xc6q1pD942rTJLE5jQ8tXbgr
         Nn37n1g/i5aLt7JJOAXGsnkukoy1ADUsFltT3fauBsYbiJPrg4Aqjq2+CJ+Pk8H4/vI+
         cfcmvNUwhwu9qbjzyEUZMQtSJAq3IjllFOu78MQ6uEA6dbZFjQI3zcp6TOSvSRu6KSSe
         m5+g==
X-Gm-Message-State: AOJu0YwlZv3LhMlDjiB+w8r6zaMNY/SbfOZNv7t/rLEPMW7+Z1JXavpy
	CTBQRXf8QlTRfPcjEKBWxyxcHJx9+Cq+jVvRE8XVEHHY6bQxar73hTMZuWFcBOXogTH0HfKaNLN
	lpV30
X-Gm-Gg: ASbGnctezc8MBRiFsack1tmpR6b6eWAtP/7FVQ4HYCXx7PWUF3Gh/0It+loZpIaHpWN
	6Ab6PN7dQRif7sg4Cuna+4xG0B2wvKXqBSaA0jjTwRHbp1E48NrJg3bHRqf1ntCBH+J6NqiSBpl
	EcX9JlqDPy8YDDkmyTKJFyf2vsrUk4i9NNQN0XhHZYX+Vvt6+LzW5cqMmxRx4bBXqvWuQs/a3A8
	sxlI6N93+exNG9BlJMK3W8sDWQjWvPKz24VErys4JjgQmyJuLUG79UFvUdxpFIhheQSStRjYdpe
	xzyF6VkeyE4Jw+kuDmhveqxqtsr/bKLiPNPigQrvgKCvjx64DjpT+1mJrbp0K5eN2L5Tr/zXB3p
	hb4ShFXqwlHuAML0PUZSat1MNXfPvmLcp8TvLDmJUU+InI7NNRKsPHlNavO8k2J/gFGzZSk6O1l
	1xJQmd
X-Google-Smtp-Source: AGHT+IE9MI02/EGLcEuj8RLfzQi94HthTqFKcq8Wp5g4r4kb41qy9Cy6X8/9v/mHfADNFNYHinugpA==
X-Received: by 2002:a05:6902:e0b:b0:e94:f463:884d with SMTP id 3f1490d57ef6-e951c3ff649mr20553107276.45.1756310925213;
        Wed, 27 Aug 2025 09:08:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c358cf8sm4133687276.23.2025.08.27.09.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:08:44 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:08:43 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	amir73il@gmail.com
Subject: Re: [PATCH v2 17/54] fs: remove the inode from the LRU list on
 unlink/rmdir
Message-ID: <20250827160843.GB2272053@perftesting>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>
 <20250827-bratkartoffeln-weltschmerz-fc60227f43e7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-bratkartoffeln-weltschmerz-fc60227f43e7@brauner>

On Wed, Aug 27, 2025 at 02:32:49PM +0200, Christian Brauner wrote:
> On Tue, Aug 26, 2025 at 11:39:17AM -0400, Josef Bacik wrote:
> > We can end up with an inode on the LRU list or the cached list, then at
> > some point in the future go to unlink that inode and then still have an
> > elevated i_count reference for that inode because it is on one of these
> > lists.
> > 
> > The more common case is the cached list. We open a file, write to it,
> > truncate some of it which triggers the inode_add_lru code in the
> > pagecache, adding it to the cached LRU.  Then we unlink this inode, and
> > it exists until writeback or reclaim kicks in and removes the inode.
> > 
> > To handle this case, delete the inode from the LRU list when it is
> > unlinked, so we have the best case scenario for immediately freeing the
> > inode.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> 
> I'm not too fond of this particular change I think it's really misplaced
> and the correct place is indeed drop_nlink() and clear_nlink().
> 
> I'm pretty sure that the number of callers that hold i_lock around
> drop_nlink() and clear_nlink() is relatively small. So it might just be
> preferable to drop_nlink_locked() and clear_nlink_locked() and just
> switch the few places over to it. I think you have tooling to give you a
> preliminary glimpse what and how many callers do this...

Fair, I'll make the weird french guy figure it out.  Thanks,

Josef

