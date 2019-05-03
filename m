Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B7412B67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 12:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfECKWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 06:22:38 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:43716 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfECKWh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 06:22:37 -0400
Received: from [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6] (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 11E25C007E8;
        Fri,  3 May 2019 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556878954;
        bh=4w7qrFj+sNYGUZDEOT3rCRK7u5psJsxzwv0FqA2xc50=;
        h=From:Subject:To:Date:From;
        b=OgMD5i32v5drN45o/hcHKopisDRR1X6iJBIhtU8ldNa4z4I1poKeU+/ODowOJ3vbM
         zZzJhszdnQOXog70rJIPX4gs9OFwNaUnjCne3qgH0ZXNoyVorYyA7aM8R//OCQ96Ru
         h+pXfVbguBZI0TpLSN94iY6lMFyOTQTowCnwodhY=
From:   =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
Subject: io_uring: REQ_F_PREPPED race condition with punting to workers
Openpgp: preference=signencrypt
Autocrypt: addr=stefan@stbuehler.de; prefer-encrypt=mutual; keydata=
 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
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <bdc72cc4-ee7b-db12-baee-47e8f06d30e7@stbuehler.de>
Date:   Fri, 3 May 2019 12:22:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

if the initial operation returns EAGAIN (and REQ_F_NOWAIT) is not set,
io_submit_sqe copies the SQE for processing in a worker.

The worker will then read from the SQE copy to determine (some)
parameters for operations, but not all of those parameters will be
validated again, as the initial operation sets REQ_F_PREPPED.

So between the initial operation and the memcpy is a race in which the
application could change the SQE: for example it could change from
IORING_OP_FSYNC to IORING_OP_READV, which would result in broken kiocb
data afaict.

The only way around that I can see right now is copying the SQE in
io_submit_sqe (moving the call to io_cqring_add_event to io_submit_sqe
should simplify this afaict): does that sound acceptable?

cheers,
Stefan
