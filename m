Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576C62A34FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgKBUOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBUOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:14:24 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74913C061A04
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 12:14:24 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id r8so10087368qtp.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 12:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dj3PuGQa0yzTEIvonvX5sUkx/3V+DauHEezndzkVd2A=;
        b=U1vW8YaNWJW2C3MNWgf8A9XinH7Kh9aRO0BsL0SehT+1ZC2STgW0kgq/lluRMbBJx1
         jcLpRrDv7s0oe6NRMD+G1Slqn+T4aYTQyeyOdTTGbDSlTjM1605xoaJRGO4+dXU46KXm
         G+i1megTTVpfGQxoANaEPwx/yfixPSe2oCughm4Yl6s9BcEm7f4SJrTxcTPgco4RoBaC
         azRTXDEYYis4ArRCnOldsEnR1l+i0ldSz90D3RdcFfEFvOmmixKqwj1XUPz0bQ6hLSzi
         XzQi6r/T9/yH5U7FFHVi6vw0dpjH1k8rVBbotOvWvccyus2ocGqo48WuOcun0Zl4piOT
         RcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dj3PuGQa0yzTEIvonvX5sUkx/3V+DauHEezndzkVd2A=;
        b=guHbMgXy069kwnDTbZbXS12YkcL3V7zDpqS27VUcAgkOWZ2I888Z89pc9tkuLzRLS9
         oKWC05jXIk2T29//cUbEpPOybrZ4w6HD2M2rwYF5XpfLG9CcTkLu12Ku55r7rOxekEBz
         4QZ4XkRxtg1F54WS5EkD7wtQZr0/7HnVXS1LVnGXZpPSfskyOl87yOfn3jipSrtSTjIv
         tGrkVwWUWZCVUUD07ykRNPWkg0FXlg7hVm7takSYv39Q94p4Le4qCvQ5SoWrPoOWIf1U
         6lxixPZyj0rs6k++IOOvj+KpA7blixl+AFJSpnvG+vWC1bOGvkTWy0k3eegiB6NI+QFv
         LMfg==
X-Gm-Message-State: AOAM5307Piwv6UGCMTHQISPaIV1leFGoTOL/2RM4K0HPt/aR6bqmx+69
        Gvsq32z3u8/vcSgaNKdayCFnpA9xi/4w1MOY
X-Google-Smtp-Source: ABdhPJyJV6SpOGenrL5yOXdAnqDj5Z95e3ZEPaMHFdJ7gdJ81PVSq24YaONM7R2uHgARP6BCFWrquQ==
X-Received: by 2002:ac8:35a9:: with SMTP id k38mr13235862qtb.241.1604348063463;
        Mon, 02 Nov 2020 12:14:23 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x31sm3476186qtb.81.2020.11.02.12.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 12:14:22 -0800 (PST)
Subject: Re: [PATCH v9 13/41] btrfs: verify device extent is aligned to zone
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <6d9191ed858e0a0283a8d52fefa538896d8d125b.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <19180a79-fa69-396a-fb41-105ca211bd95@toxicpanda.com>
Date:   Mon, 2 Nov 2020 15:14:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <6d9191ed858e0a0283a8d52fefa538896d8d125b.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> Add a check in verify_one_dev_extent() to check if a device extent on a
> zoned block device is aligned to the respective zone boundary.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
