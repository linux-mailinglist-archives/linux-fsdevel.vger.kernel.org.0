Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A516A49E86E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 18:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiA0RJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 12:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244287AbiA0RJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643303379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+dhUoO5mtU5C6v7W8MZ+6HMQJZitoVQcF/qB+IF1Jr0=;
        b=Gy8LmpFXxAOAGU7wRpJYDntrcuVCM/U9IaryiMmxjzahqE+OOGqUfNitsw1fmHcJ6nz+w4
        cki2C0YmkAod280gOQQRXPn2SMs0uiYX+AZTdh58R7eU9uHOdlYpRG2yid3l6SN89qdQDQ
        W3IziguawlapZVvthny9kdx9gifJfKk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-sLDbh_t-NfCYWRbRloEyJw-1; Thu, 27 Jan 2022 12:09:37 -0500
X-MC-Unique: sLDbh_t-NfCYWRbRloEyJw-1
Received: by mail-qv1-f69.google.com with SMTP id t3-20020a0562140c6300b00424a0fd3721so3736565qvj.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jan 2022 09:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+dhUoO5mtU5C6v7W8MZ+6HMQJZitoVQcF/qB+IF1Jr0=;
        b=MdwIWbtzfJvI4yJ7/aNO6KPsUIQXF51+3xhESihxmJXWQCn0lOisz4yQgTrH7H0x9y
         tK6k87a3U8GSyg2Q4yV7dJ+uvT1qQd8SqOl1xA+j2puelEWL6hFdqUz5+QMBFp7pb/bZ
         rmMNyJZvkoB8SVLLJwunYSPzhk/EO9krAqnZqBeJHK11osABsXIyfC0Y371k7mQiREGf
         A5jpaHxe628rtVVRW86CPcxzWJc4b91HStT+PmQcYor3gJgbWLHU8utBUm1Lu54TKUXa
         XjrG0Xd1UEGLeiWRkszqO0MKMiRi8Z74rujadO5N2rBIa/ahwa3B66j61iVAyAuLS85z
         7VWA==
X-Gm-Message-State: AOAM531fPqhVPDk4wbPqyXshA8rOaKmzaBR5SDSFlnv+DDsq7sJwwfoA
        hEZw52VQ8fBxwaDCIIIQAs/piXRCYn2sXhavKbt+dfnSOn3khSIkfDaVOcjfRP/Equ6eMKifVvP
        ArRxHOwmzpMFmAzSfc6drb9mp
X-Received: by 2002:a05:620a:1671:: with SMTP id d17mr3422680qko.683.1643303377469;
        Thu, 27 Jan 2022 09:09:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyie4bqi26jfgNY8Cjw+Pn5xYBOKV6NvnkIoBYF0/ZaizWWrCUD9ZTrfOlIA4zvFGF0i2/RFw==
X-Received: by 2002:a05:620a:1671:: with SMTP id d17mr3422658qko.683.1643303377286;
        Thu, 27 Jan 2022 09:09:37 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id i8sm1628636qti.52.2022.01.27.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:09:36 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:09:36 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: Re: [PATCH 06/19] dm-crypt: remove clone_init
Message-ID: <YfLR0DPcDOYO65Hp@redhat.com>
References: <20220124091107.642561-1-hch@lst.de>
 <20220124091107.642561-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124091107.642561-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24 2022 at  4:10P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Just open code it next to the bio allocations, which saves a few lines
> of code, prepares for future changes and allows to remove the duplicate
> bi_opf assignment for the bio_clone_fast case in kcryptd_io_read.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

