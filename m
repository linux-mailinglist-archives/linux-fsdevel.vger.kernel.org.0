Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483828A83F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 22:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHLURi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 16:17:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfHLURh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZEYyxHxPiniKVYrkg5s9QOF3kwvVsp4P0LdTV42X/to=; b=p4AjsOCDdNvgOr5k63rESQxrn
        EWwH/9D2VCyY4etgrCL8qPwf0XRThDnf4f1xlmrNDYv4+btUbGBMzeFBCmOJ0O5h4A5nxH1sqxf+H
        hENiXT+Jmp+eN38WAk5dbLGvMN0ZCEDQKuZRtwzKFdpxYvokfLYCop6g2VUrkWzH1/s0cLNz+/PzH
        emD6TBkoHZmG61uLp4zbvCFCRPmdByTIgfw0hsBD9q5aPK8k32Jq9nX4PVF2347TaKSNFr0r0nEYU
        Ow3o8QFM6ncWQDoQG+yL/BYhYJL59YivKO4Pe4mMlOmejJP6Ob5dy2mNHEsHANH6YbLjbyk2Ngj/D
        zE8y6ul3g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxGl5-0003dm-O8; Mon, 12 Aug 2019 20:17:35 +0000
Date:   Mon, 12 Aug 2019 13:17:35 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 1/5] ext4: introduce direct IO read code path using iomap
 infrastructure
Message-ID: <20190812201735.GA5307@bombadil.infradead.org>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <3e83a70c4442c6aeb15b7913c39f853e7386a3c3.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812171835.GB24564@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812171835.GB24564@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:18:35AM -0700, Christoph Hellwig wrote:
> >  		return -EIO;
> >  
> >  	if (!iov_iter_count(to))
> >  		return 0; /* skip atime */
> >  
> >  #ifdef CONFIG_FS_DAX
> > -	if (IS_DAX(file_inode(iocb->ki_filp)))
> > +	if (IS_DAX(inode))
> >  		return ext4_dax_read_iter(iocb, to);
> >  #endif
> 
> Same here.

It doesn't even need IS_ENABLED.

include/linux/fs.h:#define IS_DAX(inode)                ((inode)->i_flags & S_DAX)

#ifdef CONFIG_FS_DAX
#define S_DAX           8192    /* Direct Access, avoiding the page cache */
#else
#define S_DAX           0       /* Make all the DAX code disappear */
#endif

