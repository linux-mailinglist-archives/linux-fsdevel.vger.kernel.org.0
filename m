Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D3F300665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 16:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbhAVO74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 09:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbhAVO7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:59:19 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139F1C061788
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 06:58:39 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id o18so4235250qtp.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 06:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JfS63BrlD3fqxyGJ1urVct8jThdv0sGpJeVtrag2vXY=;
        b=lYTKnhEfX5TvwgEsEMpMJKyNBczgOugVBJRmD5fJvhFDctHPcBH/zRztsacSElU2HT
         6nohYEPihXtOSjSN6DYlaGLQlVqXaEnv32lTb/Tl+QE2q4+qMqt77ybz6bXQye8Nr+Hc
         lQqRXJfEDBxAXjq9pxhqx9TpP7eiU/HaVROdSjpVsdhCxSK5ndiAZzQN7GBIc57zq27/
         CUoK/lTnPwOIdDoK8hXc+m7fD64W+IoxYwkDDg/twBc6WPnu6bmkyZblD/B2FC9BYiGM
         Abmf54lpHCt98lpQ8gbrF1mnrmaVy6kuE7oWl8I9ybXm4/rPRBTTxtyRhHO7E7n9Y0fe
         Cdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JfS63BrlD3fqxyGJ1urVct8jThdv0sGpJeVtrag2vXY=;
        b=NVXlUDc4MC5spBTiSsbEuul+mOe8vGz+Nel2b4rHHQ0E4+AElvdqj2Yf2nGR2laZWd
         4On//EaSnJUy4KtxFrz+E7HU+lI+EoKN1qBXfcdrvhMmYhIf1KlcJ4IyASa9lcVbACL+
         jfYAsKQZT5TomLoUKPhKPcMxy3bee3932gUBzE05iTvHfUPzatPwrVr48LXvfz116aGv
         UX8CLdKWoaSoWxlqHOSsdb7oHGXzLDhOcP7bLdruy1TJBPLCVMqUDurYBVbjABfxANkI
         ZAfrR4b7UaM6TmjpMjX/bF+EuRJWR0ymmH9DFLyVDjmvoTtszcM7taDzFSLnKVJBQ7zt
         YEpg==
X-Gm-Message-State: AOAM5320mrMXhs18yKSkYGTcbg/2/KdK6fgiwpX+dJjrTzLiv6LvsuQ7
        zsJXIxalAZPpLunoROs0nHotXA==
X-Google-Smtp-Source: ABdhPJze7P5apS4AZQz3XVD/zykxmAO5BBoyyAC7gr4In/AuiDP1AWGLuUHoD2wpJIPcIpe3n3jaoA==
X-Received: by 2002:a05:622a:201:: with SMTP id b1mr4467398qtx.237.1611327518225;
        Fri, 22 Jan 2021 06:58:38 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i65sm6573646qkf.105.2021.01.22.06.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 06:58:37 -0800 (PST)
Subject: Re: [PATCH v13 06/42] btrfs: do not load fs_info->zoned from incompat
 flag
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <44c5468ccdca173216967582abde007af9c3cc9e.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <12b056ae-2bf0-9d15-6e04-db254d32ff1f@toxicpanda.com>
Date:   Fri, 22 Jan 2021 09:58:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <44c5468ccdca173216967582abde007af9c3cc9e.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Don't set the zoned flag in fs_info when encountering the
> BTRFS_FEATURE_INCOMPAT_ZONED on mount. The zoned flag in fs_info is in a
> union together with the zone_size, so setting it too early will result in
> setting an incorrect zone_size as well.
> 
> Once the correct zone_size is read from the device, we can rely on the
> zoned flag in fs_info as well to determine if the filesystem is running in
> zoned mode.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
