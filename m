Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B65129C22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 01:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfLXA4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 19:56:05 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50406 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbfLXA4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 19:56:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4CDC58EE165;
        Mon, 23 Dec 2019 16:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577148965;
        bh=iD2pVUJTAElo6XNlJ4Ka0d03YwCX7zbTkAqdNNqjais=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=AVfwYTGXYBV6Aze+goC29LNX3R9F0KThPgT2Q4HET0UPBOPl9lHp72VJ6Usb+olha
         znC3omlsaGnhPcE49vBf85suDSD8SEVir+2bukfvKzMQoYbWkTaSm8C2LjdsD4ovV4
         Xgt8MEvhpvDibHyirOsiE0hy6OHeDGCDBo7nOV0w=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IEUCgobfJHTn; Mon, 23 Dec 2019 16:56:05 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id CC0D78EE092;
        Mon, 23 Dec 2019 16:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577148965;
        bh=iD2pVUJTAElo6XNlJ4Ka0d03YwCX7zbTkAqdNNqjais=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=AVfwYTGXYBV6Aze+goC29LNX3R9F0KThPgT2Q4HET0UPBOPl9lHp72VJ6Usb+olha
         znC3omlsaGnhPcE49vBf85suDSD8SEVir+2bukfvKzMQoYbWkTaSm8C2LjdsD4ovV4
         Xgt8MEvhpvDibHyirOsiE0hy6OHeDGCDBo7nOV0w=
Message-ID: <1577148963.29997.34.camel@HansenPartnership.com>
Subject: Re: [RFC 8/9] ata_dev_printk: Add durable name to output
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tony Asleson <tasleson@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 23 Dec 2019 16:56:03 -0800
In-Reply-To: <20191223225558.19242-9-tasleson@redhat.com>
References: <20191223225558.19242-1-tasleson@redhat.com>
         <20191223225558.19242-9-tasleson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-12-23 at 16:55 -0600, Tony Asleson wrote:
> If we have a durable name we will add to output, else
> we will default to existing message output format.
> 
> Signed-off-by: Tony Asleson <tasleson@redhat.com>
> ---
>  drivers/ata/libata-core.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 28c492be0a57..b57a74cfb529 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -7249,6 +7249,9 @@ EXPORT_SYMBOL(ata_link_printk);
>  void ata_dev_printk(const struct ata_device *dev, const char *level,
>  		    const char *fmt, ...)
>  {
> +	char dict[128];
> +	int dict_len = 0;
> +
>  	struct va_format vaf;
>  	va_list args;
>  
> @@ -7257,9 +7260,26 @@ void ata_dev_printk(const struct ata_device
> *dev, const char *level,
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  
> -	printk("%sata%u.%02u: %pV",
> -	       level, dev->link->ap->print_id, dev->link->pmp + dev-
> >devno,
> -	       &vaf);
> +	if (dev->sdev) {
> +		dict_len = dev_durable_name(
> +			&dev->sdev->sdev_gendev,
> +			dict,
> +			sizeof(dict));
> +	}
> +
> +	if (dict_len > 0) {
> +		printk_emit(0, level[1] - '0', dict, dict_len,
> +				"sata%u.%02u: %pV",
> +				dev->link->ap->print_id,
> +				dev->link->pmp + dev->devno,
> +				&vaf);
> +	} else {
> +		printk("%sata%u.%02u: %pV",
> +			level,
> +			dev->link->ap->print_id,
> +			dev->link->pmp + dev->devno,
> +			&vaf);
> +	}

As I said, I think ata_dev_printk should expand to dev_printk, which
would render all the above unnecessary, but just in case there's a
problem, printk_emit() with a dict_len == 0 is directly equivalent to
printk() so the whole if (dict_len > 0) is unnecessary.

James

