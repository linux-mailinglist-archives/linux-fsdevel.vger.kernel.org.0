Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAA4D3A59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 09:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfJKHvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 03:51:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfJKHvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=waqJdP9rJDtEFqbcyOC7uJCMgDCGnjkCl4nSVoSMkIc=; b=TTiMVoHNLa+8q8+e/KY6AvYzp
        Svhs+EF5AFJfdLyUQQcbonj+z2piAL8I17nA3m2NSRx8J9UFT6qQe7ADrS6DxaboPUrG3W0iDYiKM
        sK7GDKey21FzA/eJkNAD9934qyDWZ81dJnY9wGQv03kiEMxyBt2ysEUrMH1QNzffL1Lc7rryhyjQD
        fURZvTo+j6ZxcJD4ZZkl11pVmYPbs4IVmQAo1xT0GFjbtUcKv0OHN8xu4hEhGdHTbOTgukgVkOzlO
        qup1fUZegCnwmQZmhtJ5qy9aA3SGwSrdahZK73Uos15qM/v5YjYGJXZZZ5DA8QhYmBl7nfCwYlO+5
        mf1HtD/JQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIpiC-0000PG-SE; Fri, 11 Oct 2019 07:51:44 +0000
Date:   Fri, 11 Oct 2019 00:51:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] loop: fix no-unmap write-zeroes request behavior
Message-ID: <20191011075144.GA26033@infradead.org>
References: <20191010170239.GC13098@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010170239.GC13098@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:02:39AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Currently, if the loop device receives a WRITE_ZEROES request, it asks
> the underlying filesystem to punch out the range.  This behavior is
> correct if unmapping is allowed.  However, a NOUNMAP request means that
> the caller forbids us from freeing the storage backing the range, so
> punching out the range is incorrect behavior.

It doesn't really forbid, as most protocols don't have a way for forbid
deallocation.  It requests not to.

Otherwise this looks fine, although I would have implemented it slightly
differently:

>  	case REQ_OP_FLUSH:
>  		return lo_req_flush(lo, rq);
>  	case REQ_OP_DISCARD:
> -	case REQ_OP_WRITE_ZEROES:
>  		return lo_discard(lo, rq, pos);
> +	case REQ_OP_WRITE_ZEROES:
> +		return lo_zeroout(lo, rq, pos);

This could just become:

	case REQ_OP_WRITE_ZEROES:
		if (rq->cmd_flags & REQ_NOUNMAP))
			return lo_zeroout(lo, rq, pos);
		/*FALLTHRU*/
	case REQ_OP_DISCARD:
		return lo_discard(lo, rq, pos);
