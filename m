Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0871B9B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfEMPQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 11:16:03 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51911 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfEMPQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 11:16:02 -0400
Received: by mail-it1-f196.google.com with SMTP id s3so20896465itk.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zQKAeApbQkGSD0p9oJ6Vk8zjf372ECXjcP7amsJgHmE=;
        b=XqjVMG6jbZ7CL5+3ycqBJDm2IZ4Is0m01tiJzG1wE9WJp07ok3eMK6eZxKbdTnBNsz
         8FE+QprL9A4TLnzKsxrBuRTBl1EWTjHdQm27KeoCjvLCf7xxHfn3BDyynV53cGVMJtV9
         nxGZMnPe1uywHCoVeLJuz9muXMgkkkSd9Xcz7xxIQ4krdFtYPHKuKcensTbuvPalQf8o
         nSMTA2+01DL8XCtb34vPkaubCi1uGUeBwcYJ9XvFG8H1V/okutNH4ZcE23J3ChUL0v8c
         QOStHA84Q6P1TcSUNce3Cp+rceqF5nUx5y5f2p78zmJjevaRCT6Ti3Mr9gRLWCR+HPQB
         XP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zQKAeApbQkGSD0p9oJ6Vk8zjf372ECXjcP7amsJgHmE=;
        b=JcGP2RfEZ4QG/xBURPFN22nKscPgTbUyO777YVEIP66EEIlMJ7UxF5lZmHTmw5P0nA
         XffznwCrYJe6uAnEZRBKE7KVWgAS/wmk9VEy9dG9odfvmXpivOmlJ7vS46+iDHela+OV
         Cpbh1zSfjGnCzgzQSTaU2JlScoMbo15WbC1B1foxKD4TutfAuaTD2/YCOwPvVDpBiTt8
         fuRF4hNnDaPF+slQCUb+pCh86CSgzcls8//4EMEdgCFHtxgs9PfBd9xkpdH3ApJ4QmXC
         s12/PIDvGY5voZFZJdGnrotwnwPg6n6GdNTbDhT+AGIg5g15h8jI83nK4kfz7T5oUCL4
         we6Q==
X-Gm-Message-State: APjAAAUyEnC5QwEXPUuxYzTvW8u9B9G6iHUuDB8ZBYWAJdzk9zMSRy+6
        MGIRRS2lKI3XvWjqOiR4ZhGzLKIxFpLJxA==
X-Google-Smtp-Source: APXvYqyae2kbVGHd9cIxb31cVMqpb47k9n3/oInM0VA5XiPnBWhONSYMR28gs0cOUgIUTDki9iqSmA==
X-Received: by 2002:a02:1142:: with SMTP id 63mr18630806jaf.19.1557760560527;
        Mon, 13 May 2019 08:16:00 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q16sm4360158ior.75.2019.05.13.08.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 08:15:59 -0700 (PDT)
Subject: Re: [PATCH 1/1] io_uring: fix race condition reading SQE data
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <3900c9a9-41a2-31cb-3a7b-e93251505b15@kernel.dk>
 <20190511170801.32182-1-source@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3c0071d2-528b-573a-49fe-c6f72398840c@kernel.dk>
Date:   Mon, 13 May 2019 09:15:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511170801.32182-1-source@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/19 11:08 AM, Stefan Bühler wrote:
> When punting to workers the SQE gets copied after the initial try.
> There is a race condition between reading SQE data for the initial try
> and copying it for punting it to the workers.
> 
> For example io_rw_done calls kiocb->ki_complete even if it was prepared
> for IORING_OP_FSYNC (and would be NULL).
> 
> The easiest solution for now is to alway prepare again in the worker.
> 
> req->file is safe to prepare though as long as it is checked before use.

Looks good, as we discussed a week or so ago. Applied, thanks.

-- 
Jens Axboe

