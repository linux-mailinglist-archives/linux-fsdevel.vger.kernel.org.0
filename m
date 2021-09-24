Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B304A417C32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 22:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346005AbhIXUM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344434AbhIXUMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:12:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34CAC061571;
        Fri, 24 Sep 2021 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7ncpmpQORtbSOxGAPueW+IXlEjJ+gZin6hmVmI/YRoo=; b=dGGkic4Lh01v+IinitCaZlfNiX
        d4rAidh/lyoGoYykLzOH+ZqCCDk8Rd9+U2sykPbWJ+M502s992XVMWRrHJybdQSfooRjBHScy+C1w
        OKKUm9gLECJ+3AVuiglpMi9jdz+DFjznSAMmp8qs0tMCPqwAVo2apHHBTTjQGk78PJMJcQgV5QCuD
        43CmIgXIofEmyz19muuu45gg72RzzbAl5/IYVPVZIGoGw8CxVNi+llf3/o2l4nVRu5wzKaB7dmwJs
        DD954+B29YKp0MmWLo+gVjrbEzcCft43S2m0mnbwZnG0i4qYwWdQX6OaYnUHOrOWvtoK4Chx6PpaF
        VimTJydw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTrWC-007YNw-EY; Fri, 24 Sep 2021 20:10:11 +0000
Date:   Fri, 24 Sep 2021 21:10:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     hch@lst.de, trond.myklebust@primarydata.com,
        "Darrick J. Wong" <djwong@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] mm: Add 'supports' field to the
 address_space_operations to list features
Message-ID: <YU4wmPyEoOZZfP3l@casper.infradead.org>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <163250389458.2330363.17234460134406104577.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163250389458.2330363.17234460134406104577.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:18:14PM +0100, David Howells wrote:
> Rather than depending on .direct_IO to point to something to indicate that
> direct I/O is supported, add a 'supports' bitmask that we can test, since
> we only need one bit.

Why would you add mapping->aops->supports instead of using one of the free
bits in mapping->flags?  enum mapping_flags in pagemap.h.

It could also be a per-fs flag, or per-sb flag, but it's fewer
dereferences at check time if it's in mapping->flags.

