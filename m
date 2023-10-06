Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272657BB2EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 10:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjJFIT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjJFIT6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:19:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A2CE4;
        Fri,  6 Oct 2023 01:19:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4011BC433C9;
        Fri,  6 Oct 2023 08:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696580396;
        bh=el4EO5rlsyDaQMavd+QMNqRtr1dlRDpo9KlRFmmRZJ4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qZd6LzWSz6uOiByQX5NS4YzdEpk7FxTzMejOLJnTY0ubev7ptvi/TCvxDcJA3UhlT
         Uamu8zpwnRCUN0jAxLT5LK6aHlv8mCFfGblWaXTQl7i4oY6AxhZizrHhpilBgS54Gw
         q42yIBTmH0ySUYgpYAuipBAOCo4S3/GBUKJx+gmjqpmR99y54+rTH+e6MAjmFh3feG
         isnnLZsUx7EzMHlhbTBmzSrG+1zPg8Vc7TkkBUIALsim+PReK8JgwLsyaTRlCbFy6N
         jOMEkO0uguJiaH61MekaXITkdx3B61SbkxY3o2a5zYgFXPR4mv7S5RzuEcmW7h7zEj
         R0Cq0R6K11Fnw==
Message-ID: <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
Date:   Fri, 6 Oct 2023 17:19:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O priority
 bitfield
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Hannes Reinecke <hare@suse.de>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231005194129.1882245-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/6/23 04:40, Bart Van Assche wrote:
> The NVMe and SCSI standards define 64 different data lifetimes. Support
> storing this information in the I/O priority bitfield.
> 
> The current allocation of the 16 bits in the I/O priority bitfield is as
> follows:
> * 15..13: I/O priority class
> * 12..6: unused
> * 5..3: I/O hint (CDL)
> * 2..0: I/O priority level
> 
> This patch changes this into the following:
> * 15..13: I/O priority class
> * 12: unused
> * 11..6: data lifetime
> * 5..3: I/O hint (CDL)
> * 2..0: I/O priority level
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/uapi/linux/ioprio.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index bee2bdb0eedb..efe9bc450872 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -71,7 +71,7 @@ enum {
>   * class and level.
>   */
>  #define IOPRIO_HINT_SHIFT		IOPRIO_LEVEL_NR_BITS
> -#define IOPRIO_HINT_NR_BITS		10
> +#define IOPRIO_HINT_NR_BITS		3
>  #define IOPRIO_NR_HINTS			(1 << IOPRIO_HINT_NR_BITS)
>  #define IOPRIO_HINT_MASK		(IOPRIO_NR_HINTS - 1)
>  #define IOPRIO_PRIO_HINT(ioprio)	\
> @@ -102,6 +102,12 @@ enum {
>  	IOPRIO_HINT_DEV_DURATION_LIMIT_7 = 7,
>  };
>  
> +#define IOPRIO_LIFETIME_SHIFT		(IOPRIO_HINT_SHIFT + IOPRIO_HINT_NR_BITS)
> +#define IOPRIO_LIFETIME_NR_BITS		6
> +#define IOPRIO_LIFETIME_MASK		((1u << IOPRIO_LIFETIME_NR_BITS) - 1)
> +#define IOPRIO_PRIO_LIFETIME(ioprio)					\
> +	((ioprio >> IOPRIO_LIFETIME_SHIFT) & IOPRIO_LIFETIME_MASK)
> +
>  #define IOPRIO_BAD_VALUE(val, max) ((val) < 0 || (val) >= (max))

I am really not a fan of this. This essentially limits prio hints to CDL, while
the initial intent was to define the hints as something generic that depend on
the device features. With your change, we will not be able to support new
features in the future.

Your change seem to assume that it makes sense to be able to combine CDL with
lifetime hints. But does it really ? CDL is of dubious value for solid state
media and as far as I know, UFS world has not expressed interest. Conversely,
data lifetime hints do not make much sense for spin rust media where CDL is
important. So I would say that the combination of CDL and lifetime hints is of
dubious value.

Given this, why not simply define the 64 possible lifetime values as plain hint
values (8 to 71, following 1 to 7 for CDL) ?

The other question here if you really want to keep the bit separation approach
is: do we really need up to 64 different lifetime hints ? While the scsi
standard allows that much, does this many different lifetime make sense in
practice ? Can we ever think of a usecase that needs more than say 8 different
liftimes (3 bits) ? If you limit the number of possible lifetime hints to 8,
then we can keep 4 bits unused in the hint field for future features.


-- 
Damien Le Moal
Western Digital Research

