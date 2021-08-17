Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB513EF0AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 19:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhHQRPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 13:15:05 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:52770 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhHQRPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:15:03 -0400
Received: by mail-pj1-f43.google.com with SMTP id nt11so152347pjb.2;
        Tue, 17 Aug 2021 10:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v2ezKXtmZ+KjzYhpA8Y6VRyR3KOD/971FoOogNR18Hs=;
        b=AH0Pf/fxVX60UAFVupMs2HrhXm/SeXCyGTdjRPsamQF/3aZsZHK1c7X3oF1ccKup9m
         8X/i722eoiiGnVAkeabMka6Odu0OIJNmwd0ztRKT+7r0qN13Bo9dMzsl3T88K1EN8gws
         33lbu7QGIcVeZaFNUXE2DLXd/4/ToB1oNXsVNQokhNwjjtVuwtXy0q2TYhGk4QINv3vX
         QblcpR+ujJ3/FdzXbje5uftWevEyBr+5XdJFukmMhtjIdtulZp8KDotYRjFfZDcO9XRj
         cB8PyXuAXUOMBPOj1vFAneMYuNHMfQUbbxhl5bjFnCxOeywjADUcP3l9AZUmpI6J/B0p
         zR4g==
X-Gm-Message-State: AOAM531p4Ei5/9qdGJx2W266mjHtPG+KAvjWIX/3PSsN/9iVV+eSYlM+
        mZ05yLWtLz1mP8TITDHeCiI=
X-Google-Smtp-Source: ABdhPJxyRl0ks4xxfdYxuKBl/CqSpHH1tc/kfe77IZhXj/2ic6tgtgAm7bavNRKoa2tEHngKC7nW9Q==
X-Received: by 2002:a17:90a:3b4b:: with SMTP id t11mr4532753pjf.182.1629220470271;
        Tue, 17 Aug 2021 10:14:30 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ae3f:1e44:e6d0:4a44])
        by smtp.gmail.com with ESMTPSA id x13sm2822931pjh.30.2021.08.17.10.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 10:14:29 -0700 (PDT)
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, djwong@kernel.org, snitzer@redhat.com,
        agk@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com,
        nj.shetty@samsung.com, nitheshshetty@gmail.com,
        joshi.k@samsung.com, javier.gonz@samsung.com,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
Date:   Tue, 17 Aug 2021 10:14:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210817101423.12367-4-selvakuma.s1@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/21 3:14 AM, SelvaKumar S wrote:
> Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
> bio with control information as payload and submit to the device.
> Larger copy operation may be divided if necessary by looking at device
> limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
> submitted to zoned device.
> Native copy offload is not supported for stacked devices.

Using a single operation for copy-offloading instead of separate 
operations for reading and writing is fundamentally incompatible with 
the device mapper. I think we need a copy-offloading implementation that 
is compatible with the device mapper.

Storing the parameters of the copy operation in the bio payload is 
incompatible with the current implementation of bio_split().

In other words, I think there are fundamental problems with this patch 
series.

Bart.
