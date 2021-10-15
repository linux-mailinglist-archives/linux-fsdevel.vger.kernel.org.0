Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164D842F937
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241820AbhJOQ66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 12:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241760AbhJOQ6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:58:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B395C061767
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Oct 2021 09:56:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l6so6752529plh.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Oct 2021 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vfh8ldDPWodO2+NAKgs+77i4cirGVTrsvlhR7sq6n14=;
        b=MF0yf140gbDAdW4BxnOXdsQIbZ1Zs20bgZWJgGQJccJRdMKWf0Z7qJMeg/xUZ/rSs6
         VG3QCkdC2Gak2gGrkvLjpOyqG7g5cIFwioohIVF4DnPVlIrbB81BnizHen6OonQjrvMj
         EAa7kecUI8Ha/nnI/LS4mNOBQr2yiVBjBbg4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vfh8ldDPWodO2+NAKgs+77i4cirGVTrsvlhR7sq6n14=;
        b=xgvGkcCPb6m0QxeZQOf99jcNFk2LT1mzRjICQj3wunWdLDnCiwTapHJyh4yX/W7wDZ
         F4iX0IBA/sz2/n+LWF7ceroIRdXDcZ9Im3S2X9/aUy4odQUBt4dZkllpTqrnmxrP7QOV
         pCVkgd3yM4oeBv2SG3yrInlLTktic+jG1Td6H2EqGKFCIrSlVa2XPEuLjlyLEAtBJk7R
         iuoFF9ICDE0PzaqOxlTWRnXwtsy9pVaurOR0DPXKx0B8lpb5rpQUFd8JnnDgcRuAQ4cZ
         CgN6M0t+fsgI9j1pwtO5SaP3MMyY8OHZsw/gwrESE0WqfIYjrz5910IpLc1+/1qrqmtp
         8gxA==
X-Gm-Message-State: AOAM533+x893E4zfo6PdR4Y18Ftu+Mc96zHv82S07W8f+nlkKybxtOj+
        XnoLA9jgT6BSspGpc/GojzvS/A==
X-Google-Smtp-Source: ABdhPJwnnQ3ulrXVGFg4s+UA3ddGM8HwmAEnk5XYfNq6HtGw+i5b3OvChqf29ta/Idk60aluKwm2lg==
X-Received: by 2002:a17:903:18d:b0:13e:f1ef:d80c with SMTP id z13-20020a170903018d00b0013ef1efd80cmr11974419plg.63.1634317008672;
        Fri, 15 Oct 2021 09:56:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t125sm5518370pfc.119.2021.10.15.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:56:48 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:56:47 -0700
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
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 22/30] reiserfs: use bdev_nr_bytes instead of open coding
 it
Message-ID: <202110150956.A0360E2D01@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-23-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 03:26:35PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size and remove two
> cargo culted checks that can't be false.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
