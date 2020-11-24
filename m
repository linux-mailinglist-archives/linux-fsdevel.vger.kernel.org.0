Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482312C2B4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 16:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgKXP3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 10:29:32 -0500
Received: from pb-sasl-trial21.pobox.com ([173.228.157.51]:51152 "EHLO
        pb-sasl-trial21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgKXP3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:29:31 -0500
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 10:29:30 EST
Received: from pb-sasl-trial21.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 8CFFF1FB17;
        Tue, 24 Nov 2020 10:20:52 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=Jo23Bh/xtFFvRBkpZCyz3G4sDYI=; b=hHIHwW
        DZezDY0qZ0+Uw2Kc8MxaUAgJyp45FhjJ9GZV/SP20uSHayZYoh9nwzNPgiG/G/vS
        K4857Vcglaqe9ULYXyU5bcVutM84fKdKLmCdXYi9Axf6CNxgB2/kzzuIqhvoFOxH
        qdNWw+OZHTQcxz5/WlUliCbZXspYyFBwmmaag=
Received: from pb-smtp20.sea.icgroup.com (pb-smtp20.pobox.com [10.110.30.20])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 6CABF1FB14;
        Tue, 24 Nov 2020 10:20:52 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=Mn7Qjd0RWtZW8tou1NMKSrUduDIuvsAZF25t7rjnrTc=; b=cET7Qk/8pfKrUGDHxfJjaXH3YszxaIRACnvB7bB/d4VvjFSEYF6TCaWQR5SFceEaWJ5RjBsU/BghjHWvs7bVyFlHN7YT46rBiG+xa278WNAbjNFog8ccuVy/P/felkrwGfRFvXwGSLDFUDnsieYBq2aI1oVy9CGS76f3C8U2MR4=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 594FD10FA12;
        Tue, 24 Nov 2020 10:20:49 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 876AD2DA0AC4;
        Tue, 24 Nov 2020 10:20:47 -0500 (EST)
Date:   Tue, 24 Nov 2020 10:20:47 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Ira Weiny <ira.weiny@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?ISO-8859-15?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/17] fs/cramfs: Use memcpy_from_page()
In-Reply-To: <20201124060755.1405602-13-ira.weiny@intel.com>
Message-ID: <nycvar.YSQ.7.78.906.2011241020270.2184@knanqh.ubzr>
References: <20201124060755.1405602-1-ira.weiny@intel.com> <20201124060755.1405602-13-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: A1F9A662-2E68-11EB-8BBF-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 Nov 2020, ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Remove open coded kmap/memcpy/kunmap and use mempcy_from_page() instead.
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> ---
>  fs/cramfs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 4b90cfd1ec36..996a3a32a01f 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -247,8 +247,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>  		struct page *page = pages[i];
>  
>  		if (page) {
> -			memcpy(data, kmap(page), PAGE_SIZE);
> -			kunmap(page);
> +			memcpy_from_page(data, page, 0, PAGE_SIZE);
>  			put_page(page);
>  		} else
>  			memset(data, 0, PAGE_SIZE);
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
> 
