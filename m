Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C70A88B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfIDOW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 10:22:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfIDOW4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:22:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2B4C155E0;
        Wed,  4 Sep 2019 14:22:55 +0000 (UTC)
Received: from work-vm (ovpn-117-227.ams2.redhat.com [10.36.117.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FFB7600CD;
        Wed,  4 Sep 2019 14:22:49 +0000 (UTC)
Date:   Wed, 4 Sep 2019 15:22:47 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, stefanha@redhat.com
Subject: Re: [PATCH] fuse: reserve byteswapped init opcodes
Message-ID: <20190904142247.GM2828@work-vm>
References: <20190904123607.10048-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904123607.10048-1-mst@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 04 Sep 2019 14:22:55 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Michael S. Tsirkin (mst@redhat.com) wrote:
> virtio fs tunnels fuse over a virtio channel.  One issue is two sides
> might be speaking different endian-ness. To detects this,
> host side looks at the opcode value in the FUSE_INIT command.
> Works fine at the moment but might fail if a future version
> of fuse will use such an opcode for initialization.
> Let's reserve this opcode so we remember and don't do this.

I think in theory that works even for normal fuse.

> Same for CUSE_INIT.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/fuse.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 2971d29a42e4..f042e63f4aa0 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -425,6 +425,10 @@ enum fuse_opcode {
>  
>  	/* CUSE specific operations */
>  	CUSE_INIT		= 4096,
> +
> +	/* Reserved opcodes: helpful to detect structure endian-ness */
> +	FUSE_INIT_BSWAP_RESERVED	= 26 << 24,

FUSE_INIT << 24 probably works?

> +	CUSE_INIT_BSWAP_RESERVED	= 16 << 16,

Dave

>  };
>  
>  enum fuse_notify_code {
> -- 
> MST
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
