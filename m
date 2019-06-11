Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881F53C15D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 04:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390884AbfFKCv3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 22:51:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34066 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390670AbfFKCv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 22:51:29 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5B2p9oJ002582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jun 2019 22:51:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D394C420481; Mon, 10 Jun 2019 22:51:08 -0400 (EDT)
Date:   Mon, 10 Jun 2019 22:51:08 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH] vfs: allow copy_file_range from a swapfile
Message-ID: <20190611025108.GB2774@mit.edu>
References: <20190610172606.4119-1-amir73il@gmail.com>
 <20190611011612.GQ1871505@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611011612.GQ1871505@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 06:16:12PM -0700, Darrick J. Wong wrote:
> On Mon, Jun 10, 2019 at 08:26:06PM +0300, Amir Goldstein wrote:
> > read(2) is allowed from a swapfile, so copy_file_range(2) should
> > be allowed as well.
> > 
> > Reported-by: Theodore Ts'o <tytso@mit.edu>
> > Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> > 
> > Darrick,
> > 
> > This fixes the generic/554 issue reported by Ted.
> 
> Frankly I think we should go the other way -- non-root doesn't get to
> copy from or read from swap files.

The issue is that without this patch, *root* doesn't get to copy from
swap files.  Non-root shouldn't have access via Unix permissions.  We
could add a special case if we don't trust system administrators to be
able to set the Unix permissions correctly, I suppose, but we don't do
that for block devices when they are mounted....

					- Ted
