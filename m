Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0773598A08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 05:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfHVDvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 23:51:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58270 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbfHVDvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 23:51:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0e8M-0002mA-FC; Thu, 22 Aug 2019 03:51:34 +0000
Date:   Thu, 22 Aug 2019 04:51:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     John Johansen <john.johansen@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
Subject: [RFC][PATCH] fix d_absolute_path() interplay with fsmount()
Message-ID: <20190822035134.GK1131@ZenIV.linux.org.uk>
References: <20190708131831.GT17978@ZenIV.linux.org.uk>
 <874l3wo3gq.fsf@xmission.com>
 <20190708180132.GU17978@ZenIV.linux.org.uk>
 <20190708202124.GX17978@ZenIV.linux.org.uk>
 <87pnmkhxoy.fsf@xmission.com>
 <5802b8b1-f734-1670-f83b-465eda133936@i-love.sakura.ne.jp>
 <1698ec76-f56c-1e65-2f11-318c0ed225bb@i-love.sakura.ne.jp>
 <e75d4a66-cfcf-2ce8-e82a-fdc80f01723d@canonical.com>
 <7eb7378e-2eb8-c1ba-4e1f-ea8f5611f42b@i-love.sakura.ne.jp>
 <16ae946d-dbbe-9be9-9b22-866b3cd1cd7e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ae946d-dbbe-9be9-9b22-866b3cd1cd7e@i-love.sakura.ne.jp>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[bringing a private thread back to the lists]

There's a bug in interplay of fsmount() and d_absolute_path().
Namely, the check in d_absolute_path() treats the
not-yet-attached mount as "reached absolute root".
AFAICS, the right fix is this

diff --git a/fs/d_path.c b/fs/d_path.c
index a7d0a96b35ce..0f1fc1743302 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -116,8 +116,10 @@ static int prepend_path(const struct path *path,
 				vfsmnt = &mnt->mnt;
 				continue;
 			}
-			if (!error)
-				error = is_mounted(vfsmnt) ? 1 : 2;
+			if (is_mounted(vfsmnt) && !is_anon_ns(mnt->mnt_ns))
+				error = 1;	// absolute root
+			else
+				error = 2;	// detached or not attached yet
 			break;
 		}
 		parent = dentry->d_parent;

but that would slightly change the behaviour in another case.
Namely, nfs4 mount-time temporary namespaces.  There we have
the following: mount -t nfs4 server:/foo/bar/baz /mnt
will
        * set a temporary namespace, matching the mount tree as
exported by server
        * mount the root export there
        * traverse foo/bar/baz in that namespace, triggering
automounts when we cross the filesystem boundaries on server.
        * grab whatever we'd arrived at; that's what we'll
be mounting.
        * dissolve the temp namespace.

If you trigger some LSM hook (e.g. in permission checks on
that pathname traversal) for objects in that temp namespace,
do you want d_absolute_path() to succeed (and give a pathname
relative to server's root export), or should it rather fail?

AFAICS, apparmor and tomoyo are the only things that might
care either way; I would go with "fail, it's not an absolute
path" (and that's what the patch above will end up doing),
but it's really up to you.

It definitely ought to fail for yet-to-be-attached case, though;
it doesn't, and that's a bug that needs to be fixed.  Mea culpa.
