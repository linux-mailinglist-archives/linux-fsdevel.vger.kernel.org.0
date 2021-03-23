Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90575346DDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 00:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCWXXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 19:23:33 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:36376 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCWXX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 19:23:28 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOqIe-008gcD-SL; Tue, 23 Mar 2021 23:19:01 +0000
Date:   Tue, 23 Mar 2021 23:19:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        krisman@collabora.com, smcv@collabora.com, kernel@collabora.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
Subject: Re: [RFC PATCH 2/4] mm: shmem: Support case-insensitive file name
 lookups
Message-ID: <YFp3ZF+gAnhKMJIA@zeniv-ca.linux.org.uk>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
 <20210323195941.69720-3-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323195941.69720-3-andrealmeid@collabora.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 04:59:39PM -0300, André Almeida wrote:

> * dcache handling:
> 
> For a +F directory, tmpfs only stores the first equivalent name dentry
> used in the dcache. This is done to prevent unintentional duplication of
> dentries in the dcache, while also allowing the VFS code to quickly find
> the right entry in the cache despite which equivalent string was used in
> a previous lookup, without having to resort to ->lookup().
> 
> d_hash() of casefolded directories is implemented as the hash of the
> casefolded string, such that we always have a well-known bucket for all
> the equivalencies of the same string. d_compare() uses the
> utf8_strncasecmp() infrastructure, which handles the comparison of
> equivalent, same case, names as well.
> 
> For now, negative lookups are not inserted in the dcache, since they
> would need to be invalidated anyway, because we can't trust missing file
> dentries. This is bad for performance but requires some leveraging of
> the VFS layer to fix. We can live without that for now, and so does
> everyone else.

"For now"?  Not a single practical suggestion has ever materialized.
Pardon me, but by now I'm very sceptical about the odds of that
ever changing.  And no, I don't have any suggestions either.

> The lookup() path at tmpfs creates negatives dentries, that are later
> instantiated if the file is created. In that way, all files in tmpfs
> have a dentry given that the filesystem exists exclusively in memory.
> As explained above, we don't have negative dentries for casefold files,
> so dentries are created at lookup() iff files aren't casefolded. Else,
> the dentry is created just before being instantiated at create path.
> At the remove path, dentries are invalidated for casefolded files.

Umm...  What happens to those assertions if previously sane directory
gets case-buggered?  You've got an ioctl for doing just that...
Incidentally, that ioctl is obviously racy - result of that simple_empty() 
might have nothing to do with reality before it is returned to caller.
And while we are at it, simple_empty() doesn't check a damn thing about
negative dentries in there...
