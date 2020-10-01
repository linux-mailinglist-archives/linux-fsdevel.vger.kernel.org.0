Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE1827FFD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbgJANRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 09:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgJANRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:17:04 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FBCC0613D0;
        Thu,  1 Oct 2020 06:17:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNySB-009qdV-IP; Thu, 01 Oct 2020 13:16:59 +0000
Date:   Thu, 1 Oct 2020 14:16:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pipe: Fix memory leaks in create_pipe_files()
Message-ID: <20201001131659.GE3421308@ZenIV.linux.org.uk>
References: <20201001125055.5042-1-cai@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001125055.5042-1-cai@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 01, 2020 at 08:50:55AM -0400, Qian Cai wrote:
> Calling pipe2() with O_NOTIFICATION_PIPE could results in memory leaks
> in an error path or CONFIG_WATCH_QUEUE=n. Plug them.

[snip the copy of bug report]

No objections on the patch itself, but commit message is just about
unreadable.  How about something along the lines of the following?

=======================
	Calling pipe2() with O_NOTIFICATION_PIPE could results in memory
leaks unless watch_queue_init() is successful.

	In case of watch_queue_init() failure in pipe2() we are left
with inode and pipe_inode_info instances that need to be freed.  That
failure exit has been introduced in commit c73be61cede5 ("pipe: Add
general notification queue support") and its handling should've been
identical to nearby treatment of alloc_file_pseudo() failures - it
is dealing with the same situation.  As it is, the mainline kernel
leaks in that case.

	Another problem is that CONFIG_WATCH_QUEUE and !CONFIG_WATCH_QUEUE 
cases are treated differently (and the former leaks just pipe_inode_info,
the latter - both pipe_inode_info and inode).

	Fixed by providing a dummy wath_queue_init() in !CONFIG_WATCH_QUEUE
case and by having failures of wath_queue_init() handled the same way
we handle alloc_file_pseudo() ones.

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Signed-off-by: Qian Cai <cai@redhat.com>
=======================
