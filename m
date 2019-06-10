Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC603BCB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389106AbfFJTO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:14:29 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45017 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389093AbfFJTO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:28 -0400
Received: by mail-vs1-f67.google.com with SMTP id v129so6191705vsb.11;
        Mon, 10 Jun 2019 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L/sxwoWTB1RPs4SOwxiI2pzL+HpX7W14pn3OTfWXTrs=;
        b=CgetiktdxrF1c2U99E74DYuCNKWuSjaoeV3EhxaUtm+MDJid6DMMRalfBj5ezzpGm8
         yfZ1A6nQUn3gTpzJ2FkjC82lziJOu8fC2HcgbIQ9KLE6JpqedRu0GTzHiLR5FMYk7gMR
         7PAD37RrMKsCUB8JsH9bEO09qftA7+40SHnhHibbZxmspnApawSLzWVKT+vJmzno/tHw
         aQ3HihErD7fTIecpjRrZo11C7XauhC2NNlcAF6+24ZMvqwa0VdsArLsUxWPThBAmWZu+
         UCz2c1z4f+WLrCZ8UcqcDG5+It9rwlfImqN30ZT45SwrIH/KpfQs+0+yT19kPYECE5oJ
         M2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L/sxwoWTB1RPs4SOwxiI2pzL+HpX7W14pn3OTfWXTrs=;
        b=qADMPcLyqPTpEYUgSIEzkxxklKKOruB6xpneAan0VlfFbLKi/5kkvZZd5aTdOQD7Xv
         MNJS1EWXLXaLxt4PYHk3nfzUFH47cME/wUxOk8X/5/gFWxdypMAcGg9iUfwQAWqaK7sm
         H8qfCw+EJQJ5EWoDSDxDjvEW60mLy5U8Wwnjp7fCxQVqGEdGDAtiIN6888ZsQLQEQPT2
         vgp2Nbqg82Zv8s67Ikj/X+PZ+2loDVD0gtcZ0cmloG8MqQXs9jOhDMfQvmH7n4pVRGET
         B6DLysQC4LO4lF+a9SDKISDAjLwwoT2NJ0/QuoqUfXIX3P0BRZc1kEnMW2nV5M4FYGAU
         kF+Q==
X-Gm-Message-State: APjAAAWYJGfyQiPbUYxSJsyGZM4PFfVGRT4VrNDkPP0J1/O+5aDlvlef
        oTjvBKfavAqsoMHHxcQWLcj1d6+HCQ==
X-Google-Smtp-Source: APXvYqxPcLklgE6VUoJKo32UFAMpSRl7A7jigt2Uh771lY6AZ6ewI5zyFZZsy/ZkAlqvK4h+y81wLQ==
X-Received: by 2002:a67:8c84:: with SMTP id o126mr9109717vsd.122.1560194067389;
        Mon, 10 Jun 2019 12:14:27 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:26 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong " <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: bcachefs status update (it's done cooking; let's get this sucker merged)
Date:   Mon, 10 Jun 2019 15:14:08 -0400
Message-Id: <20190610191420.27007-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Last status update: https://lkml.org/lkml/2018/12/2/46

Current status - I'm pretty much running out of things to polish and excuses to
keep tinkering. The core featureset is _done_ and the list of known outstanding
bugs is getting to be short and unexciting. The next big things on my todo list
are finishing erasure coding and reflink, but there's no reason for merging to
wait on those.

So. Here's my bcachefs-for-review branch - this has the minimal set of patches
outside of fs/bcachefs/. My master branch has some performance optimizations for
the core buffered IO paths, but those are fairly tricky and invasive so I want
to hold off on those for now - this branch is intended to be more or less
suitable for merging as is.

https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-for-review

The list of non bcachefs patches is:

closures: fix a race on wakeup from closure_sync
closures: closure_wait_event()
bcache: move closures to lib/
bcache: optimize continue_at_nobarrier()
block: Add some exports for bcachefs
Propagate gfp_t when allocating pte entries from __vmalloc
fs: factor out d_mark_tmpfile()
fs: insert_inode_locked2()
mm: export find_get_pages()
mm: pagecache add lock
locking: SIX locks (shared/intent/exclusive)
Compiler Attributes: add __flatten

Most of the patches are pretty small, of the ones that aren't:

 - SIX locks have already been discussed, and seem to be pretty uncontroversial.

 - pagecache add lock: it's kind of ugly, but necessary to rigorously prevent
   page cache inconsistencies with dio and other operations, in particular
   racing vs. page faults - honestly, it's criminal that we still don't have a
   mechanism in the kernel to address this, other filesystems are susceptible to
   these kinds of bugs too.

   My patch is intentionally ugly in the hopes that someone else will come up
   with a magical elegant solution, but in the meantime it's an "it's ugly but
   it works" sort of thing, and I suspect in real world scenarios it's going to
   beat any kind of range locking performance wise, which is the only
   alternative I've heard discussed.
   
 - Propaget gfp_t from __vmalloc() - bcachefs needs __vmalloc() to respect
   GFP_NOFS, that's all that is.

 - and, moving closures out of drivers/md/bcache to lib/. 

The rest of the tree is 62k lines of code in fs/bcachefs. So, I obviously won't
be mailing out all of that as patches, but if any code reviewers have
suggestions on what would make that go easier go ahead and speak up. The last
time I was mailing things out for review the main thing that came up was ioctls,
but the ioctl interface hasn't really changed since then. I'm pretty confident
in the on disk format stuff, which was the other thing that was mentioned.

----------

This has been a monumental effort over a lot of years, and I'm _really_ happy
with how it's turned out. I'm excited to finally unleash this upon the world.
