Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB0A19B935
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 02:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733311AbgDBAAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 20:00:16 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39374 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733287AbgDBAAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 20:00:15 -0400
Received: by mail-pj1-f68.google.com with SMTP id z3so767812pjr.4;
        Wed, 01 Apr 2020 17:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+waUt4y2u1TasC9CABKLSfdzELViZORJkYCPcxWv6M=;
        b=ej3LnOrYDOrRWYN6TKpdtX+/Dq+4mU5e6hZi0eunaCl/vB763WNsB4Bu+/cyCelTax
         edgTOXJDn5Ke4GIER6o5U1xZVFtz3NwI9VQ//xdxiudPzGcenYocd3bON8qJsnAYK7s7
         OJXt8m7wQuoc7qSafNkThe/LhVRuXTV0gl33kkcqHddWcGOzEZv8MQ6vtd2O0mMo7El7
         3FkpvgB0pgGShAjDNK2gFpPkwYC0aNrNYmkB7vPekrmlFOpzoNwy4xld74fjj7hoHgcS
         Kw8YtNfF9/cPo4LPgyL7QKAXz7QuUnwGKY0x3jn2t4sF0QJWO/kr1/J7Nh7LULfPLgKj
         8pgg==
X-Gm-Message-State: AGi0PuY59gEpYwM/cGmzz31kmiAAFSmiMclJhEETgmTjV8ilSoZThqKH
        17WaDMWz/t1tWeDzeiAbv3GSxTte4SA=
X-Google-Smtp-Source: APiQypIwnylEuaIJuJLNziJlvP3IeVk11ni6vNFos9tjKBVX1i0Hvbdh/7hbCeL6EDwv9wdD48HMZw==
X-Received: by 2002:a17:902:b692:: with SMTP id c18mr384318pls.7.1585785613452;
        Wed, 01 Apr 2020 17:00:13 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k24sm2282227pfi.196.2020.04.01.17.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 17:00:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8808D40254; Thu,  2 Apr 2020 00:00:10 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de
Cc:     mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 0/3] block: address blktrace use-after-free
Date:   Wed,  1 Apr 2020 23:59:59 +0000
Message-Id: <20200402000002.7442-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Upstream kernel.org korg#205713 contends that there is a UAF in
the core debugfs debugfs_remove() function, and has gone through
pushing for a CVE for this, CVE-2019-19770.

If correct then parent dentries are not positive, and this would
have implications far beyond this bug report. Thankfully, upon review
with Nicolai, he wasn't buying it. His suspicions that this was just
a blktrace issue were spot on, and this patch series demonstrates
that, provides a reproducer, and provides a solution to the issue.

We there would like to contend CVE-2019-19770 as invalid. The
implications suggested are not correct, and this issue is only
triggerable with root, by shooting yourself on the foot by misuing
blktrace.

If you want this on a git tree, you can get it from linux-next
20200401-blktrace-fix-uaf branch [2].

Wider review, testing, and rants are appreciated.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=205713
[1] https://nvd.nist.gov/vuln/detail/CVE-2019-19770
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200401-blktrace-fix-uaf

Luis Chamberlain (3):
  block: move main block debugfs initialization to its own file
  blktrace: fix debugfs use after free
  block: avoid deferral of blk_release_queue() work

 block/Makefile               |  1 +
 block/blk-core.c             |  9 +--------
 block/blk-debugfs.c          | 27 +++++++++++++++++++++++++++
 block/blk-mq-debugfs.c       |  5 -----
 block/blk-sysfs.c            | 21 ++++++++-------------
 block/blk.h                  | 17 +++++++++++++++++
 include/linux/blktrace_api.h |  1 -
 kernel/trace/blktrace.c      | 19 ++++++++-----------
 8 files changed, 62 insertions(+), 38 deletions(-)
 create mode 100644 block/blk-debugfs.c

-- 
2.25.1

