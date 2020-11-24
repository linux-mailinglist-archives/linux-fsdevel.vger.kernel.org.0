Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EFF2C2F06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 18:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403932AbgKXRl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 12:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403820AbgKXRl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:41:29 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23378C0613D6;
        Tue, 24 Nov 2020 09:41:29 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id l2so21578383qkf.0;
        Tue, 24 Nov 2020 09:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ibQynBLG5sCe4CZqYbUkQUaNNDbglWF2wLslYnfqek=;
        b=jYivczMQqsxh7yyiSCMC+J2uq1jjrgFqCn4zGdT7y8l1tR+lBZj0zWSEvbd0W8jl8w
         Gi4Cj5Zx4gKHsuI0fIL4rp4709gHxtA9wRWySVLNwDnlcHxfBP3hG6ecjPkRXqH0UxZp
         xk0pqka3Sqe63I6EZOHEKoOfA/4WJiEaugJWCMjne3X9nHRMXe7fYlZPuOXRYu6gUE1t
         VJ+e81XD/b5aNX2a+wyW4GmbUwrk6CKBJ/6iNXNyc9y/IvYXsxz32um6sHRBVWQzYyqm
         IRQIL0vettN12q9xzjv+kftrmu3uKde1tlzjzfXundOzi243rFxdMC5NVy5kvvEXsk4Q
         MK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4ibQynBLG5sCe4CZqYbUkQUaNNDbglWF2wLslYnfqek=;
        b=XS4LVIoGLNdwz2c9kAAo9GS5QCeVabTl6QCGv+S2U+mbF5hihSZTvxl8h+wZgWzdHo
         /FFgrfeyYTnkf+B7Ub8ovzW2IuPaGD+3W/LkQiAqJ/K/aD1M6XL4de/UKayGf8p8V/Qs
         0jS23bEZIDypB3RHE8xci4Y46dhlavZOLnBO1s/bP6SrOSPhkZWbONE863jwJNsaOHbA
         mbVqefLRLzv+4fdqkFbv+mt/nijjSa6T0QsmZsc2cwVkPOnbvQJVAxIw42AHa40COxWF
         JWi0u953+NPfYwwJ9ntQ3kz9D9X5n9m3kYIBbkuYdBDfkvsTpOfu06n/MhLxdzkkNQgJ
         MDtQ==
X-Gm-Message-State: AOAM532hhyMC4o8bEBzuVFQfMOuYSLzrCVGDR28HJnQXkQ2l6VcFJ30u
        4zoyxLAprIj8zeTNh4Pw8tY=
X-Google-Smtp-Source: ABdhPJwbAXPcygkLKUFdmjuytzuRV0DzFXM5PwNCTshXeMizxUWtjVUL4UzMNPmTvdVp88+fUo1SSg==
X-Received: by 2002:a37:8c41:: with SMTP id o62mr5500995qkd.240.1606239688196;
        Tue, 24 Nov 2020 09:41:28 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id y3sm7003885qkl.110.2020.11.24.09.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:41:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 12:41:05 -0500
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
Subject: Re: [PATCH 20/45] block: refactor __blkdev_put
Message-ID: <X71FsRDFtHWxVJOg@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-21-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-21-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:26PM +0100, Christoph Hellwig wrote:
> Reorder the code to have one big section for the last close, and to use
> bdev_is_partition.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
