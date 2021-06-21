Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C8E3AEC0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFUPMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 11:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFUPML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:12:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB8C061574;
        Mon, 21 Jun 2021 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D8ph6pAIQDI8O5xX0/bF6rOuV3U8EpQmauqRDOmPVTw=; b=qawH6s/nu6gNZqpAj9pyqEDODz
        MQb09/vjLbdWiYpA8JVaY4k0zUar9DsoQrWhb4JKAzFeSFiL8GJvX006u8PF9KYUqLByb4Ue/thtk
        oHUI/3Nk7hR8YH6VY3dXwfhMF49O4GjrUZqiR2UqDLioeOmdpRDR5+HYGq7r0b4NYsZJmUSQB58pZ
        9yf4A3b8qVaku3GgAnm/HjM5eG8r0S/i5Fd4NtCo1kK+A0m4vcAiTx0LwElKu4AJoz2VA/d7Qug2d
        C/hQvAxLJwYFquqABYvrY4OBojOVzOzSv3epUm71kfq9jL4BbZdSsIpMvmfIWhangFScMsVdBsb7Y
        2F22fS4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvLY4-00DDUo-Ca; Mon, 21 Jun 2021 15:09:25 +0000
Date:   Mon, 21 Jun 2021 16:09:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Subject: Re: [PATCH 1/2] init: split get_fs_names
Message-ID: <YNCrnCvtlOuZO9jV@casper.infradead.org>
References: <20210621062657.3641879-1-hch@lst.de>
 <20210621062657.3641879-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621062657.3641879-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 08:26:56AM +0200, Christoph Hellwig wrote:
> -static void __init get_fs_names(char *page)
> +static void __init split_fs_names(char *page, char *names)

If you're going to respin it anyway, can you rename 'page' to 'buf'
or something?  Kind of confusing to have a char * called 'page'.

>  {
> +	strcpy(page, root_fs_names);
> +	while (*page++) {
> +		if (page[-1] == ',')
> +			page[-1] = '\0';
> +	}
> +	*page = '\0';
> +}

is it really worth doing a strcpy() followed by a custom strtok()?
would this work better?

	char c;

	do {
		c =  *root_fs_names++;
		*buf++ = c;
		if (c == ',')
			buf[-1] = '\0';
	} while (c);

> +static void __init get_all_fs_names(char *page)
> +{
> +	int len = get_filesystem_list(page);

it occurs to me that get_filesystem_list() fails silently.  if you build
every linux filesystem in, and want your root on zonefs (assuming
they're alphabetical), we'll fail to find it without a message
indicating that we overflowed the buffer.

