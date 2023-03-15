Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988B56BAB1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 09:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjCOIuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjCOIt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:49:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF65D47C
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 01:49:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j13so2297528pjd.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1678870192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vsWY3tiIVy0Yn9JroDJe+huBkL6FjkeIMN/r3FyXd5s=;
        b=Tu1W0IEoh/utfOJuP49Ei0GgUJlOB7C4ob0dWEffMNAq9WjXgZb9jjYQe8No3saiVO
         bwxNSDjsO64+ejJHsAztdOAUMEOk70GsqiXzzyzN61ovBkH2bktkJXQ/IrOmUXEXUaJC
         0u9Iv5t8PBcWw61N6NelKZggBjMrf7xlJ5RkUMJL7oLMTpG4iHWP1fRuEFbwt9WFCDyi
         JxObnAJVTK8vxtpEfm4Rg4gY6h7yTtKOSgNDFGo3zHkJglspgPi534ltLU/OGPH7Uk0W
         HU1RImDREGGnttx0PKa96eby1VamA1Hr05aCpF/dsFTr8G4sDbFTP/o5Jjx2yJyIwsaU
         3+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678870192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsWY3tiIVy0Yn9JroDJe+huBkL6FjkeIMN/r3FyXd5s=;
        b=B1NRL5S6i1QPBaf0PH2tCFVTTL7GyYDhhpi/K1C8L08TKJA0KucORfHLu63ngduvGg
         WBQLEbY/KWrDc/5Hw5QQat7xcK9pqAkQHcj2HzciblogWKfGTbHddzigbMwHGnqcbOzV
         AJzWidQRO+T1tvvq4WN9yiib+bHMkJ1lMcKcxCvCxS5Rvr7AxfVHFt9DGW7xgttNLOQ3
         qS4AbTD6XvCJxngTLUp5nL+eaTnMMTX2+vkBbmS3QOMY/bhzB8oIgA1C4mB+FtJ7hu1P
         oueu0UxoYHCMiZ244n0Yyy78keyd6ZSDo/dYkBymW0xG0ngK48gAY/n9atwMuetAjQfw
         QFjA==
X-Gm-Message-State: AO0yUKV2o1gfvBZxP3bhcnL2vPhza2Y1DhAfuB02vo5akJI28U7i1frn
        vetcUoTsEjmXb3LfagBMtirapQ==
X-Google-Smtp-Source: AK7set+bs54csdRPLZxehylIRo4Xa5sAjj4gyGLb/tRk34uFP8c932/ih+zIiD18/7b0oBgOUsyMZg==
X-Received: by 2002:a05:6a20:1b1f:b0:d3:7aa2:edb3 with SMTP id ch31-20020a056a201b1f00b000d37aa2edb3mr11528330pzb.55.1678870192441;
        Wed, 15 Mar 2023 01:49:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id c11-20020a62e80b000000b005abbfa874d9sm2986079pfi.88.2023.03.15.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 01:49:51 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <dave@fromorbit.com>)
        id 1pcMpQ-008zeR-1Z; Wed, 15 Mar 2023 19:49:48 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.96)
        (envelope-from <dave@devoid.disaster.area>)
        id 1pcMpQ-00Ag6I-03;
        Wed, 15 Mar 2023 19:49:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-mm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yebin10@huawei.com
Subject: [PATCH 0/4] pcpctr: fix percpu_counter_sum vs cpu offline race
Date:   Wed, 15 Mar 2023 19:49:34 +1100
Message-Id: <20230315084938.2544737-1-david@fromorbit.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ye Bin reported an XFS assert failure when testing CPU hotplug
recently. During unmount, XFs was asserting that a percpu counter
value should be zero because at that point in time a non-zero value
indicates a space accounting leak which is a bug. The details of
that failure can be found here:

https://lore.kernel.org/linux-kernel/20230314090649.326642-1-yebin@huaweicloud.com/

Ye Bin then proposed changing the XFS code to use
percpu_counter_sum_all(), which surprised me because I didn't know
that function existed at all. Indeed, it was only merged in the
recent 6.3-rc1 merge window because someone else had noticed a
pcpctr sum race with hotplug.

commit f689054aace2 ("percpu_counter: add percpu_counter_sum_all
interface") was introduced via the mm tree. Nobody outside that
scope knew about this, because who bothers to even try to read LKML
these days? There was little list discussion, and I don't see
anything other than a cursory review done on the patch.

At minimum, linux-fsdevel should have been cc'd because multiple
filesystems use percpu counters for both threshold and ENOSPC
accounting in filesystems.  Hence if there is a problem with
percpu_counter_sum() leaking, filesystem developers kinda need to
know about it because leaks like this (as per the XFS bug report)
can actually result in on-disk corruption occurring.

So, now I know that there is an accuracy problem with
percpu_counter_sum(), I will assert that we need to fix it properly
rathern than hack around it by adding a new variant. Leaving people
who know nothing about cpu hotplug to try to work out if they have a
hotplug related issue with their use of percpu_counter_sum() is just
bad code; percpu_counter_sum() should just Do The Right Thing.

Use of the cpu_dying_mask should effectively close this race
condition.  That is, when we take a CPU offline we effectively do:

	mark cpu dying
	clear cpu from cpu_online_mask
	run cpu dead callbacks
	  ....
	  <lock counter>
	  fold pcp count into fbc->count
	  clear pcp count
	  <unlock counter>
	  ...
	mark CPU dead
	clear cpu dying

The race condition occurs because we can run a _sum operation
between the "clear cpu online" mask update and the "pcpctr cpu dead"
notification runs and fold the pcp counter values back into the
global count.  The sum sees that the CPU is not online, so it skips
that CPU even though the count is not zero and hasn't been folded by
the CPU dead notifier. Hence it skips something that it shouldn't.

However, that race condition doesn't exist if we take cpu_dying_mask
into account during the sum.  i.e. percpu_counter_sum() should
iterate every CPU set in either the cpu_online_mask and the
cpu_dying_mask to capture CPUs that are being taken offline.

If the cpu is not set in the dying mask, then the online or offline
state of the CPU is correct an there is no notifier pending over
running and we will skip/sum it correctly.

If the CPU is set in the dying mask, then we need to sum it
regardless of the online mask state or even whether the cpu dead
notifier has run.  If the sum wins the race to the pcp counter on
the dying CPU, it is included in the local sum from the pcp
variable. If the notifier wins the race, it gets folded back into
the global count and zeroed before the sum runs. Then the sum
includes the count in the local sum from the global counter sum
rather than the percpu counter.

Either way, we get the same correct sum value from
percpu_counter_sum() regardless of how it races with a CPU being
removed from the system. And there is no need for
percpu_count_sum_all() anymore.

This series introduces bitmap operations for finding bits set in
either of two bitmasks and adds the for_each_cpu_or() wrapper to
iterate CPUs set in either of the two supplied cpu masks. It then
converts __percpu_counter_sum_mask() to use this, and have
__percpu_counter_sum() pass the cpu_dying_mask as the second mask.
This fixes the race condition with CPUs dying.

It then converts the only user of percpu_counter_sum_all() to use
percpu_counter_sum() as percpu_counter_sum_all() is now redundant,
then it removes percpu_counter_sum_all() and recombines
__percpu_counter_sum_mask() and __percpu_counter_sum().

This effectively undoes all the changes in commit f689054aace2
except for the small change to use for_each_cpu_or() to fold in the
cpu_dying_mask made in this patch set to avoid the problematic race
condition. Hence the cpu unplug race condition is now correctly
handled by percpu_counter_sum(), and people can go back to being
blissfully ignorant of how pcpctrs interact with CPU hotplug (which
is how it should be!).

This has spent the last siz hours running generic/650 on XFS on a
couple of VMs (on 4p, the other 16p) which stresses the filesystem
by running a multi-process fsstress invocation whilst randomly
onlining and offlining CPUs. Hence it's exercising all the percpu
counter cpu dead paths whilst the filesystem is randomly modifying,
reading and summing summing the critical counters that XFS needs for
accurate accounting of resource consumption within the filesystem.

Thoughts, comments and testing welcome!

-Dave.

