Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599E56E4AB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjDQOE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 10:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjDQOEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:04:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C93AD2D;
        Mon, 17 Apr 2023 07:04:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0710D1FE08;
        Mon, 17 Apr 2023 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681740269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycM1AOyv1F/XUPy2gbfeKh5eBkX4JsUiYSyjOqVQtx4=;
        b=XF0wZWA4xIonh3zCNRa8cZn8519jWhKgWvvwbClKrxZj/EBZPo7ZsOAh8v7VPbl2rBOL8F
        aDfLEe2vEx7UCDTvMRSMC5GK6Q0wFQ3wZJUffDszBY10D5HudvVERp0OWUMUuDpNfF6qzp
        VZorKZCAI2BZ56sfMWcS4B2boHWVeIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681740269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycM1AOyv1F/XUPy2gbfeKh5eBkX4JsUiYSyjOqVQtx4=;
        b=+6+EYRwYIGfnz07+d4x7mvHJQxZcSV3BOwepFPXMBAX56SPzVReGfEooPI9X2rF80nQIqu
        4li3M7zWnseL9qBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D858C13319;
        Mon, 17 Apr 2023 14:04:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 54hiNOxRPWRYBQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 17 Apr 2023 14:04:28 +0000
Message-ID: <0e0de23a-fe6f-c6a1-aeaf-272185ad9e56@suse.de>
Date:   Mon, 17 Apr 2023 16:04:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/4] fs/buffer: add folio_create_empty_buffers helper
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com
References: <20230417123618.22094-1-p.raghav@samsung.com>
 <CGME20230417123621eucas1p23d1669a8b1e27d4dec64626dcb7fbd78@eucas1p2.samsung.com>
 <20230417123618.22094-4-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230417123618.22094-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/17/23 14:36, Pankaj Raghav wrote:
> Folio version of create_empty_buffers(). This is required to convert
> create_page_buffers() to folio_create_buffers() later in the series.
> 
> It removes several calls to compound_head() as it works directly on folio
> compared to create_empty_buffers(). Hence, create_empty_buffers() has
> been modified to call folio_create_empty_buffers().
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   fs/buffer.c                 | 28 +++++++++++++++++-----------
>   include/linux/buffer_head.h |  2 ++
>   2 files changed, 19 insertions(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


