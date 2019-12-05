Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176661145B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfLERUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:20:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfLERUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SyaZI99UxJjfPHeFN17yigrBhnbsXIzAC9SQrlLdaEo=; b=mZ6u5b9GQBZozKwLa5GIFuzse
        /bt9btoqtXjTQLMPVXN41h0436sVLjO0zeXVt2tIMlOo1X87OloErE1lcSJ2MzYWdqnflaDmlq/zd
        PRUhLRd+uvf+Ajh1/IjZROVVFdUSeUcurBpA79TKvME98BWXI709wSa0hHGP6l+6SILFpzpCkDIUv
        PA3hZAKuH0sERY93PnxgAd5MSe2flI09592PW+c0kHZGQ9kvg94HeisRQSBaCQaJKrUb9tDZvpMdR
        lz4xZtvu3/ke2llDp++Gwn1FfuBuU9OiX+LZ4gGuqS6aWrpOKMVwGJsN2ZR0iwRAnvlUYiuZ+HW2l
        xUR6DMCIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icunH-0002If-V0; Thu, 05 Dec 2019 17:19:59 +0000
Date:   Thu, 5 Dec 2019 09:19:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20191205171959.GA8586@infradead.org>
References: <20191205155630.28817-1-rgoldwyn@suse.de>
 <20191205155630.28817-5-rgoldwyn@suse.de>
 <20191205171815.GA19670@Johanness-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205171815.GA19670@Johanness-MacBook-Pro.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 06:18:15PM +0100, Johannes Thumshirn wrote:
> > +
> > +	return generic_file_buffered_read(iocb, to, ret);
> 
> This could as well call generic_file_read_iter() and would thus make patch 1
> of this series obsolete. I think this is cleaner.

I actually much prefer exporting generic_file_buffered_read and will
gladly switch other callers not needing the messy direct I/O handling
in generic_file_read_iter over to generic_file_buffered_read once this
series is merged.
