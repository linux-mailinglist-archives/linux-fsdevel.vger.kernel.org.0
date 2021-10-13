Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF1942B765
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 08:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbhJMGf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 02:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbhJMGfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:35:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9789AC061765
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 23:33:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id g9so1098172plo.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KN0hCxg4qCtDzIgJk5dwSpisgOtLaF48lTZLQMzdZGQ=;
        b=ZSgj9MSpSxiaNFjR5pl+MhsOPNs6TAo40lkstJ1+NMBhxL+4AoJC++ueHgXgDZsxkL
         A4rqeGya73qL9mbxIoCLhchn4/FA1cf285nRCQSnbarbdqSIQhxR7IZtW3h248WE8YVx
         CokTYsr+EOLC9mMcAUh/RiJhbXXJcMY50cpmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KN0hCxg4qCtDzIgJk5dwSpisgOtLaF48lTZLQMzdZGQ=;
        b=tj8qzWuR1l+8rbCqSgEff0Wz3BTr4FOiWO4fJrLK3rzTSmgHe5hRcjZafxIbMV+y5R
         arlkEDgVTJ6NkfnhQEHyqd5ElSZ0RRgslq1Gdmo4uhzXepy6pSawqY0QuRZonaXL1ejP
         kjPSAnXc7/pP2sJRkXchK+N3CMpdjeXFHpJ/HZ+0VtdKpZXCvn7yJ8C8hH0Oqn7tjTbG
         3pQ0455dz3k1emqNrqZZaFqhcUsvWBdVrcwaKVp3e6HyuNMWtFEdUHxO34Vgt8GD0MDf
         QURBa4RuTN0axjs9jSzCqhB07SPCBGLuFv8PVxGVZHyCHzUKTiO1/6bWvOcK69l4LH0P
         szrQ==
X-Gm-Message-State: AOAM530NnSyULMqYah+RRqpZEZ3dzR6EwDjQXF7u5QFqAZ2GR5vUmUXH
        Ts5NDc0xmx07aaWmhDtGLSRmQw==
X-Google-Smtp-Source: ABdhPJwSbdMnxpZNPs6DEcJzD+WCYFHCQcM73CXxNLIwDuWek8lOvAv7bQAbdyDz750VOQBh4gVb4A==
X-Received: by 2002:a17:902:e5d2:b0:13f:21c1:b44f with SMTP id u18-20020a170902e5d200b0013f21c1b44fmr23591611plf.30.1634106800893;
        Tue, 12 Oct 2021 23:33:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s8sm8887899pfh.186.2021.10.12.23.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:33:20 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:33:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 28/29] reiserfs: use sb_bdev_nr_blocks
Message-ID: <202110122333.7CE920EB9@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-29-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:41AM +0200, Christoph Hellwig wrote:
> Use the sb_bdev_nr_blocks helper instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
