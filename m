Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2978E7302D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245758AbjFNPGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 11:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245749AbjFNPGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:06:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4CC1BFF;
        Wed, 14 Jun 2023 08:06:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 225A522558;
        Wed, 14 Jun 2023 15:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686755175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+iWl9r/tSDUmPJvtaMNNO71uG272AM8uYMcS2LX1HA=;
        b=zWH+1UhvlX0xFsf6CtqMF58XReNVqILWs/UD3a8cjl+SBOtnaZ4Xqq/y++WdEpEHcg3hMJ
        xqDsYrDb6pNPPmC9syAaiVT9wPYIRffIEUhKQsg5Ibju9OmA+FPLvStXEU5CMm8t6Vu8nY
        OY+YZHX9lYkbhMWUBfu0UbqkgM8nhIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686755175;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+iWl9r/tSDUmPJvtaMNNO71uG272AM8uYMcS2LX1HA=;
        b=bMEJITchW/Qfuw3BbMAkjbI1kC6iyOT4RZTkBtZLchhazoizEHlXhjOdArmuURsuzO7BKP
        eVwimY9YeyTtxsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E648D1391E;
        Wed, 14 Jun 2023 15:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vRomN2bXiWTrEQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 14 Jun 2023 15:06:14 +0000
Message-ID: <b3fa1b77-d120-f86b-e02f-f79b6d13efcc@suse.de>
Date:   Wed, 14 Jun 2023 17:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/7] RFC: high-order folio support for I/O
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230614114637.89759-1-hare@suse.de>
 <cd816905-0e3e-6397-1a6f-fd4d29dfc739@suse.de>
 <ZInGbz6X/ZQAwdRx@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZInGbz6X/ZQAwdRx@casper.infradead.org>
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

On 6/14/23 15:53, Matthew Wilcox wrote:
> On Wed, Jun 14, 2023 at 03:17:25PM +0200, Hannes Reinecke wrote:
>> Turns out that was quite easy to fix (just remove the check in
>> set_blocksize()), but now I get this:
>>
>> SGI XFS with ACLs, security attributes, quota, no debug enabled
>> XFS (ram0): File system with blocksize 16384 bytes. Only pagesize (4096) or
>> less will currently work.
> 
> What happens if you just remove this hunk:
> 
> +++ b/fs/xfs/xfs_super.c
> @@ -1583,18 +1583,6 @@ xfs_fs_fill_super(
>                  goto out_free_sb;
>          }
> 
> -       /*
> -        * Until this is fixed only page-sized or smaller data blocks work.
> -        */
> -       if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> -               xfs_warn(mp,
> -               "File system with blocksize %d bytes. "
> -               "Only pagesize (%ld) or less will currently work.",
> -                               mp->m_sb.sb_blocksize, PAGE_SIZE);
> -               error = -ENOSYS;
> -               goto out_free_sb;
> -       }
> -
>          /* Ensure this filesystem fits in the page cache limits */
>          if (xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_dblocks) ||
>              xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_rblocks)) {

Whee! That works!

Rebased things with your memcpy_{to,from}_folio() patches, disabled that 
chunk, and:

# mount /dev/ram0 /mnt
XFS (ram0): Mounting V5 Filesystem 5cd71ab5-2d11-4c18-97dd-71708f40e551
XFS (ram0): Ending clean mount
xfs filesystem being mounted at /mnt supports timestamps until 
2038-01-19 (0x7fffffff)
# umount /mnt
XFS (ram0): Unmounting Filesystem 5cd71ab5-2d11-4c18-97dd-71708f40e551

Great work, Matthew!

(Now I just need to check why copying data from NFS crashes ...)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

