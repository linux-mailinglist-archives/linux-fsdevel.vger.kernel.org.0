Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168A8488212
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 08:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiAHHSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 02:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiAHHSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 02:18:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13E5C061574;
        Fri,  7 Jan 2022 23:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KSMh/bpBH4Uy4k4tKFX+8O00P4Uf43q6ePBN9GKywck=; b=WiPnWas5oTaP9guznINp2fF7Mn
        xzeGATWy/kuuFgSPlHg0Z8p5TIkf0mgvMeVP/tuV5jx+0s7gV9k4Z6oSwJi3CV16ub/PpWYkJdZYX
        q4MlD2+tI2XgKSLzq22nOThJEogSiORw9rPQJ+jkYM2tUxoHCrOJ2YGItwntGNPqhSv48p6l3l814
        dsFW43m+yQ8TTq1QC27ZoJZ3Jna/BRJNtdsQCUlGXQvrqcSMm6K6JZz10DYCatuBjNOg0u5fY4VuN
        Y5Pex2G5YuW3GH6T0rTtO9g6DtAvcx8KdFRcNJjZfO5NnnTZ3Wo34SXMHqK/Kc2zDv56IQgvzE3PB
        LgjbtHfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n65yn-000Uuc-Lb; Sat, 08 Jan 2022 07:17:33 +0000
Date:   Sat, 8 Jan 2022 07:17:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 38/68] vfs, cachefiles: Mark a backing file in use
 with an inode flag
Message-ID: <Ydk6jWmFH6TZLPZq@casper.infradead.org>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
 <164021541207.640689.564689725898537127.stgit@warthog.procyon.org.uk>
 <CAOQ4uxjEcvffv=rNXS-r+NLz+=6yk4abRuX_AMq9v-M4nf_PtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjEcvffv=rNXS-r+NLz+=6yk4abRuX_AMq9v-M4nf_PtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 08, 2022 at 09:08:57AM +0200, Amir Goldstein wrote:
> > +#define S_KERNEL_FILE  (1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
> 
> Trying to brand this flag as a generic "in use by kernel" is misleading.
> Modules other than cachefiles cannot set/clear this flag, because then
> cachefiles won't know that it is allowed to set/clear the flag.

Huh?  If some other kernel module sets it, cachefiles will try to set it,
see it's already set, and fail.  Presumably cachefiles does not go round
randomly "unusing" files that it has not previously started using.

I mean, yes, obviously, it's a kernel module, it can set and clear
whatever flags it likes on any inode in the system, but conceptually,
it's an advisory whole-file lock.
