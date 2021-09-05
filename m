Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475B4401107
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 19:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhIERVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 13:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233548AbhIERVG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 13:21:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C7476056C;
        Sun,  5 Sep 2021 17:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630862403;
        bh=Q/LqCC5d6A7mlWWVFtlQHU/7QKEKN9PG4o5aTQnUz3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fiVYK8Tt6Kfg3IHyiRhQiWeIL+xV/EIpAxYt6i29PMFBYyCVXzBHqcChnv236FTSP
         gXYO+JVcYkH0dHynMPOafBPn3O9R7Y1urLVmfeJkknbQVz0f0uGbO3vHdsKNUWXD9j
         90GpVh3cP70lKImwvzbk6CbQaWYPHLo2y60oR9no=
Date:   Sun, 5 Sep 2021 19:20:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5p2o55S35a2Q?= <nzyang@stu.xidian.edu.cn>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        security@kernel.org
Subject: Re: Report Bug to Linux File System about fs/devpts
Message-ID: <YTT8QQqQ2n63OVSP@kroah.com>
References: <2f73b89f.266.17bb4a7478b.Coremail.nzyang@stu.xidian.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f73b89f.266.17bb4a7478b.Coremail.nzyang@stu.xidian.edu.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 05, 2021 at 02:31:06PM +0800, 杨男子 wrote:
> Hi, our team has found a problem in fs system on Linux kernel v5.10, leading to DoS attacks.
> 
> The pseudo-terminals can be opened by normal user can be exhausted by one singal normal user by calling syscall such as open. A normal user keeps opening/dev/ptmx to trigger ptmx_open, which calls devpts_new_index and increases pty_count. In a couple of seconds, the pty_count limit is reached, and other normal user’s ptmx_open operations fail.
> 
> In fact, we try this attack inside a deprivileged docker container without any capabilities. The processes in the docker can exhaust all normal user’s pseudo-terminals on the host kernel. We use a machine with 16G memory. We start 4 processes to open /dev/ptmx repeatedly. In total, around 3072 number of pseudo-terminals are consumed and other normal user can not use pseudo-terminals. 

If you are concerned about this, please restrict the kernel.pty.max
value to be much lower.  Otherwise, do not run untrusted code in a
container and expect it to not be able to use up system resources :)

All of these "reports" you sent out today, seem to imply that you feel
that containers should never be allowed to take up resources from things
in other containers or elsewhere on the system.  As has been pointed
out, that is possible, but you need to tune your system to keep that
from happening by using one of the many various resource limit "knobs"
that are available to you.

These are not kernel bugs, but rather system configuration issues in
userspace from what I can determine.

thanks,

greg k-h
