Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3EB6E4AC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 16:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjDQOFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 10:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjDQOFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:05:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30AAD2D;
        Mon, 17 Apr 2023 07:05:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6F2E21A28;
        Mon, 17 Apr 2023 14:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681740310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2Kw0MpCi51zXkuO9aViVXXZ/EpbYnLUZHb6Onu8q9k=;
        b=T23EFI35GqdR476O9VuJta6qFDYtabrqgSkRjqEkslCc5NV7hh+ofaxnzvVfBOgnzmWEKR
        pWK4DQXJ6ukZSndvzZCG3xtsvyNp3ocYUfRFtBW/FqgfzBCPQR+G+/U5su+061FqxdyihM
        uGWZ7OBAM+pMtSIelpiiFNJ+jqUjGRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681740310;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2Kw0MpCi51zXkuO9aViVXXZ/EpbYnLUZHb6Onu8q9k=;
        b=XkMcp6YV8o6hFXl97TVCEUJ069622kwGtNGM3LfGA5di+HCxYS8eHb8NLiTr4ZQbOgXSKi
        0C5kXQZPUqd2mjDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBC5D13319;
        Mon, 17 Apr 2023 14:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BwMIMRZSPWTKBQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 17 Apr 2023 14:05:10 +0000
Message-ID: <24b77b42-0f31-2750-e792-dc80673eb56b@suse.de>
Date:   Mon, 17 Apr 2023 16:05:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/4] fs/buffer: convert create_page_buffers to
 folio_create_buffers
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com
References: <20230417123618.22094-1-p.raghav@samsung.com>
 <CGME20230417123627eucas1p2d3e6824e87d4fdadf459be74845ea0a8@eucas1p2.samsung.com>
 <20230417123618.22094-5-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230417123618.22094-5-p.raghav@samsung.com>
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
> fs/buffer do not support large folios as there are many assumptions on
> the folio size to be the host page size. This conversion is one step
> towards removing that assumption. Also this conversion will reduce calls
> to compound_head() if folio_create_buffers() calls
> folio_create_empty_buffers().
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   fs/buffer.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


