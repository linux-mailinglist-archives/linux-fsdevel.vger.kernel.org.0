Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6226D32C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 07:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIQFjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 01:39:37 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36405 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQFjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 01:39:36 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 01:39:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600321176; x=1631857176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C+tNjfAB8G7xN42sK6N2ECKfbEjUHhJ8IAL/lOjYzLw=;
  b=b7weoAcNkTujmxZGvx8m6MmoHIRjOmRxSUmsJU95Ezp7VxNGlrvCUquM
   wv1Rai0x6Xx/GN0zjTD7soX11K70Ckd+chx8RipFWnTQGhUDs/WSudDF8
   VIWgq3G1nB2cHrb3b9fNCQdXfVvwRW/96jDcQtl++wy9DE4VcxnfoFWj1
   R9YxzxY6ug/fNc64BlWSUIcvSJY8K2JixGCjMD05BZZcOu3+jt0jTRFNc
   WT9yG/PakEaWzuclJtKvmqoIs+UiChW5ivQZz/7E1SC5hqubyIJQMRTqp
   wfNYVTPEumiT1HZoPbTVZpabiLxbjC5JP42yaJOciNQDo0elzgNjyPaWn
   w==;
IronPort-SDR: 3STTfhUIYj3xXMkcnUS/3P7xFUGojbrZYr/9biFC4iCWDLYb4c4gLdmO2RBu6bAAq37ZeLJx4W
 FNgIOHQ4I0So1HoaQ8hUC+PkG4R4Mchh1ZULV1Osy8FYcZQXxNuhEOpmxtuFcTnIXUVAv+BJmW
 /iKQZ7LH3aBxSCKYI7LZ/LB4eJfFDafXVNUmv6RgJQCenp9XFbr+5GzdurSNV6URm8QG/pmoaH
 Pg4EagOz68ao7e8EOsJW4io5L3HbneddrauflNN+jB1rWlXJKYveZGxdOkrYdP2UD2MbCdYhCo
 TtQ=
X-IronPort-AV: E=Sophos;i="5.76,435,1592841600"; 
   d="scan'208";a="148829733"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 13:32:27 +0800
IronPort-SDR: aqIb4wp2T5WziIul2uPQn9/+ukadWLjMm6ctoiss1WAUGbIhCvlghesk+yVwRIHiVbPoIVHv0m
 tGWIYFormwOQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 22:19:35 -0700
IronPort-SDR: oRQWlAkM6hdbX6UA7u08OT1QRFATMInnFf7IR/oNyAfd4goMLoPvwgc9DzMxL6EdIyWrmpTUee
 VEv4dEUbHP+g==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 16 Sep 2020 22:32:26 -0700
Received: (nullmailer pid 816930 invoked by uid 1000);
        Thu, 17 Sep 2020 05:32:25 -0000
Date:   Thu, 17 Sep 2020 14:32:25 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 19/39] btrfs: limit bio size under max_zone_append_size
Message-ID: <20200917053225.zs2ebj63mz2mwd2r@naota.dhcp.fujisawa.hgst.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
 <20200911123259.3782926-20-naohiro.aota@wdc.com>
 <20200911141719.GA15317@infradead.org>
 <20200912041424.w4jhmsvrgtrcie2n@naota.dhcp.fujisawa.hgst.com>
 <20200912053056.GA15640@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200912053056.GA15640@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 06:30:56AM +0100, Christoph Hellwig wrote:
>On Sat, Sep 12, 2020 at 01:14:24PM +0900, Naohiro Aota wrote:
>> > For zoned devices you need to use bio_add_hw_page instead of so that all
>> > the hardware restrictions are applied.  bio_add_hw_page asso gets the
>> > lenght limited passed as the last parameter so we won't need a separate
>> > check.
>>
>> I think we can't use it here. This bio is built for btrfs's logical space,
>> so the corresponding request queue is not available here.
>>
>> Technically, we can use fs_devices->lateste_bdev. But considering this bio
>> can map to multiple bios to multiple devices, limiting the size of this bio
>> under the minimum queue_max_zone_appends_sectors() among devices is
>> feasible.
>
>Well, how do you then ensure the bio actually fits all the other
>device limits as well?  e.g. max segment size, no SG gaps policy,
>etc?

Yeah, that's problematic, and I realized we could not deal with all the
restrictions in this manner. I'm reimplementing this patch basing on
bio_add_hw_page().

Regards,
