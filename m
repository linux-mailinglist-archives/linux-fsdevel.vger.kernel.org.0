Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD692A4D3B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 18:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgKCRjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 12:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCRjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:39:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EA4C0613D1;
        Tue,  3 Nov 2020 09:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1jy5EkqBDLWV/d12B3XJL/pAIjSmFp7e1zE5bcDQgA4=; b=NaJEKYYnqkZL3wpNyI1f+p23Xf
        VvjdtLW0lYU85RqM5/vba194ZVBp28loe+4DjX45n3y0HJZbeKOTMAVasjsYx7R+4mGP6ZFaHj/To
        DYbw/b63Siazum9a/2Ye1Od+nYqccyOlFL+2eZD/paUSb1Gc0AbNj/KIxfcoYzqFwWdMrqVrjRoc8
        yU0MFXhjlVwtNKeN1C8Jf5P46MU3cLv0pK1jo21E70NmCbksVnMEL6lFlF9NMKIJN/qNjdjIHChpo
        Kf61A9qsfy4g/H25dDlXdxBoZa53Bjng5vI1rCv5YG8p2r/oEnYbWtpjxyBbVV5QapN4vVl9TbrwS
        hmtXyZXQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ka0HB-0008VN-5E; Tue, 03 Nov 2020 17:39:21 +0000
Date:   Tue, 3 Nov 2020 17:39:21 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>, fdmanana@kernel.org
Subject: Re: [RFC PATCH] vfs: remove lockdep bogosity in __sb_start_write
Message-ID: <20201103173921.GA32219@infradead.org>
References: <20201103173300.GF7123@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103173300.GF7123@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  int __sb_start_write(struct super_block *sb, int level, bool wait)
>  {
> -	int ret = 1;
> +	if (!wait)
> +		return percpu_down_read_trylock(sb->s_writers.rw_sem + level-1);
>  
> +	percpu_down_read(sb->s_writers.rw_sem + level-1);
> +	return 1;
>  }
>  EXPORT_SYMBOL(__sb_start_write);

Please split the function into __sb_start_write and
__sb_start_write_trylock while you're at it..
