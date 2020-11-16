Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6362B43D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 13:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgKPMfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 07:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbgKPMfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:35:37 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E3CC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 04:35:36 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kedjB-007GlV-Rc; Mon, 16 Nov 2020 12:35:25 +0000
Date:   Mon, 16 Nov 2020 12:35:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Garbage data while reading via usermode driver?
Message-ID: <20201116123525.GW3576660@ZenIV.linux.org.uk>
References: <0c98ab7f-8483-bb54-7b8f-3d69ed45f1ff@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c98ab7f-8483-bb54-7b8f-3d69ed45f1ff@i-love.sakura.ne.jp>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 08:11:04PM +0900, Tetsuo Handa wrote:
> Hello.
> 
> Below is a loadable kernel module which attempts to read (for example) /proc/interrupts from
> kernel using usermode driver interface. What is strange is that the total bytes obtained by
> doing "wc -c /proc/interrupts" from userspace's shell and trying to insmod this kernel module
> differs; for unknown reason, kernel_read() returns "#!/bin/cat /proc/interrupts\n" (28 bytes)
> at the end of input.

Because /bin/cat writes it out ;-)

$ echo "#!/bin/echo foo" >/tmp/a
$ chmod +x /tmp/a
$ /tmp/a
foo /tmp/a
$

IOW, same way #!/bin/sh -e in the beginning of /tmp/foo.sh results in exec
of /bin/sh with -e and /tmp/foo.sh in the arguments, #!/bin/cat /proc/interrupts
in /tmp/bar.sh will result in exec of /bin/cat with /proc/interrupts and
/tmp/bar.sh in parameters.  With cat(1) doing what it's supposed to do.
