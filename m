Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A4135491F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 01:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbhDEXKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 19:10:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:38338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231488AbhDEXKl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:10:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 218F4B10B;
        Mon,  5 Apr 2021 23:10:33 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, rpenyaev@suse.de, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH 0/2] fs/epoll: restore user-visible behavior upon event ready
Date:   Mon,  5 Apr 2021 16:10:23 -0700
Message-Id: <20210405231025.33829-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This series tries to address a change in user visible behavior,
reported in:

 https://bugzilla.kernel.org/show_bug.cgi?id=208943


Epoll does not report an event to all the threads running epoll_wait()
on the same epoll descriptor. Unsurprisingly, this was bisected back to
339ddb53d373 (fs/epoll: remove unnecessary wakeups of nested epoll), which
has had various problems in the past, beyond only nested epoll usage.

Thanks!

Davidlohr Bueso (2):
  kselftest: introduce new epoll test case
  fs/epoll: restore waking from ep_done_scan()

 fs/eventpoll.c                                |  6 +++
 .../filesystems/epoll/epoll_wakeup_test.c     | 44 +++++++++++++++++++
 2 files changed, 50 insertions(+)

--
2.26.2

