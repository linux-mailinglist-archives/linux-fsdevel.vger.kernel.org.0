Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722C46B148C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 22:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCHVzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 16:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCHVyq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:54:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0835DBC7B1;
        Wed,  8 Mar 2023 13:54:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8755321A51;
        Wed,  8 Mar 2023 21:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678312471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZffRSpnIz3pxkGcZXFr/83FfQBrEkTYvERBDI5T6DPQ=;
        b=We7y8kny4V3YEjS9jQYfqTqjmHPuw4W6uBXftAIJbK+vQHFUYqZ+V/W8p/6/7ExyZAlyl5
        z4+yrqwwwFJOHIm+blA7DnLjclZIkosaZ55VDy1s6vH7oiJevHamMs96VV5yZ+JVRj3+jG
        jB1VrX4/KPWstxkSA+zYk2P2pBbNCKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678312471;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZffRSpnIz3pxkGcZXFr/83FfQBrEkTYvERBDI5T6DPQ=;
        b=dOj8qjqM7WATrweRSGyw7OFtgLGzuqeHRpH1Xmm2ceEHb5nlTP0Gavt8o4XjUL/vbnnP5s
        wLQbxTsXeDXpjKDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58FFF1348D;
        Wed,  8 Mar 2023 21:54:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id waDXFBcECWR1VwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Mar 2023 21:54:31 +0000
Message-ID: <cd60d29e-9512-dcc6-e72a-a4936fed42f5@suse.cz>
Date:   Wed, 8 Mar 2023 22:54:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 2/2] mm: compaction: Limit the value of interface
 compact_memory
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ye.xingchen@zte.com.cn, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <202303061405242788477@zte.com.cn>
 <c48666f2-8226-3678-a744-6d613288f188@suse.cz>
 <ZAjorPD2nSszUsXz@bombadil.infradead.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZAjorPD2nSszUsXz@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/8/23 20:57, Luis Chamberlain wrote:
> On Wed, Mar 08, 2023 at 11:23:45AM +0100, Vlastimil Babka wrote:
>> >  {
>> > -	if (write)
>> > +	int ret;
>> > +
>> > +	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
>> > +	if (ret)
>> > +		return ret;
>> > +	if (write) {
>> > +		pr_info("compact_nodes start\n");
>> >  		compact_nodes();
>> > +		pr_info("compact_nodes end\n");
>> 
>> I'm not sure we want to start spamming the dmesg. This would make sense
>> if we wanted to deprecate the sysctl and start hunting for remaining
>> callers to be fixed. Otherwise ftrace can be used to capture e.g. the time.
> 
> Without that print, I don't think a custom proc handler is needed too,
> right? So what would simplify the code.

But we'd still call compact_nodes(), so that's not possible without a custom
handler, no?

>   Luis

