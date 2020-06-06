Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4551F06F8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 16:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgFFO27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 10:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgFFO27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:28:59 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE6C03E96A;
        Sat,  6 Jun 2020 07:28:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jhZoY-00494P-BZ; Sat, 06 Jun 2020 14:28:50 +0000
Date:   Sat, 6 Jun 2020 15:28:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 2/3] fs: Introduce cmdline argument exceed_file_max_panic
Message-ID: <20200606142850.GK23230@ZenIV.linux.org.uk>
References: <1591425140-20613-1-git-send-email-yangtiezhu@loongson.cn>
 <1591425140-20613-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591425140-20613-2-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 06, 2020 at 02:32:19PM +0800, Tiezhu Yang wrote:
> It is important to ensure that files that are opened always get closed.
> Failing to close files can result in file descriptor leaks. One common
> answer to this problem is to just raise the limit of open file handles
> and then restart the server every day or every few hours, this is not
> a good idea for long-lived servers if there is no leaks.
> 
> If there exists file descriptor leaks, when file-max limit reached, we
> can see that the system can not work well and at worst the user can do
> nothing, it is even impossible to execute reboot command due to too many
> open files in system. In order to reboot automatically to recover to the
> normal status, introduce a new cmdline argument exceed_file_max_panic for
> user to control whether to call panic in this case.

What the hell?  You are modifying the path for !CAP_SYS_ADMIN.  IOW,
you've just handed an ability to panic the box to any non-priveleged
process.

NAK.  That makes no sense whatsoever.  Note that root is *NOT* affected
by any of that, so you can bloody well have a userland process running
as root and checking the number of files once in a while.  And doing
whatever it wants to do, up to and including reboot/writing to
/proc/sys/sysrq-trigger, etc.  Or just looking at the leaky processes
and killing them, with a nastygram along the lines of "$program appears
to be leaking descriptors; LART the authors of that FPOS if they can
be located" sent into log/over mail/etc.
