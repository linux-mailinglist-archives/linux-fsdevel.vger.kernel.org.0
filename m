Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D774813C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Dec 2021 15:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhL2OGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Dec 2021 09:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237236AbhL2OGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640786792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aO/4Yp6T43XLmNMDQP+OwTqaYv7whlIlyBDq4dbPFsg=;
        b=cIKLPwvkNFjDmUgRNlTNSevOZIBBFlut6kEpMOFbQCxhZU69gSHGNYnoRflhGuMChScNM8
        MLLIYy1Jlu4IaaAOR1/o9cyYzvZDtsUr3P0CyuY6juobcOPXCitDDK0ZZO06bxnwR6prVQ
        6vzpTZjOkHWBIWOV7rNOYbKxvNXjFuU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-e7NL6nk7MtKvsproHBUy7w-1; Wed, 29 Dec 2021 09:06:31 -0500
X-MC-Unique: e7NL6nk7MtKvsproHBUy7w-1
Received: by mail-qk1-f200.google.com with SMTP id bs14-20020a05620a470e00b0046b1e29f53cso12907732qkb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Dec 2021 06:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aO/4Yp6T43XLmNMDQP+OwTqaYv7whlIlyBDq4dbPFsg=;
        b=wfInOtQy4XM/uGsnso6ltiuwYw5xQ4KL6dldhe6fadji0nack+a1cDyTesdzXn1Qwn
         9bQQPzfnGDlQMAVu1BZ4C6cnExsQF2D66sdkdva/NCLlJ8YPZJaujca+g7sLq0XI5sVD
         9ad/QQVRaBNGSP4jmc3fb+zU0t/JRYqe6QviH+hnqr+/FXsehWNMvqvdn78K7a3N5+lO
         6iHYvkJMC0kmcfH/O3/Od7R8oRFFQa+gKEPbimeQqFICuJx+/20gfeDBmHPQHDPL43LB
         wJ/uft5PeVh52ZPEgKv23kV1hbM7a1fCjg2ZhhHcDP0h7XIjMo8ziiymJMwRQW4E/2av
         nvIA==
X-Gm-Message-State: AOAM533cLh9uqevl4kvOzZySfhYb5O/ZIJGvyOt2pXdtrB4tlCJ5xbkQ
        LX9y8ORM2UOVDwDKOBBQAxlowZwczSQ1jS9hVT4k53v708inZHVxiP6RzRQjZ+D4envLOaqq7TO
        13zpMIZGSeLv/l7ftGUEXkDEeHQ==
X-Received: by 2002:a05:620a:4003:: with SMTP id h3mr18549119qko.153.1640786790465;
        Wed, 29 Dec 2021 06:06:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyimHrQiLRtzxiuwvtJVztliA6HApJnsXsaqWdLb9ltPripN76oNC87N68Zld9IushfHCBQfg==
X-Received: by 2002:a05:620a:4003:: with SMTP id h3mr18549076qko.153.1640786790152;
        Wed, 29 Dec 2021 06:06:30 -0800 (PST)
Received: from steredhat (host-87-10-236-9.retail.telecomitalia.it. [87.10.236.9])
        by smtp.gmail.com with ESMTPSA id h2sm18124352qkn.136.2021.12.29.06.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 06:06:29 -0800 (PST)
Date:   Wed, 29 Dec 2021 15:05:57 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        dledford@redhat.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, leon@kernel.org, ap420073@gmail.com,
        wg@grandegger.com, woojung.huh@microchip.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
        george.mccollister@gmail.com, michael.chan@broadcom.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        hawk@kernel.org, john.fastabend@gmail.com, tariqt@nvidia.com,
        saeedm@nvidia.com, ecree.xilinx@gmail.com,
        habetsm.xilinx@gmail.com, jreuter@yaina.de, dsahern@kernel.org,
        kvalo@codeaurora.org, pkshih@realtek.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        viro@zeniv.linux.org.uk, andrii@kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, nikolay@nvidia.com,
        jiri@nvidia.com, wintera@linux.ibm.com, wenjia@linux.ibm.com,
        pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        ralf@linux-mips.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        kgraul@linux.ibm.com, steffen.klassert@secunet.com,
        herbert@gondor.apana.org.au, arnd@arndb.de,
        linux-bluetooth@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-can@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-hams@vger.kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, bridge@lists.linux-foundation.org,
        linux-decnet-user@lists.sourceforge.net,
        linux-s390@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH bpf-next v2] net: don't include filter.h from net/sock.h
Message-ID: <20211229140557.cuap5jjqz47yevda@steredhat>
References: <20211229004913.513372-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 28, 2021 at 04:49:13PM -0800, Jakub Kicinski wrote:
>sock.h is pretty heavily used (5k objects rebuilt on x86 after
>it's touched). We can drop the include of filter.h from it and
>add a forward declaration of struct sk_filter instead.
>This decreases the number of rebuilt objects when bpf.h
>is touched from ~5k to ~1k.
>
>There's a lot of missing includes this was masking. Primarily
>in networking tho, this time.
>
>Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>v2: https://lore.kernel.org/all/20211228192519.386913-1-kuba@kernel.org/
> - fix build in bond on ia64
> - fix build in ip6_fib with randconfig

For AF_VSOCK:
Acked-by: Stefano Garzarella <sgarzare@redhat.com>

