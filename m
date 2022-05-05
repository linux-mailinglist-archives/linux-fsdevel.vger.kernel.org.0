Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC1C51BA90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 10:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349511AbiEEIhR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 04:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349585AbiEEIhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 04:37:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037149905;
        Thu,  5 May 2022 01:33:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F15721882;
        Thu,  5 May 2022 08:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651739613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEynGZ+H2w9ylxLdHigGAaKeSCzGaYGzl+zGjlh++AI=;
        b=EDwbKz5V9G3lRyQNsgKdCVf32/nEh34MV4fFSfgI9SZFi58EdyCUW+PQnLu4jyadbNKZPt
        v5UY/ol1LtPk37RUaDhYEnADZZX4AsGyjYtV5h5F3d3I/0mZ3PFBtr+vziVzmhtrmcwd0j
        rWvibBYIRKhGqzArBlIlOS3h3WAxB/Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A99F113B11;
        Thu,  5 May 2022 08:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8GihJtyLc2JJEAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 05 May 2022 08:33:32 +0000
Message-ID: <e96fcd60-7b2d-59f2-be72-a8f578afd583@suse.com>
Date:   Thu, 5 May 2022 11:33:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: reduce memory allocation in the btrfs direct I/O path
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220504162342.573651-1-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220504162342.573651-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4.05.22 г. 19:23 ч., Christoph Hellwig wrote:
> Hi all,
> 
> this series adds two minor improvements to iomap that allow btrfs
> to avoid a memory allocation per read/write system call and another
> one per submitted bio.  I also have at last two other pending uses
> for the iomap functionality later on, so they are not really btrfs
> specific either.
> 
> Diffstat:
>   fs/btrfs/btrfs_inode.h |   25 --------
>   fs/btrfs/ctree.h       |    6 -
>   fs/btrfs/file.c        |    6 -
>   fs/btrfs/inode.c       |  152 +++++++++++++++++++++++--------------------------
>   fs/iomap/direct-io.c   |   26 +++++++-
>   include/linux/iomap.h  |    4 +
>   6 files changed, 104 insertions(+), 115 deletions(-)
> 


Apart from the silent disk_bytenr removal nit:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
