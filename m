Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A452047220D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 09:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhLMIDD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 03:03:03 -0500
Received: from verein.lst.de ([213.95.11.211]:46543 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhLMIDB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:03:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B987768BEB; Mon, 13 Dec 2021 09:02:57 +0100 (CET)
Date:   Mon, 13 Dec 2021 09:02:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] vmcore: Convert read_from_oldmem() to take an
 iov_iter
Message-ID: <20211213080257.GC20986@lst.de>
References: <20211213000636.2932569-1-willy@infradead.org> <20211213000636.2932569-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213000636.2932569-4-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  
>  ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
>  {
> -	return read_from_oldmem(buf, count, ppos, 0,
> +	struct kvec kvec = { .iov_base = buf, .iov_len = count };
> +	struct iov_iter iter;
> +
> +	iov_iter_kvec(&iter, READ, &kvec, 1, count);
> +
> +	return read_from_oldmem(&iter, count, ppos,
>  				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
>  }

elfcorehdr_read should probably also take an iov_iter while we're at it.

I also don't quite understand why we even need the arch overrides for it,
but that would require some digging into the history of this interface.
