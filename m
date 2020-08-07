Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E9F23ED4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 14:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgHGM1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 08:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHGM1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:27:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FDFC061574;
        Fri,  7 Aug 2020 05:27:41 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k41T5-00B8RX-QH; Fri, 07 Aug 2020 12:27:27 +0000
Date:   Fri, 7 Aug 2020 13:27:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@canonical.com>
Subject: Re: splice: infinite busy loop lockup bug
Message-ID: <20200807122727.GR1236603@ZenIV.linux.org.uk>
References: <00000000000084b59f05abe928ee@google.com>
 <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 07:35:08PM +0900, Tetsuo Handa wrote:
> syzbot is reporting hung task at pipe_release() [1], for for_each_bvec() from
> iterate_bvec() from iterate_all_kinds() from iov_iter_alignment() from
> ext4_unaligned_io() from ext4_dio_write_iter() from ext4_file_write_iter() from
> call_write_iter() from do_iter_readv_writev() from do_iter_write() from
> vfs_iter_write() from iter_file_splice_write() falls into infinite busy loop
> with pipe->mutex held.
> 
> The reason of falling into infinite busy loop is that iter_file_splice_write()
> for some reason generates "struct bio_vec" entry with .bv_len=0 and .bv_offset=0
> while for_each_bvec() cannot handle .bv_len == 0.

broken in 1bdc76aea115 "iov_iter: use bvec iterator to implement iterate_bvec()",
unless I'm misreading it...

Zero-length segments are not disallowed; it's not all that hard to filter them
out in iter_file_splice_write(), but the intent had always been to have
iterate_all_kinds() et.al. able to cope with those.

How are these pipe_buffers with ->len == 0 generated in that reproducer, BTW?
There might be something else fishy going on...
