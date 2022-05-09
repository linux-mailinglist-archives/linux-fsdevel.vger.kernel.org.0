Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAF451FEC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbiEINuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 09:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiEINuh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 09:50:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9232116C5FB;
        Mon,  9 May 2022 06:46:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 26EE41F96D;
        Mon,  9 May 2022 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652104002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rOjy9GcmKAVFiB1PbhQUEeueQH6ZA7wEZEWBu7URXvI=;
        b=GkxT8Km4XwSCknfVFZqIdoV86zXFJx0Pk8sj4kOmG3oC6IpWXnF00PfE83eY60NWehMIYZ
        oURO2dN+0DSv3Z50Br9g1WYVYfmEwJIBLxMiQ3qaNDmnJI8RQ1HNDDJ/sS2LPZ0Sw+/itO
        dNwbG6gs4PVL9nYD0pOvNlaZCM+He+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652104002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rOjy9GcmKAVFiB1PbhQUEeueQH6ZA7wEZEWBu7URXvI=;
        b=hC9KfrqM07Lg5LkEuVlRu+7gpfO2ce5W6Pn+K5Dn/hUp3f9P3zGmMW2E69Bg+jtN08+MpC
        CEF2XYHQsEIkcCAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA22813AA5;
        Mon,  9 May 2022 13:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vaAoOEEbeWITagAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 May 2022 13:46:41 +0000
Message-ID: <df969c26-4fd4-1325-b3c2-07e4ef45dffe@suse.cz>
Date:   Mon, 9 May 2022 15:46:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [v3 PATCH 5/8] mm: khugepaged: make khugepaged_enter() void
 function
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220404200250.321455-1-shy828301@gmail.com>
 <20220404200250.321455-6-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220404200250.321455-6-shy828301@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/4/22 22:02, Yang Shi wrote:
> The most callers of khugepaged_enter() don't care about the return
> value.  Only dup_mmap(), anonymous THP page fault and MADV_HUGEPAGE handle
> the error by returning -ENOMEM.  Actually it is not harmful for them to
> ignore the error case either.  It also sounds overkilling to fail fork()
> and page fault early due to khugepaged_enter() error, and MADV_HUGEPAGE
> does set VM_HUGEPAGE flag regardless of the error.
> 
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
