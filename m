Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A408C1839A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 20:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgCLTiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 15:38:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56666 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgCLTiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:38:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCTeV-00AJDj-Tq; Thu, 12 Mar 2020 19:37:55 +0000
Date:   Thu, 12 Mar 2020 19:37:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Allison <jra@samba.org>,
        Ralph =?iso-8859-1?Q?B=F6hme?= <slow@samba.org>,
        Volker Lendecke <vl@sernet.de>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
Message-ID: <20200312193755.GL23230@ZenIV.linux.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 06:11:09PM +0100, Stefan Metzmacher wrote:

> If that works safely for hardlinks and having another process doing a
> rename between openat2() and unlinkat(), we could try that.
> 
> My initial naive idea was to have one syscall instead of
> linkat2/renameat3/unlinkat2.
> 
> int xlinkat(int src_dfd, const char *src_path,
>             int dst_dfd, const char *dst_path,
>             const struct xlinkat_how *how, size_t how_size);
> 
> struct xlinkat_how {
>        __u64 src_at_flags;
>        __u64 src_resolve_flags;
>        __u64 dst_at_flags;
>        __u64 dst_resolve_flags;
>        __u64 rename_flags;
>        __s32 src_fd;
> };
> 
> With src_dfd=-1, src_path=NULL, how.src_fd = -1, this would be like
> linkat().
> With dst_dfd=-1, dst_path=NULL, it would be like unlinkat().
> Otherwise a renameat2().
>
> If how.src_fd is not -1, it would be checked to be the same path as
> specified by src_dfd and src_path.

"Checked" as in...?  And is that the same path or another link to the
same object, or...?

The idea of dumping all 3 into the same syscall looks wrong - compare
the effects of link() and rename() on the opened files, for starters,
and try to come up with documentation for all of that.  Multiplexors
tend to be very bad, in large part because they have so bloody
convoluted semantics...
