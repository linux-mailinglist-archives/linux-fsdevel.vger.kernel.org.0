Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E1D4FE46F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356909AbiDLPSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356893AbiDLPSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:18:33 -0400
X-Greylist: delayed 326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 08:16:13 PDT
Received: from nibbler.cm4all.net (nibbler.cm4all.net [IPv6:2001:8d8:970:e500:82:165:145:151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B66D5E74B
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 08:16:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id 8AA27C00DA
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 17:10:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id umVe06tDEguE for <linux-fsdevel@vger.kernel.org>;
        Tue, 12 Apr 2022 17:10:38 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id 5E4E6C00A1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 17:10:38 +0200 (CEST)
Received: (qmail 29504 invoked from network); 12 Apr 2022 20:59:24 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 12 Apr 2022 20:59:24 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id 329E3460C77; Tue, 12 Apr 2022 17:10:38 +0200 (CEST)
Date:   Tue, 12 Apr 2022 17:10:38 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: fscache corruption in Linux 5.17?
Message-ID: <YlWWbpW5Foynjllo@rabbit.intern.cm-ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

two weeks ago, I updated a cluster of web servers to Linux kernel
5.17.1 (5.16.x previously) which includes your rewrite of the fscache
code.

In the last few days, there were numerous complaints about broken
WordPress installations after WordPress was updated.  There were
PHP syntax errors everywhere.

Indeed there were broken PHP files, but the interesting part is: those
corruptions were only on one of the web servers; the others were fine,
the file contents were only broken on one of the servers.

File size and time stamp and everyhing in "stat" is identical, just
the file contents are corrupted; it looks like a mix of old and new
contents.  The corruptions always started at multiples of 4096 bytes.

An example diff:

 --- ok/wp-includes/media.php    2022-04-06 05:51:50.000000000 +0200
 +++ broken/wp-includes/media.php    2022-04-06 05:51:50.000000000 +0200
 @@ -5348,7 +5348,7 @@
                 /**
                  * Filters the threshold for how many of the first content media elements to not lazy-load.
                  *
 -                * For these first content media elements, the `loading` attribute will be omitted. By default, this is the case
 +                * For these first content media elements, the `loading` efault, this is the case
                  * for only the very first content media element.
                  *
                  * @since 5.9.0
 @@ -5377,3 +5377,4 @@
  
         return $content_media_count;
  }
 +^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@

The corruption can be explained by WordPress commit
https://github.com/WordPress/WordPress/commit/07855db0ee8d5cff2 which
makes the file 31 bytes longer (185055 -> 185086).  The "broken" web
server sees the new contents until offset 184320 (= 45 * 4096), but
sees the old contents from there on; followed by 31 null bytes
(because the kernel reads past the end of the cache?).

All web servers mount a storage via NFSv3 with fscache.

My suspicion is that this is caused by a fscache regression in Linux
5.17.  What do you think?

What can I do to debug this further, is there any information you
need?  I don't know much about how fscache works internally and how to
obtain information.

Max

