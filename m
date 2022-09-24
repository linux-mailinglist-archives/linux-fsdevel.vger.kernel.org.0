Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC165E8673
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 02:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiIXAFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiIXAFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4969E9AFA8;
        Fri, 23 Sep 2022 17:04:57 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aIZ/p/zzcUdqvZHBfaTh7iNfzROHCGADiXc3h/IYPhs=;
        b=tCZMo4OJzUDsRF8Tt5+dc9rVSfsM8skI4n+zWXwCUkL8CFC32e6KCXNJYzr7jmUCSiy7PK
        d9ZVBFsHn5tVkGw/58xnFgn8uhx7BTppvYVU7Vd4CaZ2bIRNe8Z/Ii/vYBnlumMa3r3Hq3
        49kHaqlbV5niuvxKHiUPpIHDZsJZQw1iJD8rOb3wM23v9LK2MTpnIthq8+Q6WNMEqYUufP
        PMS42lqeKjpuGybID818ebteZp2Kb3z4H0DJdG80La4a8KFtliJL5kdAiqEuYYZCQlPrl1
        P+/5opPrHYIwb+TO/xBD8nL5QfWxEhOeCKp9VOoMS4tpmc0c4KjlfXyhkmGRAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aIZ/p/zzcUdqvZHBfaTh7iNfzROHCGADiXc3h/IYPhs=;
        b=G1F2Ln97f+/dUnOPn//ayxn+aXiNDFuWDxoBSCqEd1WNNf6v/RbGXOH0HkyRnz8gTDiImh
        gtw3fZf+UFXvSmDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Sven Schnelle <svens@stackframe.org>,
        John David Anglin <dave.anglin@bell.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-parisc@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH printk 00/18] preparation for threaded/atomic printing
Date:   Sat, 24 Sep 2022 02:10:36 +0206
Message-Id: <20220924000454.3319186-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This series is essentially the first 18 patches of tglx's RFC series
[0] with only minor changes in comments and commit messages. It's
purpose is to lay the groundwork for the upcoming threaded/atomic
console printing posted as the RFC series and demonstrated at
LPC2022 [1].

This series is interesting for mainline because it cleans up various
code and documentation quirks discovered while working on the new
console printing implementation.

Aside from cleanups, the main features introduced here are:

- Converts the console's DIY linked list implementation to hlist.

- Introduces a console list lock (mutex) so that readers (such as
  /proc/consoles) can safely iterate the consoles without blocking
  console printing.

- Adds SRCU support to the console list to prepare for safe console
  list iterating from any context.

- Refactors buffer handling to prepare for per-console, per-cpu,
  per-context atomic printing.

The series has the following parts:

   Patches  1 - 5:   Cleanups

   Patches  6 - 12:  Locking and list conversion

   Patches 13 - 18:  Improved output buffer handling to prepare for
                     code sharing

John Ogness

[0] https://lore.kernel.org/lkml/20220910221947.171557773@linutronix.de
[1] https://lore.kernel.org/lkml/875yheqh6v.fsf@jogness.linutronix.de

Thomas Gleixner (18):
  printk: Make pr_flush() static
  printk: Declare log_wait properly
  printk: Remove write only variable nr_ext_console_drivers
  printk: Remove bogus comment vs. boot consoles
  printk: Mark __printk percpu data ready __ro_after_init
  printk: Protect [un]register_console() with a mutex
  printk: Convert console list walks for readers to list lock
  parisc: Put console abuse into one place
  serial: kgdboc: Lock console list in probe function
  kgbd: Pretend that console list walk is safe
  printk: Convert console_drivers list to hlist
  printk: Prepare for SCRU console list protection
  printk: Move buffer size defines
  printk: Document struct console
  printk: Add struct cons_text_buf
  printk: Use struct cons_text_buf
  printk: Use an output descriptor struct for emit
  printk: Handle dropped message smarter

 arch/parisc/include/asm/pdc.h |   2 +-
 arch/parisc/kernel/pdc_cons.c |  55 +++--
 arch/parisc/kernel/traps.c    |  17 +-
 drivers/tty/serial/kgdboc.c   |   9 +-
 drivers/tty/tty_io.c          |   6 +-
 fs/proc/consoles.c            |  11 +-
 fs/proc/kmsg.c                |   2 -
 include/linux/console.h       | 197 +++++++++++++---
 include/linux/printk.h        |   9 -
 include/linux/syslog.h        |   3 +
 kernel/debug/kdb/kdb_io.c     |   7 +-
 kernel/printk/printk.c        | 414 ++++++++++++++++++++++------------
 12 files changed, 499 insertions(+), 233 deletions(-)


base-commit: dc453dd89daacdc0da6d66234aa27e417df7edcd
-- 
2.30.2

