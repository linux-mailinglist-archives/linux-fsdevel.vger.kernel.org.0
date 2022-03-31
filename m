Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54F54EE2C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 22:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbiCaUpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 16:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiCaUpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:45:00 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35211DF855;
        Thu, 31 Mar 2022 13:43:12 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1na1dP-001IbT-Nb; Thu, 31 Mar 2022 20:43:11 +0000
Date:   Thu, 31 Mar 2022 20:43:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+2778a29e60b4982065a0@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Ming Lei <ming.lei@redhat.com>
Subject: Re: [syzbot] BUG: scheduling while atomic in simple_recursive_removal
Message-ID: <YkYSX0tibIE5o0h8@zeniv-ca.linux.org.uk>
References: <0000000000007564ac05db72ff58@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007564ac05db72ff58@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:37:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d888c83fcec7 fs: fix fd table size alignment properly
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=103e7b53700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cadd7063134e07bc
> dashboard link: https://syzkaller.appspot.com/bug?extid=2778a29e60b4982065a0
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2778a29e60b4982065a0@syzkaller.appspotmail.com

Very likely to have been caused by commit 0a9a25ca7843 "block: let blkcg_gq
grab request queue's refcnt".

It had added dropping a queue refcount (which is blocking) into blkg_free(),
which is called from __blkg_release().  And that is called via call_rcu()
and thus is not allowed to block at all.
