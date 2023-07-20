Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FAD75AE20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 14:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjGTMQv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 08:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGTMQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:16:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FBB1BC6;
        Thu, 20 Jul 2023 05:16:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 311FA22BEC;
        Thu, 20 Jul 2023 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689855405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJeevWCTbOxeUOBTAxfygV2zVKl4pRNiVV/Sn4Vc5g8=;
        b=Y7xfme4rPrCF5hEC5pbUvdrHOtse6c2XE5dQH4ofisst0BxXhq5fzSvvvudIq0qb1fgAZ3
        nvIjKrBX9SBniQArDMHq3Eo1F5gHSAGQmoz/tE4t4qxq6hUdsPyEUo9DVqT6M2kkkhHlFw
        wusKJBAY7+a0/4rdZ8XEmsB7vqMiu20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689855405;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJeevWCTbOxeUOBTAxfygV2zVKl4pRNiVV/Sn4Vc5g8=;
        b=FfN5Vi6mxKPEw3x2oCzsXOategHapN8ngq0O/mlx3Dt3iIlpkGc1UcEnhLUPz5UTPIunq7
        Q/g7Z3f9m59q7UAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17569138EC;
        Thu, 20 Jul 2023 12:16:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V/cVBa0luWQKJgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 20 Jul 2023 12:16:45 +0000
Message-ID: <2fda17af-ed88-2332-27a1-61496f943e91@suse.de>
Date:   Thu, 20 Jul 2023 14:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 16/17] block: use iomap for writes to block devices
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-17-hch@lst.de>
 <b96b397e-2f5e-7910-3bb3-7405d0e293a7@suse.de>
 <20230720120650.GA13266@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230720120650.GA13266@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/20/23 14:06, Christoph Hellwig wrote:
> On Fri, May 19, 2023 at 04:22:01PM +0200, Hannes Reinecke wrote:
>> I'm hitting this during booting:
>> [    5.016324]  <TASK>
>> [    5.030256]  iomap_iter+0x11a/0x350
>> [    5.030264]  iomap_readahead+0x1eb/0x2c0
>> [    5.030272]  read_pages+0x5d/0x220
>> [    5.030279]  page_cache_ra_unbounded+0x131/0x180
>> [    5.030284]  filemap_get_pages+0xff/0x5a0
>> [    5.030292]  filemap_read+0xca/0x320
>> [    5.030296]  ? aa_file_perm+0x126/0x500
>> [    5.040216]  ? touch_atime+0xc8/0x150
>> [    5.040224]  blkdev_read_iter+0xb0/0x150
>> [    5.040228]  vfs_read+0x226/0x2d0
>> [    5.040234]  ksys_read+0xa5/0xe0
>> [    5.040238]  do_syscall_64+0x5b/0x80
>>
>> Maybe we should consider this patch:
> 
> As willy said this should be taken care of by the i_size check.
> Did you run with just this patch set or some of the large block
> size experiments on top which might change the variables?
> 
> I'll repost the series today without any chances in the area, and
> if you can reproduce it with just that series we need to root
> cause it, so please send your kernel and VM config along for the
> next report.

I _think_ it's been resolve now; I've rewritten my patchset (and the 
patches where it's based upon) several times now, so it might be a stale 
issue now.

Eagerly awaiting your patchset.

Cheers,

Hannes

