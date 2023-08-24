Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7C27866B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 06:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbjHXEc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 00:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbjHXEcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:32:20 -0400
Received: from out-28.mta0.migadu.com (out-28.mta0.migadu.com [91.218.175.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA75E68
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 21:32:17 -0700 (PDT)
Message-ID: <a4d031fa-c5cb-2fe8-5869-ec8ad35cc4ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692851536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppgphILGWctxKMPfp+OEMQ0YhWTuBxKxE8/aT7easbE=;
        b=Tghl+n7Kb0zW+vfX1rhekKc59qBms4Lj2F+tQHJBWIys6gjzrUNZauIxqOUONNNmMaQ/Sq
        f/K5Zx5JJwvlfvCh+kwZ1Oh7A/5kN58SHq1+DNk6U5Dr9kTmn/cUdF7Zz28D46/hOB908o
        jTlV3NxwLbhZPMV5F21ZLBPTDBzt1A0=
Date:   Thu, 24 Aug 2023 12:32:08 +0800
MIME-Version: 1.0
Subject: Re: [fuse-devel] [PATCH 1/2] [RFC for fuse-next ] fuse: DIO writes
 always use the same code path
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     fuse-devel@lists.sourceforge.net, bernd.schubert@fastmail.fm,
        Christoph Hellwig <hch@infradead.org>,
        Hao Xu <howeyxu@tencent.com>,
        Dharmendra Singh <dsingh@ddn.com>,
        linux-fsdevel@vger.kernel.org
References: <20230821174753.2736850-1-bschubert@ddn.com>
 <20230821174753.2736850-2-bschubert@ddn.com>
 <CAJfpegv6Q5O435xSrYUMEQAvvkObV6gWws8Ju7C+PrSKwjmSew@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <CAJfpegv6Q5O435xSrYUMEQAvvkObV6gWws8Ju7C+PrSKwjmSew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/22/23 17:53, Miklos Szeredi via fuse-devel wrote:
> On Mon, 21 Aug 2023 at 19:48, Bernd Schubert <bschubert@ddn.com> wrote:
>> There were two code paths direct-io writes could
>> take. When daemon/server side did not set FOPEN_DIRECT_IO
>>      fuse_cache_write_iter -> direct_write_fallback
>> and with FOPEN_DIRECT_IO being set
>>      fuse_direct_write_iter
>>
>> Advantage of fuse_direct_write_iter is that it has optimizations
>> for parallel DIO writes - it might only take a shared inode lock,
>> instead of the exclusive lock.
>>
>> With commits b5a2a3a0b776/80e4f25262f9 the fuse_direct_write_iter
>> path also handles concurrent page IO (dirty flush and page release),
>> just the condition on fc->direct_io_relax had to be removed.
>>
>> Performance wise this basically gives the same improvements as
>> commit 153524053bbb, just O_DIRECT is sufficient, without the need
>> that server side sets FOPEN_DIRECT_IO
>> (it has to set FOPEN_PARALLEL_DIRECT_WRITES), though.
> Consolidating the various direct IO paths would be really nice.
>
> Problem is that fuse_direct_write_iter() lacks some code from
> generic_file_direct_write() and also completely lacks


I see, seems the page invalidation post direct write is needed

as well.


> direct_write_fallback().   So more thought needs to go into this.
>
> Thanks,
> Miklos
>
>
