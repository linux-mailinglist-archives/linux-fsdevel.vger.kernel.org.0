Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD023F9F32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhH0Sww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 14:52:52 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:42272 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhH0Swv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:52:51 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJgt6-00GYzg-NV; Fri, 27 Aug 2021 18:47:36 +0000
Date:   Fri, 27 Aug 2021 18:47:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 18/19] iov_iter: Introduce nofault flag to disable
 page faults
Message-ID: <YSkzSHSp8lld6dwW@zeniv-ca.linux.org.uk>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-19-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-19-agruenba@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:25PM +0200, Andreas Gruenbacher wrote:
> Introduce a new nofault flag to indicate to get_user_pages to use the
> FOLL_NOFAULT flag.  This will cause get_user_pages to fail when it
> would otherwise fault in a page.
> 
> Currently, the noio flag is only checked in iov_iter_get_pages and
> iov_iter_get_pages_alloc.  This is enough for iomaop_dio_rw, but it
> may make sense to check in other contexts as well.

I can live with that, but
	* direct assignments (as in the next patch) are fucking hard to
grep for.  Is it intended to be "we set it for duration of primitive",
or...?
	* it would be nice to have a description of intended semantics
for that thing.  This "may make sense to check in other contexts" really
needs to be elaborated (and agreed) upon.  Details, please.
