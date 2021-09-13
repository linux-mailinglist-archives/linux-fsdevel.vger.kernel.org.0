Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBDA40998A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbhIMQlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 12:41:15 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:39846 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbhIMQlP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:41:15 -0400
Received: by mail-pl1-f174.google.com with SMTP id c4so4664756pls.6;
        Mon, 13 Sep 2021 09:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9etkatJg5nKShmGZklzZahxT3ZNU9cZVwDepK9BODww=;
        b=B3TfVpA1EEK9sAMKSwTPCioRAPKtCvvCFLZlPhfhq2yVQVQHbaqj36CAuzaK3U2IX6
         yRhFV2nZZyO5dq1hLDQnWIpgxDuLSLgOZCXxcqweZfQyPEh1Fx9TSnKusBsznecj0BQk
         KhqkHjn/8Qxf8PQ/lvNAWsr/92jehYc4YoktsloLmV7rPvQsITL9ANbC0hFOJ1plwNHf
         IALSgNzl6BHtRl1if6ouAKWcb269rGpz+9D15Y5a0yFHc9dZH0F7M9QeLVOHy/nH3Vi3
         D7gV7B308YqIGfqgOL17wEuV91qqi8LokMFaRjckX6bIeA2znJo/lBBIWjiGIvRSB4rv
         cMjA==
X-Gm-Message-State: AOAM533awpgPSIQKxGvhcIMRaFAzcTSAJGrbaLrn+Tx6OIqdzzRpSdL9
        AuCgx0CluACnv07Lqhv0jolp7dR8ckc=
X-Google-Smtp-Source: ABdhPJwstXHiM8TUTI605Eyu+7c0VM0KYLidH8RMhMhIbQX9IVEVqRev/xuEKchqIzCFwh5ycxVg2w==
X-Received: by 2002:a17:90b:3e87:: with SMTP id rj7mr383019pjb.73.1631551198378;
        Mon, 13 Sep 2021 09:39:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6765:113f:d2d7:def9])
        by smtp.gmail.com with ESMTPSA id i8sm7634077pfo.117.2021.09.13.09.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 09:39:57 -0700 (PDT)
Subject: Re: start switching sysfs attributes to expose the seq_file
To:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210913054121.616001-1-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <21413ac5-f934-efe2-25ee-115c4dcc86a5@acm.org>
Date:   Mon, 13 Sep 2021 09:39:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/12/21 10:41 PM, Christoph Hellwig wrote:
> Al pointed out multiple times that seq_get_buf is highly dangerous as
> it opens up the tight seq_file abstractions to buffer overflows.  The
> last such caller now is sysfs.
> 
> This series allows attributes to implement a seq_show method and switch
> the block and XFS code as users that I'm most familiar with to use
> seq_files directly after a few preparatory cleanups.  With this series
> "leaf" users of sysfs_ops can be converted one at at a time, after that
> we can move the seq_get_buf into the multiplexers (e.g. kobj, device,
> class attributes) and remove the show method in sysfs_ops and repeat the
> process until all attributes are converted.  This will probably take a
> fair amount of time.

Hi Christoph,

Thanks for having done this work. In case you would need it, some time ago
I posted the following sysfs patch but did not receive any feedback:
"[PATCH] kernfs: Improve lockdep annotation for files which implement mmap"
(https://lore.kernel.org/linux-kernel/20191004161124.111376-1-bvanassche@acm.org/).

Bart.
