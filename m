Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556E25B2F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 04:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfGAC7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 22:59:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfGAC7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 22:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IHOctcrnamPZlDOqkWx9gP7HKz6z4cfFnI1BHiO0w78=; b=MKHZDli96OWvWZf7Ml4qTTeTS
        ADyGVjgEjt6ySSV9VdCosU1hi/21jcTscAC72nDZep1VKznI9fOx5A3N3iQPcPQy90pnC1WC+eC1S
        Rr7xFMdssx1hm0W+7gNoMx1ZjX+NiaShGwa47IjtziyeHwzGGep8ZAN86u3cCfovTY2F7wuumVf87
        txn5FMi7ZWCH/Z/lgAMKc90KP7QwzvTaqGRrZNGra+ZSPqK40+DWONlvWDTT8RVbu20a0hZVH3uxk
        H2OilOPm03NJt7KIxOKf2aPx1YW4NfG8NGsQC+FAYu1tdnITXha3MxrdrMgG9/RcGNspO6MR5oPXD
        8OeSFCLlA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhmXZ-0007q7-Pi; Mon, 01 Jul 2019 02:59:37 +0000
Subject: Re: [PATCH 2/6] Adjust watch_queue documentation to mention mount and
 superblock watches. [ver #5]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
 <156173703546.15650.14319137940607993268.stgit@warthog.procyon.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7a288c2c-11a1-87df-9550-b247d6ce3010@infradead.org>
Date:   Sun, 30 Jun 2019 19:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <156173703546.15650.14319137940607993268.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On 6/28/19 8:50 AM, David Howells wrote:
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  Documentation/watch_queue.rst |   20 +++++++++++++++++++-
>  drivers/misc/Kconfig          |    5 +++--
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
> index 4087a8e670a8..1bec2018d549 100644
> --- a/Documentation/watch_queue.rst
> +++ b/Documentation/watch_queue.rst
> @@ -13,6 +13,10 @@ receive notifications from the kernel.  This can be used in conjunction with::
>  
>      * USB subsystem event notifications
>  
> +  * Mount topology change notifications
> +
> +  * Superblock event notifications
> +
>  
>  The notifications buffers can be enabled by:
>  
> @@ -324,6 +328,19 @@ Any particular buffer can be fed from multiple sources.  Sources include:
>      for buses and devices.  Watchpoints of this type are set on the global
>      device watch list.
>  
> +  * WATCH_TYPE_MOUNT_NOTIFY
> +
> +    Notifications of this type indicate mount tree topology changes and mount
> +    attribute changes.  A watch can be set on a particular file or directory
> +    and notifications from the path subtree rooted at that point will be
> +    intercepted.
> +
> +  * WATCH_TYPE_SB_NOTIFY
> +
> +    Notifications of this type indicate superblock events, such as quota limits
> +    being hit, I/O errors being produced or network server loss/reconnection.
> +    Watches of this type are set directly on superblocks.
> +
>  
>  Event Filtering
>  ===============
> @@ -365,7 +382,8 @@ Where:
>  	(watch.info & info_mask) == info_filter
>  
>      This could be used, for example, to ignore events that are not exactly on
> -    the watched point in a mount tree.
> +    the watched point in a mount tree by specifying NOTIFY_MOUNT_IN_SUBTREE
> +    must be 0.

I'm having a little trouble parsing that sentence.
Could you clarify it or maybe rewrite/modify it?
Thanks.

>  
>    * ``subtype_filter`` is a bitmask indicating the subtypes that are of
>      interest.  Bit 0 of subtype_filter[0] corresponds to subtype 0, bit 1 to



-- 
~Randy
