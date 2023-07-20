Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BEB75A7DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 09:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjGTHcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 03:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGTHcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:32:48 -0400
Received: from out-3.mta0.migadu.com (out-3.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E649EC
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 00:32:47 -0700 (PDT)
Message-ID: <0fe482ce-cf21-b90b-38b7-0cf378398c6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689838365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CK5MzQ87pMNg1LRn1dY7l5Z+yUTcQHhNXZVPAMs2mng=;
        b=Dc+/5WdUpfq3ogQMuWFThg0mcwiRxJ6WFZr3jeq6qmqG8UpIx34FAnJi185n9kZlWV9ZOr
        cz/gslT5rYa2FYILThMPL8ZMQsszgebhrE5IwPGcvLHYKzhaQips3n81HC7+S/4SI1MdDu
        W+Fdx1YFlGQgOVdj4r5SYF1pCW4TpX4=
Date:   Thu, 20 Jul 2023 15:32:39 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/3] fuse: add a new fuse init flag to relax
 restrictions in no cache mode
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, bernd.schubert@fastmail.fm,
        linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        cgxu519@mykernel.net
References: <20230630094602.230573-1-hao.xu@linux.dev>
In-Reply-To: <20230630094602.230573-1-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/23 17:45, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> Patch 1 is a fix for private mmap in FOPEN_DIRECT_IO mode
>    This is added here together since the later two depends on it.
> Patch 2 is the main dish
> Patch 3 is to maintain direct write logic for shared mmap in FOPEN_DIRECT_IO mode
> 
> v2 -> v3
>      add patch 1 fix here, and adjust it follow Bernd's comment
>      add patch 3 which does right thing for shared mmap in FOPEN_DIRECT_IO mode
> 
> v1 -> v2:
>       make the new flag a fuse init one rather than a open flag since it's
>       not common that different files in a filesystem has different
>       strategy of shared mmap.
> 
> Hao Xu (3):
>    fuse: invalidate page cache pages before direct write
>    fuse: add a new fuse init flag to relax restrictions in no cache mode
>    fuse: write back dirty pages before direct write in direct_io_relax
>      mode
> 
>   fs/fuse/file.c            | 26 +++++++++++++++++++++++---
>   fs/fuse/fuse_i.h          |  3 +++
>   fs/fuse/inode.c           |  5 ++++-
>   include/uapi/linux/fuse.h |  1 +
>   4 files changed, 31 insertions(+), 4 deletions(-)
> 

Ping this one.

Hi Miklos,

Could you take a look at this one when you have time, since Bernd is
going to make his patch separate, this series is ready for reviewing.

Thanks,
Hao
