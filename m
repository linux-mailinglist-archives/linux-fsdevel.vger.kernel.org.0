Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653506A9661
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 12:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjCCLdz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 06:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCCLdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:33:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C086BF;
        Fri,  3 Mar 2023 03:33:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2155820486;
        Fri,  3 Mar 2023 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677843158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftPd+/KA8GuftZeu1TCJzKZ8qqNn8uo/UAv2HZB2u88=;
        b=nPBF0bLUd8zZtssITYd6w1qecyBCwySvHXeDOWwbU76U/80+iNS2upElL/n8peRUpY45P8
        2SW3+l1zK4SPJUy4H6F+lKssXeEFG8EW8cqF4iQhRrsVO+cpjkUGfzObKYCvvGv1qgwruv
        pJuxVkdxLy5qiTU80UqZU+y6wBvAE1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677843158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftPd+/KA8GuftZeu1TCJzKZ8qqNn8uo/UAv2HZB2u88=;
        b=XhAkiEE50W5B5gwIo0Gk+KTFctuTOZtQwWnttLFogVcgYXpiI/B/6h9VsrlIeQy4u5v/Gq
        OoNkmKgej8k3skCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07DA91329E;
        Fri,  3 Mar 2023 11:32:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rFJkAdbaAWRlMwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 03 Mar 2023 11:32:38 +0000
Message-ID: <b8819a53-36f2-31c1-2640-8f0c97f72164@suse.de>
Date:   Fri, 3 Mar 2023 12:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/23 04:49, Matthew Wilcox wrote:
> On Thu, Mar 02, 2023 at 06:58:58PM -0700, Keith Busch wrote:
>> That said, I was hoping you were going to suggest supporting 16k logical block
>> sizes. Not a problem on some arch's, but still problematic when PAGE_SIZE is
>> 4k. :)
> 
> I was hoping Luis was going to propose a session on LBA size > PAGE_SIZE.
> Funnily, while the pressure is coming from the storage vendors, I don't
> think there's any work to be done in the storage layers.  It's purely
> a FS+MM problem.

Would love to have that session, though.
Luis?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)

