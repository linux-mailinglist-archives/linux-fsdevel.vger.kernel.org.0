Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBB411A390
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 05:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLKErp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 23:47:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52522 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfLKErp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 23:47:45 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ietuF-0004dd-CH; Wed, 11 Dec 2019 04:47:23 +0000
Date:   Wed, 11 Dec 2019 04:47:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] fs: introduce is_dot_or_dotdot helper for cleanup
Message-ID: <20191211044723.GC4203@ZenIV.linux.org.uk>
References: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
 <20191211024858.GB732@sol.localdomain>
 <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:59:40AM +0800, Tiezhu Yang wrote:

> static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> {
>         if (len == 1 && name[0] == '.')
>                 return true;
> 
>         if (len == 2 && name[0] == '.' && name[1] == '.')
>                 return true;
> 
>         return false;
> }
> 
> Hi Matthew,
> 
> How do you think? I think the performance influence is very small
> due to is_dot_or_dotdot() is a such short static inline function.

It's a very short inline function called on a very hot codepath.
Often.

I mean it - it's done literally for every pathname component of
every pathname passed to a syscall.
