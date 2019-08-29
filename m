Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3738CA1B01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfH2NKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 09:10:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:59172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbfH2NKl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:10:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4DB86AF18;
        Thu, 29 Aug 2019 13:10:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B8F471E3BE6; Thu, 29 Aug 2019 15:10:39 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-xfs@vger.kernel.org>
Cc:     <linux-mm@kvack.org>, Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Boaz Harrosh <boaz@plexistor.com>,
        <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3 v2] xfs: Fix races between readahead and hole punching
Date:   Thu, 29 Aug 2019 15:10:31 +0200
Message-Id: <20190829131034.10563-1-jack@suse.cz>
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

Changes since v1 (posted at [2]):
* Added reviewed-by tags
* Fixed indentation in xfs_file_fadvise()
* Improved comment and readibility of xfs_file_fadvise()

								Honza

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20190711140012.1671-1-jack@suse.cz/
