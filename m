Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5F6E4AA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDQOEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 10:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjDQOEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:04:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE04146A0;
        Mon, 17 Apr 2023 07:03:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0425821A55;
        Mon, 17 Apr 2023 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681740233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEGWuvo0Ypyc7ip0nRfI9YJT0DD4AguoHU8HGyxP4Qs=;
        b=dvhqKC3djImcVEnh918Nue3ftvsqakIhA0Zd62Yhw1QZibw4VTE37w00W3xFl3ERWc5zdG
        GvpVaFP84HFru84M37epEJ5/9oxYSP3ZQ6OcazmCvqzzpctC4UYArnlNbBMS32nmDfDL+c
        7j7zSU+FA81JBspLW3OcT/K1rktGoGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681740233;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEGWuvo0Ypyc7ip0nRfI9YJT0DD4AguoHU8HGyxP4Qs=;
        b=HuOzJnOVhLnjdcbzm79Q8myziskodsd1ZbhaylgsQ/Xi8+vVmW0FdURLG1LtEm6gOW4Ydg
        CdOyU0rLGnTqjUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1E8713319;
        Mon, 17 Apr 2023 14:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I+eNNshRPWQEBQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 17 Apr 2023 14:03:52 +0000
Message-ID: <93e6a0f3-949b-a64e-676e-8eeeec1ce1c3@suse.de>
Date:   Mon, 17 Apr 2023 16:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/4] buffer: add folio_alloc_buffers() helper
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com
References: <20230417123618.22094-1-p.raghav@samsung.com>
 <CGME20230417123621eucas1p12ef0592f7d9b97bf105ff9990da22a48@eucas1p1.samsung.com>
 <20230417123618.22094-3-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230417123618.22094-3-p.raghav@samsung.com>
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
> Folio version of alloc_page_buffers() helper. This is required to convert
> create_page_buffers() to folio_create_buffers() later in the series.
> 
> alloc_page_buffers() has been modified to call folio_alloc_buffers()
> which adds one call to compound_head() but folio_alloc_buffers() removes
> one call to compound_head() compared to the existing alloc_page_buffers()
> implementation.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   fs/buffer.c                 | 23 +++++++++++++++--------
>   include/linux/buffer_head.h |  2 ++
>   2 files changed, 17 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


