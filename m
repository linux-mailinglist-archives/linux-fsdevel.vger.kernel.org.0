Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C546F564E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfFZIuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 04:50:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27307 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfFZIuL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:50:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90A2D30BB54B;
        Wed, 26 Jun 2019 08:50:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BF6B1001B10;
        Wed, 26 Jun 2019 08:50:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, iwienand@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFS fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <834.1561539007.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jun 2019 09:50:07 +0100
Message-ID: <835.1561539007@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 26 Jun 2019 08:50:11 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Could you pull this please?

There are four patches:

 (1) Fix the printing of the "vnode modified" warning to exclude checks on
     files for which we don't have a callback promise from the server (and
     so don't expect the server to tell us when it changes).

     Without this, for every file or directory for which we still have an
     in-core inode that gets changed on the server, we may get a message
     logged when we next look at it.  This can happen in bulk if, for
     instance, someone does "vos release" to update a R/O volume from a R/W
     volume and a whole set of files are all changed together.

     We only really want to log a message if the file changed and the
     server didn't tell us about it or we failed to track the state
     internally.

 (2) Fix accidental corruption of either afs_vlserver struct objects or the
     the following memory locations (which could hold anything).  The issue
     is caused by a union that points to two different structs in struct
     afs_call (to save space in the struct).  The call cleanup code assumes
     that it can simply call the cleanup for one of those structs if not
     NULL - when it might be actually pointing to the other struct.

     This means that every Volume Location RPC op is going to corrupt
     something.

 (3) Fix an uninitialised spinlock.  This isn't too bad, it just causes a
     one-off warning if lockdep is enabled when "vos release" is called,
     but the spinlock still behaves correctly.

 (4) Fix the setting of i_block in the inode.  This causes du, for example,
     to produce incorrect results, but otherwise should not be dangerous to
     the kernel.

The in-kernel AFS client has been undergoing testing on opendev.org on one
of their mirror machines.  They are using AFS to hold data that is then
served via apache, and Ian Wienand had reported seeing oopses, spontaneous
machine reboots and updates to volumes going missing.  This patch series
appears to have fixed the problem, very probably due to patch (2), but it's
not 100% certain.

Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Ian Wienand <iwienand@redhat.com>
