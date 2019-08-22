Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 864E998BF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 09:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfHVHBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 03:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfHVHBc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:01:32 -0400
Received: from zzz.localdomain (unknown [67.218.105.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F266920870;
        Thu, 22 Aug 2019 07:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566457291;
        bh=1xRMbxjyV8ew6m3nfyvNCRRuTi1GhKBMZS5I0/ItEFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mpIBtwgHmHmuv6opUL5a6B6cFIPtk4LNZPdCb6RvShauYyMt3Ayh5SfIFRxP3zzGb
         oKFNmsRIOROoD9GQGu5F0k3dITGMsA1hEw+aJ70DCXKYFYvt6YZam3NMpGDnxi5VRD
         MkwFk1Buqa7SbLimpx/sFmShbMNpUPyIHke2XAfc=
Date:   Thu, 22 Aug 2019 00:01:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2] tomoyo: Don't check open/getattr permission on
 sockets.
Message-ID: <20190822070129.GL6111@zzz.localdomain>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        syzbot <syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp,
        "David S. Miller" <davem@davemloft.net>
References: <8f874b03-b129-205f-5f05-125479701275@i-love.sakura.ne.jp>
 <20190822063018.GK6111@zzz.localdomain>
 <201908220655.x7M6tVmv029579@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908220655.x7M6tVmv029579@www262.sakura.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 03:55:31PM +0900, Tetsuo Handa wrote:
> Eric Biggers wrote:
> > What happened to this patch?
> 
> I have to learn how to manage a git tree for sending
> pull requests, but I can't find time to try.
> 
> > 
> > Also, isn't the same bug in other places too?:
> > 
> > 	- tomoyo_path_chmod()
> > 	- tomoyo_path_chown()
> > 	- smack_inode_getsecurity()
> > 	- smack_inode_setsecurity()
> 
> What's the bug? The file descriptor returned by open(O_PATH) cannot be
> passed to read(2), write(2), fchmod(2), fchown(2), fgetxattr(2), mmap(2) etc.
> 

chmod(2), chown(2), getxattr(2), and setxattr(2) take a path, not a fd.

- Eric
