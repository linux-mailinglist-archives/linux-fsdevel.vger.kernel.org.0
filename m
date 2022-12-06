Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BFF644BF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 19:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLFSkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 13:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiLFSks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:40:48 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C022303C2;
        Tue,  6 Dec 2022 10:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=ZiiH7sPM36eESYgVd0MVQCEMcrxi9jMZwAnjeL8qWtI=; b=fxa8RuuDWwVd5gWqReAJK6uA7h
        Nny/0gZQC9I+tr59D1gA2hOqNspedLXG9FyqFlyZQR7+257futnwHXjXoQPmoPr/W+jZic5cVzPHR
        0xnD5YskPYAPxIjxKVejQ+Isixsl6K7NuwfPkpbxDLoWhH+1L0Q0+VYyZNdfl+s+5BYEsyHurI8Dk
        g4EAXFBbgAqTKkk2YkJT7c5jOklOoFSL65+EFFhHQW4dHvpEr+/mg/CslZWjcE7h8qPntCQ8tLgtk
        lsHRjnQJckZ4g1qkZM7hhxIMXOH4cdXuuXZ8s0sOVLmx3zEQwrhxCsk3+RI/HrZsY+kLwGu1F+INb
        kSrHsTFA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1p2crp-001syz-HJ; Tue, 06 Dec 2022 11:40:34 -0700
Message-ID: <8420a781-6ac2-e976-cc43-a04d59d2d043@deltatee.com>
Date:   Tue, 6 Dec 2022 11:40:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-CA
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org
References: <0d62615c-57d1-922b-5ebc-32faabf33327@deltatee.com>
 <166997419665.9475.15014699817597102032.stgit@warthog.procyon.org.uk>
 <166997421646.9475.14837976344157464997.stgit@warthog.procyon.org.uk>
 <1251303.1670351737@warthog.procyon.org.uk>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <1251303.1670351737@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: dhowells@redhat.com, viro@zeniv.linux.org.uk, hch@lst.de, jhubbard@nvidia.com, willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@infradead.org, jlayton@kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 2/4] iov_iter: Add a function to extract a page list
 from an iterator
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022-12-06 11:35, David Howells wrote:
> Logan Gunthorpe <logang@deltatee.com> wrote:
> 
>> If this is going to be a general replacement for iov_iter_get_pages()
>> it's going to need to pass through gup_flags. My recent patchset added
>> versions with these and I think it should be in during the next merge
>> cycle. [1]
> 
> Cool.  Note that the current iov_iter_get_pages2() is broken, which is why Al
> wanted a replacement.  It should not be taking a ref on the pages in an
> XARRAY, BVEC or PIPE - and it should be pinning rather than getting a ref on
> pages in IOVEC or UBUF if the buffer is being read into.  I'm guessing that
> your changes move the latter decision to the caller?

My changes maintained the status quo in terms of brokenness. They simply
added the gup_flags so I could pass a P2PDMA flag in a couple specific
cases. I have no objections to the other changes and vaguely look ok to
me, but having not seen patches to convert the users I care about, I
thought I'd point out that the P2PDMA use case will need to be supported
somehow.

Logan
