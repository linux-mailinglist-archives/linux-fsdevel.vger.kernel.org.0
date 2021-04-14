Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B386235F5B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhDNN6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 09:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233761AbhDNN6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618408669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B2vLN1g2GPOq64a7vebxlpd+t3XuOJ2b1mmcssIo044=;
        b=D4wj1GaXe5e0hXlAUPte6FU4HRJaz0DjexfMKLoynI/iemWBA55aY5lxKH7foIC/UjII9z
        usX2ZTgH+NFQuvgn1iBQtKjC//oLtsEwcDXIEkWBzVJiqvlLHPNCvrdn4/qjA+G90oIDRw
        BssvNViwelvLIfU0LUCbtI19tUfsliU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-ebNZZf_7PMakl5sEuprmVw-1; Wed, 14 Apr 2021 09:57:47 -0400
X-MC-Unique: ebNZZf_7PMakl5sEuprmVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C845107ACF3;
        Wed, 14 Apr 2021 13:57:46 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB848712A4;
        Wed, 14 Apr 2021 13:57:44 +0000 (UTC)
Date:   Wed, 14 Apr 2021 15:57:42 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 3/3] blkid: support zone reset for wipefs
Message-ID: <20210414135742.qayizmwjck5dx377@ws.net.home>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-4-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414013339.2936229-4-naohiro.aota@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:33:39AM +0900, Naohiro Aota wrote:
> +static int is_conventional(blkid_probe pr, uint64_t offset)
> +{
> +	struct blk_zone_report *rep = NULL;
> +	size_t rep_size;
> +	int ret;
> +	uint64_t zone_mask;
> +
> +	if (!pr->zone_size)
> +		return 1;
> +
> +	rep_size = sizeof(struct blk_zone_report) + sizeof(struct blk_zone);
> +	rep = calloc(1, rep_size);
> +	if (!rep)
> +		return -1;
> +
> +	zone_mask = ~(pr->zone_size - 1);
> +	rep->sector = (offset & zone_mask) >> 9;
> +	rep->nr_zones = 1;
> +	ret = ioctl(blkid_probe_get_fd(pr), BLKREPORTZONE, rep);
> +	if (ret) {
> +		free(rep);
> +		return -1;
> +	}

  ret = blkdev_get_zonereport()

:-)

>  /**
>   * blkid_do_wipe:
>   * @pr: prober
> @@ -1267,6 +1310,7 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
>  	const char *off = NULL;
>  	size_t len = 0;
>  	uint64_t offset, magoff;
> +	bool conventional;

BTW, nowhere in libblkid we use "bool". It would be probably better to include
<stdbool.h> to blkidP.h.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

