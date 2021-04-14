Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662A535F4DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 15:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351249AbhDNNba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 09:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232690AbhDNNba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618407068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eltSsqO9F1rIMDJywSOli16tHNGkO5mxD8btKqOAj+Y=;
        b=IbOHAAyqm0iWQ3TTMhktS2HlAuC596RQ9oqJJ1/U0dbl34vsUj81kEZSU3tDLEcn9DpSg5
        9CYkieLWHtVMzmJ9lCkkcyAxAPI6RQrzsJWGk556XtRhDche1bINEtpXJ1P3GjQTZLWfLV
        nk41TZnMJStCX+agwWg9vru3Y7MqTlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-VmlUsjDkPiOgY1VzHUfqmQ-1; Wed, 14 Apr 2021 09:31:06 -0400
X-MC-Unique: VmlUsjDkPiOgY1VzHUfqmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ABF5188E3C9;
        Wed, 14 Apr 2021 13:31:05 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEC9C19C78;
        Wed, 14 Apr 2021 13:31:03 +0000 (UTC)
Date:   Wed, 14 Apr 2021 15:31:01 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 1/3] blkid: implement zone-aware probing
Message-ID: <20210414133101.p5amev6tkfroiyw5@ws.net.home>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-2-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414013339.2936229-2-naohiro.aota@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:33:37AM +0900, Naohiro Aota wrote:
> --- a/configure.ac
> +++ b/configure.ac
> @@ -302,6 +302,7 @@ AC_CHECK_HEADERS([ \
>  	lastlog.h \
>  	libutil.h \
>  	linux/btrfs.h \
> +	linux/blkzoned.h \

unnecessary, there is already AC_CHECK_HEADERS([linux/blkzoned.h]) on
another place.

>  	linux/capability.h \
>  	linux/cdrom.h \
>  	linux/falloc.h \
> diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
> index a3fe6748a969..e3a160aa97c0 100644
> --- a/libblkid/src/blkidP.h
> +++ b/libblkid/src/blkidP.h
> @@ -150,6 +150,10 @@ struct blkid_idmag
>  	const char	*hoff;		/* hint which contains byte offset to kboff */
>  	long		kboff;		/* kilobyte offset of superblock */
>  	unsigned int	sboff;		/* byte offset within superblock */
> +
> +	int		is_zoned;	/* indicate magic location is calcluated based on zone position  */
> +	long		zonenum;	/* zone number which has superblock */
> +	long		kboff_inzone;	/* kilobyte offset of superblock in a zone */

It would be better to use 'flags' struct field and

  #define BLKID_FL_ZONED_DEV (1 << 6)

like we use for another stuff.

> diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
> index a47a8720d4ac..9d180aab5242 100644
> --- a/libblkid/src/probe.c
> +++ b/libblkid/src/probe.c
> @@ -94,6 +94,9 @@
>  #ifdef HAVE_LINUX_CDROM_H
>  #include <linux/cdrom.h>
>  #endif
> +#ifdef HAVE_LINUX_BLKZONED_H
> +#include <linux/blkzoned.h>
> +#endif
>  #ifdef HAVE_SYS_STAT_H
>  #include <sys/stat.h>
>  #endif
> @@ -897,6 +900,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
>  	pr->wipe_off = 0;
>  	pr->wipe_size = 0;
>  	pr->wipe_chain = NULL;
> +	pr->zone_size = 0;

you also need to update blkid_clone_probe() function

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

