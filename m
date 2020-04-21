Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532331B220E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 10:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgDUIyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 04:54:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgDUIyt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:54:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA4F2ACC2;
        Tue, 21 Apr 2020 08:54:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2DE771E0E57; Tue, 21 Apr 2020 10:54:48 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>, Jan Kara <jack@suse.cz>
Subject: ext4: Fix use after free issues with journalled data
Date:   Tue, 21 Apr 2020 10:54:42 +0200
Message-Id: <20200421085445.5731-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this series of patches fixes possible use-after-free issues resulting from
freed inode being still in writeback list. One partner was able to trigger
this using fsstress on filesystem on pmem device. The first patch fixes
mostly a theoretical issue, the third patch fixes a real issue happening
in the wild and leading to kernel crashing.

								Honza
