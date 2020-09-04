Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9888225D419
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgIDI7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 04:59:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:37370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729877AbgIDI67 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:58:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71070ACB0;
        Fri,  4 Sep 2020 08:58:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B83151E12D1; Fri,  4 Sep 2020 10:58:56 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        yebin <yebin10@huawei.com>, Andreas Dilger <adilger@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v2] bdev: Avoid discarding buffers under a filesystem
Date:   Fri,  4 Sep 2020 10:58:50 +0200
Message-Id: <20200904085852.5639-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this patch set fixes problems when buffer heads are discarded under a
live filesystem (which can lead to all sorts of issues like crashes in case
of ext4). Patch 1 drops some stale buffer invalidation code, patch 2
temporarily gets exclusive access to the block device for the duration of
buffer cache handling to avoid interfering with other exclusive bdev user.
The patch fixes the problems for me and pass xfstests for ext4.

Changes since v1:
* Check for exclusive access to the bdev instead of for the presence of
  superblock

								Honza
