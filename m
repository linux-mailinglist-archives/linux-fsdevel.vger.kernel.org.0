Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FF32FE50E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 09:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbhAUIcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 03:32:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727166AbhAUIZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611217446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HnG9+0RBizHJhdR3XOmg9XhnuWR/2oFpzyHyFXQE+as=;
        b=LC7zi7sJnw4ltJxm4wGC35BRYzKK8EwajaCpno2Py1myeNIXPDj03v6S2ktg198sEHGXrB
        vBj1u/gJzVVNOOr4uJIiN3Hs0hfMEd27Pr2xjAPIUy9KfvVQKXvAo7XSKO9pu+dcBMDgff
        u/pXByTQB8LDfYBP63dEos4/KYldROI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-OPYDEMhJO_mTgSN1dF2UwQ-1; Thu, 21 Jan 2021 03:24:04 -0500
X-MC-Unique: OPYDEMhJO_mTgSN1dF2UwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE95D59;
        Thu, 21 Jan 2021 08:24:02 +0000 (UTC)
Received: from localhost (ovpn-12-177.pek2.redhat.com [10.72.12.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEB352C318;
        Thu, 21 Jan 2021 08:23:58 +0000 (UTC)
Date:   Thu, 21 Jan 2021 16:23:56 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Yang Li <abaci-bugfix@linux.alibaba.com>
Cc:     dyoung@redhat.com, vgoyal@redhat.com, adobriyan@gmail.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vmalloc: remove redundant NULL check
Message-ID: <20210121082356.GH20161@MiWiFi-R3L-srv>
References: <1611216753-44598-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611216753-44598-1-git-send-email-abaci-bugfix@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/21/21 at 04:12pm, Yang Li wrote:
> Fix below warnings reported by coccicheck:
> ./fs/proc/vmcore.c:1503:2-7: WARNING: NULL check before some freeing
> functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
> ---
>  fs/proc/vmcore.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index c3a345c..9a15334 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1503,11 +1503,8 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	return 0;
>  
>  out_err:
> -	if (buf)
> -		vfree(buf);
> -
> -	if (dump)
> -		vfree(dump);
> +	vfree(buf);
> +	vfree(dump);

Looks good, thx.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

