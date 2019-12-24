Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4333129C1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 01:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLXAyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 19:54:14 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50352 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbfLXAyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 19:54:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AAFA28EE165;
        Mon, 23 Dec 2019 16:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577148853;
        bh=BBaZ4uA0Tdkbm7Mqn/0QCQfftt6tRY25Of2qWc7fheA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ur5z4XBzkGxdgGyzdOONwCAWQaV2ndvLgSxcCxciZRoP93e3BF7WI4YXwz2eNzAef
         dEcaEmts1F47MD7syko6K0myM4sOiR9rTgJWUGJGmC5fMvA9Iri+URmOPebDNaWoRs
         Fa3jZChPvkRynUcOKjm5APvQ3Krg23Zv0JZwicDQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1B8oFjFOje-T; Mon, 23 Dec 2019 16:54:13 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 37FBA8EE092;
        Mon, 23 Dec 2019 16:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577148853;
        bh=BBaZ4uA0Tdkbm7Mqn/0QCQfftt6tRY25Of2qWc7fheA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ur5z4XBzkGxdgGyzdOONwCAWQaV2ndvLgSxcCxciZRoP93e3BF7WI4YXwz2eNzAef
         dEcaEmts1F47MD7syko6K0myM4sOiR9rTgJWUGJGmC5fMvA9Iri+URmOPebDNaWoRs
         Fa3jZChPvkRynUcOKjm5APvQ3Krg23Zv0JZwicDQ=
Message-ID: <1577148851.29997.32.camel@HansenPartnership.com>
Subject: Re: [RFC 6/9] create_syslog_header: Add durable name
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tony Asleson <tasleson@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 23 Dec 2019 16:54:11 -0800
In-Reply-To: <20191223225558.19242-7-tasleson@redhat.com>
References: <20191223225558.19242-1-tasleson@redhat.com>
         <20191223225558.19242-7-tasleson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-12-23 at 16:55 -0600, Tony Asleson wrote:
> This gets us a persistent durable name for code that logs messages in
> the
> block layer that have the appropriate callbacks setup for durable
> name.
> 
> Signed-off-by: Tony Asleson <tasleson@redhat.com>
> ---
>  drivers/base/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 93cc1c45e9d3..57b5f5cd29fc 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3318,6 +3318,15 @@ create_syslog_header(const struct device *dev,
> char *hdr, size_t hdrlen)
>  				"DEVICE=+%s:%s", subsys,
> dev_name(dev));
>  	}
>  
> +	if (dev->type && dev->type->durable_name) {
> +		int dlen;
> +
> +		dlen = dev_durable_name(dev, hdr + (pos + 1),
> +					hdrlen - (pos + 1));
> +		if (dlen)
> +			pos += dlen + 1;
> +	}
> +

dev_durable_name already returns zero if either dev->type or dev->type-
>durable_name are NULL, so the if() above is pointless.

James
