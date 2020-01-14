Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE1139E76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 01:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgANAl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 19:41:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49084 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728641AbgANAlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:41:55 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00E0fbEI006931
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 19:41:38 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5C3A54207DF; Mon, 13 Jan 2020 19:41:37 -0500 (EST)
Date:   Mon, 13 Jan 2020 19:41:37 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] fs-verity: implement readahead for
 FS_IOC_ENABLE_VERITY
Message-ID: <20200114004137.GQ76141@mit.edu>
References: <20200106205410.136707-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106205410.136707-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 12:54:10PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> When it builds the first level of the Merkle tree, FS_IOC_ENABLE_VERITY
> sequentially reads each page of the file using read_mapping_page().
> This works fine if the file's data is already in pagecache, which should
> normally be the case, since this ioctl is normally used immediately
> after writing out the file.
> 
> But in any other case this implementation performs very poorly, since
> only one page is read at a time.
> 
> Fix this by implementing readahead using the functions from
> mm/readahead.c.
> 
> This improves performance in the uncached case by about 20x, as seen in
> the following benchmarks done on a 250MB file (on x86_64 with SHA-NI):
> 
>     FS_IOC_ENABLE_VERITY uncached (before) 3.299s
>     FS_IOC_ENABLE_VERITY uncached (after)  0.160s
>     FS_IOC_ENABLE_VERITY cached            0.147s
>     sha256sum uncached                     0.191s
>     sha256sum cached                       0.145s
> 
> Note: we could instead switch to kernel_read().  But that would mean
> we'd no longer be hashing the data directly from the pagecache, which is
> a nice optimization of its own.  And using kernel_read() would require
> allocating another temporary buffer, hashing the data and tree pages
> separately, and explicitly zero-padding the last page -- so it wouldn't
> really be any simpler than direct pagecache access, at least for now.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
