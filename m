Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAD46585C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfGKOAS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 10:00:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728055AbfGKOAS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:00:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3AC4AF5B;
        Thu, 11 Jul 2019 14:00:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 24D661E43CB; Thu, 11 Jul 2019 16:00:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Boaz Harrosh <boaz@plexistor.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] xfs: Fix races between readahead and hole punching
Date:   Thu, 11 Jul 2019 16:00:09 +0200
Message-Id: <20190711140012.1671-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this is a patch series that addresses a possible race between readahead and
hole punching Amir has discovered [1]. The first patch makes madvise(2) to
handle readahead requests through fadvise infrastructure, the third patch
then adds necessary locking to XFS to protect against the race. Note that
other filesystems need similar protections but e.g. in case of ext4 it isn't
so simple without seriously regressing mixed rw workload performance so
I'm pushing just xfs fix at this moment which is simple.

								Honza

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com/
