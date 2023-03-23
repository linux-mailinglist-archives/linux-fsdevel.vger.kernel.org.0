Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96746C6D3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjCWQTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 12:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjCWQTX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:19:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F2360AD;
        Thu, 23 Mar 2023 09:19:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C9D6337DC;
        Thu, 23 Mar 2023 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679588356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4ZejUgHNBoIjTb4eED8RR0YUHjbR+xKrnQmSeErxMw=;
        b=WMWERatqz41ixro5GhfGVr8b8iAVlTwVj5ezWdvfgYe3vGmxoOuZSiKTym9KewA+YFvUgf
        YWNt0Lca2jtbWL2XuSLOaNxixkgbwRGwtkaE4HGC496dIjiF/6lHuiBhig0uFSZNuJwEz1
        +oxK7q7AFoThIPE8yPenkijzcJlKZ3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679588356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4ZejUgHNBoIjTb4eED8RR0YUHjbR+xKrnQmSeErxMw=;
        b=nfSFgFgZsj6b1ReqqCKhiz2dmROFutClwCrf4Roga/gjUf5C+fdd7T4LLHgeGfDr+XffY+
        mXszwF5vJUJ80BDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D66B132C2;
        Thu, 23 Mar 2023 16:19:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wWS2BQR8HGThQwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 23 Mar 2023 16:19:16 +0000
Message-ID: <8ff68064-3ec6-4aa2-2389-3568483a1bd4@suse.cz>
Date:   Thu, 23 Mar 2023 17:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V5 1/2] mm: compaction: move compaction sysctl to its own
 file
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, ye.xingchen@zte.com.cn
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <202303221046286197958@zte.com.cn>
 <ZBq9uO6wLI1fX1x/@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZBq9uO6wLI1fX1x/@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/22/23 09:35, Christoph Hellwig wrote:
> On Wed, Mar 22, 2023 at 10:46:28AM +0800, ye.xingchen@zte.com.cn wrote:
>> From: Minghao Chi <chi.minghao@zte.com.cn>
>> 
>> This moves all compaction sysctls to its own file.
> 
> So there's a whole lot of these 'move sysctrls to their own file'
> patches, but no actual explanation of why that is desirable.  Please

I think Luis started this initiative, maybe he can provide the canonical
reasoning :)

> explain why we'd want to split code that is closely related, and now
> requires marking symbols non-static just to create a new tiny source
> file.

Hmm? I can see the opposite, at least in the compaction patch here. Related
code and variables are moved closer together, made static, declarations
removed from headers. It looks like an improvement to me.
