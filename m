Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94056DF857
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjDLOYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 10:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjDLOY3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:24:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A31310C0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YPL5BBTcasYPLyMcAw8sBNleYmI9kHBYcWCLDriGfOA=; b=MsX2N+ExLwZ/qPROWUdCDVge61
        vRXyMh9YoXcvIvjZTGiKYMrxKueZuGp7TGiGPT4WV2L+/EneY+bKu5t9Oj0NeDe0swUWRqv9FvRVl
        IN4/UqBDEYTb/Ed7jKVsaeMpHVtfsGeo/rytVooKCEvGWQrcLwxTAy3x97MwtwEnE+l3SNH+qBDbT
        NbnUUWa1jDIIyPVbF6flX/Bb8PVX4DAuRd+MhhjUd2YPzHxElxRni7cB3cm0/DWyY+R1PBbAfgux4
        bupMueJPqKAQrn2exXnCL1TXtbYCfTVObqxkUPFgOqHdzVGB7jcaWKEh6AklMIcc6UEn1xbdtHUbr
        O0J/KkhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmbOO-006w6x-Bc; Wed, 12 Apr 2023 14:24:12 +0000
Date:   Wed, 12 Apr 2023 15:24:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Hillf Danton <hdanton@sina.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, trix@redhat.com,
        ndesaulniers@google.com, nathan@kernel.org
Subject: Re: [PATCH] fs/ntfs3: disable page fault during ntfs_fiemap()
Message-ID: <ZDa/DDWtr0dTgoti@casper.infradead.org>
References: <000000000000e2102c05eeaf9113@google.com>
 <00000000000031b80705ef5d33d1@google.com>
 <f649c9c0-6c0c-dd0d-e3c9-f0c580a11cd9@I-love.SAKURA.ne.jp>
 <ZDaujCO3Azv92JxX@casper.infradead.org>
 <60f6bb85-825c-95e2-79b8-25a2d0e9979e@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f6bb85-825c-95e2-79b8-25a2d0e9979e@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:29:37PM +0900, Tetsuo Handa wrote:
> On 2023/04/12 22:13, Matthew Wilcox wrote:
> >> Also, since Documentation/filesystems/fiemap.rst says that "If an error
> >> is encountered while copying the extent to user memory, -EFAULT will be
> >> returned.", I assume that ioctl(FS_IOC_FIEMAP) users can handle -EFAULT
> >> error.
> > 
> > What?  No, that doesn't mean "You can return -EFAULT because random luck".
> > That means "If you pass it an invalid address, you'll get -EFAULT back".
> > 
> > NACK.
> 
> Then, why does fiemap.rst say "If an error is encountered" rather than
> "If an invalid address is passed" ?

Because people are bad at writing.

> Does the definition of -EFAULT limited to "the caller does not have permission
> to access this address" ?

Or the address isn't mapped.

> If copy_to_user() must not fail other than "the caller does not have
> permission to access this address", what should we do for now?
> Just remove ntfs_fiemap() and return -EOPNOTSUPP ?

No, fix it properly.  Or don't fix it at all and let somebody else fix it.
