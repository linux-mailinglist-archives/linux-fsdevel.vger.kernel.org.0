Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976866A8AD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCBUrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCBUqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:46:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF13A457E0;
        Thu,  2 Mar 2023 12:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3oCwpVDu4xcBlhkNHBH3geMu/7Wx6m5tuk0CiJ937us=; b=oPfHzWkN8o7ub3rjHyZDbsPtuV
        7OLcJfzIoHmz3hIhOOr5kBrnrOOjnqx+vnDYKGEwImYtId4tJmI3hI7TmpRvol1qy0/js0LDSCCef
        uYyVFwuRIv+72rBzXJJL0naQqm1tyQKKt/2w75lq7w6OQGgJpvTeV7VQJ6LrUilaqMDLDtvyolKf8
        0avj6KHqtDh0Bz8fQ0U6V+osbmh5p1GVtHHfZTjtL/mGvYZwDVOByysy24tuupVVhYrVm+iTXMJtH
        iifnMDagP5WH4KcQAHvfQb48U1z36CnTuk+x2Iz2ihBwpYE8DEkqJb+70NXox4icRbETMcGAnJpzt
        8LnDrLzQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpoc-003HXK-7q; Thu, 02 Mar 2023 20:46:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, minyard@acm.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, song@kernel.org, robinmholt@gmail.com,
        steve.wahl@hpe.com, mike.travis@hpe.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, jgross@suse.com,
        sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
        xen-devel@lists.xenproject.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/7] sysctl: slowly deprecate register_sysctl_table()
Date:   Thu,  2 Mar 2023 12:46:05 -0800
Message-Id: <20230302204612.782387-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As the large array of sysctls in kernel/sysctl.c is reduced we get to
the point of wanting to optimize how we register sysctls by only dealing
with flat simple structures, with no subdirectories. In particular the
last empty element should not be needed. We'll get there, and save some
memory, but as we move forward that path will be come the more relevant
path to use in the sysctl registration. It is much simpler as it avoids
recursion.

Turns out we can also convert existing users of register_sysctl_table()
which just need their subdirectories created for them. This effort
addresses most users of register_sysctl_table() in drivers/ except
parport -- that needs a bit more review.

This is part of the process to deprecate older sysctl users which uses
APIs which can incur recursion, but don't need it [0]. This is the
second effort.

Yes -- we'll get to the point *each* of these conversions means saving
one empty syctl, but that change needs a bit more careful review before
merging. But since these conversion are also deleting tables for
subdirectories, the delta in size of the kernel should not incrase
really.

The most complex change is the sgi-xp change which does deal with
a case where we have a subdirectory with an entry, I just split
that in two registrations. No point in keeping recursion just for
a few minor if we can simplify code around. More eyeballs / review /
testing on that change is appreciated.

Sending these out early so they can get tested properly early on
linux-next. I'm happy to take these via sysctl-next [0] but since
I don' think register_sysctl_table() will be nuked on v6.4 I think
it's fine for each of these to go into each respective tree. I can
pick up last stragglers on sysctl-next. If you want me to take this
via sysctl-next too, just let me know and I'm happy to do that. Either
way works.

[0] https://lkml.kernel.org/r/20230302202826.776286-1-mcgrof@kernel.org

Luis Chamberlain (7):
  scsi: simplify sysctl registration with register_sysctl()
  ipmi: simplify sysctl registration
  hv: simplify sysctl registration
  md: simplify sysctl registration
  sgi-xp: simplify sysctl registration
  tty: simplify sysctl registration
  xen: simplify sysctl registration for balloon

 drivers/char/ipmi/ipmi_poweroff.c | 16 +---------------
 drivers/hv/vmbus_drv.c            | 11 +----------
 drivers/md/md.c                   | 22 +---------------------
 drivers/misc/sgi-xp/xpc_main.c    | 24 ++++++++++--------------
 drivers/scsi/scsi_sysctl.c        | 16 +---------------
 drivers/tty/tty_io.c              | 20 +-------------------
 drivers/xen/balloon.c             | 20 +-------------------
 7 files changed, 16 insertions(+), 113 deletions(-)

-- 
2.39.1

