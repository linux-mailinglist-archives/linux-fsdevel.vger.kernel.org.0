Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F543241EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 17:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhBXQPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 11:15:30 -0500
Received: from sandeen.net ([63.231.237.45]:52054 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235755AbhBXQNB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:13:01 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 52F3117264;
        Wed, 24 Feb 2021 10:11:55 -0600 (CST)
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: xfstests seems broken on btrfs with multi-dev TEST_DEV
Message-ID: <3e8f846d-e248-52a3-9863-d188f031401e@sandeen.net>
Date:   Wed, 24 Feb 2021 10:12:08 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Last week I was curious to just see how btrfs is faring with RAID5 in
xfstests, so I set it up for a quick run with devices configured as:

TEST_DEV=/dev/sdb1 # <--- this was a 3-disk "-d raid5" filesystem
SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"

and fired off ./check -g auto

Every test after btrfs/124 fails, because that test btrfs/124 does this:

# un-scan the btrfs devices
_btrfs_forget_or_module_reload

and nothing re-scans devices after that, so every attempt to mount TEST_DEV
will fail:

> devid 2 uuid e42cd5b8-2de6-4c85-ae51-74b61172051e is missing"

Other btrfs tests seeme to have the same problem.

If xfstest coverage on multi-device btrfs volumes is desired, it might be
a good idea for someone who understands the btrfs framework in xfstests
to fix this.

Thanks,
-Eric
