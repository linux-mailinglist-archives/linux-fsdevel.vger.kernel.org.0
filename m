Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA8C2DBAD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 06:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgLPFlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 00:41:39 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:36938 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725274AbgLPFlj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 00:41:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chge@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UInJQtT_1608097255;
Received: from chge-ali-mac.local(mailfrom:chge@linux.alibaba.com fp:SMTPD_---0UInJQtT_1608097255)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Dec 2020 13:40:56 +0800
From:   Changwei Ge <chge@linux.alibaba.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Yan Song <imeoer@linux.alibaba.com>
Subject: [RFC] FUSE: Adding a requests resend mechanism to support userspace
 process' failover
Message-ID: <3165340d-8117-3a1c-f6dc-e6697f52e58f@linux.alibaba.com>
Date:   Wed, 16 Dec 2020 13:40:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

FUSE based userspace filesystem process can be killed accidentally. If 
it happens, the connection to kernel/fuse will be destroyed ending up 
with a residual mountpoint. All following requests will be rejected.

If userspace is capable to hold the *fd* returned by opening `/dev/fuse` 
and it's somewhat stateless or the internal state can be recovered 
somehow, even the process dies, we can still keep the fuse connection. 
It gives us an opportunity to do failover.

The philosophy doing this is simple, just a control file(perhaps named 
as "resend" to `/sys/fs/fuse/connections/<id>/resend`). By writing 
arbitrary string into this file, fuse will move all the requests waiting 
for answers from Processing queue back to the Pending queue and resend 
those requests to userspace.

After this, the recovered userspace process can continue processing 
those requests, which is transparent to end-users.

Any thoughts about this idea?
I can send a RFC patch if necessary to make this discussion progress. :-)

Thanks,
Changwei
