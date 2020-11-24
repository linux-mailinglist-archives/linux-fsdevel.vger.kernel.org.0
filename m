Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8532C3285
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 22:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgKXVUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 16:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbgKXVUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:20:17 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E637C0613D6;
        Tue, 24 Nov 2020 13:20:17 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id u23so11374326qvf.1;
        Tue, 24 Nov 2020 13:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3HC7ZqQanyIo8VeBYdMEle4L/4ENFYEM5MkKt8pSh/w=;
        b=SBpFqtt8PXbzCveB3YbrqNUj//b1rdDV1EqJm8ZT0/PCMKGkmFs6PzBliBJcdVTLfk
         tv/ZuM+3J7XM+n5fEUuohYu6uKi1fCr78XSUa/5RUJdfK+5UfN3C0U3yX9T9Q54Q5SaR
         vVOVCypSCFl85W7pD0ksSCQvKz2n77IAVCPEhA9UoBfthB9BvyYs6pYTaIL0wmQf9aCu
         xcqLyNke/DBRRYIHLihURVxMheAgoXZ/e0RlaCkV/7/TeYdWzBYlD3KA6yr3YBRfdQIT
         T2cBKt53JFvRl9mTVJp+iF+XYLyh3G75CH9aRMRIV/K8O2t4jUxGxv8CwdtQFQ8WaWa/
         HyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3HC7ZqQanyIo8VeBYdMEle4L/4ENFYEM5MkKt8pSh/w=;
        b=HwFkkoid0I4ztbjI90rhH9rdYM9nIFlmQ8PGZvlupoKEwCHb+WTdKcO5xXoAMwTBYK
         DptP6kNaLyCC90xU5zJgKQFBVL3lb1DB3o+mkZsXF8OVDZZWR2hip3yi2SZ5Ah6fVqS/
         /5GpBJEw4WpUfOf2WMyXx/H2NKSwL8zQwirU7C7MqiTRIQGBhhg4nq4fRlIREYFAuCkc
         5uNktGlbMT9cLQMtcs05zRI8hL/4tFXS8Ng89iVMdX1uALQjPS/V1yf2lDd5ekleajb1
         ARAYJgzWpr4NPo7BC3d7lkiiuc/wgMsiz/i7ZlfJZfxrcSaK8E107L+oMeENboE47SJj
         XzLQ==
X-Gm-Message-State: AOAM533X9yAVCqVg59Yqmk+b3ogRWLAnRBr5TA6fyFJHuaJXlgT8Edxq
        XtxauAW2ohTJJPLR8uGxB8w=
X-Google-Smtp-Source: ABdhPJxH3CMpes4k7VUBJmRwBA7xuLJPWwlXmpOLLvAcoVgK+lPVzlEL/k+veWQQUizcViCkQhf2+Q==
X-Received: by 2002:a05:6214:2a1:: with SMTP id m1mr370118qvv.35.1606252816750;
        Tue, 24 Nov 2020 13:20:16 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id o16sm451985qkg.27.2020.11.24.13.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:20:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 16:19:53 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 27/45] block: simplify the block device claiming interface
Message-ID: <X714+RhOhKVlNrAo@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-28-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-28-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:33PM +0100, Christoph Hellwig wrote:
> Stop passing the whole device as a separate argument given that it
> can be trivially deducted and cleanup the !holder debug check.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
