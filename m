Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36F6345259
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 23:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVWTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 18:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhCVWTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:19:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44614C061574;
        Mon, 22 Mar 2021 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NHsFX5MxjeF+VaAwcwyWFoKD78wZlg9OURQbD+OIWjI=; b=lRF/zob9BaEhB0ShW00Zg6tQC4
        GYTJS0a3vdB87rFIsddE92qBPvZez5JPYt5PPnZhpyZcPWMFw6E6PWJsk8Nll/c5p6M4q3NLH4Dv+
        iVSaJQjLNW9dbd4gBjHUBlB52OTsTx/lfg8jfOQ0dO+GhlnWwQW4bwsAuBq4nRCuT4IzeH3Q/6Zri
        zq5tVOo5meCFreI34KxT+59bGXMex4D+q+QV0RoumOPpOCk+OFo5xevvWcpp08LZtVY1cjeoUxDIC
        Lf9GeU0rjy/X6n6X1etT3+jIowXBTUqzMBOHDl6c8aU8odIlj/QCQNXIwsvOHDgW993Bwbua8mlc7
        6U3bCzGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOSsK-009A1r-Qz; Mon, 22 Mar 2021 22:18:28 +0000
Date:   Mon, 22 Mar 2021 22:18:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 1/5] cifsd: add server handler and tranport layers
Message-ID: <20210322221816.GW1719932@casper.infradead.org>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052204epcas1p1382cadbfe958d156c0ad9f7fcb8532b7@epcas1p1.samsung.com>
 <20210322051344.1706-2-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322051344.1706-2-namjae.jeon@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:13:40PM +0900, Namjae Jeon wrote:
> +#define RESPONSE_BUF(w)		((void *)(w)->response_buf)
> +#define REQUEST_BUF(w)		((void *)(w)->request_buf)

Why do you do this obfuscation?

> +#define RESPONSE_BUF_NEXT(w)	\
> +	((void *)((w)->response_buf + (w)->next_smb2_rsp_hdr_off))
> +#define REQUEST_BUF_NEXT(w)	\
> +	((void *)((w)->request_buf + (w)->next_smb2_rcv_hdr_off))

These obfuscations aren't even used; delete them

> +#define RESPONSE_SZ(w)		((w)->response_sz)
> +
> +#define INIT_AUX_PAYLOAD(w)	((w)->aux_payload_buf = NULL)
> +#define HAS_AUX_PAYLOAD(w)	((w)->aux_payload_sz != 0)

I mean, do you really find it clearer to write:

	if (HAS_AUX_PAYLOAD(work))
than
	if (work->aux_payload_sz)

The unobfuscated version is actually shorter!

