Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074FF1AF539
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 23:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgDRVpj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 17:45:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38158 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDRVpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 17:45:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id y25so2989933pfn.5;
        Sat, 18 Apr 2020 14:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2AAPHCGhMy5VItzDoJpxjkkLgCbtnvq0NCPyMd1E3BM=;
        b=tb9w/aQcuIm+0H/4IB8P1JfP8dzvcMYzC2nTShSWZbbymfI5hwqylHw3zUyz7hMOU9
         BhDRRZxAW3DiYaC0Mv/77BqJTDOCHg1Nbdyznm70qb1w0G/zGJb16c/jdb0qXp32BhU8
         sEMPVuN2Rr/bGMCpTHVqBAAjdyhnDfQ05AO0TDqRUA87sJ5tYvekuonYc3aa93Qo5ktb
         8IWry/hGxr/++//XND9hisg75fnNBZn9TCwjy5JLO/G3pG0Eh+vq3Pmq4VIo817x0E/R
         NeJaJeGxrADRAIrcc03aWXFC3XfHSiL/MkSjzyiAUYSCBka1LFHSz4Dhrj78moVEqELg
         Kjfw==
X-Gm-Message-State: AGi0PubeOUT9PDcKto4lxHx4CMMyxd+q5x1GXfPdvMIE0nsPUGMLS6e9
        07nfeQn89axrEnS5wMgwdCY=
X-Google-Smtp-Source: APiQypLlj3kmCKoHewkm1Hz+20vdn1A4jy5H9lZfMxh2Nxs40ZEubwdTcclJQ0Z2AlahHID9agkJEg==
X-Received: by 2002:aa7:9a52:: with SMTP id x18mr9614111pfj.139.1587246336719;
        Sat, 18 Apr 2020 14:45:36 -0700 (PDT)
Received: from [100.124.15.238] ([104.129.198.228])
        by smtp.gmail.com with ESMTPSA id i73sm13635656pfe.80.2020.04.18.14.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 14:45:35 -0700 (PDT)
Subject: Re: [PATCH v7 11/11] zonefs: use REQ_OP_ZONE_APPEND for sync DIO
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-12-johannes.thumshirn@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8d7c021f-d518-b6e4-7308-daaf9a1c7992@acm.org>
Date:   Sat, 18 Apr 2020 14:45:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417121536.5393-12-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/17/20 5:15 AM, Johannes Thumshirn wrote:
> Synchronous direct I/O to a sequential write only zone can be issued using
> the new REQ_OP_ZONE_APPEND request operation. As dispatching multiple
> BIOs can potentially result in reordering, we cannot support asynchronous
> IO via this interface.
> 
> We also can only dispatch up to queue_max_zone_append_sectors() via the
> new zone-append method and have to return a short write back to user-space
> in case an IO larger than queue_max_zone_append_sectors() has been issued.

Is this patch the only patch that adds a user space interface through 
which REQ_OP_ZONE_APPEND operations can be submitted? Has it been 
considered to make it possible to submit REQ_OP_ZONE_APPEND operations 
through the asynchronous I/O mechanism?

Thanks,

Bart.
