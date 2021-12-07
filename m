Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EF446BCC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 14:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhLGNpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 08:45:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232838AbhLGNpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638884539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QFkOJkYB1Uxe2T0a8h6jEusxi+X2OG7bH/Bp7qucg9w=;
        b=AGCt5f2+9EohQDnedLsAmN1Ic7XSiJTXekALJ4tSoccfGK13VLRl33c/+2dO5RhWXScxU6
        GJlD6yauC9iFkSEhevtYigSrledqbpOtGInQtJ3wQRg2thP3RoB7eng5PkrCWJ8ric29z9
        YTKIBl7A7yqyeWEsFsuNk2aBooqxFtc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-0hFTUnDdO7yQorfs7XMONQ-1; Tue, 07 Dec 2021 08:42:18 -0500
X-MC-Unique: 0hFTUnDdO7yQorfs7XMONQ-1
Received: by mail-qv1-f72.google.com with SMTP id r13-20020a0562140c8d00b003bde7a2b8e2so17605719qvr.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 05:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QFkOJkYB1Uxe2T0a8h6jEusxi+X2OG7bH/Bp7qucg9w=;
        b=6AAhQhmZfZLJV19Uy9pgz61oDqgJlk6ZBokg4iXldddhA73MubezN/G1q34A+B0dms
         5/IAjN2cOb3y0mTmcrApztSBcl+BcW8nWZ5d4A0TsUFVPwRaYGUyFb2suPGVuINJfPSu
         xau7DLjdVVQQUaZOJpub98zCze2MCbavsO+eBgYZxmF7niYf2lQenmHrJjz8r83kTkW5
         fWvYPZ+fPw/rRDnAWwjM8L+zR6b2Ch2isCI6XS+Rvc6zTkJnO6fXXd12tKC9HvoNcnCm
         r0htBfl/AZ4VXdt9QzIoSUdpuXMBWUm5jiSh32yWvvQM6V9yH5pV51st+gdKLeGqGRx/
         C5Vg==
X-Gm-Message-State: AOAM530w7zA1aO47Oqx7zB6aMFucU/0HMKe6gl4O7HHMDyDPmPcLTQPf
        jpnX3WQPb1CECYlcG1LfR02bpjUTZdk+nnAAC4IDwuz5b+yPJN2pVaSG2gVvNJCEVl0akGatTVo
        rexFvQaJBpBso+XNQlHo1m/0DaQ==
X-Received: by 2002:a05:620a:4689:: with SMTP id bq9mr40849758qkb.242.1638884537796;
        Tue, 07 Dec 2021 05:42:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyg8p/0Hq9h4Lug7LbFKUqGROwqTbJaprG7N7+V6Z7GYNVsAydFBlBJ2531rBELEjHrIdbfwQ==
X-Received: by 2002:a05:620a:4689:: with SMTP id bq9mr40849722qkb.242.1638884537554;
        Tue, 07 Dec 2021 05:42:17 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id s12sm9442778qtk.61.2021.12.07.05.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:42:17 -0800 (PST)
Message-ID: <d621c5522bdee8113946e7d1e5e9822820e0ef5a.camel@redhat.com>
Subject: Re: [Linux-cachefs] [PATCH] netfs: fix parameter of cleanup()
From:   Jeff Layton <jlayton@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com
Date:   Tue, 07 Dec 2021 08:42:16 -0500
In-Reply-To: <20211207031449.100510-1-jefflexu@linux.alibaba.com>
References: <20211207031449.100510-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-12-07 at 11:14 +0800, Jeffle Xu wrote:
> The order of these two parameters is just reversed. gcc didn't warn on
> that, probably because 'void *' can be converted from or to other
> pointer types without warning.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3d3c95046742 ("netfs: Provide readahead and readpage netfs helpers")
> Fixes: e1b1240c1ff5 ("netfs: Add write_begin helper")
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/netfs/read_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 7046f9bdd8dc..4adcb0336ecf 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -960,7 +960,7 @@ int netfs_readpage(struct file *file,
>  	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
>  	if (!rreq) {
>  		if (netfs_priv)
> -			ops->cleanup(netfs_priv, folio_file_mapping(folio));
> +			ops->cleanup(folio_file_mapping(folio), netfs_priv);
>  		folio_unlock(folio);
>  		return -ENOMEM;
>  	}
> @@ -1191,7 +1191,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  		goto error;
>  have_folio_no_wait:
>  	if (netfs_priv)
> -		ops->cleanup(netfs_priv, mapping);
> +		ops->cleanup(mapping, netfs_priv);
>  	*_folio = folio;
>  	_leave(" = 0");
>  	return 0;
> @@ -1202,7 +1202,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	folio_unlock(folio);
>  	folio_put(folio);
>  	if (netfs_priv)
> -		ops->cleanup(netfs_priv, mapping);
> +		ops->cleanup(mapping, netfs_priv);
>  	_leave(" = %d", ret);
>  	return ret;
>  }

Ouch, good catch.

Reviewed-by: Jeff Layton <jlayton@redhat.com>

