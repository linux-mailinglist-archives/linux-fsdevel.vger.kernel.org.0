Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F516EDBB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 08:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjDYGi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 02:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjDYGiZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:38:25 -0400
Received: from out-18.mta1.migadu.com (out-18.mta1.migadu.com [IPv6:2001:41d0:203:375::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2B49CC
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 23:38:21 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682404699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0Sw1HF+tb0ME16TauipdBUqsBMcXzjj7/tJbiHX/1s=;
        b=Waxpik0MqJXy4sXV9FTSarf+6yE6iLfbA5xW066NmLPSnwiydD2Fo6Bmj1v0lb/pBAGcgI
        rLzA9EJRZD2KJqeI6HeSp6aQgasrBIU7bx7Tm+8Qhc11S2W7IazEP5JY+nBrydwV4ic13k
        WhGhE8O4Ia/nEpLKkJps7kSxKYwr7Uo=
Date:   Tue, 25 Apr 2023 06:38:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <c570ff25fbfa38a5aee84a892762da85@linux.dev>
Subject: Re: [PATCH] mmzone: Introduce for_each_populated_zone_pgdat()
To:     "Huang, Ying" <ying.huang@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox" <willy@infradead.org>, david@redhat.com,
        osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <875y9kfr0o.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <875y9kfr0o.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20230424030756.1795926-1-yajun.deng@linux.dev>
 <ZEX8jV/FQm2gL+2j@casper.infradead.org>
 <20230424145823.b8e8435dd3242614371be6d5@linux-foundation.org>
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

April 25, 2023 1:51 PM, "Huang, Ying" <ying.huang@intel.com> wrote:=0A=0A=
> Andrew Morton <akpm@linux-foundation.org> writes:=0A> =0A>> On Mon, 24 =
Apr 2023 04:50:37 +0100 Matthew Wilcox <willy@infradead.org> wrote:=0A>> =
=0A>>> On Mon, Apr 24, 2023 at 11:07:56AM +0800, Yajun Deng wrote:=0A>>>>=
 Instead of define an index and determining if the zone has memory,=0A>>>=
> introduce for_each_populated_zone_pgdat() helper that can be used=0A>>>=
> to iterate over each populated zone in pgdat, and convert the most=0A>>=
>> obvious users to it.=0A>>> =0A>>> I don't think the complexity of the =
helper justifies the simplification=0A>>> of the users.=0A>> =0A>> Are yo=
u sure?=0A>> =0A>>>> +++ b/include/linux/mmzone.h=0A>>>> @@ -1580,6 +1580=
,14 @@ extern struct zone *next_zone(struct zone *zone);=0A>>>> ; /* do n=
othing */ \=0A>>>> else=0A>>>> =0A>>>> +#define for_each_populated_zone_p=
gdat(zone, pgdat, max) \=0A>>>> + for (zone =3D pgdat->node_zones; \=0A>>=
>> + zone < pgdat->node_zones + max; \=0A>>>> + zone++) \=0A>>>> + if (!p=
opulated_zone(zone)) \=0A>>>> + ; /* do nothing */ \=0A>>>> + else=0A>>>>=
 +=0A>> =0A>> But each of the call sites is doing this, so at least the c=
omplexity is=0A>> now seen in only one place.=0A>> =0A>> btw, do we need =
to do the test that way? Why won't this work?=0A>> =0A>> #define for_each=
_populated_zone_pgdat(zone, pgdat, max) \=0A>> for (zone =3D pgdat->node_=
zones; \=0A>> zone < pgdat->node_zones + max; \=0A>> zone++) \=0A>> if (p=
opulated_zone(zone))=0A>> =0A>> I suspect it was done the original way in=
 order to save a tabstop,=0A>> which is no longer needed.=0A> =0A> This m=
ay cause unexpected effect when used with "if" statement. For=0A> example=
,=0A> =0A> if (something)=0A> for_each_populated_zone_pgdat(zone, pgdat, =
max)=0A> total +=3D zone->present_pages;=0A> else=0A> pr_info("something =
is false!\n");=0A> =0A=0AThanks Huang, Ying for the example.=0A=0AYes, th=
is macros with multiple statements but doesn't have a do - while loop,=0A=
It needs if and else together.=0A=0A> Best Regards,=0A> Huang, Ying
