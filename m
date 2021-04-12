Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AFE35C3CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 12:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbhDLKX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 06:23:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:49986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238442AbhDLKX5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:23:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04789AFEC;
        Mon, 12 Apr 2021 10:23:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A26621F2B62; Mon, 12 Apr 2021 12:23:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Eric Whitney <enwlinux@gmail.com>,
        <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] ext4: Fix data corruption when extending DIO write races with buffered read
Date:   Mon, 12 Apr 2021 12:23:30 +0200
Message-Id: <20210412102333.2676-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This patch series fixes a bug manifesting as occasional generic/418 failure
when direct IO write extending a file races with buffered read. Patch 1
extends iomap DIO code to pass original IO size to ->end_dio handler so that
ext4 can tell whether everything has succeeded and we don't need expensive
DIO cleanup (possible truncate of leftover blocks beyond i_size). Patch 2
fixes the ext4 bug, patch 3 fixes unrelated problem I've found in ext4 DIO
code.

								Honza
