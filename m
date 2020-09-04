Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD125DD05
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 17:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgIDPRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 11:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbgIDPRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:17:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0DEC061244
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2020 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1PD1rFq3d5PVVBt0yU5bcx1/iksHX586uEiGDyFPoT8=; b=GRVY+xgmG7FWuumJiOaPV8hzCP
        MOpKjakBFc3bZetH60ojtSw9WbQk3GM6ctu4SPDxWmNaEdHWXcRxB8zpobyxPIg3pxRNmBFniJGoI
        67buLfWkb0bJG/dJeZI5E5IpsPd83qJOj29hOclQTyywRQTGDpxxm77+j3Znh5hMMAYYXaiFBeP3S
        X2utFNZKx2ukK778E8ISZdCi/vOnjfFGeWvBvG9jXrEMaeLtgAYIg8pdsQmHjf2Gyk2QmumWbr34R
        TUEqe20JnDDJFXtkirCFx1myDD2duzQWYXw3VzqSSUbXSWfQ5ldZhBIIs1xScmouDziq0VKgwnLx+
        El4+DtPQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEDT4-0002z7-L1; Fri, 04 Sep 2020 15:17:35 +0000
Subject: Re: [PATCH 3/3] zonefs: document the explicit-open mount option
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org
References: <20200904112328.28887-1-johannes.thumshirn@wdc.com>
 <20200904112328.28887-4-johannes.thumshirn@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <79f72527-00e5-8707-0b7b-aaf90d9dc163@infradead.org>
Date:   Fri, 4 Sep 2020 08:17:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904112328.28887-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 9/4/20 4:23 AM, Johannes Thumshirn wrote:
> Document the newly introduced explicit-open mount option.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  Documentation/filesystems/zonefs.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/filesystems/zonefs.rst b/Documentation/filesystems/zonefs.rst
> index 6c18bc8ce332..ff8bc3634bad 100644
> --- a/Documentation/filesystems/zonefs.rst
> +++ b/Documentation/filesystems/zonefs.rst
> @@ -326,6 +326,21 @@ discover the amount of data that has been written to the zone. In the case of a
>  read-only zone discovered at run-time, as indicated in the previous section.
>  The size of the zone file is left unchanged from its last updated value.
>  
> +A zoned block device (e.g. a NVMe Zoned Namespace device) may have

I would say                   an NVMe

> +limits on the number of zones that can be active, that is, zones that
> +are in the the implicit open, explicit open or closed conditions.

          ^^ duplicate "the"

> +This potential limitation translate into a risk for applications to see

                             translates

> +write IO errors due to this limit being exceeded if the zone of a file
> +is not already active when a write request is issued by the user.
> +
> +To avoid these potential errors, the "explicit-open" mount option
> +forces zones to be made active using an open zone command when a file
> +is open for writing for the first time. If the zone open command

      opened

> +succeeds, the application is then guaranteed that write requests can be
> +processed. Conversely, the "explicit-open" mount option will result in
> +a zone close command being issued to the device on the last close() of
> +a zone file if the zone is not full nor empty.
> +
>  Zonefs User Space Tools
>  =======================
>  
> 

thanks.
-- 
~Randy

