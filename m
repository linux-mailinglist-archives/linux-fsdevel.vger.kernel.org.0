Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAC6F4FB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 07:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjECFUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 01:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECFUG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 01:20:06 -0400
X-Greylist: delayed 609 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 22:20:05 PDT
Received: from out-58.mta0.migadu.com (out-58.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2683F1BCA
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 22:20:05 -0700 (PDT)
Message-ID: <75f7fa44-8bf8-f986-63f5-993b7fc863f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683090592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7AGU+iZFyhCl1yojES5RSm0k8YDMhOnv0qEoOQECgn0=;
        b=vTz/LnSIOVOrZ7Gq2fPxIoSOQ+esdVMEzV87LtfJU4SKGuEqdoKmRBxfOF89eOnzJeqVUX
        +eaAtxjYWRd+XfprJzQn6NtZoCaPOdywJkFlzJk3oSu9w2shoH7e2rAGkJF3RFuHUY+RYS
        Ej0u3zXUpl9ByRmAa8r9GN4Rxiu3c40=
Date:   Wed, 3 May 2023 13:09:15 +0800
MIME-Version: 1.0
Subject: Re: [RFC] FUSE: add another flag to support shared mmap in
 FOPEN_DIRECT_IO mode
Content-Language: en-US
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        miklos@szeredi.hu
Cc:     Antonio SJ Musumeci <trapexit@spawn.link>,
        linux-fsdevel@vger.kernel.org
References: <5683716d-9b1d-83d6-9dd1-a7ad3d05cbb1@linux.dev>
 <45ad47ae-5471-3d44-d3d6-2760dee0945d@fastmail.fm>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <45ad47ae-5471-3d44-d3d6-2760dee0945d@fastmail.fm>
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

Hi Bernd,


On 5/2/23 15:37, Bernd Schubert wrote:
> Hi Hao,
>
> On 5/2/23 09:28, Hao Xu wrote:
>> Hi all,
>>
>>  From discussion with Bernd, I get that FOPEN_DIRECT_IO is designed 
>> for those user cases where users want strong coherency like network 
>> filesystems, where one server serves multiple remote clients. And 
>> thus shared mmap is disabled since local page cache existence breaks 
>> this kind of coherency.
>>
>> But here our use case is one virtiofs daemon serve one guest vm, We 
>> use FOPEN_DIRECT_IO to reduce memory footprint not for coherency. So 
>> we expect shared mmap works in this case. Here I suggest/am 
>> implementing adding another flag to indicate this kind of 
>> cases----use FOPEN_DIRECT_IO not for coherency----so that shared mmap 
>> works.
>
> Yeah it should work, but I think what you want is "DAX" - can you try 
> to enable it?
>
> fuse_i.h:    FUSE_DAX_ALWAYS,    /* "-o dax=always" */
> fuse_i.h:    FUSE_DAX_NEVER,        /* "-o dax=never" */
> fuse_i.h:    FUSE_DAX_INODE_USER,    /* "-o dax=inode" */
>
>
>
> Hope it helps,
> Bernd


Thanks for your suggestion, the thing is most IO in our case are small 
random read to small files. I believe Dax should help but doubt it may 
be not too much.

Another reason we are not leveraging DAX is the hypervisor software we 
use doesn't support DAX well. So I think the feature in this RFC should 
be good for

some non-DAX use cases (like ours)


Thanks,

Hao

