Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC2D3F9F38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 20:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhH0Sy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 14:54:26 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:42332 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhH0SyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:54:19 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJgyi-00GZ6s-QW; Fri, 27 Aug 2021 18:53:24 +0000
Date:   Fri, 27 Aug 2021 18:53:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 04/19] iov_iter: Turn iov_iter_fault_in_readable into
 fault_in_iov_iter_readable
Message-ID: <YSk0pAWx7xO/39A6@zeniv-ca.linux.org.uk>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-5-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-5-agruenba@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:11PM +0200, Andreas Gruenbacher wrote:
> Turn iov_iter_fault_in_readable into a function that returns the number
> of bytes not faulted in (similar to copy_to_user) instead of returning a
> non-zero value when any of the requested pages couldn't be faulted in.
> This supports the existing users that require all pages to be faulted in
> as well as new users that are happy if any pages can be faulted in at
> all.
> 
> Rename iov_iter_fault_in_readable to fault_in_iov_iter_readable to make
> sure that this change doesn't silently break things.

I really disagree with these calling conventions.  "Number not faulted in"
is bloody useless; make it "nothing could be faulted in"/"something had
been faulted in" and it would make sense.  Failure several pages into the
area should not be treated as a hard error, for one thing, and ANY user
of that thing will have to cope with short copies anyway, no matter how
much you've managed to fault in.
