Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444214114AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbhITMk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 08:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbhITMky (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:40:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ABFC061574;
        Mon, 20 Sep 2021 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wo+vAVxsvvL69J6kBhb2k3hYCVmdEGu6z6CieNSf45o=; b=Atewm4NOs4/l+DuGNUyY53AjHy
        70TO3+51yjvHj0182A4vAxE9+LFDnm5Vw/mGE4zoxkJ6WR0ig7YE9ZURNu8uOV0+zY2joRoYXQm1D
        7NyF5YMWFBsKUEMXHFTq2VB26z+A0I5DskYpuK/zRRJB+vnqEPUF0S9VtIITY8kLFVjkimCmHVcfL
        tSb6zp1KE8n9or8xF+4hAI+G0PcKd8oRuw4JYZ05cXelw/f3YEWC2+JszJohc/QHcLCYrY2i1BZC6
        tEdobQre2gxMelJ4E/azkUcwwoHAgk9JVNCXKkmQ2ZmKs4Lmlp9/OBGYDsYJ15Co7FV3eIcLC+Vrs
        tksAiKmA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIYM-002f95-A3; Mon, 20 Sep 2021 12:37:50 +0000
Date:   Mon, 20 Sep 2021 13:37:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fscache, 9p, afs, cifs, nfs: Deal with some warnings
 from W=1
Message-ID: <YUiAmnMV7+fprNC1@casper.infradead.org>
References: <163214005516.2945267.7000234432243167892.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163214005516.2945267.7000234432243167892.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:14:15PM +0100, David Howells wrote:
> +++ b/fs/9p/vfs_addr.c
> @@ -88,7 +88,7 @@ static const struct netfs_read_request_ops v9fs_req_ops = {
>  
>  /**
>   * v9fs_vfs_readpage - read an entire page in from 9P
> - * @filp: file being read
> + * @file: file being read
>   * @page: structure to page
>   *
>   */

This is an example of a weird pattern in filesystems.  Several of
them have kernel-doc for the implementation of various ->ops methods.
I don't necessarily believe we should delete the comments (although is
there any useful information in the above?), but I don't see the point
in the comment being kernel-doc.

