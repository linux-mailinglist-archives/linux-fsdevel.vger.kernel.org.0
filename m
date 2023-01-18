Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D417767187E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 11:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjARKGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 05:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjARKFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:05:22 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE29F6B99B
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 01:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674033080; x=1705569080;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z6BysG4KL98DqsIpUTGvi6mt5tSfxRSvpbiiNzn9uKM=;
  b=SNj70+Yk6v5KDJ81NNS3VA+0nsdLwQV/J/rHY6Bi0mrQhBNaafreVLO4
   mU9HSqJeEhfScnPKChaJDG1MR10poSt40QPHrwi2C6JO5ESKbYGlnsEgw
   nAGtXzvtjA/oNNUubu8fTiaAI5x7H/7Ex/RlkQa0gq1mF0i8bGVIoY/O1
   My0R5arVuYZHPzLsZvHXKb0/q0xgu+9f+lhr/Md0ZSaK5ghDEpaeI2DSf
   hKp3rUfLPryAx7G0Hff5Oai5+zXPYkYO7CIguY4JedeMpj9OpZn1PP8Fw
   LxfJ+o/t0qwpKuYQ9J2wX6D/eBcwNWvgHrGJ5tUelFvzupfKFc/Irwszf
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,224,1669046400"; 
   d="scan'208";a="221199188"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2023 17:11:07 +0800
IronPort-SDR: arxgt4jdo+I55xnYSLuHAqYvlpD1G0Wlb3GcJpDkPKnxQSeXhgCN5V2uSdF8SmW0FoxQbd3RSa
 84OX6yL0ZfftaNXFT0zUD1zpMeHP+T3TB7hFZseVRiHEplrH59Osm0+dOG6vWBbjMG7Vo4nNzH
 i4g5vsl4cVrxUphhliBh5dYJ6FsTUIm8sCME6pJv2Es8NJRuoTWokFaa9qBGWPH+yqjKK7N0pQ
 pgZfEio66X3wSO8p5G3rFtrwTvGlaJxz8bBA5WFqGOTKTc/0CsvR/tYQ0Jpu3pqiF1lLrhlZF9
 C2g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2023 00:28:48 -0800
IronPort-SDR: lfSvhDJhXnrRR9nkzWLA8RoE4QCpfNugzAAujYRqgs43+O4Od5PgVwQoqiQ0CyqWr/SCmIkxWq
 vWWrP8dHX1kYkUCn4HB4u8nwJNMqCley8V2vol+oo4TK4RTAcdHsBfY5ru5UTC+E9hr3mv+bO6
 40Fqt2BG3UWjxNlGbxTpEKilSgjfhHa5acjnxi5ER4It9EwMdEM/rhNX+sC0ypz6BzYKopxW3y
 N/VmVET2M0ukRttUgpqoCw9pUSAo2PaHzH9EGzKY/3rB7vCnvCo1WTnUIRsDQQAn5Vhf4imNAe
 RG8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2023 01:11:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nxg3b5Qxqz1RwqL
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 01:11:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674033067; x=1676625068; bh=z6BysG4KL98DqsIpUTGvi6mt5tSfxRSvpbi
        iNzn9uKM=; b=Ga3takGvh+J+i7baxfPg8EsKVzqG8+qfIZBhYx0Y1fKrLOUEE1F
        CeqynFOIi/QYls9toCQc2be+9JUXbeUUqMD3fTt9E2ZQzVVD/rocU+UaICXzKHLR
        JpXHM9BSsdrsIhvJH4ELmOUrWeGU5hx0yMLqyxyFz2h2rykU/1pHIbUm9VLhA+ia
        XwQQ0zsq1vmGKV0b7APXF2R4L6vgHFCQfIAFt10/oNWp3yRXvnmpC+vXREgW7jWQ
        quw8DByP6O+2Hno02DR23ivqpBSrDapBZ5vf/zWXT8/ACrUGmxZ6Cb5bWA9cpQBz
        bOwip/HCJ31zLsqAntEsKMpB5vDo8Bendjg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id muTWhwzeEC3v for <linux-fsdevel@vger.kernel.org>;
        Wed, 18 Jan 2023 01:11:07 -0800 (PST)
Received: from [10.225.163.40] (unknown [10.225.163.40])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nxg3Y0J3Zz1RvLy;
        Wed, 18 Jan 2023 01:11:04 -0800 (PST)
Message-ID: <3855fa1d-ec30-2c63-c5e2-b388e8a02b3e@opensource.wdc.com>
Date:   Wed, 18 Jan 2023 18:11:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC v6 08/10] iomap/xfs: Eliminate the iomap_valid handler
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     =?UTF-8?Q?Andreas_Gr=c3=bcnbacher?= <andreas.gruenbacher@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
References: <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-9-agruenba@redhat.com>
 <20230108215911.GP1971568@dread.disaster.area>
 <CAHc6FU4z1nC8zdM8NvUyMqU29_J7_oNu1pvBHuOvR+M6gq7F0Q@mail.gmail.com>
 <20230109225453.GQ1971568@dread.disaster.area>
 <CAHpGcM+urV5LYpTZQWTRoK6VWaLx0sxk3mDe_kd3VznMY9woVw@mail.gmail.com>
 <Y8Q4FmhYehpQPZ3Z@magnolia> <Y8eeAmm1Vutq3Fc9@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y8eeAmm1Vutq3Fc9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/18/23 16:21, Christoph Hellwig wrote:
> On Sun, Jan 15, 2023 at 09:29:58AM -0800, Darrick J. Wong wrote:
>> I don't have any objections to pulling everything except patches 8 and
>> 10 for testing this week. 
> 
> That would be great.  I now have a series to return the ERR_PTR
> from __filemap_get_folio which will cause a minor conflict, but
> I think that's easy enough for Linux to handle.
> 
>>
>> 1. Does zonefs need to revalidate mappings?  The mappings are 1:1 so I
>> don't think it does, but OTOH zone pointer management might complicate
>> that.
> 
> Adding Damien.

zonefs has a static mapping of file blocks that never changes and is fully
populated up to a file max size from mount. So zonefs is not using the
iomap_valid page operation. In fact, zonefs is not even using struct
iomap_page_ops.

> 
>> 2. How about porting the writeback iomap validation to use this
>> mechanism?  (I suspect Dave might already be working on this...)
> 
> What is "this mechanism"?  Do you mean the here removed ->iomap_valid
> ?   writeback calls into ->map_blocks for every block while under the
> folio lock, so the validation can (and for XFS currently is) done
> in that.  Moving it out into a separate method with extra indirect
> functiona call overhead and interactions between the methods seems
> like a retrograde step to me.
> 
>> 2. Do we need to revalidate mappings for directio writes?  I think the
>> answer is no (for xfs) because the ->iomap_begin call will allocate
>> whatever blocks are needed and truncate/punch/reflink block on the
>> iolock while the directio writes are pending, so you'll never end up
>> with a stale mapping.
> 
> Yes.

-- 
Damien Le Moal
Western Digital Research

