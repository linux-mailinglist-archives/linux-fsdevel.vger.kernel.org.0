Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D372509C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 22:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHXUJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 16:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXUJ1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:09:27 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 557512067C;
        Mon, 24 Aug 2020 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598299766;
        bh=Fo2SRSPedysLovKtNIgg+PCgYoeSknIuP8nfThruowM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oVb0YTnfyZktyEkeLYGcaehsAloadoiqjiEyq2xIr6VwObSpc4zR8yb410HYYWTdH
         uU4whUU553p+EW7Wf3qYRu0s4ZTc9ImbYVY7ZFFqrw5a6+n8iKhlAwkYzrAhZAzB9z
         ZyCibojd1hEhPqETi09r1BZKK35oT22KKqE1hdbc=
Date:   Mon, 24 Aug 2020 13:09:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 2/2] xfs: avoid transaction reservation recursion
Message-Id: <20200824130925.a3d2d2b75ac3a6b4eba72fb9@linux-foundation.org>
In-Reply-To: <20200824014234.7109-3-laoar.shao@gmail.com>
References: <20200824014234.7109-1-laoar.shao@gmail.com>
        <20200824014234.7109-3-laoar.shao@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Aug 2020 09:42:34 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:

> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -271,4 +271,11 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  # define iomap_swapfile_activate(sis, swapfile, pagespan, ops)	(-EIO)
>  #endif /* CONFIG_SWAP */
>  
> +/* Use the journal_info to indicate current is in a transaction */
> +static inline bool
> +fstrans_context_active(void)
> +{
> +	return current->journal_info != NULL;
> +}

Why choose iomap.h for this?
