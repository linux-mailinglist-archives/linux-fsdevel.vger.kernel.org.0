Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2150B2624A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 03:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgIIBtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 21:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgIIBth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:49:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C593C061573;
        Tue,  8 Sep 2020 18:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mXUgxcP9Ws9NeMj/Q9aKesnrRpqGRQa7a1QsUO3vl1Y=; b=QY2aZKZX6xr9Gq5gIFFDB+fOLr
        SOAHvTxZORPvV0km99Pd5V7OwOKVARZuc7X+vN+tttdYcytcsuySAmTzS8mGbRH02s5n+9q1nROdK
        S0Z4aWugH2uFL1YwnO/oJENx2i8FUsYI2s0tKSiPZx4azzSu+mL2vx7q27fTN2sqvSD1GPdaZuUsj
        FLByEDxh4568qRNTn/EKH5HOjgHLFXhA/tBSWU/pGGeO4bqkhibRDqJOEsS/SBJmHcMnvroOd7XD0
        QQt5l29OwvCGKp8AJo/QrnnlDInEnKrfCgPhVYKbyqi55F0aE+G5S/b1B3Xp7NrZpXmMR5Ys7KHWP
        vZITeRGg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFpEr-00082Z-OS; Wed, 09 Sep 2020 01:49:33 +0000
Date:   Wed, 9 Sep 2020 02:49:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, hch@lst.de
Subject: Re: [PATCH v3] quota: widen timestamps for the fs_disk_quota
 structure
Message-ID: <20200909014933.GC6583@casper.infradead.org>
References: <20200909013251.GG7955@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909013251.GG7955@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 08, 2020 at 06:32:51PM -0700, Darrick J. Wong wrote:
> +static inline void copy_to_xfs_dqblk_ts(const struct fs_disk_quota *d,
> +		__s32 *timer_lo, __s8 *timer_hi, s64 timer)
> +{
> +	*timer_lo = timer;
> +	if (d->d_fieldmask & FS_DQ_BIGTIME)
> +		*timer_hi = timer >> 32;
> +	else
> +		*timer_hi = 0;
> +}

I'm still confused by this.  What breaks if you just do:

	*timer_lo = timer;
	*timer_hi = timer >> 32;

>  	memset(dst, 0, sizeof(*dst));
> +	if (want_bigtime(src->d_ino_timer) || want_bigtime(src->d_spc_timer) ||
> +	    want_bigtime(src->d_rt_spc_timer))
> +		dst->d_fieldmask |= FS_DQ_BIGTIME;

You still need this (I guess?  In case somebody's written to the
d_padding2 field?)

