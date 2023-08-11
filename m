Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A04779780
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbjHKTFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjHKTFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:05:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869DE30F2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 12:05:09 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a76d882080so2032817b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691780709; x=1692385509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pcEsTcn+SuNhkMLUeSCuQ8sXknpybV5WhOTYGeQ66kk=;
        b=GouqE1wtiSNd2VDPYzSXDYabK6ZZuVqnse+oyaREUTX1vEIHxzw3JXU8sy106O8h8r
         rnpMw8phgP/YClOZuJjpMco1VT10oqjwDIWzbnqPj70ZD3tbBDpwX+fq6XJEE5wEdOPx
         QjJuSZO1QAoh4BNFy8v7WmHglWi2fyVQgieSvCJQTYEBX8M94FcVupMdjmii7uzhb1+N
         PCnDrpK1CBjSjTQ0w8uVH9MNO5gfSijh5Dq6r7W7lb80R+INHNx9oAEhmCjAGmpudAmM
         G66IhXvfl+SCyy0DzoFwbWTMmlMKJ1K+X6g88co5Ihkmx34/67BiMkqoFGbe8vanNg4T
         sffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691780709; x=1692385509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcEsTcn+SuNhkMLUeSCuQ8sXknpybV5WhOTYGeQ66kk=;
        b=ZiJ223pU8V9gZencDmN4pRqGI+ty+mkQwzq8pg55C/5twzdAPAD+7G9ofrJeJO6mPr
         W0oPNuj2YH/j09yAKwIHM2eag06iP4gGDUOy2zZdlvtb5MZN8JlS+3KHsfLkXRUPW8x4
         DSOVrmOgLvboXzOrkvDUqaCgjQ7Gyh6ZqcdMsWTdAznFhw9IQcYOiNwHeTSMQvkytXBP
         mcnXzk9Ppfi3TJy6dTaPE2AUwjTMcjZV3ivYJV0dy3ntKRaBygbYNQK4z+yQRx50AuYT
         zxWobj0EIl/kFVbX3Qf024QsiWQr8td6TIF3higQzZI5thSv59v2lO55THSBHlnsD0lR
         IMEA==
X-Gm-Message-State: AOJu0YxuRF2HBTmPvkZKo/vrk80aBCnYrD9KUPASJCJDnxQHH9QQrCbk
        p8YpqInQynCdIGhCsZR/fUJ84w==
X-Google-Smtp-Source: AGHT+IHELnDF7HiqdqfbjE1ESPLlwkNJVzceCMXsKsrRJaWJL+rwobZOAgSlRjw7wGzjYOhJLtQejA==
X-Received: by 2002:a05:6808:2099:b0:3a7:a379:63a with SMTP id s25-20020a056808209900b003a7a379063amr4042976oiw.41.1691780708768;
        Fri, 11 Aug 2023 12:05:08 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e23-20020a05620a12d700b00767ceac979asm1373441qkl.42.2023.08.11.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 12:05:08 -0700 (PDT)
Date:   Fri, 11 Aug 2023 15:05:07 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: remove get_super
Message-ID: <20230811190507.GA2791339@perftesting>
References: <20230811100828.1897174-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:11PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series against the VFS vfs.super branch finishes off the work to remove
> get_super and move (almost) all upcalls to use the holder ops.
> 
> The first part is the missing btrfs bits so that all file systems use the
> super_block as holder.
> 
> The second part is various block driver cleanups so that we use proper
> interfaces instead of raw calls to __invalidate_device and fsync_bdev.
> 
> The last part than replaces __invalidate_device and fsync_bdev with upcalls
> to the file system through the holder ops, and finally removes get_super.
> 
> It leaves user_get_super and get_active_super around.  The former is not
> used for upcalls in the traditional sense, but for legacy UAPI that for
> some weird reason take a dev_t argument (ustat) or a block device path
> (quotactl).  get_active_super is only used for calling into the file system
> on freeze and should get a similar treatment, but given that Darrick has
> changes to that code queued up already this will be handled in the next
> merge window.
> 
> A git tree is available here:
> 
>     git://git.infradead.org/users/hch/misc.git remove-get_super
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/remove-get_super

The CI testing didn't show any regressions or lockdep errors related to moving
the device opening around (which is what I was worried about).  If you look at
the status you'll see the subpage compress timed out, that's not you, that's an
existing bug I haven't devoted time to figuring out yet.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
