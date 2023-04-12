Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460096DF6C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 15:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDLNPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 09:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDLNPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:15:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392417EDD
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jhnbfZZJmRmZ+IEFhR2VhfrX2b5999A1n8AJ1gD5lxM=; b=fuJmWaypLyPsm8wmSwakd4AtLJ
        0ylp0YlkyNAIfNlutNxX3yTN8vLYyE9fuyJQsWNtD649gEuZSj8PWaRVUgM/dcyOmzhffiS93i4Cy
        vEUBETP/sVTGRA1NtfVaZgQeV4neTcIsIdyH32yDMXTvdM6uYnP9eNxRJQPL/T5sIBeDDzFJNZB8+
        B3GRn7z9e+1vk7uY4FD8kgdb/uYhD8E5nhDhX13W+Fkpqxesk9GfStsGntLvXnung9qudYGGCSleI
        T3ViyMdxrfjVpVzzsMViUXD4QDeqZe9IGmpYpREkkq8kzO4YGpWVNxNBRoXkv0mOo06eFwJRz5sQ7
        sypV+wow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmaIG-006tKO-VN; Wed, 12 Apr 2023 13:13:49 +0000
Date:   Wed, 12 Apr 2023 14:13:48 +0100
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
Message-ID: <ZDaujCO3Azv92JxX@casper.infradead.org>
References: <000000000000e2102c05eeaf9113@google.com>
 <00000000000031b80705ef5d33d1@google.com>
 <f649c9c0-6c0c-dd0d-e3c9-f0c580a11cd9@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f649c9c0-6c0c-dd0d-e3c9-f0c580a11cd9@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:11:08PM +0900, Tetsuo Handa wrote:
> syzbot is reporting circular locking dependency between ntfs_file_mmap()
> (which has mm->mmap_lock => ni->ni_lock dependency) and ntfs_fiemap()
> (which has ni->ni_lock => mm->mmap_lock dependency).
> 
> Since ni_fiemap() is called by ioctl(FS_IOC_FIEMAP) via optional
> "struct inode_operations"->fiemap callback, I assume that importance of
> ni_fiemap() is lower than ntfs_file_mmap().
> 
> Also, since Documentation/filesystems/fiemap.rst says that "If an error
> is encountered while copying the extent to user memory, -EFAULT will be
> returned.", I assume that ioctl(FS_IOC_FIEMAP) users can handle -EFAULT
> error.

What?  No, that doesn't mean "You can return -EFAULT because random luck".
That means "If you pass it an invalid address, you'll get -EFAULT back".

NACK.
