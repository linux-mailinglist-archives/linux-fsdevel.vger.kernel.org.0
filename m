Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837764BCEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfFSPf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 11:35:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfFSPf6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:35:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38A3A31628E3;
        Wed, 19 Jun 2019 15:35:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C11F1001E81;
        Wed, 19 Jun 2019 15:35:56 +0000 (UTC)
Subject: [PATCH 0/6] keys: request_key() improvements [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jun 2019 16:35:56 +0100
Message-ID: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 19 Jun 2019 15:35:58 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here's a fix and some improvements for request_key() intended for the next
merge window:

 (1) Fix the lack of a Link permission check on a key found by
     request_key(), thereby enabling request_key() to link keys that don't
     grant this permission to the target keyring (which must still grant
     Write permission).

     Note that the key must be in the caller's keyrings already to be
     found.

 (2) Invalidate used request_key authentication keys rather than revoking
     them, so that they get cleaned up immediately rather than hanging
     around till the expiry time is passed.

 (3) Move the RCU locks outwards from the keyring search functions so that
     a request_key_rcu() can be provided.  This can be called in RCU mode,
     so it can't sleep and can't upcall - but it can be called from
     LOOKUP_RCU pathwalk mode.

 (4) Cache the latest positive result of request_key*() temporarily in
     task_struct so that filesystems that make a lot of request_key() calls
     during pathwalk can take advantage of it to avoid having to redo the
     searching.

     It is assumed that the key just found is likely to be used multiple
     times in each step in an RCU pathwalk, and is likely to be reused for
     the next step too.

     Note that the cleanup of the cache is done on TIF_NOTIFY_RESUME, just
     before userspace resumes, and on exit.

The patches can be found on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-request

and this depends on keys-misc.

David
---
David Howells (6):
      keys: Fix request_key() lack of Link perm check on found key
      keys: Invalidate used request_key authentication keys
      keys: Move the RCU locks outwards from the keyring search functions
      keys: Provide request_key_rcu()
      keys: Cache result of request_key*() temporarily in task_struct
      keys: Kill off request_key_async{,_with_auxdata}


 Documentation/security/keys/core.rst        |   38 ++-----
 Documentation/security/keys/request-key.rst |   33 +++----
 include/keys/request_key_auth-type.h        |    1 
 include/linux/key.h                         |   14 +--
 include/linux/sched.h                       |    5 +
 include/linux/tracehook.h                   |    7 +
 kernel/cred.c                               |    9 ++
 security/keys/Kconfig                       |   17 +++
 security/keys/internal.h                    |    6 +
 security/keys/key.c                         |    4 -
 security/keys/keyring.c                     |   16 ++-
 security/keys/proc.c                        |    4 +
 security/keys/process_keys.c                |   41 ++++----
 security/keys/request_key.c                 |  137 ++++++++++++++++++---------
 security/keys/request_key_auth.c            |   60 +++++++-----
 15 files changed, 228 insertions(+), 164 deletions(-)

