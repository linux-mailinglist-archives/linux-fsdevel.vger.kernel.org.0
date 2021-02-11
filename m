Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BA0318EF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 16:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhBKPlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 10:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhBKPi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:38:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7351CC061756;
        Thu, 11 Feb 2021 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hJ8uepiWcgph891R8KmreTzxxreni/R3Me86FH4whMI=; b=AM9M439DoxUhB2VN8sDK+YxWqJ
        BSt3SLbkDhjj63TYXe0RewsK2AnF1vNMZTCQff7DxgeMRETzDYSV+xvWEjVomMr58RuYXcrjxA3D0
        RHv4hj7HlhSdzgSAryVR7ppxvG6jBa2vV4tMe65tJIGIAWcQPgXSdxQFQwA1r1FXAYu73lwFVExaT
        bDNR3D7MWIzz0eNmvPCPi1HKdLwAXlS4Bx0+4hmk0Cph0JKyIxxFqXuimax+XsnNyt+kZp0h5Jh1y
        AowmOKlWantiHq1fVgZxr/oVzARN45ok+Ra8WdyD5q32rQVRIy8GNAqPGCu0lWZhFCs/evV9YWk3f
        ZwdAl6Wg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lAE2n-00APiO-6Q; Thu, 11 Feb 2021 15:38:13 +0000
Date:   Thu, 11 Feb 2021 15:38:13 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] quota: Add mountpath based quota support
Message-ID: <20210211153813.GA2480649@infradead.org>
References: <20210211153024.32502-1-s.hauer@pengutronix.de>
 <20210211153024.32502-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211153024.32502-2-s.hauer@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	if (!mountpoint)
> +		return -ENODEV;
> +
> +	ret = user_path_at(AT_FDCWD, mountpoint,
> +			     LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT, &mountpath);

user_path_at handles an empty path, although you'll get EFAULT instead.
Do we care about the -ENODEV here?

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
