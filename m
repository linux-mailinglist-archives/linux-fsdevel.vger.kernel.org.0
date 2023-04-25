Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5450C6EDBA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 08:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjDYGeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 02:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjDYGeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:34:18 -0400
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 23:34:16 PDT
Received: from out-29.mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3181359C
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 23:34:16 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682404021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fE6a+Te8DkR/N/sxnjG6LA5qHZWxIA4mQpHNV+STRD0=;
        b=dfwCYaOmaC6+WJnL/mY2doSQSSqaHJbFFv23O4R0YeHN8v5HiUQSC0p6Ffl6vGoR6l0oHS
        sjB/yl3VyaN5Zo5+JpjyDrm/M/gVW64uHobRyZviq8UUWFRizcW/rYRDC5lQfgcGthBoiK
        ATEm0EXlEHBEIc7OvvvoPfC9PWOPZzA=
Date:   Tue, 25 Apr 2023 06:27:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <57fda19f31d5fb7c6220ca679a969668@linux.dev>
Subject: Re: [PATCH] mmzone: Introduce for_each_populated_zone_pgdat()
To:     "Matthew Wilcox" <willy@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     david@redhat.com, osalvador@suse.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <ZEdHpxPRwcGVOctJ@casper.infradead.org>
References: <ZEdHpxPRwcGVOctJ@casper.infradead.org>
 <20230424030756.1795926-1-yajun.deng@linux.dev>
 <ZEX8jV/FQm2gL+2j@casper.infradead.org>
 <20230424145823.b8e8435dd3242614371be6d5@linux-foundation.org>
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

April 25, 2023 11:23 AM, "Matthew Wilcox" <willy@infradead.org> wrote:=0A=
=0A> On Mon, Apr 24, 2023 at 02:58:23PM -0700, Andrew Morton wrote:=0A> =
=0A>> On Mon, 24 Apr 2023 04:50:37 +0100 Matthew Wilcox <willy@infradead.=
org> wrote:=0A>> =0A>> On Mon, Apr 24, 2023 at 11:07:56AM +0800, Yajun De=
ng wrote:=0A>>> Instead of define an index and determining if the zone ha=
s memory,=0A>>> introduce for_each_populated_zone_pgdat() helper that can=
 be used=0A>>> to iterate over each populated zone in pgdat, and convert =
the most=0A>>> obvious users to it.=0A>> =0A>> I don't think the complexi=
ty of the helper justifies the simplification=0A>> of the users.=0A>> =0A=
>> Are you sure?=0A>> =0A>>> +++ b/include/linux/mmzone.h=0A>>> @@ -1580,=
6 +1580,14 @@ extern struct zone *next_zone(struct zone *zone);=0A>>> ; /=
* do nothing */ \=0A>>> else=0A>>> =0A>>> +#define for_each_populated_zon=
e_pgdat(zone, pgdat, max) \=0A>>> + for (zone =3D pgdat->node_zones; \=0A=
>>> + zone < pgdat->node_zones + max; \=0A>>> + zone++) \=0A>>> + if (!po=
pulated_zone(zone)) \=0A>>> + ; /* do nothing */ \=0A>>> + else=0A>>> +=
=0A>> =0A>> But each of the call sites is doing this, so at least the com=
plexity is=0A>> now seen in only one place.=0A> =0A> But they're not doin=
g _that_. They're doing something normal and=0A> obvious like:=0A> =0A> f=
or (zone =3D pgdat->node_zones; zone < pgdat->node_zones + max; zone++) {=
=0A> if (!populated_zone(zone)=0A> continue;=0A> ...=0A> }=0A>=0A=0AThey =
will be like:=0A=0Afor (zone =3D pgdat->node_zones; zone < pgdat->node_zo=
nes + max; zone++)=0A        if (!populated_zone(zone))=0A               =
 ;=0A        else {=0A=0A                ...=0A        }=0A     =0A =0A> =
which clearly does what it's supposed to. But with this patch, there's=0A=
> macro expansion involved, and it's not a nice simple macro, it has a lo=
op=0A> _and_ an if-condition, and there's an else, and now I have to thin=
k hard=0A> about whether flow control is going to do the right thing if t=
he body=0A> of the loop isn't simple.=0A> =0A>> btw, do we need to do the=
 test that way? Why won't this work?=0A>> =0A>> #define for_each_populate=
d_zone_pgdat(zone, pgdat, max) \=0A>> for (zone =3D pgdat->node_zones; \=
=0A>> zone < pgdat->node_zones + max; \=0A>> zone++) \=0A>> if (populated=
_zone(zone))=0A> =0A> I think it will work, except that this is now legal=
:=0A> =0A> for_each_populated_zone_pgdat(zone, pgdat, 3)=0A> else i++;=0A=
> =0A> and really, I think that demonstrates why we don't want macros tha=
t are=0A> that darn clever.
