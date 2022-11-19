Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC66630C23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 06:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiKSF3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Nov 2022 00:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSF3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Nov 2022 00:29:41 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C204AF31;
        Fri, 18 Nov 2022 21:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yRfhb+NrhMCpwQojHAdu4kSKTfkVB70x/cknHkdRPP8=; b=pf87u4oTQjYpt5Kue2sttXTfdD
        gYe+9YPbM438h4uJ8GHSprDo8rJFusGWG1D7MOnAbza7Zh+mfoIB3Y8Lsi4i12zopiOa+YVy75gCN
        JuxtOh8IXowqco7em0GWWWFLdl5ge/wecZugF/4GVcGK2scKI2VgO8lD7FAj9yJmO94kuWjMkLmMA
        ggmMH0Y0X83DwdjRPQ2wTRSuJDrakuAlkwsZkF/yEEuKT4adIYC+FFYGletRX4kqjswewR9CmmCBi
        hE9eZDaH2thJa+B6RhrG3ry2LdG4TNmDu+6gRr66CxjImNAV/CvWK44oPBy8hV+OzbMPjtmNjbNBS
        4BmzBRSA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1owGPq-004zW4-20;
        Sat, 19 Nov 2022 05:29:22 +0000
Date:   Sat, 19 Nov 2022 05:29:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc: fix shift-out-of-bounds in
 check_special_flags
Message-ID: <Y3hpslPymEBPmZCS@ZenIV>
References: <20221102025123.1117184-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102025123.1117184-1-liushixin2@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 10:51:23AM +0800, Liu Shixin wrote:
> UBSAN reported a shift-out-of-bounds warning:
> 
>  left shift of 1 by 31 places cannot be represented in type 'int'
>  Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
>   ubsan_epilogue+0xa/0x44 lib/ubsan.c:151
>   __ubsan_handle_shift_out_of_bounds+0x1e7/0x208 lib/ubsan.c:322
>   check_special_flags fs/binfmt_misc.c:241 [inline]
>   create_entry fs/binfmt_misc.c:456 [inline]
>   bm_register_write+0x9d3/0xa20 fs/binfmt_misc.c:654
>   vfs_write+0x11e/0x580 fs/read_write.c:582
>   ksys_write+0xcf/0x120 fs/read_write.c:637
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0x80 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  RIP: 0033:0x4194e1
> 
> Since the type of Node's flags is unsigned long, we should define these
> macros with same type too.

We are limited to 32 bits anyway.  More interesting question here is what's
the point of having those bits that high anyway?
