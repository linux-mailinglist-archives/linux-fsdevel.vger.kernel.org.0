Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1373B5AA3AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 01:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiIAXZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 19:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiIAXZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:25:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB40613F11;
        Thu,  1 Sep 2022 16:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5257162028;
        Thu,  1 Sep 2022 23:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDA6C433D6;
        Thu,  1 Sep 2022 23:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662074700;
        bh=3Ei2pJxNHEj7Ms4tUmMY4vQ3bWZICi1bGNA88E3kO3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zNHLDPV6huB6ldajXdDKZJKTucg41vNQy1eDgNGzo6nSdipYamio1gvgjT2LJMsIL
         81HbuA8Ueqo5zDQi71TpbbiUn6wi2SPV5NXXmeo6T6uDk27V0YTO5S+YXmw98mBTsL
         +70Eq5tndj9TjEClRfrdME66CqB9ha620mnml22c=
Date:   Thu, 1 Sep 2022 16:24:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+5867885efe39089b339b@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in
 truncate_inode_pages_range
Message-Id: <20220901162459.431c49b3925e99ddb448e1b3@linux-foundation.org>
In-Reply-To: <000000000000117c7505e7927cb4@google.com>
References: <000000000000117c7505e7927cb4@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 Aug 2022 17:13:36 -0700 syzbot <syzbot+5867885efe39089b339b@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    89b749d8552d Merge tag 'fbdev-for-6.0-rc3' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14b9661b080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=911efaff115942bb
> dashboard link: https://syzkaller.appspot.com/bug?extid=5867885efe39089b339b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5867885efe39089b339b@syzkaller.appspotmail.com
> 
> ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
> ntfs3: loop0: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
> ================================================================================
> UBSAN: array-index-out-of-bounds in mm/truncate.c:366:18
> index 254 is out of range for type 'long unsigned int [15]'

That's

		index = indices[folio_batch_count(&fbatch) - 1] + 1;

I looked.  I see no way in which fbatch.nr got a value of 255.


I must say, the the code looks rather hacky.  Isn't there a more
type-friendly way of doing this?


