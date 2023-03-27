Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4486CA15F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjC0K1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 06:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjC0K1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:27:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7F040C6;
        Mon, 27 Mar 2023 03:27:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E78121C2D;
        Mon, 27 Mar 2023 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679912839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zeAapTweggWvHmqJXKCAVkq4U6iU7yqVvakxDRPJlY=;
        b=ZZLqyqejDT1+lC/IQ0gMRG3AlrSFychR3wkDlFd5FSCq4EHG5rTAB/qYAVNJQbOIZaa/tE
        9cEv58WBEa0T1IlSWuMEanv6r13TJnifohbH+RP8aLpowMFBupa8uoRGKOlpODLKZ3rmVy
        pQUpQMYyyQA6DFVHIlMKLaykAM7kom4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679912839;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zeAapTweggWvHmqJXKCAVkq4U6iU7yqVvakxDRPJlY=;
        b=Ogoao4Ypl7iEHpBZ/JQCvSxu+zhkwLijk7xqr9zPLv5AZW9ZPSzECLFMgU2/19hvPq5spU
        YIMBoNA3iXeoSNBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3BF313329;
        Mon, 27 Mar 2023 10:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NGBvMoZvIWTTBgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 27 Mar 2023 10:27:18 +0000
Message-ID: <067f7347-ba10-5405-920c-0f5f985c84f4@suse.cz>
Date:   Mon, 27 Mar 2023 12:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V5 1/2] mm: compaction: move compaction sysctl to its own
 file
Content-Language: en-US
To:     ye xingchen <yexingchen116@gmail.com>, mcgrof@kernel.org
Cc:     akpm@linux-foundation.org, chi.minghao@zte.com.cn,
        hch@infradead.org, keescook@chromium.org, linmiaohe@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, ye.xingchen@zte.com.cn,
        yzaikin@google.com
References: <ZB3n1pJZsOK+E/Zk@bombadil.infradead.org>
 <20230327024939.75976-1-ye.xingchen@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230327024939.75976-1-ye.xingchen@zte.com.cn>
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

On 3/27/23 04:49, ye xingchen wrote:
>>> >$ ./scripts/bloat-o-meter vmlinux.old vmlinux
>>> >add/remove: 1/0 grow/shrink: 1/2 up/down: 346/-350 (-4)
>>> >Function                                     old     new   delta
>>> >vm_compaction                                  -     320    +320
>>> >kcompactd_init                               167     193     +26
>>> >proc_dointvec_minmax_warn_RT_change          104      10     -94
>>> >vm_table                                    2112    1856    -256
>>> >Total: Before=19287558, After=19287554, chg -0.00%
>>> >
>>> >So I don't think we need to pause this move or others where are have savings.
>>> >
>>> >Minghao, can you fix the commit log, and explain how you are also saving
>>> >4 bytes as per the above bloat-o-meter results?
>>> 
>>> $ ./scripts/bloat-o-meter vmlinux vmlinux.new
>>> add/remove: 1/0 grow/shrink: 1/1 up/down: 350/-256 (94)
>>> Function                                     old     new   delta
>>> vm_compaction                                  -     320    +320
>>> kcompactd_init                               180     210     +30
>>> vm_table                                    2112    1856    -256
>>> Total: Before=21104198, After=21104292, chg +0.00%
>>> 
>>> In my environment, kcompactd_init increases by 30 instead of 26.
>>> And proc_dointvec_minmax_warn_RT_change No expansion.
>>
>>How about a defconfig + compaction enabled? Provide that information
>>and let Vlastimal ACK/NACK the patch.
> I use x86_defconfig and linux-next-20230327 branch
> $ make defconfig;make all -j120
> CONFIG_COMPACTION=y
> 
> add/remove: 1/0 grow/shrink: 1/1 up/down: 350/-256 (94)
> Function                                     old     new   delta
> vm_compaction                                  -     320    +320
> kcompactd_init                               180     210     +30
> vm_table                                    2112    1856    -256
> Total: Before=21119987, After=21120081, chg +0.00%

No savings then, but to me the patch still seems a worthwile cleanup. But if
others think the 94 bytes are an issue, it can wait for the new APIs.
