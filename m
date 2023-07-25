Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FDC7606AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 05:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjGYDde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 23:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYDdc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:33:32 -0400
Received: from out-18.mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8371171E
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 20:33:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690255481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6p0DFvIoLJzSIVM0qRIM/GXeN12xkckyA9Fji4TGEhI=;
        b=r9D+tXFVa/N1RN+BLv5WgR5iQ4rwtyebnPM62Sh3w2AQ+19WlSlFOjsJl5wosr8TEtJchn
        V877L2MD6oNieyuMlTG6JawmQ1ns/Fjh33pHsVXqhR6CCRTDc2499SUTwOS+JRsWVrdweW
        vS3GyBw0+b28Uj9NeJVk00fqQ8IPfLM=
MIME-Version: 1.0
Subject: Re: [PATCH v2 01/47] mm: vmscan: move shrinker-related code into a
 separate file
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <d2621ad0-8b99-9154-5ff5-509dec2f32a3@bytedance.com>
Date:   Tue, 25 Jul 2023 11:23:54 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        tkhai@ya.ru, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, djwong@kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        yujie.liu@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        x86@kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FE62F56-1B4E-4E2A-BEA9-0DA6907A2FA9@linux.dev>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-2-zhengqi.arch@bytedance.com>
 <97E80C37-8872-4C5A-A027-A0B35F39152A@linux.dev>
 <d2621ad0-8b99-9154-5ff5-509dec2f32a3@bytedance.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 25, 2023, at 11:09, Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>=20
>=20
>=20
> On 2023/7/25 10:35, Muchun Song wrote:
>>> On Jul 24, 2023, at 17:43, Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>>>=20
>>> The mm/vmscan.c file is too large, so separate the shrinker-related
>>> code from it into a separate file. No functional changes.
>>>=20
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>> include/linux/shrinker.h |   3 +
>>> mm/Makefile              |   4 +-
>>> mm/shrinker.c            | 707 =
+++++++++++++++++++++++++++++++++++++++
>>> mm/vmscan.c              | 701 =
--------------------------------------
>>> 4 files changed, 712 insertions(+), 703 deletions(-)
>>> create mode 100644 mm/shrinker.c
>>>=20
>>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>>> index 224293b2dd06..961cb84e51f5 100644
>>> --- a/include/linux/shrinker.h
>>> +++ b/include/linux/shrinker.h
>>> @@ -96,6 +96,9 @@ struct shrinker {
>>>  */
>>> #define SHRINKER_NONSLAB (1 << 3)
>>>=20
>>> +unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct =
mem_cgroup *memcg,
>>> +    int priority);
>> A good cleanup, vmscan.c is so huge.
>> I'd like to introduce a new header in mm/ directory and contains =
those
>> declarations of functions (like this and other debug function in
>> shrinker_debug.c) since they are used internally across mm.
>=20
> How about putting them in the mm/internal.h file?

Either is fine to me.

>=20
>> Thanks.


