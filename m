Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB416131F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBQNRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:17:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBQNRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m99idTVz6j5X391tgL2V4vZc3QX+neDzRSEZQxuFrDw=; b=plmw6BFvypCQyzRuR51HPo/4RO
        pEGFnlYHf4eSIEqgio/Pris9HqcgWXGSi9sT02zq95eh7vcCWD5kMzHJTx5LvWI9qvm47asaWBSIB
        rclJpvNUZl7Xg5tA7AxZmkUFbSSgzpO+5d8xid6K+ZDDnaVF34VEBuXGyMOqOCuKTqX+degOg5Bc0
        d9s+0XVI9ujCO+nJZfn+p/TuKssKtCaNk4Std8LlS/+B9G1tPB0Y9AszjXcBBQEp130SiBBjskIp7
        kxmzyo+cR1bOil/J4+4HyiEqyzxHc5fBGZqgwXWJpD7hb9nJpGoQrPxXKEuVOM4yoQH7x81EnbXiU
        yp0vnZ1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3gHZ-0000at-0p; Mon, 17 Feb 2020 13:17:53 +0000
Date:   Mon, 17 Feb 2020 05:17:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH] iomap: return partial I/O count on error in direct I/O
Message-ID: <20200217131752.GA14490@infradead.org>
References: <20200213192503.17267-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213192503.17267-1-rgoldwyn@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 01:25:03PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> In case of a block device error, iomap code returns 0 as opposed to
> the amount of submitted I/O, which may have completed before the
> error occurred. Return the count of submitted I/O for correct
> accounting.

Haven't we traditionally failed direct I/O syscalls that don't fully
complete and never supported short writes (or reads)?
