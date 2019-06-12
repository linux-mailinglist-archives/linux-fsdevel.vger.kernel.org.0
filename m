Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1C42C22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502098AbfFLQZG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 12:25:06 -0400
Received: from server.eikelenboom.it ([91.121.65.215]:56262 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfFLQZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ktowEjqF/CBPxhQY3pu7cziNBjpasaaInkiP4lM1ITk=; b=RSlgjpwaOad4S6Af3UpDb10U4o
        dC7hhgdeQYuNplE4lMwObyLofK5gd7ONp6mAexVHPXXBoFTRvgqpdJmyUudt/WiPUNIj7jjICxEmj
        IpNyVa0Nz254ZSjkoJpQjgIBcexHaR8UVvXVNPXoUZtLmlIXHUMs5NBuGuJ8gZdmoyUs=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:38718 helo=[172.16.1.50])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1hb63Y-0004wh-UT; Wed, 12 Jun 2019 18:25:00 +0200
Subject: Re: [PATCH] fuse: require /dev/fuse reads to have enough buffer
 capacity (take 2)
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>, gluster-devel@gluster.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it>
 <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com>
 <20190611202738.GA22556@deco.navytux.spb.ru>
 <CAOssrKfj-MDujX0_t_fgobL_KwpuG2fxFmT=4nURuJA=sUvYYg@mail.gmail.com>
 <20190612112544.GA21465@deco.navytux.spb.ru>
 <f31ca7b5-0c9b-5fde-6a75-967265de67c6@eikelenboom.it>
 <20190612141220.GA25389@deco.navytux.spb.ru>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <f79ff13f-701b-89d8-149c-e53bb880bb77@eikelenboom.it>
Date:   Wed, 12 Jun 2019 18:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612141220.GA25389@deco.navytux.spb.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/06/2019 16:12, Kirill Smelkov wrote:
> On Wed, Jun 12, 2019 at 03:03:49PM +0200, Sander Eikelenboom wrote:
>> On 12/06/2019 13:25, Kirill Smelkov wrote:
>>> On Wed, Jun 12, 2019 at 09:44:49AM +0200, Miklos Szeredi wrote:
>>>> On Tue, Jun 11, 2019 at 10:28 PM Kirill Smelkov <kirr@nexedi.com> wrote:
>>>>
>>>>> Miklos, would 4K -> `sizeof(fuse_in_header) + sizeof(fuse_write_in)` for
>>>>> header room change be accepted?
>>>>
>>>> Yes, next cycle.   For 4.2 I'll just push the revert.
>>>
>>> Thanks Miklos. Please consider queuing the following patch for 5.3.
>>> Sander, could you please confirm that glusterfs is not broken with this
>>> version of the check?
>>>
>>> Thanks beforehand,
>>> Kirill
>>
>>
>> Hmm unfortunately it doesn't build, see below.
>> [...]
>> fs/fuse/dev.c:1336:14: error: ‘fuse_in_header’ undeclared (first use in this function)
>>        sizeof(fuse_in_header) + sizeof(fuse_write_in) + fc->max_write))
> 
> Sorry, my bad, it was missing "struct" before fuse_in_header. I
> originally compile-tested the patch with `make -j4`, was distracted onto
> other topic and did not see the error after returning due to long tail
> of successful CC lines. Apologize for the inconvenience. Below is a
> fixed patch that was both compile-tested and runtime-tested with my FUSE
> workloads (non-glusterfs).
> 
> Kirill
> 

Just tested and it works for me, thanks !

--
Sander
