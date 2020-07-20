Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B213226633
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbgGTQBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731851AbgGTQBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:01:11 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC3BC061794;
        Mon, 20 Jul 2020 09:01:11 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYDr-00Ge6L-Kq; Mon, 20 Jul 2020 16:00:59 +0000
Date:   Mon, 20 Jul 2020 17:00:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+75867c44841cb6373570@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: KASAN: use-after-free Read in userfaultfd_release (2)
Message-ID: <20200720160059.GO2786714@ZenIV.linux.org.uk>
References: <0000000000001bbb6705aa49635a@google.com>
 <20200713084512.10416-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713084512.10416-1-hdanton@sina.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 04:45:12PM +0800, Hillf Danton wrote:

> Bridge the gap between slab free and the fput in task work wrt
> file's private data.

No.  This

> @@ -2048,6 +2055,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  
>  	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
>  	if (fd < 0) {
> +		file->private_data = NULL;
>  		fput(file);
>  		goto out;
>  	}
> 

is fundamentally wrong; you really shouldn't take over the cleanups
if you ever do fput().
