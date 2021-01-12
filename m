Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA762F3484
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 16:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405461AbhALPqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 10:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405460AbhALPqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:46:22 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E06C061786
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 07:45:42 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id a1so1045784qvd.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 07:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v9l50jqPNoBOOTLDEtZWZwTrEvZOlOYAJ9ghVHd0rtA=;
        b=NYuTYxayVqXR2Jibpi6u25k0LlmKLobt6Xe/hc7/dvwWzLQWOiz+NpPNVP8XRJ2xO9
         8ukghIv7J4SStY3QE9h2pLce7WlLIwKoSN4TnZ/kw/uLmLKrnyL0z8vJ10LqYPDCzqtd
         wEPgltwCf34oaaY1ozeR8/1jQ6rkv0HS3AAfcuQ5TLY9MFlaBw2L/KAMQRVcQHsMRvcU
         U6hPLI/vz8zahWefpld4WdiJNEGhTHMX/OOVAyG79YuvaIpMlKZC2jv1e/RIYrBNAllY
         OIOYBZFbQ5Mowy3M9IXPlST0H9l+aK9LtrJmdXjcNByKdJNWWFLcUOO2L3SWMcJSbPRW
         QfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v9l50jqPNoBOOTLDEtZWZwTrEvZOlOYAJ9ghVHd0rtA=;
        b=SuXyeTr+n9/5xws7+CAnJnaw0HN9j46VhKLle62jkaomrhEoYPIVUA/macvalbsEgl
         /c4+pT5XaYJlCZtxtoUj9IvcI5DFEJWnxLKLMYW7KH6zlw3g5+XTCZw9NP6zwgpASvWp
         X1uH7flTO/fCgvu4gEZzW+mJLWJVhmomG0zKPlyC8znVOq1NB9k0JPXqIElncwciLMSw
         acL2XsZ0EYTj6p2mH2A5awawms1Lr9/ONgbp7jm6Lqo+0RYcpjfSlspXbCs1HGp34QDE
         0Ym54YWSrIHf5Ho182OqxBdAeRfe4HP6eLDB2glevumNy2J78yh2mSp1hmb6z24OSwV7
         vxbA==
X-Gm-Message-State: AOAM532KTsPIEDg8R8YyY/Ig5utOOIisEqmyrVrkROm5tLK7G482I3Lb
        dRkJzj3qf+Uzx99TxjGBEAbwxg==
X-Google-Smtp-Source: ABdhPJwzKrdj+cTDTebTSm7DMvdCXKI/ezX47wSqc55xpADwHqgifQ0BBlSMoJ3q2G90L91+7SxSFw==
X-Received: by 2002:ad4:5a50:: with SMTP id ej16mr5406933qvb.25.1610466341165;
        Tue, 12 Jan 2021 07:45:41 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b65sm1404390qkg.75.2021.01.12.07.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:45:40 -0800 (PST)
Subject: Re: [PATCH v11 13/40] btrfs: track unusable bytes for zones
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <43075f585c6866abcf2b4e000f4481159b39d78a.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b7a41c8d-3c4c-e6c1-c8d1-0d6fc7f7cdf5@toxicpanda.com>
Date:   Tue, 12 Jan 2021 10:45:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <43075f585c6866abcf2b4e000f4481159b39d78a.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> In zoned btrfs a region that was once written then freed is not usable
> until we reset the underlying zone. So we need to distinguish such
> unusable space from usable free space.
> 
> Therefore we need to introduce the "zone_unusable" field  to the block
> group structure, and "bytes_zone_unusable" to the space_info structure to
> track the unusable space.
> 
> Pinned bytes are always reclaimed to the unusable space. But, when an
> allocated region is returned before using e.g., the block group becomes
> read-only between allocation time and reservation time, we can safely
> return the region to the block group. For the situation, this commit
> introduces "btrfs_add_free_space_unused". This behaves the same as
> btrfs_add_free_space() on regular btrfs. On zoned btrfs, it rewinds the
> allocation offset.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
