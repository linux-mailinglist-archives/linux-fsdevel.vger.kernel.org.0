Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2342A57F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 22:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbgKCUt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 15:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbgKCUt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:49:57 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04C6C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 12:49:56 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id s14so16471990qkg.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 12:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uDcRoDkLiE73WEi7gWpkshjuXCB6xBChgrb/c6z9g4k=;
        b=1l8JPLPlkIJiVCZRnyk9DEgw+1bSioCWeESQ/4tIT01VUE6v58efsJE1jAwLLjJV5o
         jHeYDyeqAsXEhEjF5yEVOb1uns49QBFO2jE/DX5TkfJpAMlSUxFAGRVbSCeVP7wiBjtA
         dXxc1Lh7Qg2ZRF/Evk9/abC7l+27nQmiU1TiwV9O/wxAwrAnOWZ1ve1FZXzpF+XA7U3Z
         oRBRKs2RBnfCR10rMkkrMBd+Ibza3hAWbdvsUOvB6X5Ys66OlcadSZJUfa8j54fhVIbZ
         6cID41znREcKPA7fiGUZWIdNMSJXBKQl8GlmCFDIribaGpZGjvD0qRWuYlEsIxoZ6F44
         aS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uDcRoDkLiE73WEi7gWpkshjuXCB6xBChgrb/c6z9g4k=;
        b=gELa1zvgGzFpNHuU1TzHWCPanir8ndATDO4JmMgtsLmPDwOIaT4N6mn/jrtarI9ajY
         khAKTL2RpqtxTK3GoPZFTuPgHWpLucewKibQv8k5Ej/EmAJqyFccigW2w+jLTa2tG697
         Zb0utmlVGAKidZvKGp5+BaiAbcU13UWdiCtJLtOJFNEmfLcyGipM/jJdKCYSvOrZxfrD
         E8OMn4REpAmWNlYXfmkQJlVka5sQq340ERauNvjy6SzNFbxyRAu+tNd/2hd6d40u8UUH
         C62Sb5vuRRG1y31s/QygI4W/gw4DjN0QSSaWi4No32JEg3qBczZ9b2VUvunv/QnDU3a5
         VmNA==
X-Gm-Message-State: AOAM530qVRWrSuWIVYwMxVJONq0COMIPaOEYgT/nHvbX4oj7IThi0frq
        KsNNsy+d18ab2edgqFHOVRuMcQ==
X-Google-Smtp-Source: ABdhPJx0kW1gc4bcDHipnKtoga65ixPAWTUqMbLn0qkMGYm3RPkfaInTiGdHeHrtUZxaM4JN2XKgVw==
X-Received: by 2002:a37:a9d2:: with SMTP id s201mr21734008qke.501.1604436596109;
        Tue, 03 Nov 2020 12:49:56 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e28sm6251979qka.73.2020.11.03.12.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 12:49:55 -0800 (PST)
Subject: Re: [PATCH v9 40/41] btrfs: reorder log node allocation
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <ea3f5bdd11553b1ba3864f25c42d0943eb97b139.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bfa5978e-0688-edaf-4014-1b7b3fdd3bf6@toxicpanda.com>
Date:   Tue, 3 Nov 2020 15:49:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <ea3f5bdd11553b1ba3864f25c42d0943eb97b139.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This is the 3/3 patch to enable tree-log on ZONED mode.
> 
> The allocation order of nodes of "fs_info->log_root_tree" and nodes of
> "root->log_root" is not the same as the writing order of them. So, the
> writing causes unaligned write errors.
> 
> This patch reorders the allocation of them by delaying allocation of the
> root node of "fs_info->log_root_tree," so that the node buffers can go out
> sequentially to devices.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

If you keep the tree log stuff, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
