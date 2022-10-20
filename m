Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18946058EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 09:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiJTHpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 03:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiJTHow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:44:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6C05D72C;
        Thu, 20 Oct 2022 00:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C675B8265D;
        Thu, 20 Oct 2022 07:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FA0C433D6;
        Thu, 20 Oct 2022 07:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666251884;
        bh=/X3zUfIEqop89UwTpCzOAvKau054bntqKN6EBSFrHSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WaVcBSr3hHoeIlSPyS/NHlxK83RyEHlTyI4Le/sqovm8M54s38VHPPw92GQBYe5TB
         fxOrJibFO7nS9J36165wBrC0RJnPQfM4YxDkvfD+hzfWwMDmrc6Zi48gyYVH0YXmpU
         qB/xTLXCB8HRjXeg7IyK+uvksyvEvTpq29/LRwkwMzPD3VLiXnsbN9ESRm5cV7qlbA
         bxspxGvXSHBTYKViEVN8bhoIiuIADntsPjUShzvfaZv7vDVQnAcLZPeisy4y7hYter
         mA7Ow8JJ3N2MIBwBd4yyGSd6F/XU/UxLYfAuX0lfDhYgPCO+LdFyGe1JknD5ET5eEc
         6nUPquQ2EifGQ==
Date:   Thu, 20 Oct 2022 09:44:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Odd interaction with file capabilities and procfs files
Message-ID: <20221020074440.zdw7gbdjhl4o6z7r@wittgenstein>
References: <f1e63e54-d88d-4b69-86f1-c0b4a0fd8035@app.fastmail.com>
 <20221019132201.kd35firo6ks6ph4j@wittgenstein>
 <6ddd00bd-87d9-484e-8f2a-06f15a75a4df@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ddd00bd-87d9-484e-8f2a-06f15a75a4df@app.fastmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 03:42:42PM -0600, Daniel Xu wrote:
> Hi Christian,
> 
> On Wed, Oct 19, 2022, at 7:22 AM, Christian Brauner wrote:
> > On Tue, Oct 18, 2022 at 06:42:04PM -0600, Daniel Xu wrote:
> >> Hi,
> >> 
> >> (Going off get_maintainers.pl for fs/namei.c here)
> >> 
> >> I'm seeing some weird interactions with file capabilities and S_IRUSR
> >> procfs files. Best I can tell it doesn't occur with real files on my btrfs
> >> home partition.
> >> 
> >> Test program:
> >> 
> >>         #include <fcntl.h>
> >>         #include <stdio.h>
> >>         
> >>         int main()
> >>         {
> >>                 int fd = open("/proc/self/auxv", O_RDONLY);
> >>                 if (fd < 0) {
> >>                         perror("open");
> >>                         return 1;
> >>                 }
> >>        
> >>                 printf("ok\n");
> >>                 return 0;
> >>         }
> >> 
> >> Steps to reproduce:
> >> 
> >>         $ gcc main.c
> >>         $ ./a.out
> >>         ok
> >>         $ sudo setcap "cap_net_admin,cap_sys_admin+p" a.out
> >>         $ ./a.out
> >>         open: Permission denied
> >> 
> >> It's not obvious why this happens, even after spending a few hours
> >> going through the standard documentation and kernel code. It's
> >> intuitively odd b/c you'd think adding capabilities to the permitted
> >> set wouldn't affect functionality.
> >> 
> >> Best I could tell the -EACCES error occurs in the fallthrough codepath
> >> inside generic_permission().
> >> 
> >> Sorry if this is something dumb or obvious.
> >
> > Hey Daniel,
> >
> > No, this is neither dumb nor obvious. :)
> >
> > Basically, if you set fscaps then /proc/self/auxv will be owned by
> > root:root. You can verify this:
> >
> > #include <fcntl.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <stdio.h>
> > #include <errno.h>
> > #include <unistd.h>
> >
> > int main()
> > {
> >         struct stat st;
> >         printf("%d | %d\n", getuid(), geteuid());
> >
> >         if (stat("/proc/self/auxv", &st)) {
> >                 fprintf(stderr, "stat: %d - %m\n", errno);
> >                 return 1;
> >         }
> >         printf("stat: %d | %d\n", st.st_uid, st.st_gid);
> >
> >         int fd = open("/proc/self/auxv", O_RDONLY);
> >         if (fd < 0) {
> >                 fprintf(stderr, "open: %d - %m\n", errno);
> >                 return 1;
> >         }
> >
> >         printf("ok\n");
> >         return 0;
> > }
> >
> > $ ./a.out
> > 1000 | 1000
> > stat: 1000 | 1000
> > ok
> > $ sudo setcap "cap_net_admin,cap_sys_admin+p" a.out
> > $ ./a.out
> > 1000 | 1000
> > stat: 0 | 0
> > open: 13 - Permission denied
> >
> > So acl_permission_check() fails and returns -EACCESS which will cause
> > generic_permission() to rely on capable_wrt_inode_uidgid() which checks
> > for CAP_DAC_READ_SEARCH which you don't have as an unprivileged user.
> 
> Thanks for checking on this.
> 
> That does explain explain the weirdness but at the expense of another
> question: why do fscaps cause /proc/self/auxv to be owned by root?
> Is that the correct semantics? This also seems rather unexpected.
> 
> I'll take a look tonight and see if I can come up with any answers.

Sorry I didn't explain this in more detail.
You mostly uncovered the reasons as evidenced by the Twitter thread.

Yes, this is expected. When a new process that gains privileges during
exec the kernel will make it non-dumpable. That includes changing of the
e{g,u}id or fs{g,u}id of the process, s{g,u}id binary execution that
results in changed e{g,u}id, or if the executed binary has fscaps set if
the new permitted caps aren't a subset of the currently permitted caps.

The last reason is what causes your sample program's /proc/self to be
owned by root. The culprit here is cred_cap_issubset() which is called
during commit_creds() in begin_new_exec().

If the dumpable attribute is set then all files in /proc/<pid> will be
owned by (userns) root. To get the full picture you'd need to at least
read man proc(5), man execve(2), and man prctl(2).

The reason behind the dumpability change is to prevent unprivileged user
to make privilege-elevating-binaries (e.g., s{g,u}id binaries) crash to
produce (userns-)root-owned coredumps which can be used in exploits. A
fairly recent example of this is e.g.,
https://alephsecurity.com/2021/10/20/sudump/
https://www.openwall.com/lists/oss-security/2021/10/20/2
