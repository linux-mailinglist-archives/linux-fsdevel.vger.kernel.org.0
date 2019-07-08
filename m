Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB861E20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 14:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfGHMCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 08:02:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53675 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfGHMCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:02:44 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x68C2GN4006206;
        Mon, 8 Jul 2019 21:02:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Mon, 08 Jul 2019 21:02:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x68C2ApD006173
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 8 Jul 2019 21:02:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
Date:   Mon, 8 Jul 2019 21:02:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, David Howells.

I realized via https://lwn.net/Articles/792622/ that a new set of
system calls for filesystem mounting has been added to Linux 5.2. But
I feel that LSM modules are not ready to support these system calls.

An example is move_mount() added by this patch. This patch added
security_move_mount() LSM hook but none of in-tree LSM modules are
providing "LSM_HOOK_INIT(move_mount, ...)" entry. Therefore, currently
security_move_mount() is a no-op. At least for TOMOYO, I want to check
mount manipulations caused by system calls because allowing mounts on
arbitrary location is not acceptable for pathname based access control.
What happened? I want TOMOYO to perform similar checks like mount() does.

On 2019/02/20 2:08, David Howells wrote:
> Add a move_mount() system call that will move a mount from one place to
> another and, in the next commit, allow to attach an unattached mount tree.
> 
> The new system call looks like the following:
> 
> 	int move_mount(int from_dfd, const char *from_path,
> 		       int to_dfd, const char *to_path,
> 		       unsigned int flags);
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-api@vger.kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
