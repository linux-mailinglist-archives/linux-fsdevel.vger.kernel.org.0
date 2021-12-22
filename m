Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48047D138
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Dec 2021 12:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbhLVLpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 06:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238045AbhLVLpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640173541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t8hfe6Gfw3N3sm/iHXx5ElkmaS7YGmdkl1wnNMkOIrk=;
        b=EG4DRgTgn5m3fOZmedxzXpQ6UXa3B8Ntzx2zfRwyxAbbclKkIEjLAnysduX84gxqj9Mj6E
        DK2c1nIUnWlyRGSIcTgqBSPpud/6p0b3Nr2wlMhr9LuGhjRXw4tWMgcPrbEtaz9OchwE2R
        gMLaM4t9CCngRN1FtBp0JFW8jEZnI5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-5CSJt_XzNSmqpNF8X7sCyQ-1; Wed, 22 Dec 2021 06:45:36 -0500
X-MC-Unique: 5CSJt_XzNSmqpNF8X7sCyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C54651018720;
        Wed, 22 Dec 2021 11:45:32 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-211.pek2.redhat.com [10.72.12.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E96477314B;
        Wed, 22 Dec 2021 11:45:21 +0000 (UTC)
Date:   Wed, 22 Dec 2021 19:45:18 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net,
        kexec@lists.infradead.org
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
Message-ID: <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109202848.610874-4-gpiccoli@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Guilherme,

Thanks for you patch.  Could you add kexec list for any following up
patches?  This could change kdump behavior so let's see if any comments
from kexec list.

Kudos for the lore+lei tool so that I can catch this by seeing this
coming into Andrews tree :)
On 11/09/21 at 05:28pm, Guilherme G. Piccoli wrote:
> Currently we have the "panic_print" parameter/sysctl to allow some extra
> information to be printed in a panic event. On the other hand, the kdump
> mechanism allows to kexec a new kernel to collect a memory dump for the
> running kernel in case of panic.
> Right now these options are incompatible: the user either sets the kdump
> or makes use of "panic_print". The code path of "panic_print" isn't
> reached when kdump is configured.
> 
> There are situations though in which this would be interesting: for
> example, in systems that are very memory constrained, a handcrafted
> tiny kernel/initrd for kdump might be used in order to only collect the
> dmesg in kdump kernel. Even more common, systems with no disk space for
> the full (compressed) memory dump might very well rely in this
> functionality too, dumping only the dmesg with the additional information
> provided by "panic_print".
> 
> So, this is what the patch does: allows both functionality to co-exist;
> if "panic_print" is set and the system performs a kdump, the extra
> information is printed on dmesg before the kexec. Some notes about the
> design choices here:
> 
> (a) We could have introduced a sysctl or an extra bit on "panic_print"
> to allow enabling the co-existence of kdump and "panic_print", but seems
> that would be over-engineering; we have 3 cases, let's check how this
> patch change things:
> 
> - if the user have kdump set and not "panic_print", nothing changes;
> - if the user have "panic_print" set and not kdump, nothing changes;
> - if both are enabled, now we print the extra information before kdump,
> which is exactly the goal of the patch (and should be the goal of the
> user, since they enabled both options).

People may enable kdump crashkernel and panic_print together but
they are not aware the extra panic print could cause kdump not reliable
(in theory).  So at least some words in kernel-parameters.txt would
help.
 
> 
> (b) We assume that the code path won't return from __crash_kexec()
> so we didn't guard against double execution of panic_print_sys_info().
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  kernel/panic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 5da71fa4e5f1..439dbf93b406 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -243,6 +243,13 @@ void panic(const char *fmt, ...)
>  	 */
>  	kgdb_panic(buf);
>  
> +	/*
> +	 * If we have a kdump kernel loaded, give a chance to panic_print
> +	 * show some extra information on kernel log if it was set...
> +	 */
> +	if (kexec_crash_loaded())
> +		panic_print_sys_info();
> +
>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
>  	 * everything else.
> -- 
> 2.33.1
> 
> 

Thanks
Dave

