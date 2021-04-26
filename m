Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4CF36B7E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhDZRTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbhDZRTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:19:05 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9756C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 10:18:23 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id c3so1052762ils.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 10:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AxkKTuRTwJPgdbALDNSex6+V1PllqCVivdIpcpLUoWI=;
        b=Zbxks/KufSJccFgUWsuKnSdfP0p5yutHTZBJtfwBXSQauTAagYAUbKfmTXM+HopPBP
         8YiYFpHY3R8pbS7YQQe0qYggrwgzkYpvGn/jPQBldWNusaVRd0wXojx2pTTQrfdsAw60
         cxbUSfew9bRZkIUZNxt/uOc+z55R/2MJn9a64OetGYOr27RpLABCrqfA+PfHWjbz0WZk
         AYMjsiI0b0YG+rZjz8IGxczmY2Wed1mId1ZCFxoUSu3XlvubarnHmgz1UvcA/mZptD/h
         cdxi6M3nko/QjcITaYyocXZDX5KwriUe8/iDeIAkuQMs5frg+hV4UFYB01VWgGHIUxrJ
         o0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AxkKTuRTwJPgdbALDNSex6+V1PllqCVivdIpcpLUoWI=;
        b=OmWW3IYrrBON2W0BZH7xhfouijBOYHjHoB5SbL5MoAcv/zMc6rw31SoRxQRu4GoRYS
         icXyGehEY0i5oA+OUuROgn3879PCdXobqb6c5f73SrbAeh2yZZd4ODLz+q1dUoS0OUz4
         t77cVnd0kei4jNrDLzYMR57Gclgm2uYp193lo5rGxz1XfL0WxI8BZXbDLkYx3P1XmD0c
         r/cPDSAF7j8DaSPSXicqsHDYyY+UDfpFSooKMYf6YeXky4P2KhHbFAlwC5crjxrnM5s1
         XtmC7kRU6BasvHir1omj6+1/tFsM1AT/y7GvkKHJMb/gx2Yl7UJEn8ZJzrWzw6Z0k1tE
         tw4A==
X-Gm-Message-State: AOAM530KYYTJLe2ylrfYB9V2B3QX1wh48VMn3UdD8ffcHkSIpio7rwiT
        LRJB4HgdKhmmMMXP1tfzTR92um8LCHSRkg==
X-Google-Smtp-Source: ABdhPJzzByfqQal+7IdJWmviqRcpDsE1o8kjGOsh8wkQBIZlM0mK9H9C+Wmeu9Cs8pt5zm2OnW//wg==
X-Received: by 2002:a05:6e02:5a2:: with SMTP id k2mr15151182ils.177.1619457502866;
        Mon, 26 Apr 2021 10:18:22 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a11sm194486ilj.22.2021.04.26.10.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:18:22 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210426134821.2191160-1-hch@lst.de>
 <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk>
 <20210426170516.GA1443@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3bd0ff91-6613-8da5-810f-f23baa9d94c7@kernel.dk>
Date:   Mon, 26 Apr 2021 11:18:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210426170516.GA1443@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/21 11:05 AM, Christoph Hellwig wrote:
> Can you test the force pushed update?  This now avoids the RCU free
> for each bio and just uses SLAB_TYPESAFE_BY_RCU instead.

That looks better, perf is now back where it is without the series.
At least according to usual variation within boots.

-- 
Jens Axboe

