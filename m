Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E572C2ECC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 18:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403887AbgKXRiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 12:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403879AbgKXRiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:38:05 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A672C0613D6;
        Tue, 24 Nov 2020 09:38:05 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id y197so21480711qkb.7;
        Tue, 24 Nov 2020 09:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E5yu6Z9CIGvjjdSWaM1JDiBNwd7R7l70HZvgJTMOMAo=;
        b=bP/UrEJdRXtdgl6ivVFuNIsepdmdiobKpEaoQqAkqVcxh4oLhWjED34HU2CgSOcS0r
         u8nX3lWOcITugT41Gz5ogHCeG5HvCzBWSnlVt6HFT/XLqvXGgBQUlkC2CFe4rQZ6Jdgz
         Xlh808EEDi3JUpO3tYkyT+AsuwhV2f7GO2Y1rVQbOYvLQXrbYCZEOEXyaM/QNly3oWKd
         nMDmSodcBiZ4nkTVRK5MN+HlnZkSvenRe7tY//FCQ2HZJpqhNw22PuiG5Df4AdGG0TX6
         9RHtJd4eQvkljDEZVlwbW5qc2pplOC6tGot90vCLquU/Y2qjjEP022211N4bqrY0nZQk
         Cpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=E5yu6Z9CIGvjjdSWaM1JDiBNwd7R7l70HZvgJTMOMAo=;
        b=oYq6AhPsufnp06vV80pzXLLC9vlj0gobrkXX2UoD3C7t2zVIXxH6fZ4NZrXgXwmZ/y
         0b9vdYy8+HDBeHxdTq2C7/Z/gyY6O92vYGUmso/STx7T5ypWVXnqL/Jq1bxe/K/LiMXv
         lrV66axFpStBalVPOL9rof6xLNR0ewBBaENZqzXORnRlizCv8YwlaSOZ6ewnfI3UBjDG
         BlJLo57vC8jL3+MeCseFSUUZgBaEPIo6fSmg5/uqmys2h5I+hr4yAbqyJSTHm0V+MuY6
         3CcVJGIduwq/1FsN3tpZrja+YQSbyv1R98hNa7NCcg5m4HykBEwgbkcK/LKC/2ia0Xgi
         2KqQ==
X-Gm-Message-State: AOAM532GN29dBY9ufYQZFcTOmpLqqfWVNoXQY/VTKEqzLHPN1X+U4NRS
        eCPrETi0zYxEhZmtjA4U23A=
X-Google-Smtp-Source: ABdhPJyi1T8dRX2wY3q65x2J+bQePuJjN+c8Pa1HrFeBbFFSDxXqbhzlU09MTDkUoIjmr+Nu4Id3fQ==
X-Received: by 2002:a37:7bc7:: with SMTP id w190mr5863735qkc.476.1606239484751;
        Tue, 24 Nov 2020 09:38:04 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id i4sm12549778qti.78.2020.11.24.09.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:38:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 24 Nov 2020 12:37:42 -0500
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
Subject: Re: [PATCH 14/45] block: use disk_part_iter_exit in
 disk_part_iter_next
Message-ID: <X71E5ohZ7I/tDKWO@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124132751.3747337-15-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:27:20PM +0100, Christoph Hellwig wrote:
> Call disk_part_iter_exit in disk_part_iter_next instead of duplicating
> the functionality.

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
