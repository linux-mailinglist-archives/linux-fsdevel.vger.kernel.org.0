Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF6604816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 15:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiJSNtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 09:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiJSNs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5D157464;
        Wed, 19 Oct 2022 06:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92D97615AD;
        Wed, 19 Oct 2022 13:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28ACC433D6;
        Wed, 19 Oct 2022 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666185726;
        bh=ZCpdj8pPesM/jS+ooafHVb6mMa1dZ1MUcBDFH9w5Eiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwXO9CHPe4QSEAHZF1XVE2PQ/k97orXWrr1R2xbwjKVcMB75V5U15xoP47YpaG4pc
         xSri+53EnN+fv2abzB7CuElP/TVZgMthc67qAWagYhb9uBxf6ZAx34q37cnUTgm8y/
         UtzsVyIiQpSaWRP2qVXL7VU4hEhBt1LUfJJfw8uC4s/tI/HlwXSv0ioCxPjqXwepUt
         C/mZzvnxwfU2bL0jn74AG9U/I+CAf1pGUVMtfFvJBVz/4kBhCeGxVYdZFWCOQiK7lQ
         hiODawqhXIN/74vGPmw4w/36YvF1BEYsuthhI1BfAurig52vCPIsNfhAIKLVzgmA9Z
         vhG5L6isq503w==
Date:   Wed, 19 Oct 2022 15:22:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Odd interaction with file capabilities and procfs files
Message-ID: <20221019132201.kd35firo6ks6ph4j@wittgenstein>
References: <f1e63e54-d88d-4b69-86f1-c0b4a0fd8035@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1e63e54-d88d-4b69-86f1-c0b4a0fd8035@app.fastmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 06:42:04PM -0600, Daniel Xu wrote:
> Hi,
> 
> (Going off get_maintainers.pl for fs/namei.c here)
> 
> I'm seeing some weird interactions with file capabilities and S_IRUSR
> procfs files. Best I can tell it doesn't occur with real files on my btrfs
> home partition.
> 
> Test program:
> 
>         #include <fcntl.h>
>         #include <stdio.h>
>         
>         int main()
>         {
>                 int fd = open("/proc/self/auxv", O_RDONLY);
>                 if (fd < 0) {
>                         perror("open");
>                         return 1;
>                 }
>        
>                 printf("ok\n");
>                 return 0;
>         }
> 
> Steps to reproduce:
> 
>         $ gcc main.c
>         $ ./a.out
>         ok
>         $ sudo setcap "cap_net_admin,cap_sys_admin+p" a.out
>         $ ./a.out
>         open: Permission denied
> 
> It's not obvious why this happens, even after spending a few hours
> going through the standard documentation and kernel code. It's
> intuitively odd b/c you'd think adding capabilities to the permitted
> set wouldn't affect functionality.
> 
> Best I could tell the -EACCES error occurs in the fallthrough codepath
> inside generic_permission().
> 
> Sorry if this is something dumb or obvious.

Hey Daniel,

No, this is neither dumb nor obvious. :)

Basically, if you set fscaps then /proc/self/auxv will be owned by
root:root. You can verify this:

#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>

int main()
{
        struct stat st;
        printf("%d | %d\n", getuid(), geteuid());

        if (stat("/proc/self/auxv", &st)) {
                fprintf(stderr, "stat: %d - %m\n", errno);
                return 1;
        }
        printf("stat: %d | %d\n", st.st_uid, st.st_gid);

        int fd = open("/proc/self/auxv", O_RDONLY);
        if (fd < 0) {
                fprintf(stderr, "open: %d - %m\n", errno);
                return 1;
        }

        printf("ok\n");
        return 0;
}

$ ./a.out
1000 | 1000
stat: 1000 | 1000
ok
$ sudo setcap "cap_net_admin,cap_sys_admin+p" a.out
$ ./a.out
1000 | 1000
stat: 0 | 0
open: 13 - Permission denied

So acl_permission_check() fails and returns -EACCESS which will cause
generic_permission() to rely on capable_wrt_inode_uidgid() which checks
for CAP_DAC_READ_SEARCH which you don't have as an unprivileged user.
