Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA1141551B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 06:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgBGFHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 00:07:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37808 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgBGFHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 00:07:15 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izvr8-008chp-EV; Fri, 07 Feb 2020 05:07:06 +0000
Date:   Fri, 7 Feb 2020 05:07:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+c23efa0cc68e79d551fc@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, ceph-devel@vger.kernel.org,
        darrick.wong@oracle.com, dhowells@redhat.com,
        dongsheng.yang@easystack.cn, gregkh@linuxfoundation.org,
        idryomov@gmail.com, kstewart@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sage@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: KASAN: slab-out-of-bounds Read in suffix_kstrtoint
Message-ID: <20200207050706.GC23230@ZenIV.linux.org.uk>
References: <000000000000860811059df44228@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000860811059df44228@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 07:48:17PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    a0c61bf1 Add linux-next specific files for 20200206
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13925e6ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d320d6d9afdaecd
> dashboard link: https://syzkaller.appspot.com/bug?extid=c23efa0cc68e79d551fc
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1725bad9e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ac3c5ee00000
> 
> The bug was bisected to:
> 
> commit 61dff92158775e70c0183f4f52c3a5a071dbc24b
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Tue Dec 17 19:15:04 2019 +0000
> 
>     Pass consistent param->type to fs_parse()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fa020de00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=13fa020de00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15fa020de00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c23efa0cc68e79d551fc@syzkaller.appspotmail.com
> Fixes: 61dff9215877 ("Pass consistent param->type to fs_parse()")

Argh...  OK, I see what's going on.

commit 296713d91a7df022b0edf20d55f83554b4f95ba1
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Feb 7 00:02:11 2020 -0500

    do not accept empty strings for fsparam_string()
    
    Reported-by: syzbot+c23efa0cc68e79d551fc@syzkaller.appspotmail.com
    Fixes: 61dff9215877 ("Pass consistent param->type to fs_parse()")

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index fdc047b804b2..7e6fb43f9541 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -256,7 +256,7 @@ EXPORT_SYMBOL(fs_param_is_enum);
 int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec *p,
 		       struct fs_parameter *param, struct fs_parse_result *result)
 {
-	if (param->type != fs_value_is_string)
+	if (param->type != fs_value_is_string || !*param->string)
 		return fs_param_bad_value(log, param);
 	return 0;
 }
