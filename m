Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6CC2677A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 06:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgILEO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 00:14:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48634 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgILEO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 00:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599884066; x=1631420066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BNl6BClW/JQVTxBSvDrATPpOKqPo281pEiBmX2rOtCw=;
  b=moL4+NmvJ7keivzoM+kGoj3QL8gbnqPnkuJqdm1S5wol5ByPeJ6wZrQ7
   aBZFpYtF1wAICIVGnLXqQE7aZsRueu65L2xwSjBLnfiSrvamJMgmr8nr1
   KAqS4ORf5bbnW3FPmvjV2/6sOwMht8DqKY7skg9UT1b10Af4yBfx149CF
   GuxBr/a/V5UbmwTamh0LPmLCMuLinUX5H2KGmKGjGlt2Jh9DpRJRUrTAO
   eMFL2dCZqDG8XpKjpSep4/euMvlmjiWdrorcWORDxnzFZ9Kd+21TaWZlX
   Gz5G1j7XEhWfSu0AA6GmwIzSKRd434Qy1vty8R6xc6yYDpKpjoUbnvvbA
   g==;
IronPort-SDR: ywx3k3r4H444IZAhL9cB6kP7PoWxHPM9yvQW8Q6KGaZdoLe5P/D2E7+ShbdeGIqJQy8jrMe9kB
 60314IjjwQNgMoxHmvfab+oDBHyxrYtmWx8jblB0qy4Ot4NApwXmX3wxk5zbe8GXXgqh0Mvyyw
 NSjfyuVu4bz5W6dvB9R/uauakZ3S+jauGpEsR63V3xgSccpyt5Gcun8cNsq92jqHK/sxHw0Zdk
 Yn7U7vXL32VF82Oc46erwY0HPOMYEbAanYDHyXS0QdLOyzxfzhmxdl7GGlwUk4LjWtiv9p8wf/
 veg=
X-IronPort-AV: E=Sophos;i="5.76,418,1592841600"; 
   d="scan'208";a="148417368"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 12:14:26 +0800
IronPort-SDR: HxH5zfP67TmxoK5F02JdX6GCA2v3/1M9itpoJpigrhOENoGf+x44e9n5sOa+zwGsHr5JrbLsyz
 yh35YSGAlpnw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 21:00:46 -0700
IronPort-SDR: pxzRTxqFPjjEPHA7DQ8Z24sjPaGlgJe3x/sdKJggiw2aRX2Qgu0x0a0gWWP1DDHwpew1rgmfoi
 +1NCCUWDZKRA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 11 Sep 2020 21:14:26 -0700
Received: (nullmailer pid 3884290 invoked by uid 1000);
        Sat, 12 Sep 2020 04:14:24 -0000
Date:   Sat, 12 Sep 2020 13:14:24 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 19/39] btrfs: limit bio size under max_zone_append_size
Message-ID: <20200912041424.w4jhmsvrgtrcie2n@naota.dhcp.fujisawa.hgst.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
 <20200911123259.3782926-20-naohiro.aota@wdc.com>
 <20200911141719.GA15317@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200911141719.GA15317@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 11, 2020 at 03:17:19PM +0100, Christoph Hellwig wrote:
>On Fri, Sep 11, 2020 at 09:32:39PM +0900, Naohiro Aota wrote:
>> +		if (fs_info->max_zone_append_size &&
>> +		    bio_op(bio) == REQ_OP_WRITE &&
>> +		    bio->bi_iter.bi_size + size > fs_info->max_zone_append_size)
>> +			can_merge = false;
>> +
>>  		if (prev_bio_flags != bio_flags || !contig || !can_merge ||
>>  		    force_bio_submit ||
>>  		    bio_add_page(bio, page, page_size, pg_offset) < page_size) {
>
>For zoned devices you need to use bio_add_hw_page instead of so that all
>the hardware restrictions are applied.  bio_add_hw_page asso gets the
>lenght limited passed as the last parameter so we won't need a separate
>check.

I think we can't use it here. This bio is built for btrfs's logical space,
so the corresponding request queue is not available here.

Technically, we can use fs_devices->lateste_bdev. But considering this bio
can map to multiple bios to multiple devices, limiting the size of this bio
under the minimum queue_max_zone_appends_sectors() among devices is
feasible.
