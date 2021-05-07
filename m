Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C9B376763
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhEGPAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 11:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbhEGPAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 11:00:20 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18624C0613ED
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 May 2021 07:59:21 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z24so8222270ioi.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZI0bcFPJ2tB9w0Gpmkj9hW2yBs41/ZZ7AdB8tXpcJ6E=;
        b=1sF8kkl0oiBEzdziAi6zItCMjm0zTh9wN2VDqE3XA+oy/ZFRwHwQ1SMnlhm8UYR1BY
         mUNZPoVTSP42VaTmvh+wrrQwB6gvCxUv85siGvP4/LbRpqZt7/iUq2Cj8Tng2qAJZmVj
         W2NCtStma6SAZFxxAP8SfxMgRU80Y3UjFtylrgL8C7MLlsnKCe2sreef0d9ovm10ggEj
         7Lf1FnuAGpxXLidRqqWUxBj8iVGUcrvx5fw4Z/y5r31aSfizch7vQMN2q0bCWP9cnin3
         Drxq/TZ0D6S+7y638G0hlRoaakWyORwVnCyQ7KSw5XMdWCEOWoymucVwdW9Hiebh3IY4
         E6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZI0bcFPJ2tB9w0Gpmkj9hW2yBs41/ZZ7AdB8tXpcJ6E=;
        b=aUMa9US04eTIOsn05JLfj5VCTBulwUF37/QY8wS179M0a7PPiNhbxDhpdVi0uvdSuK
         ynHK0j/G0sE2mNm6oSDJT2rJoOjFSKrq2x3ZEb/bJ+EouRgv4be0r7BpPiC5dhYeajvZ
         Wc1WvUB4sQZ/CKtvALfVOeihbsBRTuyL6M0+LeL5TZz7pac4RBs6ABhcVvTmf5JwgldL
         KCQP5xFYW6ygsT2nOx2fLxfIYbBXquevkvRT5J9jfx4wt0mNpEE4oTFAcxTz+M5+6gda
         C8gzoYiu8Mw09Yet0yy8qgXTw3TEUVkviIzDNHH7Zagnvw+ZPQeuSrXYm//J0sIzqsFN
         7QOA==
X-Gm-Message-State: AOAM533WPV6HF2ZFesG7Qv/puqxzDyIXTj00xBnjyniQCLAk53xQFyiP
        bvUF2+4ADoW/3px6JNV6cKivgw==
X-Google-Smtp-Source: ABdhPJxijx6e3v21+945OHqw2INCZe53gErjSGMh4PgWqDOnfDVdO5PyS6Vqvc1VA2KnWBEbkt753g==
X-Received: by 2002:a6b:7901:: with SMTP id i1mr7999861iop.41.1620399560342;
        Fri, 07 May 2021 07:59:20 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q3sm1595752ils.61.2021.05.07.07.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 07:59:19 -0700 (PDT)
Subject: Re: [PATCH] block: reexpand iov_iter after read/write
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        yangerkun <yangerkun@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20210401071807.3328235-1-yangerkun@huawei.com>
 <a2e97190-936d-ebe0-2adc-748328076f31@gmail.com>
 <7ff7d1b7-8b6d-a684-1740-6a62565f77b6@gmail.com>
 <3368729f-e61d-d4b6-f2ae-e17ebe59280e@gmail.com>
 <3d6904c0-9719-8569-2ae8-dd9694da046b@huawei.com>
 <05803db5-c6de-e115-3db2-476454b20668@gmail.com>
 <YIwVzWEU97BylYK1@zeniv-ca.linux.org.uk>
 <2ee68ca3-e466-24d4-3766-8c627d94d71e@kernel.dk>
 <YJQ7jf7Twxexx31T@zeniv-ca.linux.org.uk>
 <b4fe4a3d-06ab-31e3-e1a2-46c23307b32a@kernel.dk>
 <YJRa4gQSWl3/eMXV@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9c83335a-dbd4-dde7-ca6a-14ed5d7a6fc1@kernel.dk>
Date:   Fri, 7 May 2021 08:59:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJRa4gQSWl3/eMXV@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/21 3:08 PM, Al Viro wrote:
> On Thu, May 06, 2021 at 01:15:01PM -0600, Jens Axboe wrote:
> 
>> Attached output of perf annotate <func> for that last run.
> 
> Heh...  I wonder if keeping the value of iocb_flags(file) in
> struct file itself would have a visible effect...

A quick hack to get rid of the init_sync_kiocb() in new_sync_write() and
just eliminate the ki_flags read in eventfd_write(), as the test case is
blocking. That brings us closer to the ->write() method, down 7% vs the
previous 10%:

Executed in  468.23 millis    fish           external
   usr time   95.09 millis  114.00 micros   94.98 millis
   sys time  372.98 millis   76.00 micros  372.90 millis

Executed in  468.97 millis    fish           external
   usr time   91.05 millis   89.00 micros   90.96 millis
   sys time  377.92 millis   69.00 micros  377.85 millis

-- 
Jens Axboe

