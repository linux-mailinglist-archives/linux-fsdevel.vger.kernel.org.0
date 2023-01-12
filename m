Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3049D667E68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 19:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjALSuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 13:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjALStY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:49:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D1E82F41;
        Thu, 12 Jan 2023 10:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2345620EA;
        Thu, 12 Jan 2023 18:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505F2C433D2;
        Thu, 12 Jan 2023 18:21:55 +0000 (UTC)
Date:   Thu, 12 Jan 2023 13:21:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Brian Norris <briannorris@chromium.org>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [LSF/MM/BPF TOPIC] tracing mapped pages for quicker boot
 performance
Message-ID: <20230112132153.38d52708@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Title: Tracing mapped pages for quicker boot performance

Description:

ChromeOS currently uses ureadahead that will periodically trace files that
are opened by the processes during the boot sequence. Then it will use this
information to call the readahead() system call in order to prefetch pages
before they are needed and speed up the applications. We have seen upward
towards 60% (and even higher is certain cases) performance gains when it's
working properly.

The ureadahead program comes from Canonical, and has not been updated since
2009 (although we've been adding patches on top of it since).

  https://launchpad.net/ubuntu/+source/ureadahead

The only changes Ubuntu has been doing with it is forward porting it to the
next release. But no code actually has changed. The 0.100.0 release was
last done in 2009.

Another problem with ureadahead is that it requires kernel modifications.
It adds in two tracepoints into the open paths so that it can see what
files have been opened (and it doesn't handle relative paths). These
tracepoints have been rejected upstream. We've been carrying them in our
ChromeOS kernel to use ureadahead.

ureadahead only looks at the files that are opened during boot, and then
reads the extents to see what parts of the file are interesting. It stores
this information into a "pack" file. Then on subsequent boots, instead of
tracing, it reads the pack file, calls the readahead() system call on the
locations it has in that pack file, to make sure they are in cache when the
applications need them.

One issue is that it can pick too much of the file, where it's reading
ahead portions of the file that will never be read, and hence, waste system
resources.

I've been looking into other approaches. I wrote a simple program that
reads the page_fault_user trace event, and every time it sees a new PID, it
reads the /proc/<pid>/maps file. And using the page fault trace event's
address, it can see exactly where in the file it is mapped to.

There's several issues with this approach. The main one being the race
condition between reading the pid and the /proc/<pid>/maps file. As the pid
may no longer exist, or it does an exec where the page faults no longer map
to the right location. But even with that, it does surprisingly well
(especially since we care more about long running applications than short
ones).

  https://rostedt.org/code/file-mapping.c

The above is just a toy application that tries this out, but could be used
as a starting point to replace ureadahead.

What I would like to discuss, is if there could be a way to add some sort
of trace events that can tell an application exactly what pages in a file
are being read from disk, where there is no such races. Then an application
would simply have to read this information and store it, and then it can
use this information later to call readahead() on these locations of the
file so that they are available when needed.

Note, in our use case boot ups do not change much. But I'm sure this could
be useful for other distributions.

This topic will require coordination with File systems, Storage, and MM.

I'm also open to having BPF help with this. One issue I want to make sure
we avoid, is any ABI we come up with that will hinder development later on.

-- Steve
