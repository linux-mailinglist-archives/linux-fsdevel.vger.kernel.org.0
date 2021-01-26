Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F84430436A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 17:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404150AbhAZQJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 11:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405368AbhAZQJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:09:35 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4540C0617A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 08:08:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id my11so1486772pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 08:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+ytHGj9hzjS8tWbRn01Y3t8CKTtCDlaSytsLpHNKwbM=;
        b=Vd2md71v7UpRSlhov2sIisYE9OegPw+XGGG5pPcf4yiO8AhUG774popHL15Nvu+FKl
         NTd1hxr9xyo3aMxPYQAE10FkeMCJw+yLQguR4nLzDaHKlI/4uLt09Jbvta6nP41rQ7xs
         1+tkZogN4mSJWBx7++Aw3eNqj51ZApxSgcGwGCAlsUlTHs1EHz8BTs8yAwKRUt0GXQ1/
         fSJC4u7v/3isT7uE+fov07wnaGxUF5id0oD87R87r0wH0/g4AN3S8V6Rm/rypjkUHS0F
         NI6MtAJ7Pr4N1pUcdg1vK+db64f2WpObUx/e4RRJriu+LgUJ29399ZZvqEuUiPkhNy6P
         fsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ytHGj9hzjS8tWbRn01Y3t8CKTtCDlaSytsLpHNKwbM=;
        b=rBB+tPoUn3TPSPiAugHXOGPBMgkCNfjaEFFuGBOGS+4SD1rcl8lgHFQd/nZWbXw6ph
         vTdNIkw9l3t1SE5vhGGrzMSeCKuqLllsWhkotBleVrwdYD8CpNmSFm9iXosmKAq2EZci
         BVJr270jn3okxqIYkHRAnF++WkLwMcqEs/fseYM6VldXbH/xOMgZTOKg+fy37SC5SuVW
         8CeCJBR8SqXn3Wx6II5G1RIDYKL+xlMpf7NsUHoo6OtYKLlcRTf6XpmhQdZSS/EJzve8
         Q4+WFH9S7xgsivweEw92VwuunibgdaF3kDUp8jhZOWsZHIq2Qrj/EYH46qH5H1zUDzIv
         LAow==
X-Gm-Message-State: AOAM532SZD+z1+tYjFVowDQmxLXw1npODVmKYwrdW3ZoCGD+HpKpdmPK
        x+yE12jeAxHg2M6+T6tibwTfZA==
X-Google-Smtp-Source: ABdhPJwEuawRRfmqCWi93Yj0FkaBVsdird1qnJATUzz+mNNqCoNeMRWgAucnuNcSGjZ6c7cuqMbwvA==
X-Received: by 2002:a17:90a:ea14:: with SMTP id w20mr533116pjy.72.1611677329299;
        Tue, 26 Jan 2021 08:08:49 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id q141sm9561950pfc.24.2021.01.26.08.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 08:08:48 -0800 (PST)
Subject: Re: [PATCH v14 01/42] block: add bio_add_zone_append_page
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <2a0a587139de5586a2c563e4d43060b9abcbf1ed.1611627788.git.naohiro.aota@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5dfb8ad5-50cd-7057-2b64-37465b7279cb@kernel.dk>
Date:   Tue, 26 Jan 2021 09:08:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2a0a587139de5586a2c563e4d43060b9abcbf1ed.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/25/21 7:24 PM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which
> is intended to be used by file systems that directly add pages to a bio
> instead of using bio_iov_iter_get_pages().
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Acked-by: Jens Axboe <axboe@kernel.dk>

assuming you want to carry this with the patchset.

-- 
Jens Axboe

