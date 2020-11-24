Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26D02C30B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 20:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391002AbgKXTZK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 14:25:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:17772 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390987AbgKXTZJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:25:09 -0500
IronPort-SDR: tK38+FhMbwAc+WFE+pw/hXCe1iX6ZqDIMWUzyP/RpaOOaVYp6lwGcudAr69P5PbMRfcd6hgZIc
 Mhas4PmUaw6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="159771502"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="159771502"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 11:25:08 -0800
IronPort-SDR: 6Sl8+oaY1IVjYtT30cuSTX9tyV+kga+JlcAgTnvahVIiQy/tyDZShM5V7oiCOTFgkHLbC+8Y3I
 MHdmSzM7LTFQ==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="478608510"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 11:25:08 -0800
Date:   Tue, 24 Nov 2020 11:25:08 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Howells <dhowells@redhat.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/17] fs/btrfs: Convert to memzero_page()
Message-ID: <20201124192508.GM1161629@iweiny-DESK2.sc.intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
 <20201124060755.1405602-6-ira.weiny@intel.com>
 <20201124141244.GE17322@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124141244.GE17322@twin.jikos.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 03:12:44PM +0100, David Sterba wrote:
> On Mon, Nov 23, 2020 at 10:07:43PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Remove the kmap/memset()/kunmap pattern and use the new memzero_page()
> > call where possible.
> > 
> > Cc: Chris Mason <clm@fb.com>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: David Sterba <dsterba@suse.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/btrfs/inode.c | 21 +++++----------------
> 
> The patch converts the pattern only in inode.c, but there's more in
> compression.c, extent_io.c, zlib.c,d zstd.c (kmap_atomic) and reflink.c,
> send.c (kmap).

Thanks...  not sure how I missed reflink.c and send.c.

I'll add them in v2.

Thanks!
Ira
