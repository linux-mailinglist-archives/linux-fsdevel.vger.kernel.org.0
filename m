Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED2137EBCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbhELTh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 15:37:57 -0400
Received: from sandeen.net ([63.231.237.45]:49412 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244044AbhELR6J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 13:58:09 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 5E22E323C00;
        Wed, 12 May 2021 12:56:39 -0500 (CDT)
From:   Eric Sandeen <sandeen@sandeen.net>
To:     Hyunchul Lee <hyc.lee@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Pavel Reichl <preichl@redhat.com>,
        chritophe.vu-brugier@seagate.com
References: <372ffd94-d1a2-04d6-ac38-a9b61484693d@sandeen.net>
 <CAKYAXd_5hBRZkCfj6YAgb1D2ONkpZMeN_KjAQ_7c+KxHouLHuw@mail.gmail.com>
 <CGME20210511233346epcas1p3071e13aa2f1364e231f2d6ece4b64ca2@epcas1p3.samsung.com>
 <276da0be-a44b-841e-6984-ecf3dc5da6f0@sandeen.net>
 <001201d746c0$cc8da8e0$65a8faa0$@samsung.com>
 <b3015dc1-07a9-0c14-857a-9562a9007fb6@sandeen.net>
 <CANFS6bZs3bDQdKH-PYnQqo=3iDUaVy5dH8VQ+JE8WdeVi4o0NQ@mail.gmail.com>
 <35b5967f-dc19-f77f-f7d1-bf1d6e2b73e8@sandeen.net>
Subject: Re: problem with exfat on 4k logical sector devices
Message-ID: <39726442-efd9-2c7a-c52e-04b1d7f14985@sandeen.net>
Date:   Wed, 12 May 2021 12:56:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <35b5967f-dc19-f77f-f7d1-bf1d6e2b73e8@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/21 11:44 AM, Eric Sandeen wrote:
> I also wonder about:
> 
>         bd->num_sectors = blk_dev_size / DEFAULT_SECTOR_SIZE;
>         bd->num_clusters = blk_dev_size / ui->cluster_size;
> 
> is it really correct that this should always be in terms of 512-byte sectors?

It does look like this causes problems as well:

# dump/dump.exfat /root/test.img 
exfatprogs version : 1.1.1
-------------- Dump Boot sector region --------------
Volume Length(sectors): 		65536 <<<<<<
FAT Offset(sector offset): 		256
FAT Length(sectors): 			64
Cluster Heap Offset (sector offset): 	512
Cluster Count: 				65024
Root Cluster (cluster offset): 		6
Volume Serial: 				0x1234
Sector Size Bits: 			12    <<<<<<<
Sector per Cluster bits: 		0

...

# tune/tune.exfat -v /root/test.img  
exfatprogs version : 1.1.1
[exfat_get_blk_dev_info: 202] Block device name : /root/test.img
[exfat_get_blk_dev_info: 203] Block device offset : 0
[exfat_get_blk_dev_info: 204] Block device size : 268435456
[exfat_get_blk_dev_info: 205] Block sector size : 512         <<<<<<<
[exfat_get_blk_dev_info: 206] Number of the sectors : 524288  <<<<<<<
[exfat_get_blk_dev_info: 208] Number of the clusters : 65536
