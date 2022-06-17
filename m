Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139A254F075
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 07:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379891AbiFQFPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 01:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiFQFPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:15:05 -0400
X-Greylist: delayed 360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 22:15:03 PDT
Received: from smtp03.aussiebb.com.au (2403-5800-3-25--1003.ip6.aussiebb.net [IPv6:2403:5800:3:25::1003])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A563BE6;
        Thu, 16 Jun 2022 22:15:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id A81321A0089;
        Fri, 17 Jun 2022 15:09:00 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp03.aussiebb.com.au
Received: from smtp03.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp03.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kkiu0vSoVOHC; Fri, 17 Jun 2022 15:09:00 +1000 (AEST)
Received: by smtp03.aussiebb.com.au (Postfix, from userid 119)
        id 94D6B1A0085; Fri, 17 Jun 2022 15:09:00 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp03.aussiebb.com.au (Postfix) with ESMTP id 7F66C1A0072;
        Fri, 17 Jun 2022 15:08:58 +1000 (AEST)
Subject: [PATCH 0/2] vfs: fix a couple of mount table handling problems
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Jun 2022 13:08:53 +0800
Message-ID: <165544249242.247784.13096425754908440867.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

First, whenever a mount has an empty "source" (aka mnt_fsname), the
glibc function getmntent incorrectly parses its input, resulting in
reporting incorrect data to the caller.

The problem is that the get_mnt_entry() function in glibc's
misc/mntent_r.c assumes that leading whitespace on a line can always
be discarded because it will always be followed by a # for the case
of a comment or a non-whitespace character that's part of the value
of the first field. However, this assumption is violated when the
value of the first field is an empty string.

This is fixed in the mount API code by simply checking for a pointer
that contains a NULL and treating it as a NULL pointer.

Second, when a filesystem is mounted with a name that starts with
a # the glibc finction getmentent() will interpret the leading #
as a comment so that the mount line will not appear in the output.

This is fixed by adding a # to the to be translated string in
fs/proc_namespace.c:mangle().

Signed-off-by: Ian Kent <raven@themaw.net>
---

Ian Kent (1):
      vfs: parse: deal with zero length string value

Siddhesh Poyarekar (1):
      vfs: escape hash as well


 fs/fs_context.c     | 10 +++++++---
 fs/proc_namespace.c |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

--
Ian Kent

