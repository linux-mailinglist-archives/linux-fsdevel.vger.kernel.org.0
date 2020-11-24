Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935872C2EC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 18:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403865AbgKXRhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 12:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403840AbgKXRhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:37:33 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60290C0613D6;
        Tue, 24 Nov 2020 09:37:33 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id k3so4150760qvz.4;
        Tue, 24 Nov 2020 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NMx3wGtNfY3eeaXC4utlwl41yJ4qPilA6BGetqYUorY=;
        b=ttWPoi7SbGNczr/1HSKQP13JwOnnq6d51NvgAXrXOVbFUHDENikis8wgWQ/ICO4vWD
         QXvXHNRrjPvcjtbRUNuU5kihbWk0IwxLYcoiLDd6H0sLjKI3e2qbtU5af/N7pFoOqAgC
         h3xBKCRJvq/QDtB6ihgsX92WTCe21la5HoXVw91eRC04tEZopSMLMnfWKE1wWDcnWaYf
         S2KXfW3yg0N/7LpsJ40fmTrf9EG2F6mG56V6rpZ8GyEnO0Ym+iYS/n4CBM7mxtRyxGrg
         uQLw/J+qnYSYcVKcO0TGKVFY752sD2m6oYXQvW4fux2BOd14a3jTxvr52rzBLO0HCBoZ
         teng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NMx3wGtNfY3eeaXC4utlwl41yJ4qPilA6BGetqYUorY=;
        b=CO0xEOyAD2rKgeb4/796CJPJBkWAVoP6kI0NpWWzxKHu8o3a7/zoLHJ59ZtVjDuZHi
         rtfvQmL2lw0ySJ29Pw/xy1/FUa/2EKKv9R/p++JPimaFIKbjJ2tS5udw/5Oni/UsdG6Q
         DRCmjVKc+lGlYymDO3K/dMfjd67hygdN+LilkX303noRZR1MIuPfQFDLPXZiRYpFtlRR
         u/wlaO5/BLrUUbjtmuNRX0vwG32n7nPgMz1NKcSkjFHlbtrFw0GaSdgmOOraP/jJDOIg
         QSUu3WliKijBIB4d7CA3oYo7YGbBf5SWNz5ly7o3q2738fxAeKK4whw6/n64s7JRzQny
         QrIg==
X-Gm-Message-State: AOAM5302ZH6yv7Zgho8FgODKvj+TQpugfNPP7XOFUSEXZjoOVkXNGzDT
        2f8fFFN8Nm+BZYy3EcUaHA4=
X-Google-Smtp-Source: ABdhPJzX+Vh2Egxjq814YfOpUGajTbbALAhbpqH5gqFyQRlGy9nqyUOsvItkj0Gt+6yRJDRCbrF4QA==
X-Received: by 2002:a05:6214:4e5:: with SMTP id cl5mr5723077qvb.42.1606239452550;
        Tue, 24 Nov 2020 09:37:32 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id k70sm13834520qke.46.2020.11.24.09.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:37:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 12:37:09 -0500
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
Subject: Re: [PATCH 12/45] block: remove a superflous check in blkpg_do_ioctl
Message-ID: <X71ExfXNm5IC7xMq@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-13-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:18PM +0100, Christoph Hellwig wrote:
> sector_t is now always a u64, so this check is not needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
