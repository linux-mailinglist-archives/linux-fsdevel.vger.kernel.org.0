Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D57126E126
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 18:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgIQQuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 12:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgIQQtn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:49:43 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650562220E;
        Thu, 17 Sep 2020 16:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600361382;
        bh=sF5GNWOZkQ3nf3+Th5gnQt2xcpsdwKBCS7zrVGfmbVw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=y+iGlgpCeM9xb9d27IMJV7+wkEMiK0mQoV9W7l5UCg8sFTmZkgM99uNvIc2+GWqlH
         0ZPlY/toTe9JazTgGCZZDIpYPmlLHd2V1m/PsaZcDqBuvctHhOeuwFRx8Pao5bfxG/
         9CS6yNA1rBp1Aud48qlKW00CelvRgOeuZ6WNzkHg=
Message-ID: <57d35fdb5ea646f96b70fd8b8a29434761c3f1d3.camel@kernel.org>
Subject: Re: [PATCH 04/13] ceph: Tell the VFS that readpage was synchronous
From:   Jeff Layton <jlayton@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Date:   Thu, 17 Sep 2020 12:49:40 -0400
In-Reply-To: <20200917151050.5363-5-willy@infradead.org>
References: <20200917151050.5363-1-willy@infradead.org>
         <20200917151050.5363-5-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-09-17 at 16:10 +0100, Matthew Wilcox (Oracle) wrote:
> The ceph readpage implementation was already synchronous, so use
> AOP_UPDATED_PAGE to avoid cycling the page lock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ceph/addr.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 6ea761c84494..b2bf8bf7a312 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -291,10 +291,11 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
>  static int ceph_readpage(struct file *filp, struct page *page)
>  {
>  	int r = ceph_do_readpage(filp, page);
> -	if (r != -EINPROGRESS)
> -		unlock_page(page);
> -	else
> -		r = 0;
> +	if (r == -EINPROGRESS)
> +		return 0;
> +	if (r == 0)
> +		return AOP_UPDATED_PAGE;
> +	unlock_page(page);
>  	return r;
>  }
>  

Looks good to me. I assume you'll merge all of these as a set since the
early ones are a prerequisite?

Reviewed-by: Jeff Layton <jlayton@kernel.org>

