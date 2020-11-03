Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000592A4A6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgKCP4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgKCP4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:56:20 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98793C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 07:56:18 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id o205so8283703qke.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 07:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xGV2UNYb0nI/lzfyIBqhDfDZls5ahyQVBs0FRsMVQ6w=;
        b=Cil/lDqC8gmenkjZVcPnN0r3vvbX3wFYuYjrI7qBNzbvTIWmCztOeiai7/EaE5kMuq
         im3uWonFZewRHEZl6LqQ9oEinyHnHukCC0JlzczQaDy6dmPR79DGJg3IuFrYGHnE0mPj
         xmDKS6TTAdGI166bSJVtzAeM6qjpSR/8vqMeIrxAZKzTAqnP227XGNMZpRN+HTsgp/Ui
         bV3taVhd9w5mQcOdsqe3wAtTKMxHbByRi3Kr5WvomMINeAaLpEW12msEK2Y5BrHR2Gob
         Ui6HI/KcbDusIQ1tiO5kE10P24uLfrsiCo0MPzgvHa9WPUywbkX2p69KTkKpzkUSKJe4
         WDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xGV2UNYb0nI/lzfyIBqhDfDZls5ahyQVBs0FRsMVQ6w=;
        b=J8y+2MVMZrsLBHxtDqDe9cTajy/ZzV8dowmV6bKI+L53pWAp40Ec1XEn5F9hJpqS2w
         +FuYflh9DulpWH+RMgnc8dDtowlsXAwZRCjZzmgI2QIVpkqtxugbeDHC4PCx2Vj51msn
         Y/CcMG66PlH5es7A8lmfOs4wdpkZORIvaqZgVVbr3f2VS00aO7lSnl7Ky/o8B6GQwGpX
         aSMa61VS5f4KRQbFfDbqp47o8KsrWQnjmg1a+b34YF1SxJcP21zZxdlJd4BESqzVnyHG
         JCGY/d2w/mqdIKufCOV+MoBFxE9PqAGX6nwHbh0dHefWl9DQ6WZLojk+3H3aIOsmddPi
         Bijw==
X-Gm-Message-State: AOAM532zsR2GNgG2jXCl8GJ/1jhlPG0OO8zEWQ09HhmLAfO9U257adlj
        Kba+EH8U/Nywg89IvV4lx2rWKYt0aOscRLcO
X-Google-Smtp-Source: ABdhPJz2tCfnmaWvCRHtn9QfwqupXuyQHIN8ljpud/EsSVOsCkKzseHB0/Ie+Aspr8e4Oum5jW3ifA==
X-Received: by 2002:a37:b484:: with SMTP id d126mr20102017qkf.385.1604418977493;
        Tue, 03 Nov 2020 07:56:17 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 129sm10795277qkf.62.2020.11.03.07.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 07:56:16 -0800 (PST)
Subject: Re: [PATCH v9 26/41] btrfs: enable zone append writing for direct IO
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <0ac6b4d4630d97838ea6532ba81c8ebf1cfaffd3.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bd1decc5-acfe-f698-26a7-a006e04cdc4c@toxicpanda.com>
Date:   Tue, 3 Nov 2020 10:56:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <0ac6b4d4630d97838ea6532ba81c8ebf1cfaffd3.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> Likewise to buffered IO, enable zone append writing for direct IO when its
> used on a zoned block device.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
