Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA67303EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbjFNPfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFNPfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:35:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D99EB6;
        Wed, 14 Jun 2023 08:35:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F41081FDB5;
        Wed, 14 Jun 2023 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686756903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZQgDi2VbOJpatdj+K52qKpMPGdEGQyZQB7VZLDRrk0=;
        b=fUFVVC3XA/mDZqMaAEfUGeGjVt9wOWzjWc+k0KQr04POAEBD8IDz6iZ9S4+/FWked+CqTL
        N54EvcEqNVNtgI9C7AnjQ9FBX0GKusVOr6HxuizQr8vtDp9I74hUhiAuwI3jKZHPRkTCX0
        NRa90g24DNZMo894Pk4AP1FK6LWTSX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686756903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZQgDi2VbOJpatdj+K52qKpMPGdEGQyZQB7VZLDRrk0=;
        b=a3SNS2gseRlaWZ4Uk7ssBaGnd+YEFqWgniZp4QSerAuSO5oD9qbSnjsL+Lw/SZML4ijWs/
        1Rrw8eErycXi86CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC8B81357F;
        Wed, 14 Jun 2023 15:35:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rdIILCbeiWTDHwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 14 Jun 2023 15:35:02 +0000
Message-ID: <cfa191cc-47e4-5b61-bf4f-33ebd52fa783@suse.de>
Date:   Wed, 14 Jun 2023 17:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/7] RFC: high-order folio support for I/O
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230614114637.89759-1-hare@suse.de>
 <cd816905-0e3e-6397-1a6f-fd4d29dfc739@suse.de>
 <ZInGbz6X/ZQAwdRx@casper.infradead.org>
 <b3fa1b77-d120-f86b-e02f-f79b6d13efcc@suse.de>
In-Reply-To: <b3fa1b77-d120-f86b-e02f-f79b6d13efcc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/14/23 17:06, Hannes Reinecke wrote:
[ .. ]
> 
> Whee! That works!
> 
> Rebased things with your memcpy_{to,from}_folio() patches, disabled that 
> chunk, and:
> 
> # mount /dev/ram0 /mnt
> XFS (ram0): Mounting V5 Filesystem 5cd71ab5-2d11-4c18-97dd-71708f40e551
> XFS (ram0): Ending clean mount
> xfs filesystem being mounted at /mnt supports timestamps until 
> 2038-01-19 (0x7fffffff)
> # umount /mnt
> XFS (ram0): Unmounting Filesystem 5cd71ab5-2d11-4c18-97dd-71708f40e551
> 
> Great work, Matthew!
> 
> (Now I just need to check why copying data from NFS crashes ...)
> 
Hmm. And for that I'm hitting include/linux/pagemap.h:1250 pretty 
consistently; something's going haywire with readahead.

Matthew, are you sure that this one:

/** 

  * readahead_length - The number of bytes in this readahead request. 

  * @rac: The readahead request. 

  */
static inline size_t readahead_length(struct readahead_control *rac)
{
         return rac->_nr_pages * PAGE_SIZE;
}

is tenable for large folios?
Especially as we have in mm/readahead.c:499

         ractl->_nr_pages += 1UL << order;

Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

