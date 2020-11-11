Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F58A2AFD19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 02:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgKLBcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 20:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgKKXJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:09:28 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1A7C0613D4;
        Wed, 11 Nov 2020 15:09:28 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kczEi-003t2b-3Z; Wed, 11 Nov 2020 23:09:08 +0000
Date:   Wed, 11 Nov 2020 23:09:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     yulei zhang <yulei.kernel@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: Re: [PATCH 01/35] fs: introduce dmemfs module
Message-ID: <20201111230908.GC3576660@ZenIV.linux.org.uk>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <aa553faf9e97ee9306ecd5a67d3324a34f9ed4be.1602093760.git.yuleixzhang@tencent.com>
 <20201110200411.GU3576660@ZenIV.linux.org.uk>
 <CACZOiM1L2W+neaF-rd=k9cJTnQfNBLx2k9GLZydYuQiJqr=iXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACZOiM1L2W+neaF-rd=k9cJTnQfNBLx2k9GLZydYuQiJqr=iXg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 04:53:00PM +0800, yulei zhang wrote:

> > ... same here, seeing that you only call that thing from the next two functions
> > and you do *not* provide ->mknod() as a method (unsurprisingly - what would
> > device nodes do there?)
> >
> 
> Thanks for pointing this out. we may need support the mknod method, otherwise
> the dev is redundant  and need to be removed.

I'd suggest turning that into (static) __create_file(....) with

static int dmemfs_create(struct inode *dir, struct dentry *dentry,
			 umode_t mode, bool excl)
{
	return __create_file(dir, dentry, mode | S_IFREG);
}

static int dmemfs_mkdir(struct inode *dir, struct dentry *dentry,
			 umode_t mode)
{
	return __create_file(dir, dentry, mode | S_IFDIR);
}

(i.e. even inc_nlink() of parent folded into that).

[snip]

> Yes, we seperate the full implementation for dmemfs_file_mmap into
> patch 05/35, it
> will assign the interfaces to handle the page fault.

It would be less confusing to move the introduction of ->mmap() to that patch,
then.
