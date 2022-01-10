Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B29848974A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 12:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244647AbiAJLWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 06:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbiAJLVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:21:40 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B99C061759;
        Mon, 10 Jan 2022 03:21:39 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id B7FD0C009; Mon, 10 Jan 2022 12:21:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1641813698; bh=M3CpKCS476tBUMFu8GUWmiEFpmJ0Nl5M9joFvkmU2jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ad/UXD+Tlx6NyAQ6TwfNielAN2P/E9qo+T3gFyIHzS1SbyJcaNGNAQfA2lWgI5Jyi
         EdnUG0+jX3zWebMXFO4ka4cADi0fES36qSozwKpqeeBcTgWvNLAH9XlLr+WwPk+PIT
         pamK434nCm/j7F7zq+OMebPBr5TgBmIRyMU0bpLUc3GieFBSPxYt6txuIZVXWj142V
         MKfDzP5jr+1ZV/oTHRNm0jU68kDFSJuNBvxhHSFHdvjqgOF+cc7QWKF7m4lpCoCGXP
         AoDGoEcKWxQOmSqzv/lCPPAlo3aqRDwXzT0g0XwRx8pQqdgBzWSLvS+s4+cCmX9FQp
         vcyYgx2hkVgIg==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 4C1BFC009;
        Mon, 10 Jan 2022 12:21:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1641813697; bh=M3CpKCS476tBUMFu8GUWmiEFpmJ0Nl5M9joFvkmU2jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QO6UckVYlN+m3bFMPviSwz1BO4PHWk3d97gkU50kG7ycBzeC0V9cSWYKQqGwWn6nQ
         KFkHuZYXYgQ1TTpCzkNtGuhyAzUwUnCHKQi5de9GKDA0U6ld4F8u3L7EnEh8X1E6cc
         Xnu5xjf/jUlc53xt5iGqZpX1DvGn/C7VYT3TBu5rj3/FFpT38+1zzGF3bWuId1Wq49
         WQoll0GYAED7vkuQB8y7lPLq59zkl5s2Dd0IIH/CNr79vmIA/6abNuikA46BcZHMm0
         0uWrTwoip9SqFSN1pZj3WQqg9kLh9mvIFDNgLWlUC135LBJXlhKQczejtwfhObXJBD
         vfmT1v9v5T0fQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 029121b1;
        Mon, 10 Jan 2022 11:21:27 +0000 (UTC)
Date:   Mon, 10 Jan 2022 20:21:12 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, ceph-devel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-cifs@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Shyam Prasad N <nspmangalore@gmail.com>, linux-mm@kvack.org,
        linux-afs@lists.infradead.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, Steve French <sfrench@samba.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/68] fscache, cachefiles: Rewrite
Message-ID: <YdwWqOCtR2cDI0Fv@codewreck.org>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote on Wed, Dec 22, 2021 at 11:13:11PM +0000:
> These patches can be found also on:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-rewrite

Tested today's tip of the branch for 9p, with the patch I just sent it
appears to work ok with the note that files aren't read from cachefilesd
properly.

They were in v5.15 and not 5.16 so it's another regression from the
previous PR, and not a problem with these patches though, so can add my
tested-by to the three 9p patches:

Tested-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique
