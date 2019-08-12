Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DABD8A423
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 19:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfHLRSg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 13:18:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfHLRSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DEQNuctojuWVbKWasBQpEwHSDMEyohKSnrhZzBUeOKw=; b=LcIA8FNMty82d8dDrPk94VQcd
        vpzGamIB7+6/MRLw7Q2LtAlskL7BwCC28jEzgMPpkGz06AQXlOEtXa2Pu0YWi02zmQJEPOUwTiyZ3
        +F4iXjx8syhVACBnNK0/oTT5fLFxb5vvpMJG0VZp52g+DV9/h4dIGWPq02vX9LbQ0+pIlntIaY5BH
        nULfLobWqoMmdmMOKQropiIfgfhavVgotpBLNjOtpShK00z4/b8qBa2KkjcqDxPAtZrEFFd1jdHpg
        awgwk5wWTTV9Ob/NjpicAwMDSLNf4oSr/kW64E7mG3nS7yC9y3H6+425z3hvw6Imc/DbaMF+z1piG
        sq6Be6DMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxDxr-0001M7-RN; Mon, 12 Aug 2019 17:18:35 +0000
Date:   Mon, 12 Aug 2019 10:18:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 1/5] ext4: introduce direct IO read code path using iomap
 infrastructure
Message-ID: <20190812171835.GB24564@infradead.org>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <3e83a70c4442c6aeb15b7913c39f853e7386a3c3.1565609891.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e83a70c4442c6aeb15b7913c39f853e7386a3c3.1565609891.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:52:35PM +1000, Matthew Bobrowski wrote:
> +#ifdef CONFIG_FS_ENCRYPTION
> +	if (IS_ENCRYPTED(inode))
> +		return false;
> +#endif

This could use IS_ENABLED.

>  		return -EIO;
>  
>  	if (!iov_iter_count(to))
>  		return 0; /* skip atime */
>  
>  #ifdef CONFIG_FS_DAX
> -	if (IS_DAX(file_inode(iocb->ki_filp)))
> +	if (IS_DAX(inode))
>  		return ext4_dax_read_iter(iocb, to);
>  #endif

Same here.
