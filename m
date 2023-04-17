Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1C86E4AA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjDQOEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjDQOEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:04:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482F0AD37;
        Mon, 17 Apr 2023 07:03:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99EF51FE09;
        Mon, 17 Apr 2023 14:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681740210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BTqdIaKMgfCKDmdI90DW9DHLtHV07G0du1vlR3DUGQ=;
        b=wWW5WRK2q5kqp5TCtpMDlzbRVCuKzmPJjYxET7kk6fT0D12K+qPK4+CO7sXgioEniYl7BI
        Eubqt4CDBm26clHkq+LJIPYJLx/bd13fx9SUmDPibgMsany6gEG7MoKhv5Ly46CxOHfxKB
        bgj92vzhdiCpH516IK114rE94K1piRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681740210;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BTqdIaKMgfCKDmdI90DW9DHLtHV07G0du1vlR3DUGQ=;
        b=Xu7DMrt4BpEi8IRGov+SBkcn/E8dRXm+lAlS8BVOElVeJoYpRPCMBCjOj69z2bQ1R9egr2
        wgNnwu1dltqdI/Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8470013319;
        Mon, 17 Apr 2023 14:03:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VnwGILJRPWS+BAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 17 Apr 2023 14:03:30 +0000
Message-ID: <40d568d0-9c06-780c-00b7-630af356d0df@suse.de>
Date:   Mon, 17 Apr 2023 16:03:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/4] fs/buffer: add folio_set_bh helper
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com
References: <20230417123618.22094-1-p.raghav@samsung.com>
 <CGME20230417123620eucas1p266aa61d2213f94bbe028a98be73b70fc@eucas1p2.samsung.com>
 <20230417123618.22094-2-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230417123618.22094-2-p.raghav@samsung.com>
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
> The folio version of set_bh_page(). This is required to convert
> create_page_buffers() to folio_create_buffers() later in the series.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   fs/buffer.c                 | 15 +++++++++++++++
>   include/linux/buffer_head.h |  2 ++
>   2 files changed, 17 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


