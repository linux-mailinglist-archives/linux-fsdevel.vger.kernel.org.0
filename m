Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48B8AAAFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 20:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403881AbfIES3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 14:29:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390029AbfIES27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=acxEENEa/DqMCNqNx4aBDRRIK560ncz4Caqw5lxEPBs=; b=Qqt13/dNdTpOF/UEMQ73DriBY
        +VchaP0F0KycJLtkPdlJQqQZwlt+gUeo8pCDHDsHtHYir37mRbm5OPWy/dP9bgPQwRMrVYURW0iK9
        OVVxf51ZsaBTSpRk+UxB27lvyLvXZxCYzonU11dcYngMZUt1fxBmaE5uPjC+Cjsx/IUWdvlgzmlsA
        XYJPwOjTlLcbCsguxdG7bUwe+mgHe/6JJ0aAQ5SdhVPrhKsA9kVMhgL/A10WKAArcXr2Lr5eUhUGD
        q2qdAGvs1zl26/WbEMyQ51kmnm9vJdCcTF872vqBB1Suv3o0Fu7k+Ud9+EcmEPfjwkdsFRw6MUrLH
        8zrqFlqJg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5wV9-0003Li-Gr; Thu, 05 Sep 2019 18:28:59 +0000
Date:   Thu, 5 Sep 2019 11:28:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Kirill Shutemov <kirill@shutemov.name>,
        Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH 2/3] mm: Allow large pages to be added to the page cache
Message-ID: <20190905182859.GR29434@bombadil.infradead.org>
References: <20190905182348.5319-1-willy@infradead.org>
 <20190905182348.5319-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905182348.5319-3-willy@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:23:47AM -0700, Matthew Wilcox wrote:
> +		xas_for_each_conflict(&xas, old) {
> +			if (!xa_is_value(old))
> +				break;
> +			exceptional++;
> +			if (shadowp)
> +				*shadowp = old;
> +		}
> +		if (old) {
>  			xas_set_err(&xas, -EEXIST);
> -		xas_store(&xas, page);
> +			break;

Of course, one cannot see one's own bugs until one has posted them
publically.  This will exit the loop with the lock held.

> +		}
> +		xas_create_range(&xas);
>  		if (xas_error(&xas))
>  			goto unlock;
>  

The stanza should read:

                if (old) 
                        xas_set_err(&xas, -EEXIST);
                xas_create_range(&xas);
                if (xas_error(&xas))
                        goto unlock;

just like the corresponding stanza in mm/shmem.c.

(while the xa_state is in an error condition, the xas_create_range()
function will return without doing anything).
