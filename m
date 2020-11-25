Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19512C3F98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 13:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgKYMKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 07:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKYMKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:10:10 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914FC0613D4;
        Wed, 25 Nov 2020 04:10:09 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id i9so1915327ioo.2;
        Wed, 25 Nov 2020 04:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Gu8dfUtFbW1JkuoI0JsJxuRwdXnhq5kHzNpgpg59Vg=;
        b=qBMGf8ZlpGBDrQf4OZ1U5hpBWVyNLxT8t7mb89EQfIXn+CYHj49+4NspUMpFZN+IBb
         ow2ADzA501Y4hGPFKjrnnAGIPGi9hyvAwwXtpDtFAkYj7ksmhQny5Q5+xlY6jtJjsSvN
         iA9i5fMRanrtfyZfe3+dWZgmeaV0x4lRD+7LgXZczkfB+RbnQDZrkTxOZ7Es8MQAef6B
         e5RRaQ3t+46Lg0Zd/h/8g8StzDseAQGAZgvUuKfsUJH8/o4saKvewPtw+57G9TyZa/BY
         /ViJEbywwBG8XKFF7bgqckI6jrquPx5+GfHPK5ghMTcJ5KumQuJnVjVzT50eAtnQOxE9
         Uwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7Gu8dfUtFbW1JkuoI0JsJxuRwdXnhq5kHzNpgpg59Vg=;
        b=MLwT3DvGDNNdaho0bgCfxDiEvEcF/8omAvMvJwMnWRwRqGeYQ7HQJzC5OwOE+d40HF
         e/5ZJ6b0qb55APBJbO/ljQrUKB1tB+Yz1nvLjzQcNVZ/fxTMUq3qzuu3iBS88DoyGCys
         Sf0fwcsSdHPR1ETn72K5ITs4KmdrOfyDo3GEjGCgAf0kIMFUSt+6LgJx9s7O8h9ZFvnv
         wcwt/um60nQPYlggbGTWJFgMNM0/DOL+RSFxw6TeOrzW1ZYviKTeMKFMyKSevOe4aTX1
         pjy565Nd7v0tWLN8cMj7K7QVFRuyRab/gIPqiH80I/1A7D+XTO3ndWrMAxlIUfpuiz6N
         zBsw==
X-Gm-Message-State: AOAM531jN58DsRFqE2+6YGl97jGUyu5OEgqiO8tQNAD3ovJJhbZAcCC9
        91Hq+bhq2lrVdfabWdio10o=
X-Google-Smtp-Source: ABdhPJzrP+6qlAsvVf6NJAz9IW3W/tDwuPyEzkZeYfjLrVcKdFZvzQhG4Xm+JItZe22HwNKBFUD46g==
X-Received: by 2002:a5e:8206:: with SMTP id l6mr2327550iom.126.1606306209079;
        Wed, 25 Nov 2020 04:10:09 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id v85sm1343250ilk.50.2020.11.25.04.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:10:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 07:09:46 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 11/20] block: reference struct block_device from struct
 hd_struct
Message-ID: <X75JitlWvZieqIR3@mtj.duckdns.org>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-12-hch@lst.de>
 <X708BTJ5njtbC2z1@mtj.duckdns.org>
 <20201125114044.GC16944@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125114044.GC16944@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey, Jan,

On Wed, Nov 25, 2020 at 12:40:44PM +0100, Jan Kara wrote:
> > I don't think this is necessary now that the bdev and inode lifetimes are
> > one. Before, punching out the association early was necessary because we
> > could be in a situation where we can successfully look up a part from idr
> > and then try to pin the associated disk which may already be freed. With the
> > new code, the lookup is through the inode whose lifetime is one and the same
> > with gendisk, so use-after-free isn't possible and __blkdev_get() will
> > reliably reject such open attempts.
> 
> I think the remove_inode_hash() call is actually still needed. Consider a
> situation when the disk is unplugged, gendisk gets destroyed, bdev still
> lives on (e.g. because it is still open). Device gets re-plugged, gendisk
> for the same device number gets created. But we really need new bdev for
> this because from higher level POV this is completely new device. And the
> old bdev needs to live on as long as it is open. So IMO we still need to
> just unhash the inode and leave it lingering in the background.

You're absolutely right. I was only thinking about the lifetime problem
described in the comment. So, it just needs an updated comment there, I
think.

Thanks.

-- 
tejun
