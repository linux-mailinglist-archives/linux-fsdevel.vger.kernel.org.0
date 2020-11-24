Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C272C2945
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbgKXOUf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 09:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgKXOUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:20:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB43CC0613D6;
        Tue, 24 Nov 2020 06:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lCJuGvEXhGVtkMxPpM35X/PsPMXYs4s7j54JBm6CPhQ=; b=as4wsJEPyN7AbT6hYhmyY71R4/
        EUgHBRcOa+6QHUb2uTS1FNVr35DuEHom7w8q5+vfEy1lfsSMja4EnUl07Ioaw/BVvP3g3dX/Fz3jj
        n8O4DzrOrycv7GgS8yqUG+x7+kRiHeqR/qAyDBrQfYU+y9GuoOMUpjXcVqgra+EGGrTk6yfhCZQhm
        JK+Se6heZvGAqndPAwFIIcvJtszvPPz1W/NM9WYZ8sjDKSaUyDo6xoHuGI7qbDj09QUL1bjVLAVfp
        RkyEwVRZker2pYu9SW++MxaftZETRaN/+HyshNONSP1z02VgbtexthQvBdVe23RWL2ehe6+ecz8uu
        YuqMBXRg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khZAT-0002uo-EZ; Tue, 24 Nov 2020 14:19:41 +0000
Date:   Tue, 24 Nov 2020 14:19:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/17] mm/highmem: Lift memcpy_[to|from]_page and
 memset_page to core
Message-ID: <20201124141941.GB4327@casper.infradead.org>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
 <20201124060755.1405602-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124060755.1405602-2-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:07:39PM -0800, ira.weiny@intel.com wrote:
> +static inline void memzero_page(struct page *page, size_t offset, size_t len)
> +{
> +	memset_page(page, 0, offset, len);
> +}

This is a less-capable zero_user_segments().

