Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC282B4ABC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 17:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbgKPQTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 11:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgKPQTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:19:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA9C0613CF;
        Mon, 16 Nov 2020 08:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PTcACb+OPzDkD7ip03OpCQ1AWGmAYd97p5XJ+anWegk=; b=fcvLdwy/fhA+TsKH7HKxs4jKmO
        H+PhyvltB7ut8MnBtmeulXF1ztgUkQBjnCGuFKAjvVB/YjgWnFb/sM1LEzOtveF4NrWTGw/71CoGp
        MN7PFpNHsPbI8wK27sSmATqhLgDQBE8Uj9glbXdl/8eA2fUffPEZDG0wcBn7MHDbTia3YJo7wSQmP
        7+UBW3BXPDzIrSG6bw6LeaGkdLzBfOY6vxWMShbfTy/KGb1nMspLPEg5id7MbgtX+kci0zPo8H6Pd
        whQuS8y/TgNkvtu/v9ZkaJyb3Iim3aPFtnFl5wT6bG8cbAtsTefll+1EDoxK43dnzHQrnGmCf31Jx
        JjY4L4Bw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehE2-0003lV-Py; Mon, 16 Nov 2020 16:19:30 +0000
Date:   Mon, 16 Nov 2020 16:19:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        soheil.kdev@gmail.com, arnd@arndb.de, shuochen@google.com,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v2] epoll: add nsec timeout support
Message-ID: <20201116161930.GF29991@casper.infradead.org>
References: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 11:10:01AM -0500, Willem de Bruijn wrote:
> diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> index 8a3432d0f0dc..f6ef9c9f8ac2 100644
> --- a/include/uapi/linux/eventpoll.h
> +++ b/include/uapi/linux/eventpoll.h
> @@ -21,6 +21,7 @@
>  
>  /* Flags for epoll_create1.  */
>  #define EPOLL_CLOEXEC O_CLOEXEC
> +#define EPOLL_NSTIMEO 0x1
>  
>  /* Valid opcodes to issue to sys_epoll_ctl() */
>  #define EPOLL_CTL_ADD 1

Not a problem with your patch, but this concerns me.  O_CLOEXEC is
defined differently for each architecture, so we need to stay out of
several different bits when we define new flags for EPOLL_*.  Maybe
this:

/*
 * Flags for epoll_create1.  O_CLOEXEC may be different bits, depending
 * on the CPU architecture.  Reserve the known ones.
 */
#define EPOLL_CLOEXEC		O_CLOEXEC
#define EPOLL_RESERVED_FLAGS	0x00680000
#define EPOLL_NSTIMEO		0x00000001

