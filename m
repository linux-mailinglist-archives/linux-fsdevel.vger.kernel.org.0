Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541065B0EDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 23:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiIGVH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 17:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiIGVH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:07:26 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D572CC2F94
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 14:07:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c20so11430660qtw.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Sep 2022 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5XFSbTu8JLiaqbe/aaB5H3G6q2+uAR8AZMv3BlQCVkw=;
        b=hAaWh9Hp75G7fMyvoVm+2YeyAMoo/jh/Sj00Sg9ngiZrFj/iyVFFOZZRq3Dl8JCJBg
         gVjEtOwcXK5pgpv8GgXyUKSq87CXj6tAif+k1fYyZSbX/uZYoYjlsbEbf87UId2CmIRa
         ArT7QIeeYfRNxvsHxteZ0nNX7sqmM7wwcc0b5grb4+jZ0eRAy3asuPle285XnAEUHyGo
         fS3aGASz1Pkj0Su5/Yq7FWoLCFLpkaAa2rrLckTpKYzO/lpYX3r5kQJ9Epj5VUgpN6M9
         pwLjgg3OPF3IYA2LsqWwLIm5frSEa68tgiHu2tYeXmZC4qAsdjgCHxmjgOdvBe8/Ql4n
         fPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5XFSbTu8JLiaqbe/aaB5H3G6q2+uAR8AZMv3BlQCVkw=;
        b=k97Qu1A0mSImcYYaUVXSvCRbdtbrNyA/hv8SXnDXR0EejseMvy7F7oX68WcQzwAYN+
         R/yWRKe8yPgiBY2Pkg+yd5Mn3M+oYMDRJMtOpY/u1SDuf7ODgxQnJbigQZdZ2AsNTW7B
         +Tp4TaQ3ykRLK/vYV5+Yy08UsjB1U5jggFKVQjxTm3tFVPlU2XSvXDZNspdhnmfKGh6M
         5jKR3RDMiLQQ9LcDEMv7h5Eh3AmO4wvmBv2UR8+6CZpBDKyKjz3MoPpm5IxTI2T6mnb0
         zE5ngqw82lJA5GPVoNwt3jGey83ooWmNrRW+tK0zTF0orZuEaiCHLmzDLc3uU9XyD6Bj
         8Nfg==
X-Gm-Message-State: ACgBeo1207DVkxKCTJBBEElEQjB7MaMQpgt4oK2EXGoKVogXlFy6DabL
        V4twpjk2LsBZHwnAND1QmiUFndDpmf/zsJDi
X-Google-Smtp-Source: AA6agR5Y+ctVk6tTsu8FtmceqQEVqGmzGqiBK6IB5xxE15uCaH8k9MNkzjPeibjNcwOrOLSiOfXN1A==
X-Received: by 2002:a05:622a:1b9e:b0:344:5627:7afe with SMTP id bp30-20020a05622a1b9e00b0034456277afemr5219357qtb.329.1662584837422;
        Wed, 07 Sep 2022 14:07:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u4-20020a05620a0c4400b006bc1512986esm16634752qki.97.2022.09.07.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:07:16 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:07:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/17] btrfs: remove stripe boundary calculation for
 compressed I/O
Message-ID: <YxkIA8vVgL2jy11c@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-11-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:09AM +0300, Christoph Hellwig wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> Stop looking at the stripe boundary in alloc_compressed_bio() now that
> that btrfs_submit_bio can split bios, open code the now trivial code
> from alloc_compressed_bio() in btrfs_submit_compressed_read and stop
> maintaining the pending_ios count for reads as there is always just
> a single bio now.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> [hch: remove more cruft in btrfs_submit_compressed_read]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
