Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15A17BE5D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 18:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377114AbjJIQEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 12:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377106AbjJIQEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:04:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B399;
        Mon,  9 Oct 2023 09:04:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47AB621885;
        Mon,  9 Oct 2023 16:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696867488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLrtq61I2S0cToZBib/cJSy8l48RNzXOA1hvvbyOcVw=;
        b=Mr38JGJFjkHEHogb8j2ImpDNRltdr68BiPqMf/56ruc2lWi2zb7p4/qD+DxY5DI3VKAhLg
        UKqSbvdcMd0DjO83e8Em15CdLmueOm8+cfCej5Zl0N/uZhyJYw+wKXfqwXoLcq/OYtpWSE
        eSlEetIPSwvdOKEb8S41Ns1jgqo185g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696867488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLrtq61I2S0cToZBib/cJSy8l48RNzXOA1hvvbyOcVw=;
        b=lrC8CBCcgX71SDRJDSQYJ7pPeh0XnW9UNEjzqMOx9LBdlz26yoCQpqPMba2ZTipx5K91Qh
        b1AOepPg3X22PCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2531F13586;
        Mon,  9 Oct 2023 16:04:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8GpbCKAkJGXkRAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 Oct 2023 16:04:48 +0000
Message-ID: <e0300e5a-394d-0cdf-4044-a9a67a24c9b3@suse.cz>
Date:   Mon, 9 Oct 2023 18:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] mm: abstract merge for new VMAs into
 vma_merge_new_vma()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <cover.1696795837.git.lstoakes@gmail.com>
 <f38b4333badbdabdb141d5ecc59518f50e5d3493.1696795837.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <f38b4333badbdabdb141d5ecc59518f50e5d3493.1696795837.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/23 22:23, Lorenzo Stoakes wrote:
> Only in mmap_region() and copy_vma() do we add VMAs which occupy entirely
> new regions of virtual memory.
> 
> We can share the logic between these invocations and make it absolutely
> explici to reduce confusion around the rather inscrutible parameters

explicit ... inscrutable

> possessed by vma_merge().
> 
> This also paves the way for a simplification of the core vma_merge()
> implementation, as we seek to make the function entirely an implementation
> detail.
> 
> Note that on mmap_region(), vma fields are initialised to zero, so we can
> simply reference these rather than explicitly specifying NULL.

Right, if they were different from NULL, the code would be broken already.

> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

