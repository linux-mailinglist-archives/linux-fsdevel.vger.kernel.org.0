Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC32176EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgGGSjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgGGSjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:39:31 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CE5C061755
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 11:39:31 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e18so26174852ilr.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5xeeSJNl89hdKNZc1p2IwCwGKPk4JGxYiYMtbRQmKxI=;
        b=HR0L6o45VkMPdZEhOiGtgwb0XyoPs1smLQhWsbJoJFM3270Dny+fsvO465OMms0KLl
         cQkrkK2q6o6bnFjMkNwLcvhlO0Hm0ylhjSyQG8eGo44G83CAvKjF5PxmQS2HnI75yPPq
         weVjhbIk7cUu7LM7sH5fIMJPy1/GVyMt+EuIKx3EMB7/VNGeOddk4itL0OYuHjzAWBfn
         zHgXKV6M0ChVIhJB6K8gAqOjuxPxFa1TJfs4kpUDiYgPnhWdWLZyXIYGe6TjiWpJz2XB
         OhcIYCsc2GYpQD/2zTI8sOCbvSuzPMgBmqPKyQ9MwYBdB2EPrMzpPitk++G4wT9utrVB
         cnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5xeeSJNl89hdKNZc1p2IwCwGKPk4JGxYiYMtbRQmKxI=;
        b=Fbltm3NU/mCqkAv+myBXLAOVHbGwPMJmhxV24O1zcZ/ik7UqEdVmSTVxazUXspc1uf
         tZLt7U+rAUc7eBd5yAsDs77JqbHHExa74HcPHV7tUbgv+w8JhMi9iNXH4/qiqc3OLRzg
         FFDopy0NAXMml6xVUxX91Fth9LzI7CCFYC/ki5A4+0N/fQjxKmIH9gb/yH5/xC0RJS7H
         147yKfIny3C9aFHMuscWwRmAhvenmB5sARKET00mD0cKqb19wv2R+Q5bu4dDyHc3IFar
         q3g0qeZIVA19SB9u10pdz6fdVumBvMQMN/EqH02tSTUmdfoaFjvHe+zerYhuGCzIC6By
         zy8w==
X-Gm-Message-State: AOAM531LDEiBBRUtt4E1q9jC8XokZykYNXidM73yVaZIfh+WHS2CbfgZ
        j8F0ZaWLVz3gXfSMqRBVNKrTM0ODHO0Vpg==
X-Google-Smtp-Source: ABdhPJzXMYDY68ecmhBSVS35kxyxucMZrFavc7ZlIavGwuXlLW9FHoAZuz7G2RqaKLRDUCHGnuud7w==
X-Received: by 2002:a92:cd01:: with SMTP id z1mr37863825iln.103.1594147170503;
        Tue, 07 Jul 2020 11:39:30 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w5sm13211479ilm.46.2020.07.07.11.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 11:39:29 -0700 (PDT)
Subject: Re: [RFC v3 1/2] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200707144457.1603400-1-agruenba@redhat.com>
 <20200707144457.1603400-2-agruenba@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e49c5a2b-866f-14ae-9665-284726815bbd@kernel.dk>
Date:   Tue, 7 Jul 2020 12:39:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707144457.1603400-2-agruenba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/7/20 8:44 AM, Andreas Gruenbacher wrote:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3f881a892ea7..1ab2ea19e883 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -315,6 +315,7 @@ enum rw_hint {
>  #define IOCB_SYNC		(1 << 5)
>  #define IOCB_WRITE		(1 << 6)
>  #define IOCB_NOWAIT		(1 << 7)
> +#define IOCB_NOIO		(1 << 8)

Just to make this even more trivial in terms of merge conflicts, could
you do 1 << 9 instead?

-- 
Jens Axboe

