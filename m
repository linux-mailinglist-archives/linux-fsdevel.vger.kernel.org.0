Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E851E24685F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgHQOau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 10:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbgHQOaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:30:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E628C061389
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 07:30:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so15198828wrx.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=njqeGiWtXLg5+jOB3X5A+tJKa5oFt5uNxmm5GwqrJhw=;
        b=qMjHrx7t7+r44ug3VoLGOer7utNoQQG6VakgF8M2r1F1bVok4SFkN/vtuqLMQN/+jq
         in9MgdaZlN/g1nheeMXL0M1J7mEy0Ben0ZovQ/Es3wg1c8xsOXS9Z6p1XfiOBl273060
         R5XLxrqxPBXuoAlHrseGf5+k0UeOXGw1BjnIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=njqeGiWtXLg5+jOB3X5A+tJKa5oFt5uNxmm5GwqrJhw=;
        b=RgAwKMWJ15DoUTAXUFIEsXoVggB2t+XLwn8UPvcpwD89E83w/VtpuSzI61ZMe2e0YK
         KkWUwoap/AOviUeXJsad9+GPaEQJbvxOm/mQSRhbcCyqlTKInQ2spskXi9vRgmb0fvs6
         tWBVEy1xHn6a7L2WJEJtyemzqblDrvISTQ2GUgs3G4bL6xQhH//iFTDU2XnEpEZR1kl2
         HFHjnK1U2I+V1qdseUUdmkKSdW/xpcm51OQat5fzM3uWr/GBXWpCRoKfG6xDWeuxffwN
         QsKRqkiKGoVxiyjBLaGEwpd0DU3Z0oe/MWoCaaDj9Y62M1vXd7EzbKHFgO0C5g60SoIg
         msNg==
X-Gm-Message-State: AOAM531okka0pLyC41UP1I7ip9HMqnYpZrisf5zbGes3eFLK26Tf1EwY
        6g3CbGJ4t5lIkspxcKdxHepGAg==
X-Google-Smtp-Source: ABdhPJwodIZ9VzeppooFZHBp6d/RYmUjf7eNRDcmX5a3kZs1mHhE4oA9pVzsHqo4xWB+RGeWvl0HVQ==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr16755889wru.170.1597674645277;
        Mon, 17 Aug 2020 07:30:45 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id z12sm31397694wrp.20.2020.08.17.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:30:44 -0700 (PDT)
Date:   Mon, 17 Aug 2020 15:30:44 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/8] memcg: Enable fine-grained control of over
 memory.high action
Message-ID: <20200817143044.GA1987@chrisdown.name>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200817140831.30260-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200817140831.30260-2-longman@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Astractly, I think this really overcomplicates the API a lot. If these are 
truly generally useful (and I think that remains to be demonstrated), they 
should be additions to the existing API, rather than a sidestep with prctl.

I also worry about some other more concrete things:

1. Doesn't this allow unprivileged applications to potentially bypass 
    memory.high constraints set by a system administrator?
2. What's the purpose of PR_MEMACT_KILL, compared to memory.max?
3. Why add this entirely separate signal delivery path when we already have 
    eventfd/poll/inotify support, which makes a lot more sense for modern 
    applications?
