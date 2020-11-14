Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A571C2B2A67
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 02:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKNBR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 20:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgKNBR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 20:17:59 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4CCC0613D1;
        Fri, 13 Nov 2020 17:17:58 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdkCQ-005Ux6-Bf; Sat, 14 Nov 2020 01:17:54 +0000
Date:   Sat, 14 Nov 2020 01:17:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201114011754.GL3576660@ZenIV.linux.org.uk>
References: <20201104082738.1054792-1-hch@lst.de>
 <20201104082738.1054792-2-hch@lst.de>
 <20201110213253.GV3576660@ZenIV.linux.org.uk>
 <20201110213511.GW3576660@ZenIV.linux.org.uk>
 <20201110232028.GX3576660@ZenIV.linux.org.uk>
 <CAHk-=whTqr4Lp0NYR6k3yc2EbiF0RR17=TJPa4JBQATMR__XqA@mail.gmail.com>
 <20201111215220.GA3576660@ZenIV.linux.org.uk>
 <20201111222116.GA919131@ZenIV.linux.org.uk>
 <20201113235453.GA227700@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113235453.GA227700@ubuntu-m3-large-x86>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:54:53PM -0700, Nathan Chancellor wrote:

> This patch in -next (6a9f696d1627bacc91d1cebcfb177f474484e8ba) breaks
> WSL2's interoperability feature, where Windows paths automatically get
> added to PATH on start up so that Windows binaries can be accessed from
> within Linux (such as clip.exe to pipe output to the clipboard). Before,
> I would see a bunch of Linux + Windows folders in $PATH but after, I
> only see the Linux folders (I can give you the actual PATH value if you
> care but it is really long).
> 
> I am not at all familiar with the semantics of this patch or how
> Microsoft would be using it to inject folders into PATH (they have some
> documentation on it here:
> https://docs.microsoft.com/en-us/windows/wsl/interop) and I am not sure
> how to go about figuring that out to see why this patch breaks something
> (unless you have an idea). I have added the Hyper-V maintainers and list
> to CC in case they know someone who could help.

Out of curiosity: could you slap WARN_ON(!iov_iter_count(iter)); right in
the beginning of seq_read_iter() and see if that triggers?
