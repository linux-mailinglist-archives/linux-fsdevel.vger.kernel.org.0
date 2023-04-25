Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E128C6EDB60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 07:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjDYFxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 01:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjDYFxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:53:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7AF4C15;
        Mon, 24 Apr 2023 22:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682401985; x=1713937985;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yEFEZaCGdPu5BAzE+GbFl7dn/Sse2du6ZjLBsJ1OM2s=;
  b=c2mz6GzswSIBjy2g1CWsKRhzZ3fh9GLP+QI2aLFA2TgsQH+YvQCAYzMA
   Jp7r0dRkQTPOt85J2EveBnKYgSYle0gTqxnXyaK3rdAgrG4dn6kTUbhi+
   7hZgydAK17q+iAh1m4rjD9o2yOALpK2n1pFUQ5vrjrM49uETU982CCJYv
   rUZR80KW+1KQI1aszQGqdeMpBZHN5tZV7yPwGYBxJlJ27VKMgLm73GbU3
   H0eJ+TsJEPDRexeTP2150OUt3uJ9E3VRLV3oWlEKM1Q/7Qfa1O/2NgTUq
   NPYZ0U5X88d06L35E985YBH9saf+KGKeGum6MWqsFD2WjI3sEyBrPlNyX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="348579489"
X-IronPort-AV: E=Sophos;i="5.99,224,1677571200"; 
   d="scan'208";a="348579489"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 22:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="1023003065"
X-IronPort-AV: E=Sophos;i="5.99,224,1677571200"; 
   d="scan'208";a="1023003065"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 22:53:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yajun Deng <yajun.deng@linux.dev>, david@redhat.com,
        osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mmzone: Introduce for_each_populated_zone_pgdat()
References: <20230424030756.1795926-1-yajun.deng@linux.dev>
        <ZEX8jV/FQm2gL+2j@casper.infradead.org>
        <20230424145823.b8e8435dd3242614371be6d5@linux-foundation.org>
Date:   Tue, 25 Apr 2023 13:51:51 +0800
In-Reply-To: <20230424145823.b8e8435dd3242614371be6d5@linux-foundation.org>
        (Andrew Morton's message of "Mon, 24 Apr 2023 14:58:23 -0700")
Message-ID: <875y9kfr0o.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 24 Apr 2023 04:50:37 +0100 Matthew Wilcox <willy@infradead.org> wrote:
>
>> On Mon, Apr 24, 2023 at 11:07:56AM +0800, Yajun Deng wrote:
>> > Instead of define an index and determining if the zone has memory,
>> > introduce for_each_populated_zone_pgdat() helper that can be used
>> > to iterate over each populated zone in pgdat, and convert the most
>> > obvious users to it.
>> 
>> I don't think the complexity of the helper justifies the simplification
>> of the users.
>
> Are you sure?
>
>> > +++ b/include/linux/mmzone.h
>> > @@ -1580,6 +1580,14 @@ extern struct zone *next_zone(struct zone *zone);
>> >  			; /* do nothing */		\
>> >  		else
>> >  
>> > +#define for_each_populated_zone_pgdat(zone, pgdat, max) \
>> > +	for (zone = pgdat->node_zones;                  \
>> > +	     zone < pgdat->node_zones + max;            \
>> > +	     zone++)                                    \
>> > +		if (!populated_zone(zone))		\
>> > +			; /* do nothing */		\
>> > +		else
>> > +
>
> But each of the call sites is doing this, so at least the complexity is
> now seen in only one place.
>
> btw, do we need to do the test that way?  Why won't this work?
>
> #define for_each_populated_zone_pgdat(zone, pgdat, max) \
> 	for (zone = pgdat->node_zones;                  \
> 	     zone < pgdat->node_zones + max;            \
> 	     zone++)                                    \
> 		if (populated_zone(zone))
>
> I suspect it was done the original way in order to save a tabstop,
> which is no longer needed.

This may cause unexpected effect when used with "if" statement.  For
example,

        if (something)
                for_each_populated_zone_pgdat(zone, pgdat, max)
                        total += zone->present_pages;
        else
                pr_info("something is false!\n");

Best Regards,
Huang, Ying
