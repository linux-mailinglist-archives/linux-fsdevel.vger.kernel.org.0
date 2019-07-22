Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670EA6FD9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 12:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfGVKRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 06:17:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:46608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728569AbfGVKRr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:17:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4BEDBB062;
        Mon, 22 Jul 2019 10:17:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3FF33DA882; Mon, 22 Jul 2019 12:18:18 +0200 (CEST)
Date:   Mon, 22 Jul 2019 12:18:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v3 23/24] erofs: introduce cached decompression
Message-ID: <20190722101818.GN20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gao Xiang <gaoxiang25@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-24-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722025043.166344-24-gaoxiang25@huawei.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:50:42AM +0800, Gao Xiang wrote:
> +choice
> +	prompt "EROFS Data Decompression mode"
> +	depends on EROFS_FS_ZIP
> +	default EROFS_FS_ZIP_CACHE_READAROUND
> +	help
> +	  EROFS supports three options for decompression.
> +	  "In-place I/O Only" consumes the minimum memory
> +	  with lowest random read.
> +
> +	  "Cached Decompression for readaround" consumes
> +	  the maximum memory with highest random read.
> +
> +	  If unsure, select "Cached Decompression for readaround"
> +
> +config EROFS_FS_ZIP_CACHE_DISABLED
> +	bool "In-place I/O Only"
> +	help
> +	  Read compressed data into page cache and do in-place
> +	  I/O decompression directly.
> +
> +config EROFS_FS_ZIP_CACHE_READAHEAD
> +	bool "Cached Decompression for readahead"
> +	help
> +	  For each request, it caches the last compressed page
> +	  for further reading.
> +	  It still does in-place I/O for the rest compressed pages.
> +
> +config EROFS_FS_ZIP_CACHE_READAROUND
> +	bool "Cached Decompression for readaround"
> +	help
> +	  For each request, it caches the both end compressed pages
> +	  for further reading.
> +	  It still does in-place I/O for the rest compressed pages.
> +
> +	  Recommended for performance priority.

The number of individual Kconfig options is quite high, are you sure you
need them to be split like that?

Eg. the xattrs, acls and security labels seem to be part of the basic
set of features so I wonder who does not want to enable them by default.
I think you copied ext4 as a skeleton for the options, but for a new
filesystem it's not necessary copy the history where I think features
were added over time.

Then eg. the option EROFS_FS_IO_MAX_RETRIES looks like a runtime
setting, the config help text does not explain anything about the change
in behaviour leaving the user with 'if not sure take the defaut'.

EROFS_FS_USE_VM_MAP_RAM is IMO a very low implementation detail, why
does it need to be config option at all?

And so on. I'd suggest to go through all the options and reconsider them
to be built-in, or runtime settings. Debugging features like the fault
injections could be useful on non-debugging builds too, so a separate
option is fine, otherwise grouping other debugging options under the
main EROFS_FS_DEBUG would look more logical.
