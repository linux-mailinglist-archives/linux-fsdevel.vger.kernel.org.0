Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE0134642C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 16:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhCWP7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 11:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhCWP6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:58:55 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52DDC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 08:58:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e8so18209846iok.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NO3WLs2vlBKiTCA7DRRz2cdPr87od0vVxyebRQ/JakY=;
        b=f3vd+CopGTvevG8pEPkv8DeH4ALqoBzv+RVf1kXcnba6/+sTCctXQaaEajrj65fhwt
         YXE+hqZsMzbd7Yxmx5VTJjZTE06KKiIvUiQHe+w6iWx6OMzp5AvvHRYthPBm9WZ9HaQ3
         eysHTBCuabELRxnBPUwc/voVKA+FVDO5TF2zBD8Vj8x+JdV8Aso8ZoAoRsA07BE2uxYh
         zvqKXXFOa5DiqI8/G1tdpKKmpAVGz/8RHhBbnJ2sQW+05MzkqADVLsR3qGRmP2yBZzPz
         DLHy4U+rDB/Ou+AD70UYuLc/4YAWm2UpYr2c59+dQ+8q7LRjYC5BwEMIjs6r/UWzZCM5
         fL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NO3WLs2vlBKiTCA7DRRz2cdPr87od0vVxyebRQ/JakY=;
        b=fKrLO9KFWPQeGjI8SES8bjYvdOYQIpu6odIwofekE9OkjMTFyZ3z6ddLDuB/12U83O
         drrP4JR7bzCHnoUk58Fp6rB/+bQH5SuveW+P3g8fQwbCRdWwyR+4xuwCQ/QtnIzaB857
         MPLXGNL3DWtg3/kMV1fdcJ1JI/Cl4Et++z1RY2qdaItiG0lmM5uXmf0+gIfZEasOPxEk
         N5V/tGmbu66dSau/avpn84ymUr3zNcpF13C7xRa1qcOwvTywguK21i6YxNppxxcCTvcZ
         TBsL+7oFu3NdgnLK9ts6O3QmcoqTo/gZ30NQf5YM5onkgFfw27V8kYzCOldi+f32/NGR
         2W3A==
X-Gm-Message-State: AOAM533fTHBXPA7WRhmNwqXbVgm7zTWpO9OeInT77oot5WHtJcAH9mQL
        B4Vy/5sFLh2pEtHEp7yCj1S9c+2Fn75g0A==
X-Google-Smtp-Source: ABdhPJwfcaCYU4OYAne4TbFTL8+80cuww4d05IMpb+sAobc+HNYDfnEuWSXybld8Ezbi8ZjwEU4QvA==
X-Received: by 2002:a05:6638:f11:: with SMTP id h17mr5233398jas.67.1616515135123;
        Tue, 23 Mar 2021 08:58:55 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n7sm9895823ile.12.2021.03.23.08.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 08:58:54 -0700 (PDT)
Subject: Re: [PATCH] block: clear GD_NEED_PART_SCAN later in bdev_disk_changed
To:     chris.chiu@canonical.com, viro@zeniv.linux.org.uk, hch@lst.de
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210323085219.24428-1-chris.chiu@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0ec65a30-741d-9f22-e90b-1f72f68b4346@kernel.dk>
Date:   Tue, 23 Mar 2021 09:58:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323085219.24428-1-chris.chiu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/23/21 2:52 AM, chris.chiu@canonical.com wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
> 
> The GD_NEED_PART_SCAN is set by bdev_check_media_change to initiate
> a partition scan while removing a block device. It should be cleared
> after blk_drop_paritions because blk_drop_paritions could return
> -EBUSY and then the consequence __blkdev_get has no chance to do
> delete_partition if GD_NEED_PART_SCAN already cleared.
> 
> It causes some problems on some card readers. Ex. Realtek card
> reader 0bda:0328 and 0bda:0158. The device node of the partition
> will not disappear after the memory card removed. Thus the user
> applications can not update the device mapping correctly.

Applied, thanks.

-- 
Jens Axboe

