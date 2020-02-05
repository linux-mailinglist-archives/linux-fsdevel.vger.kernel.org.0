Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1657F15386F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 19:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgBESpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 13:45:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33772 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBESpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:45:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so2404841qto.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2020 10:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QYoMdIAaqahJjepvkJ7REaMmBDJckxR3VrMFaS6MKNY=;
        b=GdVPLikdaMErLnDV65mcb/+ItucXtOwLICARC88ezS9vFIlFCBXrtnGMf+g6v489FN
         n+48qQFv8gt2UQ93yob4VTNBvaGyOhGAOboMJIHxB4o/PPc5Ph0X2PD84rb4OTmWS3rJ
         yUR0QjHfD2h4hiTX2SQ0wRa+cS0UGdV0frHs0ocxr2tKVNO8WPaxblqQth+mJwCtzebw
         pkyRary2dSismCyszI9Z7ilb/UHhLfWbF378hulwQs9T1tbxIY0gw9r/ISzlP/AZM4hK
         YRhfN/I6IhujDgJ+A2q1BM24cLTaGrO8I1luSBmkj1hRO0ba4xCRZYFo/z5jbI3akRlc
         6W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QYoMdIAaqahJjepvkJ7REaMmBDJckxR3VrMFaS6MKNY=;
        b=p1FKxrXRHX/RGvlahfIn6hVJbt925rX2lb4GnsWg2nV+CJJnXjmAdN89mb4GHdUH3f
         rdwaxlMn2sC4wcRTAxrR4kQjNNINGF6ThsuhUvymdTz1gsNd9myivd3fyfRdINheXoNT
         N4ByrP/ZUQ4DOiYwdEY6IhS1dSIvXtxglr1wyx3qe5DQ5Da9SuyzQjgwME1sLzoH7Of0
         cTvBnTXN1UX17b0tiRUu0Sdzh+saHKl1myQODGK8Oz3slgP+CHuqOHRUWjPibvcYCqbS
         TKiym+f4Z808JQkNC+W3liTbBRCRme8/a4xqklqita3utTJfeA6ic2/rrgFDCbmVm3o2
         96hA==
X-Gm-Message-State: APjAAAVDdbW4fvhyoeC+glQxfVoKaHdQPnE5auuB+5Tom5MaAO6QyX7O
        mnlWC2J1+294OmB5agD3BAAzuXVN5iQ=
X-Google-Smtp-Source: APXvYqzWcr4PCpzvsF2kua43sLKjIgPtIjh8aXczMBiNRwSqrEUPqJ7EzvB56kTUEocmfGwTFLWj8w==
X-Received: by 2002:aed:2d86:: with SMTP id i6mr35454014qtd.297.1580928313307;
        Wed, 05 Feb 2020 10:45:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 73sm320171qtg.40.2020.02.05.10.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 10:45:12 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1izPfk-0003uX-6R; Wed, 05 Feb 2020 14:45:12 -0400
Date:   Wed, 5 Feb 2020 14:45:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/8] xarray: Explicitely set XA_FREE_MARK in
 __xa_cmpxchg()
Message-ID: <20200205184512.GC28298@ziepe.ca>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204142514.15826-4-jack@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:25:09PM +0100, Jan Kara wrote:
> __xa_cmpxchg() relies on xas_store() to set XA_FREE_MARK when storing
> NULL into xarray that has free tracking enabled. Make the setting of
> XA_FREE_MARK explicit similarly as its clearing currently it.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
>  lib/xarray.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/xarray.c b/lib/xarray.c
> index ae8b7070e82c..4e32497c51bd 100644
> +++ b/lib/xarray.c
> @@ -1477,8 +1477,12 @@ void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
>  		curr = xas_load(&xas);
>  		if (curr == old) {
>  			xas_store(&xas, entry);
> -			if (xa_track_free(xa) && entry && !curr)
> -				xas_clear_mark(&xas, XA_FREE_MARK);
> +			if (xa_track_free(xa)) {
> +				if (entry && !curr)
> +					xas_clear_mark(&xas, XA_FREE_MARK);
> +				else if (!entry && curr)
> +					xas_set_mark(&xas, XA_FREE_MARK);
> +			}

This feels like an optimization that should also happen for
__xa_store, which has very similar code:

		curr = xas_store(&xas, entry);
		if (xa_track_free(xa))
			xas_clear_mark(&xas, XA_FREE_MARK);

Something like

                if (xa_track_free(xa) && entry && !curr)
			xas_clear_mark(&xas, XA_FREE_MARK);

?

Regards,
Jason
