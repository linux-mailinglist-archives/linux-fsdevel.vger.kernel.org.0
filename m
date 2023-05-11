Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C686FEABF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 06:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbjEKEgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 00:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbjEKEgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 00:36:14 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44D95246;
        Wed, 10 May 2023 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FwD1TG3KvO31uHKjMBRrWv8n8XTIU3am8QNND0y08hI=; b=XTh3e+NNeDPxkXa8i3uD5CUqlG
        XYmD5UFBCTxbfGglI5VRtqu4HlMkjjFpw1EuZqOP/0lQtAephFqxU3PPxtM2KFzImIf4soLtsTEDd
        xX8ENDiDyFaaWs5vsTyJlCgnMz1yhR+cMs1LdMbUHLC0winPHAkwMOv+Zfk+xN0sFlAlBTTZlycNZ
        dqhQlY8mSeaeAq33TFxVph+5+XWwhpLLy4E8SM4RfkwLE+Hale90P80193SscQOuqBf0guW688Z+Z
        IHbYrULJ5+RYvkzZ2IwFrQSscW+AOQfBDL8y205TDh0ufnlpCHJqlPCaO8YNxX93zjtfhTLqYs9EQ
        zn60H5Hw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pwy26-001bR2-17;
        Thu, 11 May 2023 04:36:02 +0000
Date:   Thu, 11 May 2023 05:36:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     houweitao <houweitao@didiglobal.com>
Cc:     akpm@linux-foudation.org, xupengfei@nfschina.com,
        brauner@kernel.org, dchinner@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        royliyueyi@didiglobal.com
Subject: Re: [PATCH] fs: hfsplus: fix uninit-value bug in hfsplus_listxattr
Message-ID: <20230511043602.GG3390869@ZenIV>
References: <20230510022515.9368-1-houweitao@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510022515.9368-1-houweitao@didiglobal.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 10:25:15AM +0800, houweitao wrote:
> BUG: KMSAN: uninit-value in strncmp+0x11e/0x180 lib/string.c:307
>  strncmp+0x11e/0x180 lib/string.c:307
>  is_known_namespace fs/hfsplus/xattr.c:45 [inline]
>  name_len fs/hfsplus/xattr.c:397 [inline]
>  hfsplus_listxattr+0xe61/0x1aa0 fs/hfsplus/xattr.c:746
>  vfs_listxattr fs/xattr.c:473 [inline]
>  listxattr+0x700/0x780 fs/xattr.c:820
>  path_listxattr fs/xattr.c:844 [inline]
>  __do_sys_llistxattr fs/xattr.c:862 [inline]
>  __se_sys_llistxattr fs/xattr.c:859 [inline]
>  __ia32_sys_llistxattr+0x171/0x300 fs/xattr.c:859
>  do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>  __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
>  do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
>  do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
>  entry_SYSENTER_compat_after_hwframe+0x70/0x82
> 
> Reported-by: syzbot <syzbot+92ef9ee419803871020e@syzkaller.appspotmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=92ef9ee419803871020e
> Signed-off-by: houweitao <houweitao@didiglobal.com>

Why does it actually fix anything?  Other than making KMSAN STFU, that is...

"Fill it with zeroes" might or might not be a fix in this particular case,
but it really needs more detailed proof.

You might have figured it out, but how do I (or anybody else) even begin
to reason about the correctness of that fix?  By redoing the analysis from
scratch, starting with "in some conditions this stack trace might end up
reading uninitialized data in strbuf"?

NAK.  *IF* you have an explanation of what's going on and why this change
really fixes things, please repost with useful commit message.
