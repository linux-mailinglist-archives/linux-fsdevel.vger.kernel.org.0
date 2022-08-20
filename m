Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3659AEDF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 17:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbiHTPdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 11:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTPdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 11:33:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE01209E;
        Sat, 20 Aug 2022 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5sAr4rzx6SCv44UYAl1KMLXHp2wkDi6knE6w66LUH/Q=; b=aaf03K0StTdCGsUh+GWGmzlgJl
        JKrPSsYEa6v5bWe3xzk01borQuEI+zplNIyVoz0BCek7ZHDCy/o9/IYypRkUS8E4g+BW6Ee4Qd6RN
        +/WsjNTd1y6KsNSU5gYliZRqkWJTDppJvz0l/LzAktRV7J/o/vJwOPIg9AILhuOwuZxCG50OODHp9
        3ZJDTjzFOx2KQZTUaMTZdXEH4nJJ+SgBh9siP9iQS93aNEqp0WI84GZk2LBKDOrgbtXPyJcJv4gI0
        ENLU3xoVFCIxrhq7PTnmKBCDC6vuQSJZb62pxEM7MpY9sozDh3Fw05RwGDcL4spOQbs6W5b5msflF
        elMNOfyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPQTb-006Pjx-AI;
        Sat, 20 Aug 2022 15:33:31 +0000
Date:   Sat, 20 Aug 2022 16:33:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH 4/5] ksmbd: don't open-code %pf
Message-ID: <YwD+y2cXpcenIHlW@ZenIV>
References: <Yv2qoNQg48rtymGE@ZenIV>
 <Yv2rCqD7M8fAhq5v@ZenIV>
 <CAKYAXd-Xsih1TKTbM0kTGmjQfpkbpp7d3u9E7USuwmiSXLVvBw@mail.gmail.com>
 <Yv6igFDtDa0vmq6H@ZenIV>
 <CAKYAXd-6fT5qG2VmVG6Q51Z8-_79cjKhERHDatR_z62w19+p1Q@mail.gmail.com>
 <YwBZPCy0RBc9hwIk@ZenIV>
 <CAKYAXd9DGgLJ=-hcdADXVZUqp2aYRkGr2YKpfUND6S_GuaWgWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9DGgLJ=-hcdADXVZUqp2aYRkGr2YKpfUND6S_GuaWgWQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 20, 2022 at 02:44:29PM +0900, Namjae Jeon wrote:
> > OK...  FWIW, I've another ksmbd patch hanging around and it might be
> > less PITA if I put it + those two patches into never-rebased branch
> > (for-ksmbd) for ksmbd folks to pull from.  Fewer pointless conflicts
> > that way...
> Okay, Thanks for this. I'm trying to resend "ksmbd: fix racy issue
> from using ->d_parent and ->d_name" patch to you, but It conflict with
> these patches:)
> We will pull them from that branch if you create it.

OK, pull request follows:

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-ksmbd

for you to fetch changes up to f2ea6d96500dd8947467f774d70700c1ba3ed8ef:

  ksmbd: constify struct path (2022-08-20 10:54:48 -0400)

----------------------------------------------------------------
assorted ksmbd cleanups

Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (3):
      ksmbd: don't open-code file_path()
      ksmbd: don't open-code %pD
      ksmbd: constify struct path

 fs/ksmbd/misc.c    |  2 +-
 fs/ksmbd/misc.h    |  2 +-
 fs/ksmbd/smb2pdu.c | 33 ++++++++++++++++-----------------
 fs/ksmbd/smbacl.c  |  6 +++---
 fs/ksmbd/smbacl.h  |  6 +++---
 fs/ksmbd/vfs.c     | 18 ++++++++----------
 fs/ksmbd/vfs.h     |  2 +-
 7 files changed, 33 insertions(+), 36 deletions(-)
