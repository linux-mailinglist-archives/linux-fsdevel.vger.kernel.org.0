Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6EF10EEB8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 18:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfLBRsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 12:48:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLBRsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IjKhKcfgs56M77BJcCUDLX9sVHFCM1k5EtqXolSK9BI=; b=to0x0zNLuMR9SJWagjLNUTOhJ
        Td85PD9p/IMuxIVyZghetmTvmAAHrLd+/4wG00F6N8fga+/bUZtcW1aGl/FQF9DX4IiIUoQFZkGUf
        o204oydF0rMZfPxQJcsh3/mGxfOcGHRLXGU7IJ1UruYeMPn/nhtmPeW4aACQ7tduAQbkg/vJEUTH1
        A5QYUGJkAwFLSahVOnlJW179qaf6/BrrecY2Kf+RzDklpRV4pBO1sfsbCMc4duDGVib4DGR4ZblYY
        NGG8Cg1jfOvB18C2l33uIkNUWc9OFXro8W3VVgeoH16ALAAN7taJWw8+2udWY4nI6ka1ndLYmoJIA
        h6RA9qdug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibpnv-0001Q4-QS; Mon, 02 Dec 2019 17:48:11 +0000
Date:   Mon, 2 Dec 2019 09:48:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH 7/7] fs: Do not overload update_time
Message-ID: <20191202174811.GA31468@infradead.org>
References: <20191130053030.7868-1-deepa.kernel@gmail.com>
 <20191130053030.7868-8-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130053030.7868-8-deepa.kernel@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 29, 2019 at 09:30:30PM -0800, Deepa Dinamani wrote:
> -	int (*update_time)(struct inode *, struct timespec64 *, int);
> +	int (*cb)(struct inode *, struct timespec64 *, int);
>  
> -	update_time = inode->i_op->update_time ? inode->i_op->update_time :
> +	cb = inode->i_op->update_time ? inode->i_op->update_time :
>  		generic_update_time;
>  
> -	return update_time(inode, time, flags);
> +	return cb(inode, time, flags);

Just killing the pointless local variable cleans the function op, and
also avoids the expensive indirect call for the common case:

	if (inode->i_op->update_time)
		return inode->i_op->update_time(inode, time, flags);
	return generic_update_time(inode, time, flags);
