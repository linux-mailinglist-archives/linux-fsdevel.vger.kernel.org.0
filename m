Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423CE59081F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 23:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiHKVcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 17:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiHKVcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:32:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318DC9D8EA;
        Thu, 11 Aug 2022 14:32:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5EDDB822A2;
        Thu, 11 Aug 2022 21:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92860C433D6;
        Thu, 11 Aug 2022 21:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660253534;
        bh=vfs6ZvdrMMPGHJcOhOY6fsB75ibvlNBP1nVqQythD4o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jQw3f/vmaQusAPI1oMHwA4sRadqnrqWc9vP8jJen6W8rA9b/3tb+EhcrOPtjzfUYF
         oywi9/zVVtcJupyhiw4n8tWnmuVk3HgIXQMywuUj6CqFHkYuDNxOr4CwGeoRTuzpeV
         W7I8g8kSFq9WwEdfsetRS5BL2eBL+h4GDH5HQW+HjaCxx+/h/kamHOdogFbpdv8rOK
         E1B93HzaygDEK8DvHijc7zG56cYhnkaM6+3DtsLDj6FeqBbXwMbL146PmLkCuKJmNG
         3YlM7WjD9Lz7mefv7p58PhrESwoK1XRO8mot6R0bGTtTzpTtfCyTnj5hjlZrZGOXny
         6ZdcU9iMKQGpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80820C43142;
        Thu, 11 Aug 2022 21:32:14 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: new code for 5.20/6.0, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvUnxjj5ktXpwGj9@magnolia>
References: <YvUnxjj5ktXpwGj9@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvUnxjj5ktXpwGj9@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.0-merge-2
X-PR-Tracked-Commit-Id: 478af190cb6c501efaa8de2b9c9418ece2e4d0bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8745889a7fd04d14f461f6536c45f70cbaf3ee02
Message-Id: <166025353452.15191.18167009332867162574.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Aug 2022 21:32:14 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 11 Aug 2022 09:01:10 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-6.0-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8745889a7fd04d14f461f6536c45f70cbaf3ee02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
