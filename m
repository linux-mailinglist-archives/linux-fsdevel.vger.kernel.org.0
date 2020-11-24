Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A162C3282
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 22:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgKXVTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 16:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbgKXVTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:19:55 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D0DC0613D6;
        Tue, 24 Nov 2020 13:19:55 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id 62so1144522qva.11;
        Tue, 24 Nov 2020 13:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A2Ux7RQ7mBCZEojzGvR0WDuZtfXBN33NUKSWm/nAx2s=;
        b=uiOjPjtUtQlGuTii+qORJIGUPOgnFY1nUtEhKLlffzZur6sGJm+gKH90kLKTftzjMY
         gUznZxSbf+gcBmxTds5RUXjrVxrE+Fq2EmBwcWZB+pJf3BS5L+QJ7kv+CxvIAOrqPzEX
         dMqmSibOB0dtykbXe/2E2zoCxbKuzPbH5RmI+Xfb2tQjieKxRGRgQgps4Mrmdf0e2l3a
         eNnhJnzPz0bblYg/4cAkndkSQkON8xjuTRqoNexKjm8D+3aqj4P9Sj0gjlauNmeONhmf
         5kvr4Ddaona2AGKfmkN2405koPZEL1O1mk4yy01pHWJJDJlpvcRl+PE1xhRDe1lIBY+4
         jUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=A2Ux7RQ7mBCZEojzGvR0WDuZtfXBN33NUKSWm/nAx2s=;
        b=iSei1FPm+0qEGBqhKgC5XaRh+REUmpld7YeM2cu4PsV9aG9sF83NW3F1uhYfFuDwTy
         u9xyDs4FFqNd7to7sgPmigD4DQHr6ob5vSa3LISyX5Q9KQQHB9wktmU/EHvRqsOMUy6f
         hQR2ODE2VNVF5WSKe+eItz47TN+3tMXA/5gxOPq8xFtIT12tRuNg3JpBFWLwbH6wvwet
         XV3/D1bRnccHn5lkdTaJhbFc55TPyLP4lzfr7gt0/putKGFROjG3AMRvgFpytvADEqfO
         nojPbCowudIq3rfccenn5nvgWLvC70EwSnKpXFWBxyUhlsvO8pJUNhryMmk2AM5BLhRD
         syhw==
X-Gm-Message-State: AOAM531usCOMT7uU/391uKsW0y3kwsN8Y3AKE+9V1hyLNp2X6HBHvuOd
        qn5UjCpqXNxG5C0+emjonM8=
X-Google-Smtp-Source: ABdhPJxvWSMIcF1QvtVmsROEnFEfbgneWE4I12McWSmR7ItrCaZw+O6oSDwh472sj7fwnSIDMbgqhQ==
X-Received: by 2002:a05:6214:443:: with SMTP id cc3mr455144qvb.53.1606252794270;
        Tue, 24 Nov 2020 13:19:54 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id l46sm308143qta.44.2020.11.24.13.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:19:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 16:19:31 -0500
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
Subject: Re: [PATCH 26/45] block: remove ->bd_contains
Message-ID: <X7144xvjxqhopOck@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-27-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-27-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:32PM +0100, Christoph Hellwig wrote:
> Now that each hd_struct has a reference to the corresponding
> block_device, there is no need for the bd_contains pointer.  Add
> a bdev_whole() helper to look up the whole device block_device
> struture instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
