Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6781B13C11D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 13:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAOMgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 07:36:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgAOMgF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:36:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB4724679;
        Wed, 15 Jan 2020 12:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579091764;
        bh=Zn5YUWMjJaii5+Wh6/mMidWzdRlfpQDPnJUaF8RwJxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnoFqM3ety8zk+QArvc+sqGentBLZikbuLuYiipxowNn2syZ3SHpXBEL2AJDvycQO
         ZMcELqqcBMDiJz25Ifu/ZxfYWc3a6Iz0gLZkUen6CT31zwuWzKO26SLq/soeClBnFE
         PBnEuTW2w/Ia7w8sOADXzeT/xgYsrshkv6RwFFBw=
Date:   Wed, 15 Jan 2020 13:36:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv2-next 1/3] sysctl/sysrq: Remove __sysrq_enabled copy
Message-ID: <20200115123601.GA3461986@kroah.com>
References: <20200114171912.261787-1-dima@arista.com>
 <20200114171912.261787-2-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114171912.261787-2-dima@arista.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 05:19:10PM +0000, Dmitry Safonov wrote:
> Many embedded boards have a disconnected TTL level serial which can
> generate some garbage that can lead to spurious false sysrq detects.
> 
> Currently, sysrq can be either completely disabled for serial console
> or always disabled (with CONFIG_MAGIC_SYSRQ_SERIAL), since
> commit 732dbf3a6104 ("serial: do not accept sysrq characters via serial port")
> 
> At Arista, we have such boards that can generate BREAK and random
> garbage. While disabling sysrq for serial console would solve
> the problem with spurious false sysrq triggers, it's also desirable
> to have a way to enable sysrq back.
> 
> Having the way to enable sysrq was beneficial to debug lockups with
> a manual investigation in field and on the other side preventing false
> sysrq detections.
> 
> As a preparation to add sysrq_toggle_support() call into uart,
> remove a private copy of sysrq_enabled from sysctl - it should reflect
> the actual status of sysrq.
> 
> Furthermore, the private copy isn't correct already in case
> sysrq_always_enabled is true. So, remove __sysrq_enabled and use a
> getter-helper for sysrq enabled status.
> 
> Cc: Iurii Zaikin <yzaikin@google.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  drivers/tty/sysrq.c   |  7 +++++++
>  include/linux/sysrq.h |  7 +++++++
>  kernel/sysctl.c       | 41 ++++++++++++++++++++++-------------------
>  3 files changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index f724962a5906..ef3e78967146 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -73,6 +73,13 @@ static bool sysrq_on_mask(int mask)
>  	       (sysrq_enabled & mask);
>  }
>  
> +int sysrq_get_mask(void)
> +{
> +	if (sysrq_always_enabled)
> +		return 1;
> +	return sysrq_enabled;
> +}

Naming is hard.  And this name is really hard to understand.

Traditionally get/put are used for incrementing reference counts.  You
don't have a sysrq_put_mask() call, right?  :)

I think what you want this function to do is, "is sysrq enabled right
now" (hint, it's a global function, add kernel-doc to it so we know what
it does...).  If so, it should maybe be something like:

	bool sysrq_is_enabled(void);

which to me makes more sense.

thoughts?

thanks,

greg k-h
