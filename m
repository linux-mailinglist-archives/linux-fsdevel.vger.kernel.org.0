Return-Path: <linux-fsdevel+bounces-18432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7498B8BE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694F7284EC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6B1DA24;
	Wed,  1 May 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAbznpP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217539B;
	Wed,  1 May 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573897; cv=none; b=hZ4v2N/95T5A7wLImuV/v/plRfRSSTZ249D2Tc7VD2JqMCb6nkkvgTTuF9uqTBQtus5VMgO8W6XvO/n40rCEOxW9XTQQyDijogVXx5ME+m8uC1/8pAvdO7wTchu1jCMNXmGINoqQUrWnT1vb+KFP/8b0oulxY0JSCHu2j/sI5j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573897; c=relaxed/simple;
	bh=+wNamIIBjqWv8wNbYxdQ9RyH/LZFpQ1Ija47F0o7+ak=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=I1NwXQdFKL5mJL2K861shKzyQrgZiM/wLQTHSmPamPn402nSwpUBOq8L60xqgfRtZVCKd/twrcyQ35xJXnxcR8ZsJNv8YVeHliDoaMunRy1iu9N2UTty9oK+9+/z+XptUxCn2EaPmo+TWuKGxLDwzI0nPaoOn45yAfIB2NHyKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAbznpP4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6effe9c852eso6112734b3a.3;
        Wed, 01 May 2024 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714573895; x=1715178695; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zcjwcyL162mAw3vYWOhklGg/HCY1i6wwZ9HtuvhcCfU=;
        b=AAbznpP43J0qDUcIX8pNp1qTUOzMfK5ej7OhZ7us4o+wYtn7vFl8OG2I846dgalY6O
         bCpbyRyCs7WwrMfwn4HNKD3iga37sh5dOd+SlWAEt6q698xN58VK3MwjezzV51OeB+4D
         doNngV09AoXO1g87ElEcHRjm6HHgY2QQVDAjjuBDjBqDSQcYJ2rAoZcWdbDzLEQK21Rs
         JYJ0AKhoLS5y+IDIyvSeAhXGaw9FJV4jJNYPsglCVfGXWXB02N9CFCaBon61wCKIu+jx
         AFHC0mKFECOiTgD7LVCPh+zYMO51pmyxFzzyPaxMLfh6blm7LdLjWlyzckYX+Adb7Jyx
         eOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714573895; x=1715178695;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcjwcyL162mAw3vYWOhklGg/HCY1i6wwZ9HtuvhcCfU=;
        b=YMxBYyO/yXINimQitmFtTpjZx+DOKv26dcBoZGyPHMZOFFR6TMKLUvwylpYnc+B4HN
         gg0H4DPupAZfbdv8jvSIquanaYrPJhkTMnFnP1XceCha4o88FshfLjo9dryKkGbel51F
         OtQJtONg4zqNlYNDW2b/xevPxeJgle7aKM8l6PSTeYnyG6aukZ8fejrI/VXZs6jhlraN
         0FGEbVq5PGm3XrfnjLNPIYIXke+kYad39ow0IBWFAKSG779helaHxPqyUaToeM+ijKXK
         20hIGIWbL6FBlq27Q6u8braHwvXZpnj6pLWKHMB/3zBj/XouQ/4LSVnofdZi1wZLkqnE
         /5EA==
X-Forwarded-Encrypted: i=1; AJvYcCUeH6Vwiv9MuZEKesNt7fG6jcRU0SkFQPM7DmYTqw1tDZ7/TKs1fyfNDZZOt/bbggO35R/aLk8jVWRz8ekqyHtCv83cad1vl9hNDgEC5vQANiqEa60aFw0jMbkUGLflPRMT3SJcrG0Bsw==
X-Gm-Message-State: AOJu0YwWM3sQfhfaTZQxEIh3dlsc3vBUKwXN8J7fp5rmhzgXxmr/jHLP
	5KhvRepVNchofehSC0NyV84WDsaCvpRynCUR63XbO8i9JXHgMdc0
X-Google-Smtp-Source: AGHT+IGsJOaC+lS+/evg5Leq+hxeaR9zb7+g4k0bI/FQiC36XhEwuw9ttXGSR/TYaCH0fF4LcExP7Q==
X-Received: by 2002:a05:6a20:8418:b0:1ad:31e2:56c with SMTP id c24-20020a056a20841800b001ad31e2056cmr3321219pzd.8.1714573894892;
        Wed, 01 May 2024 07:31:34 -0700 (PDT)
Received: from dw-tp ([171.76.84.250])
        by smtp.gmail.com with ESMTPSA id fh31-20020a056a00391f00b006f3ef025ed2sm7601061pfb.94.2024.05.01.07.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:31:33 -0700 (PDT)
Date: Wed, 01 May 2024 20:01:27 +0530
Message-Id: <87h6fh4n9c.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org, djwong@kernel.org, david@fromorbit.com, willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com, yi.zhang@huaweicloud.com, chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 03/34] ext4: trim delalloc extent
In-Reply-To: <20240410142948.2817554-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Zhang Yi <yi.zhang@huaweicloud.com> writes:

> From: Zhang Yi <yi.zhang@huawei.com>
>
> The cached delalloc or hole extent should be trimed to the map->map_len
> if we map delalloc blocks in ext4_da_map_blocks().

Why do you say the cached delalloc extent should also be trimemd to
m_len? Because we are only inserting delalloc blocks of
min(hole_len, m_len), right?

If we find delalloc blocks, we don't need to insert anything in ES
cache. So we just return 0 in such case in this function.


> But it doesn't
> trigger any issue now because the map->m_len is always set to one and we
> always insert one delayed block once a time. Fix this by trim the extent
> once we get one from the cached extent tree, prearing for mapping a
> extent with multiple delalloc blocks.
>

Yes, it wasn't clear until I looked at the discussion in the other
thread. It would be helpful if you could use that example in the commit
msg here for clarity.


"""
Yeah, now we only trim map len if we found an unwritten extent or written
extent in the cache, this isn't okay if we found a hole and
ext4_insert_delayed_block() and ext4_da_map_blocks() support inserting
map->len blocks. If we found a hole which es->es_len is shorter than the
length we want to write, we could delay more blocks than we expected.

Please assume we write data [A, C) to a file that contains a hole extent
[A, B) and a written extent [B, D) in cache.

                      A     B  C  D
before da write:   ...hhhhhh|wwwwww....

Then we will get extent [A, B), we should trim map->m_len to B-A before
inserting new delalloc blocks, if not, the range [B, C) is duplicated.

"""

Minor nit: ext4_da_map_blocks() function comments have become stale now. 
It's not clear of it's return value, the lock it uses etc. etc. If we are
at it, we might as well fix the function description.

-ritesh

