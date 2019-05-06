Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374621551C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 22:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEFU4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 16:56:48 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:37885 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFU4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 16:56:48 -0400
Received: by mail-qt1-f176.google.com with SMTP id o7so4586134qtp.4;
        Mon, 06 May 2019 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=C96Vqs3gtl8LDEgx+SsgtfimIPC6dR8eqMiB195vWGg=;
        b=VeXkqm4JPWzQJd6+IZBeOf/nIgtQhud4XEf8CPeC8xsHh9hSko7nE8z4fPQqg2hhKC
         0o7MkdgwoxWgqUwUliMnavJYs7oUv2ctJB0i2St9yJ8clnvRYtfz1/x6DI5r8jO26kCE
         lX/OBCCTBl6/JHrx81v+6hkyKzRXKvVwJ6ed4Wv7bP/3eC1mKSQb8NOWFulByyP415ea
         KUoPk2DOKd86DhqPj6wzBgHnKjOI3Y8pzz0OOJfVKj0IoNowMsT4lkUxZ0Vf28d0G1a8
         r8BEXiSUFPiueQRDRP5nM2I+nUiXY3a3LesC8mj/TpfAaZnVtq9biUpi+SPnM3jCOoSf
         pkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=C96Vqs3gtl8LDEgx+SsgtfimIPC6dR8eqMiB195vWGg=;
        b=OgiuR1cWnuxIYlS70HN1C+6cxvSPSbzpd79p4RFgxU4WxyBLvnaYpbhi54bqSCH6K+
         y/At7Opvi1aNmdKd4ARxMkLRXh/TNkosw3yvtuiqH8nWc4ge7fJtJztFYP/he+Fk8vNS
         fLeullvEIjsvZy7veeyxjXQjKO4oKsxAqWu4ImXDFmgPml1OuExeKnw2kiSGOK2eC/wD
         qJEdJy25Pwgz8BQ5a1KrVztWDCgBiPrBpHC6OZvHS4Ld48nv+bHTV++hL4ulz+4zBlnj
         f3BQDUIGeyDmR2YPRQvNXX8JWze1eJTP0aTTtbDMV6c5d9VqhNiLhZtwESkJ6TzY2rV2
         iMRg==
X-Gm-Message-State: APjAAAUkcHU7CUFXwA3KZ/9mOLbcZqUrI3pbQvFEe1TFD52V3mMt8oI3
        XCBMoiwc2X8MZewZ8t4VUpI=
X-Google-Smtp-Source: APXvYqywGEcKDN6MyEFM4+Ge1nJ8GO2xmYNgB0yAr81p7mBM0Nce8pf0Glf/YRTYn2mwuT4839y2YA==
X-Received: by 2002:ac8:8ad:: with SMTP id v42mr22657570qth.337.1557176207128;
        Mon, 06 May 2019 13:56:47 -0700 (PDT)
Received: from localhost.localdomain ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id w184sm2568790qkc.48.2019.05.06.13.56.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 13:56:45 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
From:   Ric Wheeler <ricwheeler@gmail.com>
Subject: Testing devices for discard support properly
Message-ID: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
Date:   Mon, 6 May 2019 16:56:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


(repost without the html spam, sorry!)

Last week at LSF/MM, I suggested we can provide a tool or test suite to 
test discard performance.

Put in the most positive light, it will be useful for drive vendors to 
use to qualify their offerings before sending them out to the world. For 
customers that care, they can use the same set of tests to help during 
selection to weed out any real issues.

Also, community users can run the same tools of course and share the 
results.

Down to the questions part:

Â * Do we just need to figure out a workload to feed our existing tools 
like blkdiscard and fio?

* What workloads are key?

Thoughts about what I would start getting timings for:

* Whole device discard at the block level both for a device that has 
been completely written and for one that had already been trimmed

* Discard performance at the block level for 4k discards for a device 
that has been completely written and again the same test for a device 
that has been completely discarded.

* Same test for large discards - say at a megabyte and/or gigabyte size?

* Same test done at the device optimal discard chunk size and alignment

Should the discard pattern be done with a random pattern? Or just 
sequential?

I think the above would give us a solid base, thoughts or comments?

Thanks!

Ric




