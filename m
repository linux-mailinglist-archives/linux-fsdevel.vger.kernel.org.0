Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76876CB9F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 10:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjC1I44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 04:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1I4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:56:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BED19A1;
        Tue, 28 Mar 2023 01:56:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34513219C2;
        Tue, 28 Mar 2023 08:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679993813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nh59YKaOupZZpTW1uDmCRUQ1aAKohqr+w5EA7d7jR+o=;
        b=t2sipxadwSudSlY5Uvh6MJVXEiPOV924bCkqtrbZIXG9TkRf6kcSA5opwqRVMm50tG08H7
        NMLk4pWmyyRlCWYTkuMZVw823ynOk0+WT1aqAEdwyRdusV+U2XIC0M+4OU0xC8BpQJN3Zo
        aJAjx9sOTgpWEcZaBn/Z8VELsr7fE6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679993813;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nh59YKaOupZZpTW1uDmCRUQ1aAKohqr+w5EA7d7jR+o=;
        b=ZPtqPIHV2b/ncSH9qfDV+t916jW0VhX2ALCoE49wzX5TOKprWRiheCiQVk9+9cdvDibeyk
        WNOTkluVrkaC4+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BAEE1390B;
        Tue, 28 Mar 2023 08:56:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zhMtAtWrImRqNQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 28 Mar 2023 08:56:53 +0000
Message-ID: <a231f05c-b157-f495-bf06-8aca903c7e17@suse.cz>
Date:   Tue, 28 Mar 2023 10:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V8 1/2] mm: compaction: move compaction sysctl to its own
 file
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, mcgrof@kernel.org
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, chi.minghao@zte.com.cn,
        linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <202303281446280457758@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202303281446280457758@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/28/23 08:46, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> This moves all compaction sysctls to its own file.
> 
> Move sysctl to where the functionality truly belongs to improve
> readability, reduce merge conflicts, and facilitate maintenance.
> 
> I use x86_defconfig and linux-next-20230327 branch
> $ make defconfig;make all -jn
> CONFIG_COMPACTION=y
> 
> add/remove: 1/0 grow/shrink: 1/1 up/down: 350/-256 (94)
> Function                                     old     new   delta
> vm_compaction                                  -     320    +320
> kcompactd_init                               180     210     +30
> vm_table                                    2112    1856    -256
> Total: Before=21119987, After=21120081, chg +0.00%
> 
> Despite the addition of 94 bytes the patch still seems a worthwile
> cleanup.
> 
> Link: https://lore.kernel.org/lkml/067f7347-ba10-5405-920c-0f5f985c84f4@suse.cz/
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.
