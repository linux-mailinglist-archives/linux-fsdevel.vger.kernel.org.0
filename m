Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB693B6824
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 20:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhF1SQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 14:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhF1SQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:16:10 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851EBC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 11:13:44 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id u8so6425439qvg.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vih7lSeTueBCbjEmdntDrRfbr0j6t6TO5019BI4IVz8=;
        b=BUI3E5FdSxd3eykuWBo+Kh3VHoZZLi4cas8a7XA505tyOYJh10M4yrU3ku5xXb8iTa
         tr+CBwa8dOUPCWI+OLhG5NpFnrmrYIHYjBY6TnC/Fe3SXNtZlnAdSPZ3v2Mi+93dhnK8
         aBeWk+bxvSuUbT/EY6vXwe++ywJU5nswLqvuF8hLsEvH2Tv2NsYyMxSuEggiTaBLf+81
         6x8lCconqx3aNCd733qG+zoUBBhpQQNWNi+FdVeVjcDRlHxjRGnTb+KOl6pqnWWRy35Y
         mo7dJwHw060iU8aJN8mvNthrDRdj7yY1KFgFnzdoyMwyJ6h2keHfLQpUveE3hRGt73Pf
         rteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vih7lSeTueBCbjEmdntDrRfbr0j6t6TO5019BI4IVz8=;
        b=mIYN4KKbVvZEXG1uf4/rmm8Zxjv2E/W7sIvptyK2G6vGRU7PEO4mFJ1W7HwQ0PLsUz
         9tdzUZYhG0nsGlLYRMIWTdEaV1sdrITKr3muTny3ViRSh+emBCnZnzwYeTlymhntQytK
         X8CdEn1oc8ffSMbeir8pNRhFKktYKMW2pwZIbxl3wEh6zLzxDI6ONUFmqr+XYXNIrmxd
         3HHRKVA7M7DuBzCKnEaawEizN8LjK8Bopl7+mZTvEZsPYPGLwvKfHXR69pLp8C35aiiw
         Ez+1+Nr07AzoBdiUmuhzoW7B0f/l8LCVlzaR24jSyNxQOZPsIMbWrsC+3AOK4uU4FSEU
         ETuw==
X-Gm-Message-State: AOAM5330qHJXHQK4pmSVRt+XfqihXqvkk/WX4HPHq6FXQ5JkpUaAOaLl
        gbA4/n+mQ5J8jV5bJta+5v340g==
X-Google-Smtp-Source: ABdhPJzoHxRC7qixtkNunlPX+yGAv8qJ76J2a1Dno9M4Fyatrrdc4dJtQ8JCOK/8bbflfCx4Ndf4zg==
X-Received: by 2002:a0c:fbc7:: with SMTP id n7mr26851932qvp.36.1624904023622;
        Mon, 28 Jun 2021 11:13:43 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z22sm3901173qki.42.2021.06.28.11.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 11:13:43 -0700 (PDT)
Subject: Re: [PATCH 6/6] btrfs: use the filemap_fdatawrite_wbc helper for
 delalloc shrinking
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1624894102.git.josef@toxicpanda.com>
 <2acb56dd851d31d7b5547099821f0cbf6dfb5d29.1624894102.git.josef@toxicpanda.com>
 <YNn90xi1imSwCDr/@infradead.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <435f0d30-9a6d-85fb-6ba9-bbc17517ebcf@toxicpanda.com>
Date:   Mon, 28 Jun 2021 14:13:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNn90xi1imSwCDr/@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/21 12:50 PM, Christoph Hellwig wrote:
> On Mon, Jun 28, 2021 at 11:37:11AM -0400, Josef Bacik wrote:
>> sync_inode() has some holes that can cause problems if we're under heavy
>> ENOSPC pressure.  If there's writeback running on a separate thread
>> sync_inode() will skip writing the inode altogether.  What we really
>> want is to make sure writeback has been started on all the pages to make
>> sure we can see the ordered extents and wait on them if appropriate.
>> Switch to this new helper which will allow us to accomplish this and
>> avoid ENOSPC'ing early.
> 
> The only other exported user of sync_inode is in btrfs as well.  What
> is the difference vs this caller?  Mostly I'd like to kill sync_inode
> to reduce the surface of different hooks into the writeback code, and
> for something externally callable your new filemap_fdatawrite_wbc
> helpers looks nassively preferable of sync_inode /
> writeback_single_inode.
> 

Sounds good, if you don't hate this helper I'll go through and clean up all the 
various helpers.  Thanks,

Josef
