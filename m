Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC0D2DA376
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439112AbgLNWfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403758AbgLNWfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:35:04 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D804AC0613D3;
        Mon, 14 Dec 2020 14:34:23 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kowQ5-001HZ6-Fr; Mon, 14 Dec 2020 22:34:17 +0000
Date:   Mon, 14 Dec 2020 22:34:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] epoll rework
Message-ID: <20201214223417.GC3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Deal with epoll loop check/removal races sanely (among other things).
Solution merged last cycle (pinning a bunch of struct file instances) had
been forced by the wrong data structures; untangling that takes a bunch
of preparations, but it's worth doing - control flow in there is ridiculously
overcomplicated.  Memory footprint has also gone down, while we are at it.
This is not all I want to do in the area, but since I didn't get around to
posting the followups they'll have to wait for the next cycle.

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll

for you to fetch changes up to 319c15174757aaedacc89a6e55c965416f130e64:

  epoll: take epitem list out of struct file (2020-10-25 20:02:08 -0400)

----------------------------------------------------------------
Al Viro (27):
      epoll: switch epitem->pwqlist to single-linked list
      epoll: get rid of epitem->nwait
      untangling ep_call_nested(): get rid of useless arguments
      untangling ep_call_nested(): it's all serialized on epmutex.
      untangling ep_call_nested(): take pushing cookie into a helper
      untangling ep_call_nested(): move push/pop of cookie into the callbacks
      untangling ep_call_nested(): and there was much rejoicing
      reverse_path_check_proc(): sane arguments
      reverse_path_check_proc(): don't bother with cookies
      clean reverse_path_check_proc() a bit
      ep_loop_check_proc(): lift pushing the cookie into callers
      get rid of ep_push_nested()
      ep_loop_check_proc(): saner calling conventions
      ep_scan_ready_list(): prepare to splitup
      lift the calls of ep_read_events_proc() into the callers
      lift the calls of ep_send_events_proc() into the callers
      ep_send_events_proc(): fold into the caller
      lift locking/unlocking ep->mtx out of ep_{start,done}_scan()
      ep_insert(): don't open-code ep_remove() on failure exits
      ep_insert(): we only need tep->mtx around the insertion itself
      take the common part of ep_eventpoll_poll() and ep_item_poll() into helper
      fold ep_read_events_proc() into the only caller
      ep_insert(): move creation of wakeup source past the fl_ep_links insertion
      convert ->f_ep_links/->fllink to hlist
      lift rcu_read_lock() into reverse_path_check()
      epoll: massage the check list insertion
      epoll: take epitem list out of struct file

 fs/eventpoll.c            | 717 +++++++++++++++++++---------------------------
 fs/file_table.c           |   1 -
 include/linux/eventpoll.h |  11 +-
 include/linux/fs.h        |   5 +-
 4 files changed, 305 insertions(+), 429 deletions(-)
