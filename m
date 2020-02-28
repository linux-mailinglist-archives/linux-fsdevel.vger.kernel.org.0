Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 897F2172F5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 04:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbgB1DeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 22:34:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbgB1DeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8ohWsBNybdoUlsH9268dif1L9MEaj5QT7JAO8j1ggLc=; b=Bd791Ixini1pwewoL2V9vEiHTl
        xbdtRGLm8B+bBqUJvH8F9vnusQAImUKO3DvyUVsUFB5at16CO4xiM2a16YujtnqTUV6fBuQwDqsJg
        vbXEKlTxmXsD2dAMAl3yqiO7rQdvBMSeltt79eRQgjkE+o0DPBieLMdG6WLVt5NArdeChc4o5ix9k
        7/fEAVGXho0E/oWy5es6qshWghH/Yy7ggoSNr2UyTQj8JRSBBoVvpVFGQiGezil6RA4OuH0KLiiBX
        7puBjkRprI2OixIexMypB1eRkx67+XRiHaLYqnMiDXYp9tDCGOXpCiSNxV4H7DNJCUByG2zLRY/aS
        vPHSUE1w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7WPk-0003d7-Dn; Fri, 28 Feb 2020 03:34:12 +0000
Date:   Thu, 27 Feb 2020 19:34:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Message-ID: <20200228033412.GD29971@bombadil.infradead.org>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
 <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
 <9d7b76c32d09492137a253e692624856388693db.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d7b76c32d09492137a253e692624856388693db.camel@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 05:55:43PM +0800, Ian Kent wrote:
> Not all file systems even produce negative hashed dentries.
> 
> The most beneficial use of them is to improve performance of rapid
> fire lookups for non-existent names. Longer lived negative hashed
> dentries don't give much benefit at all unless they suddenly have
> lots of hits and that would cost a single allocation on the first
> lookup if the dentry ttl expired and the dentry discarded.
> 
> A ttl (say jiffies) set at appropriate times could be a better
> choice all round, no sysctl values at all.

The canonical argument in favour of negative dentries is to improve
application startup time as every application searches the library path
for the same libraries.  Only they don't do that any more:

$ strace -e file cat /dev/null
execve("/bin/cat", ["cat", "/dev/null"], 0x7ffd5f7ddda8 /* 44 vars */) = 0
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/dev/null", O_RDONLY) = 3

So, are they still useful?  Or should we, say, keep at most 100 around?
