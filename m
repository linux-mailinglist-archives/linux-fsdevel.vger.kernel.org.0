Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBE9112104
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 02:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfLDB1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 20:27:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbfLDB1w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:27:52 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 056399E0601D957A6116;
        Wed,  4 Dec 2019 09:27:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Dec 2019
 09:27:44 +0800
Subject: Re: [PATCH v2] f2fs: Fix direct IO handling
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Javier Gonzalez <javier@javigon.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20191126075719.1046485-1-damien.lemoal@wdc.com>
 <20191126234428.GB20652@jaegeuk-macbookpro.roam.corp.google.com>
 <20191203173308.GA41093@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4eb6db72-8667-7306-e989-36b5d79289d0@huawei.com>
Date:   Wed, 4 Dec 2019 09:27:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191203173308.GA41093@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/4 1:33, Jaegeuk Kim wrote:
> Thank you for checking the patch.
> I found some regressions in xfstests, so want to follow the Damien's one
> like below.
> 
> Thanks,
> 
> ===
>>From 9df6f09e3a09ed804aba4b56ff7cd9524c002e69 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 26 Nov 2019 15:01:42 -0800
> Subject: [PATCH] f2fs: preallocate DIO blocks when forcing buffered_io
> 
> The previous preallocation and DIO decision like below.
> 
>                          allow_outplace_dio              !allow_outplace_dio
> f2fs_force_buffered_io   (*) No_Prealloc / Buffered_IO   Prealloc / Buffered_IO
> !f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO
> 
> But, Javier reported Case (*) where zoned device bypassed preallocation but
> fell back to buffered writes in f2fs_direct_IO(), resulting in stale data
> being read.
> 
> In order to fix the issue, actually we need to preallocate blocks whenever
> we fall back to buffered IO like this. No change is made in the other cases.
> 
>                          allow_outplace_dio              !allow_outplace_dio
> f2fs_force_buffered_io   (*) Prealloc / Buffered_IO      Prealloc / Buffered_IO
> !f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO
> 
> Reported-and-tested-by: Javier Gonzalez <javier@javigon.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
