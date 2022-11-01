Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB6614BB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 14:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKAN20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKAN2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C60DF3F;
        Tue,  1 Nov 2022 06:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AACD612D1;
        Tue,  1 Nov 2022 13:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FACC433C1;
        Tue,  1 Nov 2022 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667309302;
        bh=qn/BBkYwXhsC9S6z3zDROC8oNtgG+BFKYdU879D3sT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Farymb1qpUoPea5c83twStB/Qb4TFgn4n5e0b+pSQqKjwQ0S0rTR9nroLgBLUaI5F
         5TP73Sw04QBAtKlpfH8h/y1I7GEhNjpC4de6ADh6DOFF+62nifB4OJUDiMrtwRUuEU
         W0b/qAJ2UC5DAcLG7m/TDlWLmXP4a7upy5EtjRiw=
Date:   Tue, 1 Nov 2022 14:29:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karel Zak <kzak@redhat.com>,
        Masatake YAMATO <yamato@redhat.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] proc: add byteorder file
Message-ID: <Y2EfK2CnHLq5HF9B@kroah.com>
References: <20221101130401.1841-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101130401.1841-1-linux@weissschuh.net>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 02:04:01PM +0100, Thomas Weiﬂschuh wrote:
> Certain files in procfs are formatted in byteorder dependent ways. For
> example the IP addresses in /proc/net/udp.
> 
> Assuming the byteorder of the userspace program is not guaranteed to be
> correct in the face of emulation as for example with qemu-user.
> 
> Also this makes it easier for non-compiled applications like
> shellscripts to discover the byteorder.

Your subject says "proc" :(

Also you do not list the new file name here in the changelog text, why
not?

> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> ---
> 
> Development of userspace part: https://github.com/util-linux/util-linux/pull/1872
> 
> v1: https://lore.kernel.org/lkml/20221101005043.1791-1-linux@weissschuh.net/
> v1->v2:
>   * Move file to /sys/kernel/byteorder
> ---
>  .../ABI/testing/sysfs-kernel-byteorder         | 12 ++++++++++++
>  kernel/ksysfs.c                                | 18 ++++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-byteorder
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-byteorder b/Documentation/ABI/testing/sysfs-kernel-byteorder
> new file mode 100644
> index 000000000000..4c45016d78ae
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-byteorder
> @@ -0,0 +1,12 @@
> +What:		/sys/kernel/byteorder
> +Date:		February 2023
> +KernelVersion:	6.2
> +Contact:	linux-fsdevel@vger.kernel.org

Why is this a filesystem thing?  I don't see how that is true.

> +Description:
> +		The current endianness of the running kernel.
> +
> +		Access: Read
> +
> +		Valid values:
> +			"little", "big"
> +Users:		util-linux
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index 65dba9076f31..7c7cb2c96ac0 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2004 Kay Sievers <kay.sievers@vrfy.org>
>   */
>  
> +#include <asm/byteorder.h>
>  #include <linux/kobject.h>
>  #include <linux/string.h>
>  #include <linux/sysfs.h>
> @@ -20,6 +21,14 @@
>  
>  #include <linux/rcupdate.h>	/* rcu_expedited and rcu_normal */
>  
> +#if defined(__LITTLE_ENDIAN)
> +#define BYTEORDER_STRING	"little"
> +#elif defined(__BIG_ENDIAN)
> +#define BYTEORDER_STRING	"big"
> +#else
> +#error Unknown byteorder
> +#endif
> +
>  #define KERNEL_ATTR_RO(_name) \
>  static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>  
> @@ -34,6 +43,14 @@ static ssize_t uevent_seqnum_show(struct kobject *kobj,
>  }
>  KERNEL_ATTR_RO(uevent_seqnum);
>  
> +/* kernel byteorder */
> +static ssize_t byteorder_show(struct kobject *kobj,
> +			      struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%s\n", BYTEORDER_STRING);

sysfs_emit() please.

And this really is CPU byteorder, right?  We have processors that have
devices running in different byteorder than the CPU.  userspace usually
doesn't need to know about that, but it might be good to be specific.

thanks,

greg k-h
