Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1412B5B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 16:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfL0Pye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 10:54:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42095 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfL0Pyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 10:54:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so14901475pfz.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2019 07:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5tmJ7pFrmFzYzeB9duDLlIXotQmxNCWC6b/fIBvaYCk=;
        b=KzLzCJFpbtP/oJwyBNQ25kfgreR370en2dKVxMdyxJJXuCCMZoytDGHdkhZ/Q+iJjI
         wfoN6ft8uMihOQ5SxXCF9ksuEolbVxqx7I/e8vIpvZ0EZoNiYPv07HV+JQt+I/hR1iBO
         sE87usxT9O5hytFGqTUinsg/Zw4o8sfBEeodb9WdxDGD832+9j8OwMR3U6GFP2xx2XoA
         6pMWeDt6AtMpijj5Zu11f0w2xSI62A6lc/hFTfohmZQ6YfcK7OgRt8GwwUQo4NtSynET
         LrushROkNN+qYR3f3/xWEsh1uSPQJ3hn6CK8S69ExFwByMP1LzP5ljA8QFfWomcwkBxX
         +UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5tmJ7pFrmFzYzeB9duDLlIXotQmxNCWC6b/fIBvaYCk=;
        b=CzoE0XdG7untVF/irJ8GcPju8Puvu6BiAvL7m/4tCr+IJpCQk455Hzboe8f00hcPWd
         WW6ljQWd76a4vSLXRfG5L4vX6xm6SON0b+CpqVTpf4rI3LI2rq18Uui6HWKeTnt4Uf89
         05a8T0vk0IEkCsQtbp3sSkWtvuts1NMYyjpPxguhW8syF/XV+wO5dZoriox0Rv+4I8/e
         iOQnKSPOpVuzfnu13ageLGpf1J68zM0aU4/a8OJ1od6bfoaDDGjgbp28EjtM+bXad8Ar
         o7yJ1+RTdDUZK6Cq6ZpprbR+jiUB/2J2a9zcVIhyWhagW4vKt31s7Jsv5fnMeuRTEvkK
         WKvQ==
X-Gm-Message-State: APjAAAU4N34dY8Yd8THchIXcR13DnrcVWMwMw5DnzHX7rXC6BHMQr3bs
        XXqY3sAHggHo0IddUCJ0Tihv2A==
X-Google-Smtp-Source: APXvYqwriT6+++f0WbF5wJkls137egx/03pjzMGgKvJ+IOmh+HZhBsWos/+tWFHwgwcLXbNkun89aw==
X-Received: by 2002:a63:1210:: with SMTP id h16mr54486504pgl.171.1577462072890;
        Fri, 27 Dec 2019 07:54:32 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id h26sm44211250pfr.9.2019.12.27.07.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 07:54:32 -0800 (PST)
Subject: Re: [PATCH] block: add bio_truncate to fix guard_bio_eod
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com
References: <20191227083658.23912-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c8e77b65-5653-39bc-3593-ec6a939d1ecb@kernel.dk>
Date:   Fri, 27 Dec 2019 08:54:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227083658.23912-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/27/19 1:36 AM, Ming Lei wrote:
> Some filesystem, such as vfat, may send bio which crosses device boundary,
> and the worse thing is that the IO request starting within device boundaries
> can contain more than one segment past EOD.
> 
> Commit dce30ca9e3b6 ("fs: fix guard_bio_eod to check for real EOD errors")
> tries to fix this issue by returning -EIO for this situation. However,
> this way lets fs user code lose chance to handle -EIO, then sync_inodes_sb()
> may hang forever.
> 
> Also the current truncating on last segment is dangerous by updating the
> last bvec, given the bvec table becomes not immutable, and fs bio users
> may lose to retrieve pages via bio_for_each_segment_all() in its .end_io
> callback.
> 
> Fixes this issue by supporting multi-segment truncating. And the
> approach is simpler:
> 
> - just update bio size since block layer can make correct bvec with
> the updated bio size. Then bvec table becomes really immutable.
> 
> - zero all truncated segments for read bio

This looks good to me, but we don't need the export of the symbol.

-- 
Jens Axboe

