Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1DE7B9894
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 01:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbjJDXKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 19:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjJDXKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:10:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E358DD
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 16:10:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fa455cd94so223883a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 16:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696461010; x=1697065810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBCvMKFa+vcZnG26/JeWxeoSgocrNcnNb84l5SDtiC0=;
        b=JYaT0TWedclRbg6rhIKg0EkHmJaXOUcskCIaj1ApK0GoaKeIQIK+OXwH2UHFzMXhRL
         ROskWE9YtFNENPQsoaw/RG68F06iHOBsm1R7tqxp7w5y6qbHUPf6rQ74puaK5UhaDwmj
         C9icbukZ++CmH/qStRLyzoz9NTxs6fVSnJKcTH+tZUrEW3DWWxUYdjmvldG4S6zG/GVC
         e3Fx1p+TMiniDlrGDoAvb53Qv2dHj+6pTxr1rXD25lhtt75CMTmyM6ULMBJs6tVAfaSQ
         dd9uxYhx3rowJOitpiDxbpp1Bqt5JaEN9+TBeR3MsYxL4RI6BM5eDh79SGldIjvGj6Nb
         Q7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696461010; x=1697065810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBCvMKFa+vcZnG26/JeWxeoSgocrNcnNb84l5SDtiC0=;
        b=A4KYWMW3DfxUu6CXOTW11MgJVTWHwad0oifxqiK4ALfigRkBurwnPSjSRMBOqs4qP5
         Y+YNvZdcWRHhOnL1tKnDtwoKgxUx/oLDKr88QV3s2D60LbuC9m0qQTG7q0CncO/PDwLr
         0BnFbhTCr0wlpqQHVfojXd6Z/wz5fyAPFpOVHeoOud01uiVl/+HbyjuL6HKKNNLomWxi
         TWwoKjSHjuoArXh5i0qJNWDa9Ex0zz+dBo3wfGEk4RcdTjJ3EtVQKtr3makWCDjjXpy9
         UKquYoEdWconqSvIQX/NQJdCqMDSIDZMUUYP4aCRRUkipgahFkFl/rbbjbwCJccF6tc+
         R4mw==
X-Gm-Message-State: AOJu0Yy4DrHVxR559LghXLfy5OrjfQLWrsfpsyuaO2wiqdGNct2esOcX
        8PRS6rHUha9PAnO0oc/9qmX3uw==
X-Google-Smtp-Source: AGHT+IEzCkW3N7WbBiXE2690U1CrRQ58ztSV2yenmMp5uTGEVYjAPVvffGppyu1YjwxFATJTBrrj0A==
X-Received: by 2002:a05:6a20:9698:b0:15d:624c:6e43 with SMTP id hp24-20020a056a20969800b0015d624c6e43mr3049725pzc.3.1696461010435;
        Wed, 04 Oct 2023 16:10:10 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ea8300b001bdb8c0b578sm100725plb.192.2023.10.04.16.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 16:10:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qoB0H-009XMo-3D;
        Thu, 05 Oct 2023 10:10:06 +1100
Date:   Thu, 5 Oct 2023 10:10:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
Message-ID: <ZR3wzVJ019gH0DvS@dread.disaster.area>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 08:42:45PM -0700, Hugh Dickins wrote:
> Percpu counter's compare and add are separate functions: without locking
> around them (which would defeat their purpose), it has been possible to
> overflow the intended limit.  Imagine all the other CPUs fallocating
> tmpfs huge pages to the limit, in between this CPU's compare and its add.
> 
> I have not seen reports of that happening; but tmpfs's recent addition
> of dquot_alloc_block_nodirty() in between the compare and the add makes
> it even more likely, and I'd be uncomfortable to leave it unfixed.
> 
> Introduce percpu_counter_limited_add(fbc, limit, amount) to prevent it.
> 
> I believe this implementation is correct, and slightly more efficient
> than the combination of compare and add (taking the lock once rather
> than twice when nearing full - the last 128MiB of a tmpfs volume on a
> machine with 128 CPUs and 4KiB pages); but it does beg for a better
> design - when nearing full, there is no new batching, but the costly
> percpu counter sum across CPUs still has to be done, while locked.
> 
> Follow __percpu_counter_sum()'s example, including cpu_dying_mask as
> well as cpu_online_mask: but shouldn't __percpu_counter_compare() and
> __percpu_counter_limited_add() then be adding a num_dying_cpus() to
> num_online_cpus(), when they calculate the maximum which could be held
> across CPUs?  But the times when it matters would be vanishingly rare.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Darrick J. Wong <djwong@kernel.org>
> ---
> Tim, Dave, Darrick: I didn't want to waste your time on patches 1-7,
> which are just internal to shmem, and do not affect this patch (which
> applies to v6.6-rc and linux-next as is): but want to run this by you.

Hmmmm. IIUC, this only works for addition that approaches the limit
from below?

So if we are approaching the limit from above (i.e. add of a
negative amount, limit is zero) then this code doesn't work the same
as the open-coded compare+add operation would?

Hence I think this looks like a "add if result is less than"
operation, which is distinct from then "add if result is greater
than" operation that we use this same pattern for in XFS and ext4.
Perhaps a better name is in order?

I'm also not a great fan of having two
similar-but-not-quite-the-same implementations for the two
comparisons, but unless we decide to convert the XFs slow path to
this it doesn't matter that much at the moment....

Implementation seems OK at a quick glance, though.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
