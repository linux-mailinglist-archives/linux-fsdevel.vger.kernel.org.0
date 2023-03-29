Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73E66CF791
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 01:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjC2Xiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 19:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjC2Xin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:38:43 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1281FC1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680133122; x=1711669122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aODFcqxqHz5iuZ9R2+Bd+E8Nkx+iNXfbVHgy68x60n0=;
  b=pnHbg7VlRfryIZfqK57DeibJUwN4w9Ka+aUrOXVv0jF7EAjAS6SPrrP+
   1RBDk+mbKabnO7nkEgrVLhELlEQc1eBQnLI6lIqLiPTjmSseZ+/WpaKGr
   KyMiIbAjqWEdNM12EPqz014eVWgU22lmbwTxPMY+SzSZS5Ve8CEuuwKrY
   ZBcruobjacSobDcdZ1dstjmPozAC8izcuGZsOLkS3l4r1BGRJqg+VKCGL
   HnO4EUQbxgeyljLjFGvSj3SqMgmly1yCa4KE8GAcaJqT9VybC0Nea5OdN
   D1kQaaKUq+f99u9+70ByTwLJ7yUom4E9UG+JHdfWdrhIZxAUMXQfG0sJy
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226828807"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:38:40 +0800
IronPort-SDR: KwhZxzKFW85aHHSH+CGa/iXhvBlHBEohaXlqulerPQsKrHDIk4RRmMpNCZH6wmPZIFKfjJUboB
 YbW7yv0UGDqc5zzupI0IFq3rI6LNCokNWnFNvHALaMqtSp13HYsHXebj48EXzk7b7+xpkyFVH3
 qMXXXOOAFBSuvnRUzh1Munu/xArQqGlWdfk8MmRsYw+IefgOjH2wBWyoW7MdlPr++N+xpPE1f6
 qgP/57ves7INH+6iaAvMAoZf5aTpUEKpvtqZ2OZW9WSvFvI5R8ehNM0nsudSwFhC+ZWtFFSBIZ
 Kvc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:54:49 -0700
IronPort-SDR: B8CyO0z/aAC6ROlU9dmINcCvAtMw9VB9R8xO6rwu4T/qn7M07RNwpB1F0c9e5t5sUs0Gi+meAU
 njVdoqZRXWKXUlqoVIoYXfmaIykarqdBxWsqPccf60D0v+icp4lKisnS9zdRjpbLCQvTppdt1g
 3x3VRkZfxNhUfYHaFM53vA/ZFnY9nvZiw29i2izoF7yv9ra9X+ko3Pq4YwabChE5nlugB6FcyI
 AimYb+kbuvxy2lR1UDdWYGOMBSw4Z1OkSyUJjukVLaYtHRSWjQkzNeGH0O1mZgQrIzIFqeRKCG
 30M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:38:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn30J3hQYz1RtW1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 16:38:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680133119; x=1682725120; bh=aODFcqxqHz5iuZ9R2+Bd+E8Nkx+iNXfbVHg
        y68x60n0=; b=KBjlQKVFv+faQXsHdbboX8Xx9NxcmIm9AdBgDadiYuEI6iU44Gp
        jIKLTOiXkry8UpjbdYwauGh77NnsPrQSFZpCT7/P7YDoBzDw9zAFX+sbYXbItBD4
        Awy5kRAsBzpAxGEQt6/iFRAhFRIvGXb6QP2BKhHdWdA6t/8jyHKIjGtg0XDfA0ep
        9/S+K4tRXJIRFwdQ+UasHvlXj7W7pXISUVz/O/kQ1s0icT+btM6C83LvSU896SWN
        zX3mTR/5AXoqxmQ7Cm4R0QRAsxtuKFEiZ8wGyy7Y6iwGwfe3kKGL98CIKdDi6AJd
        jzR0sEF+xRcPBDw1yJoRYinpIPNolkCqMHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ePOQazKub5sg for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 16:38:39 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn30D5vG4z1RtVn;
        Wed, 29 Mar 2023 16:38:36 -0700 (PDT)
Message-ID: <84d3057f-58b3-b3da-a473-082806c4b5f2@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:38:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 16/19] md: raid1: use __bio_add_page for adding single
 page to bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <8758569c543389604d8a6a9460de086246fabe89.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8758569c543389604d8a6a9460de086246fabe89.1680108414.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/23 02:06, Johannes Thumshirn wrote:
> The sync request code uses bio_add_page() to add a page to a newly created bio.
> bio_add_page() can fail, but the return value is never checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

