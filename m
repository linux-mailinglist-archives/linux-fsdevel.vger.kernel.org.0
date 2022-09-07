Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447395B0F06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 23:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiIGVRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 17:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiIGVRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:17:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6D79A6E
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 14:17:21 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id m5so11498582qkk.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Sep 2022 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wlbYT4g/i1s7x7g2nKFCgX1XT2I9wFkMIk2KMBdguIQ=;
        b=iVaYbd6O4QTDogZP46oKns26mhO1DYRueB11OAt9U0BT9Dbd3KplizaW+BUwzL6CZt
         GZPwWmg0B4abZt3iFuxv4tRE23aQAm/3yLf4EkrERTRLpLICO210iF99+blmP7zJAEBx
         UWiypDt8ITMja8YOBhX0Aa0tFgt1PtvnATi9DtrSV2OuqQp80E7OiYNPpLtHX/4ZmLA1
         PB69T5Qp4OcYujGk2OoedW9rGDZk2CoH/qxTtzQHHJCktQdEqjE3eB65b9AIm2FKQrCK
         cz0XxxJ84LCBw1CJUW6692WBWQjUfwiygwyMbkQqlLGn5E/NMJmJuBKM2wZeEg8WoRwS
         iHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wlbYT4g/i1s7x7g2nKFCgX1XT2I9wFkMIk2KMBdguIQ=;
        b=ZsxmrpIeOalNwrVagVHorYW1ZJzrcUwbw5cLq2nL6oHmdPSEgyK46ocGpFeR+l5fB6
         F29vgvNKct+UrNa97OhVfynEGY8xdl9SL6QnqeDs8Oxj0NB8ETzb2XA2Mons76F/bRWs
         hIkc5InitMU1oNztoH2pOOHp9wTqsnQ5V6NUxwZyDWqNGxSaoBKfQy0YGeio3xfQNUN7
         Zv70X0/g/RPJ7jj6D51CT2TUmjEzcYjuGevQdSGVFO/A4+7bIHff10XX1PG3d/J9o6lD
         Q8fVv7/aCz04lgB71URpUy6nlGmRTyHLJ71DEzS0lgojB67eQyW4NLETv+nmkwRr+Nod
         dr0A==
X-Gm-Message-State: ACgBeo0NOhbDC3IQcTrGVED9HSU3hb56SqAdxGdGhqgZCEM9gLRdAHuA
        9ZJ8x1Q7lo3FFY9QxMP5FmNTAA==
X-Google-Smtp-Source: AA6agR6ovkqf93+nQzPH17gK8EoWayRf7zthEgRDQrCgEOzBVnvj2o5aM3MNB4pidxyBSZ5kdJ+PEA==
X-Received: by 2002:a05:620a:284c:b0:6b8:6e70:cd95 with SMTP id h12-20020a05620a284c00b006b86e70cd95mr4139852qkp.247.1662585440762;
        Wed, 07 Sep 2022 14:17:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id ay39-20020a05620a17a700b006a65c58db99sm14514653qkb.64.2022.09.07.14.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:17:20 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:17:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Message-ID: <YxkKXrY2lmH+l3Zl@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-17-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:15AM +0300, Christoph Hellwig wrote:
> The current btrfs zoned device support is a little cumbersome in the data
> I/O path as it requires the callers to not support more I/O than the
> supported ZONE_APPEND size by the underlying device.  This leads to a lot
> of extra accounting.  Instead change btrfs_submit_bio so that it can take
> write bios of arbitrary size and form from the upper layers, and just
> split them internally to the ZONE_APPEND queue limits.  Then remove all
> the upper layer warts catering to limited write sized on zoned devices,
> including the extra refcount in the compressed_bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

tho I'd trust the zoned guys reviews over mine here.  Thanks,

Josef
