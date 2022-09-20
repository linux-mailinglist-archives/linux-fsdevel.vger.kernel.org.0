Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA115BDE53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 09:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiITHfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiITHfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:35:08 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 00:35:05 PDT
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8669D286E9;
        Tue, 20 Sep 2022 00:35:04 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 0B304100392;
        Tue, 20 Sep 2022 17:26:20 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bqzabNvPKfwb; Tue, 20 Sep 2022 17:26:20 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id F1BD6100562; Tue, 20 Sep 2022 17:26:19 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id C617810026B;
        Tue, 20 Sep 2022 17:26:17 +1000 (AEST)
Subject: [REPOST PATCH v3 0/2] vfs: fix a mount table handling problem
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 20 Sep 2022 15:26:17 +0800
Message-ID: <166365872189.39016.10771273319597352356.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Whenever a mount has an empty "source" (aka mnt_fsname), the glibc
function getmntent incorrectly parses its input, resulting in reporting
incorrect data to the caller.

The problem is that the get_mnt_entry() function in glibc's
misc/mntent_r.c assumes that leading whitespace on a line can always
be discarded because it will always be followed by a # for the case
of a comment or a non-whitespace character that's part of the value
of the first field. However, this assumption is violated when the
value of the first field is an empty string.

This is fixed in the mount API code by simply checking for a pointer
that contains a NULL and treating it as a NULL pointer.

Changes:

v3: added patch to fix zero length string access violation caused after
    fs parser patch is applied.

v2: fix possible oops if conversion functions such as fs_param_is_u32()
    are called.

Signed-off-by: Ian Kent <raven@themaw.net>
---

Ian Kent (2):
      ext4: fix possible null pointer dereference
      vfs: parse: deal with zero length string value


 fs/ext4/super.c            |  4 ++--
 fs/fs_context.c            | 17 ++++++++++++-----
 fs/fs_parser.c             | 16 ++++++++++++++++
 include/linux/fs_context.h |  3 ++-
 4 files changed, 32 insertions(+), 8 deletions(-)

--
Ian

