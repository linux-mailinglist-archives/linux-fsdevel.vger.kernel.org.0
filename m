Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABFA7155D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 08:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjE3G5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 02:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjE3G5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 02:57:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BCD103;
        Mon, 29 May 2023 23:57:38 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 02EEF1F8B9;
        Tue, 30 May 2023 06:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685429857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWXYP+41GoV2YheaoKz5SXvxdufsZAJ/DkvO+3vgn0U=;
        b=m063HSmjZlYQyX7lM1ruPLYTf/tOrH3WvPXahoRopER2rEWY3kfxxMNznuBLQAiuXYq1qy
        iYTlJZjw1jb+Xw1oDFBfWUc5LP9orvsh82ZZkE5JHC8safHEf1g1ZixH/FaexFseFNkPeq
        sGQk42YsKJmrLhxWj3afVaq3x3tNIEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685429857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWXYP+41GoV2YheaoKz5SXvxdufsZAJ/DkvO+3vgn0U=;
        b=3vxEADTuEEuEE+nkeH+6ER8V1ObQzv/+xqNPnL8zCuXcVbdcMnPxgVPehS0w8EyUL4XGyO
        0kVPmBtKWCkb2+Bg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5C1711341B;
        Tue, 30 May 2023 06:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2Vv+EWCedWQkcgAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 30 May 2023 06:57:36 +0000
Message-ID: <cb123d95-354d-65ba-ce6c-7cb41318b78a@suse.de>
Date:   Tue, 30 May 2023 08:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 03/11] filemap: update ki_pos in generic_perform_write
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
References: <20230524063810.1595778-1-hch@lst.de>
 <20230524063810.1595778-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230524063810.1595778-4-hch@lst.de>
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

On 5/24/23 08:38, Christoph Hellwig wrote:
> All callers of generic_perform_write need to updated ki_pos, move it into
> common code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xiubo Li <xiubli@redhat.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Acked-by: Darrick J. Wong <djwong@kernel.org>
> ---
>   fs/ceph/file.c | 2 --
>   fs/ext4/file.c | 9 +++------
>   fs/f2fs/file.c | 1 -
>   fs/nfs/file.c  | 1 -
>   mm/filemap.c   | 8 ++++----
>   5 files changed, 7 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

