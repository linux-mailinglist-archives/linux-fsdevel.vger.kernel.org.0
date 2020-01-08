Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEED1343FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 14:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgAHNhh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 08:37:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbgAHNhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ejHBtPPFJZIqJBmHQJ9f5DcsufizT72B16/+fp0KyUI=; b=T7DDIoTqmYZnhipukNXhM5o54
        YYNrdqPftrURa+QMA8UvGDv75bKKXys44frDcZjhL4MrI6zVm+zd5qXkzAeCDnKBZId/YD/v1Mvh0
        5KKR4Wr3EOcI1tLARjvNNOaIjT9qhGeMtBl0nbn52oDWXVMUJVFwwP2mLjhwSojhYym8uQkGtHg4C
        5UH15opKAp720d4WZ0JXLRMiIeNf/gO4WU/ta4EgRe7vl8R2JZL08tewMCsUuj0ka696Axbz1qpet
        ZZ/vsCuL6w8m71dGwcOaCef2JoO3uy5UJzM8KO9qeduobTu6/8clc/6q7ffqBIR1Ku7Bsua9ORreW
        M8uZbPZyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBWh-0003hm-Q5; Wed, 08 Jan 2020 13:37:35 +0000
Date:   Wed, 8 Jan 2020 05:37:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com
Subject: Re: [PATCH V2] block: add bio_truncate to fix guard_bio_eod
Message-ID: <20200108133735.GB4455@infradead.org>
References: <20191227230548.20079-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227230548.20079-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> +void bio_truncate(struct bio *bio, unsigned new_size)

This function really needs a kerneldoc or similar comment describing
what it does in detail.

> +	if (bio_data_dir(bio) != READ)
> +		goto exit;

This really should check the passed in op for REQ_OP_READ directly instead
of just the direction on the potentially not fully set up bio.
