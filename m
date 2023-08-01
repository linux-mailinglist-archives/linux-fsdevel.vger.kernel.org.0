Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0032C76B20D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 12:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjHAKky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 06:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjHAKkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:40:52 -0400
Received: from out-64.mta1.migadu.com (out-64.mta1.migadu.com [IPv6:2001:41d0:203:375::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DA9119
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 03:40:50 -0700 (PDT)
Message-ID: <16c14e85-f128-e5e8-c271-f03da0e476f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690886448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81z/y/Xtja4bc9tyeoVdMg90X0HioeWHJ+en8McVYVU=;
        b=UmvbdGrC7YniJStcDwjhOqimfatTdNmjMkbpjVILji4XNe3zfcdCa/o/KnrUc9EFMCh9fu
        xSBGCSJOprWj5Ejfehkg/f6HZU/ARLyZiJ9f81GfZfUoL5Rk6/BlidTtgibtWvpPnXe1eM
        wNDsxAohOIo1QR0Uoy5yFPOBJv5E7g4=
Date:   Tue, 1 Aug 2023 18:40:39 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] fuse: invalidate page cache pages before direct write
Content-Language: en-US
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     fuse-devel@lists.sourceforge.net, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
References: <20230801080647.357381-1-hao.xu@linux.dev>
 <20230801080647.357381-2-hao.xu@linux.dev>
 <B98453E7-ABF1-426E-A752-553476D390C5@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <B98453E7-ABF1-426E-A752-553476D390C5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alan,


On 8/1/23 18:14, Alan Huang wrote:
>> 2023年8月1日 16:06，Hao Xu <hao.xu@linux.dev> 写道：
>>
>> From: Hao Xu <howeyxu@tencent.com>
>>
>> In FOPEN_DIRECT_IO, page cache may still be there for a file since
>> private mmap is allowed. Direct write should respect that and invalidate
>> the corresponding pages so that page cache readers don't get stale data.
> Do other filesystems also invalidate page cache in this case?


For now all filesystems that use iomap do this invalidation, see: 
__iomap_dio_rw()

e.g. ext4, xfs


Regards,

Hao

