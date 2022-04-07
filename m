Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEEA4F8292
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 17:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244740AbiDGPPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 11:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiDGPPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:15:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97047194FC2;
        Thu,  7 Apr 2022 08:13:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 10E40CE27B8;
        Thu,  7 Apr 2022 15:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AECC385A0;
        Thu,  7 Apr 2022 15:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649344378;
        bh=Xiseu+wEgMPUFkZF6Yf9OlNxv6pgJeUFoN3xO+zk/ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfqOxb5LoOPOr9bxK7zeHwRVmSiktRWfvhGUM14eY1k4Em3apDxb5RuyCznG5sSP3
         whtIuEPi0hjTjtAQd/T4qYwype+CCDy1JydwfXyE8Pf4kN6W0/X/lWfanOLw6SYrRC
         SSufLaiAq+Impg1znPVRc83rYuy1XiBcIOKeFMk/hIwegJ4oi0RJvUuyryFsW2Wgoy
         LmadCjyPQDTBanMg1uBJXdtsxaRwwyoRiZBp1fpgN4cFywGYIfIQmkB7teBkrwf5HZ
         +teKHm++nxExoOI6cVXChyUNu8IlQ0y1xdYvHki1I/+4vA5NlhOqwa4KiW5RgcA9jG
         u3836xoFvvfNA==
Date:   Thu, 7 Apr 2022 17:12:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 4/6] idmapped-mounts: Add umask(S_IXGRP) wrapper for
 setgid_create* cases
Message-ID: <20220407151253.fdzwsiyigmamwfjh@wittgenstein>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649333375-2599-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649333375-2599-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 07, 2022 at 08:09:33PM +0800, Yang Xu wrote:
> Since stipping S_SIGID should check S_IXGRP, so umask it to check whether
> works well.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  src/idmapped-mounts/idmapped-mounts.c | 66 +++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index d2638c64..d6769f08 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -8031,6 +8031,27 @@ out:
>  	return fret;
>  }
>  
> +static int setgid_create_umask(void)
> +{
> +	pid_t pid;
> +
> +	umask(S_IXGRP);

Ok, this is migraine territory (not your fault ofc). So I think we want
to not just wrap the umask() and setfacl() code around the existing
setgid() tests. That's just so complex to reason about that the test
just adds confusion if we just hack it into existing functions.

Can you please add separate tests that don't just wrap existing tests
via umask()+fork() and instead add dedicated umask()-based and
acl()-based functions.

Do you have time to do that?

Right now it's confusing because there's an intricate relationship
between acls and current_umask() and that needs to be mentioned in the
respective tests.

The current_umask() is stripped from the mode directly in the vfs if the
filesystem either doesn't support acls or the filesystem has been
mounted without posic acl support.

If the filesystem does support acls then current_umask() stripping is
deferred to posix_acl_create(). So when the filesystem calls
posix_acl_create() and there are no acls set or not supported then
current_umask() will be stripped.

If the parent directory has a default acl then permissions are based off
of that and current_umask() is ignored. Specifically, if the ACL has an
ACL_MASK entry, the group permissions correspond to the permissions of
the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
group permissions correspond to the permissions of the ACL_GROUP_OBJ
entry.

Yes, it's confusing which is why we need to clearly give both acls and
the umask() tests their separate functions and not just hack them into
the existing functions.

As it stands the umask() and posix acl() tests only pass by accident
because the filesystem you're testing on supports acls but doesn't strip
the S_IXGRP bit. So the current_umask() is ignored and that's why the
tests pass, I think. Otherwise they'd fail because they test the wrong
thing.

You can verify this by setting
export MOUNT_OPTIONS='-o noacl'
in your xfstests config.

You'll see the test fail just like it should:

ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check generic/999
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 imp1-vm 5.18.0-rc1-ovl-7d354bcd37d1 #273 SMP PREEMPT_DYNAMIC Thu Apr 7 11:07:08 UTC 2022
MKFS_OPTIONS  -- /dev/sda4
MOUNT_OPTIONS -- -o noacl /dev/sda4 /mnt/scratch

generic/999 2s ... [failed, exit status 1]- output mismatch (see /home/ubuntu/src/git/xfstests/results//generic/999.out.bad)
    --- tests/generic/999.out   2022-04-07 12:48:18.948000000 +0000
    +++ /home/ubuntu/src/git/xfstests/results//generic/999.out.bad      2022-04-07 14:19:28.517811054 +0000
    @@ -1,2 +1,5 @@
     QA output created by 999
     Silence is golden
    +idmapped-mounts.c: 8002: setgid_create - Success - failure: is_setgid
    +idmapped-mounts.c: 8110: setgid_create_umask - Success - failure: setgid
    +idmapped-mounts.c: 14428: run_test - No such file or directory - failure: create operations in directories with setgid bit set by umask(S_IXGRP)
    ...
    (Run 'diff -u /home/ubuntu/src/git/xfstests/tests/generic/999.out /home/ubuntu/src/git/xfstests/results//generic/999.out.bad'  to see the entire diff)
Ran: generic/999
Failures: generic/999
Failed 1 of 1 tests
