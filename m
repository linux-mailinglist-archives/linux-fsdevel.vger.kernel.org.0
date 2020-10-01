Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1527F81C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 05:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgJADE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 23:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJADE1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 23:04:27 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 566B921D7D;
        Thu,  1 Oct 2020 03:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601521467;
        bh=Kj+fsBMxRWNG9VlBrcTFDufvU96D5sKeoAB1XD3c9GA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=St+j+UHKud3cBmz7WmQqqknMNONsSTGzzhm2ZTtUclYOxNyU0jAdgRRhr3hUztF78
         KaEVuFEeeXBABwtSDPkOkC1dWcsBLg8h+FQ+MVtKGfTzRPaQtRak2AxJemiLEKggnf
         qF7Ime9jkIv3g8/KMyCpGgDSUlGpuMhdJlKVyoDQ=
Date:   Wed, 30 Sep 2020 20:04:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Qian Cai <cai@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pipe: Fix memory leaks in create_pipe_files()
Message-ID: <20201001030425.GA238305@sol.localdomain>
References: <20201001025255.29560-1-cai@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001025255.29560-1-cai@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:52:55PM -0400, Qian Cai wrote:
> diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
> index 5e08db2adc31..20665fbe0552 100644
> --- a/include/linux/watch_queue.h
> +++ b/include/linux/watch_queue.h
> @@ -123,5 +123,9 @@ static inline void remove_watch_list(struct watch_list *wlist, u64 id)
>  #define watch_sizeof(STRUCT) (sizeof(STRUCT) << WATCH_INFO_LENGTH__SHIFT)
>  
>  #endif
> +static inline int watch_queue_init(struct pipe_inode_info *pipe)
> +{
> +	return -ENOPKG;
> +}

This needs to be conditional on !CONFIG_WATCH_QUEUE.

- Eric
