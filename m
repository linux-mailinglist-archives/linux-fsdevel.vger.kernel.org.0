Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752EFCA048
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfJCO1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 10:27:18 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43126 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfJCO1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:27:18 -0400
Received: by mail-qk1-f196.google.com with SMTP id h126so2513239qke.10;
        Thu, 03 Oct 2019 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QoMfXeCBE2+e9NZxnjQG1SWoCD2staT4ZlOGYZkaxM4=;
        b=V/ZZwApsQXkPKcYVsPp7lYdZdi8cvMG6jQ8XQetrU9Fq9JcaIIT9bRD+QTBBaUDgSu
         JfWMPYIAYfgAbejz1js+pgC8JGVrFdrWlksiYLLv2YqMArXBKQlLWBDEeF1AuXh+v1yU
         EeFDcX2TlJ2ZStwoYZecfp4bjbFB7fqXFbbIvBYge6ehthduNDZvyoTcDiBIXg8lHJUh
         ERYZh++Cwnw7HbRVMFzsmMqQefKCrhd1eIo0QRIl3wrytXGlV+iwMAIEVPmAc9D9Cx+2
         1csBowm+1F+TlBAqxsylxbqXVz0r1F+YiyzifhOJ0rM//SvS6ydRyT54B+5iIBVGF1lC
         GfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=QoMfXeCBE2+e9NZxnjQG1SWoCD2staT4ZlOGYZkaxM4=;
        b=raQBFbOM2BKhuqopFfPqYgk5n25VlnquBZqXJvG194B4NRkfU3Nx7W3UnbDG+To5wd
         gIfRufieTfY3UXqNNt6z41L06hRUDb7tIu5MhhWEM/R639YUDuilhsXfmVunqCnkwslh
         6sAbWUq5Y+CxrmfpQUCazRe5fL52CniZHIrRL0GI9A3kgruF7NPfVKUOhD4HedVu6N90
         2MLmwrUJHEeHy2uyW9SXHAgGLNRjNrUueqPoR9zutHEHyqAcW8cbhN379pABM8AzHSSk
         idK/cpa51raEk0zyw7AkrrGgaV4imbqpqJL5s7A2V+4Nr9jjOKbCD5xcQBldJvYSPwnQ
         zgOQ==
X-Gm-Message-State: APjAAAUC8hB/BtTIKUwN+zkhY1nBTT2T2zKCPjNzY4WcOCajZ69q1Sbk
        noyuU5NXfruN1z7lsclCTtI8/u6tJGw=
X-Google-Smtp-Source: APXvYqwOxKIiaAX2C3B3METaTMp0USKJlj4RW8SRT/uLyS+USZQGJDU/pkgesWJYHyaOCXFekbPhSw==
X-Received: by 2002:ae9:f50a:: with SMTP id o10mr1978279qkg.372.1570112835413;
        Thu, 03 Oct 2019 07:27:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:9f72])
        by smtp.gmail.com with ESMTPSA id d23sm1588317qkc.127.2019.10.03.07.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 07:27:14 -0700 (PDT)
Date:   Thu, 3 Oct 2019 07:27:13 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Avoid getting stuck during cyclic writebacks
Message-ID: <20191003142713.GA2622251@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During a cyclic writeback, extent_write_cache_pages() uses done_index
to update the writeback_index after the current run is over.  However,
instead of current index + 1, it gets to to the current index itself.

Unfortunately, this, combined with returning on EOF instead of looping
back, can lead to the following pathlogical behavior.

1. There is a single file which has accumulated enough dirty pages to
   trigger balance_dirty_pages() and the writer appending to the file
   with a series of short writes.

2. bdp kicks in, wakes up background writeback and sleeps.

3. Writeback kicks in and the cursor is on the last page of the dirty
   file.  Writeback is started or skipped if already in progress.  As
   it's EOF, extent_write_cache_pages() returns and the cursor is set
   to done_index which is pointing to the last page.

4. Writeback is done.  Nothing happens till bdp finishes, at which
   point we go back to #1.

This can almost completely stall out writing back of the file and keep
the system over dirty threshold for a long time which can mess up the
whole system.  We encountered this issue in production with a package
handling application which can reliably reproduce the issue when
running under tight memory limits.

Reading the comment in the error handling section, this seems to be to
avoid accidentally skipping a page in case the write attempt on the
page doesn't succeed.  However, this concern seems bogus.

On each page, the code either:

* Skips and moves onto the next page.

* Fails issue and sets done_index to index + 1.

* Successfully issues and continue to the next page if budget allows
  and not EOF.

IOW, as long as it's not EOF and there's budget, the code never
retries writing back the same page.  Only when a page happens to be
the last page of a particular run, we end up retrying the page, which
can't possibly guarantee anything data integrity related.  Besides,
cyclic writes are only used for non-syncing writebacks meaning that
there's no data integrity implication to begin with.

Fix it by always setting done_index past the current page being
processed.

Note that this problem exists in other writepages too.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
---
 fs/btrfs/extent_io.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cceaf05aada2..4905f48587df 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4121,7 +4121,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-			done_index = page->index;
+			done_index = page->index + 1;
 			/*
 			 * At this point we hold neither the i_pages lock nor
 			 * the page lock: the page may be truncated or
@@ -4156,16 +4156,6 @@ static int extent_write_cache_pages(struct address_space *mapping,
 
 			ret = __extent_writepage(page, wbc, epd);
 			if (ret < 0) {
-				/*
-				 * done_index is set past this page,
-				 * so media errors will not choke
-				 * background writeout for the entire
-				 * file. This has consequences for
-				 * range_cyclic semantics (ie. it may
-				 * not be suitable for data integrity
-				 * writeout).
-				 */
-				done_index = page->index + 1;
 				done = 1;
 				break;
 			}
