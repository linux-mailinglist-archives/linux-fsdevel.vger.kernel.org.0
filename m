Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914A02964B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369717AbgJVSfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 14:35:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42208 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368258AbgJVSfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:35:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id x13so1675919pfa.9;
        Thu, 22 Oct 2020 11:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XI2Q+0LJ+MrF6PTdb/vTI0hg1qM7/BgdBxfc/cQLFU=;
        b=KfvJzwfxn7jq43862MSUDXsjHVLQiDL2XxoZJGmoXONgP4vY3GlCA5FN+8DrSsW8wB
         9SmbJi6W4JdS5zP5MzYogQw2PEMOlYdeKT6+WY0h01gtWfYbQhRjLOx0oc5r/8kiEOLp
         4eIQiBAyv4wvJfpI6+JS713/r5xD54+18A2io2LjdPOKLQCw3Xa5BGWDUkjlj5m5F1SR
         raWFqZtJq/rlWV3AqoLz7KXLZypGdBl3h/vciJMketksAu0hImF/F4e3OxebTToubG+f
         1/VAmkFB1GxeNxg75NKaDKeoIUGinxz/SKDwgRSkrGuq/Xq3oIYt2o+5il5uSpTq1j7G
         cmcQ==
X-Gm-Message-State: AOAM53173u/AwlX54c+Hsy6e5BJ0qGFyF8+wWy5WJICweLZmcvJ93i1Y
        hO+KLdQJP5Q3SwhAmQL9TxmqQ9iFEr7O+8FtCOE=
X-Google-Smtp-Source: ABdhPJz36fkFyGr3qzw17+AgK9oYpIzBshcfChZVSHFTISPy8X4z6IdPGqE/7nwcLSyFF6/1DoPxCQ5X7a4DVfLIwnM=
X-Received: by 2002:a63:a546:: with SMTP id r6mr3310324pgu.160.1603391713825;
 Thu, 22 Oct 2020 11:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
In-Reply-To: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
From:   Mike Snitzer <snitzer@redhat.com>
Date:   Thu, 22 Oct 2020 14:35:02 -0400
Message-ID: <CAMM=eLfTf2f2Me7f5tpL5DEGgKsqaFaAS0qTDVpLAYrwR5Jf5g@mail.gmail.com>
Subject: Re: [PATCH 0/2] block layer filter and block device snapshot module
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, rjw@rjwysocki.net,
        len.brown@intel.com, Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        johannes.thumshirn@wdc.com, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        gustavo@embeddedor.com, Bart Van Assche <bvanassche@acm.org>,
        osandov@fb.com, koct9i@gmail.com,
        Damien Le Moal <damien.lemoal@wdc.com>, steve@sk2.org,
        linux-block <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 21, 2020 at 5:04 AM Sergei Shtepa <sergei.shtepa@veeam.com> wrote:
>
> Hello everyone! Requesting for your comments and suggestions.
>
> # blk-filter
>
> Block layer filter allows to intercept BIO requests to a block device.
>
> Interception is performed at the very beginning of the BIO request
> processing, and therefore does not affect the operation of the request
> processing queue. This also makes it possible to intercept requests from
> a specific block device, rather than from the entire disk.
>
> The logic of the submit_bio function has been changed - since the
> function execution results are not processed anywhere (except for swap
> and direct-io) the function won't return a value anymore.

Your desire to switch to a void return comes exactly when I've noticed
we need it.

->submit_bio's blk_qc_t return is the cookie assigned by blk-mq.  Up
to this point we haven't actually used it for bio-based devices but it
seems clear we'll soon need for bio-based IO polling support.

Just today, I've been auditing drivers/md/dm.c with an eye toward
properly handling the blk_qc_t return (or lack thereof) from various
DM methods.

It could easily be that __submit_bio_noacct and __submit_bio_noacct_mq
will be updated to do something meaningful with the returned cookie
(or that DM will) to facilitate proper IO polling.

Mike
