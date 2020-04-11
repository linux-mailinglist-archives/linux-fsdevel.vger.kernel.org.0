Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E074F1A52DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Apr 2020 18:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgDKQOm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 12:14:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgDKQOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 12:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4kLMPck/UQTFbc7P/dtGX9z+C5HE2yHjGcXQaPeD8UE=; b=E0NjrzbCb12cq87rjgyqkwADEW
        WAHh8mUUwTfsCROLuFG0kbje7DyHccwxOL380SlXlKeGnNjF1bsciAybqAPEmO8A+J3X/1QtH19Xy
        +53Ux1fcD5TfDsE20RWsl8RObPX1qW5c/K8rzmTk33ONfOLvRz5d9IxM2p2Mk2goeNMYjwze1O3GY
        wsHu/ins6D7MCHyncSooKHUIilEp5z9YHm1zyBXzOE1V+Lb9jhS0nG2IcuDAzTWSwUQccjqgQR0Qa
        hm8ooSvlQZJLMhV/HFq1p6r1rlkDX3/SDeHLpj5W2lvCoWJKUE7kUn1u3X1eAkHiiKTDk1FUnWZ8I
        Q4A1BvHw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNImG-0002LU-1t; Sat, 11 Apr 2020 16:14:40 +0000
Date:   Sat, 11 Apr 2020 09:14:39 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com>
Cc:     darrick.wong@oracle.com, hch@infradead.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, riteshh@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: WARNING in iomap_apply
Message-ID: <20200411161439.GE21484@bombadil.infradead.org>
References: <00000000000048518b05a2fef23a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000048518b05a2fef23a@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 12:39:13AM -0700, syzbot wrote:
> The bug was bisected to:
> 
> commit d3b6f23f71670007817a5d59f3fbafab2b794e8c
> Author: Ritesh Harjani <riteshh@linux.ibm.com>
> Date:   Fri Feb 28 09:26:58 2020 +0000
> 
>     ext4: move ext4_fiemap to use iomap framework
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c62a57e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15c62a57e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11c62a57e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
> Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 7023 at fs/iomap/apply.c:51 iomap_apply+0xa0c/0xcb0 fs/iomap/apply.c:51

This is:

        if (WARN_ON(iomap.length == 0))
                return -EIO;

and the call trace contains ext4_fiemap() so the syzbot bisection looks
correct.

>  iomap_fiemap+0x184/0x2c0 fs/iomap/fiemap.c:88
>  _ext4_fiemap+0x178/0x4f0 fs/ext4/extents.c:4860
>  ovl_fiemap+0x13f/0x200 fs/overlayfs/inode.c:467
>  ioctl_fiemap fs/ioctl.c:226 [inline]
>  do_vfs_ioctl+0x8d7/0x12d0 fs/ioctl.c:715
