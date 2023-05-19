Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B17709952
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 16:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjESORU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 10:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjESORT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 10:17:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6189F7;
        Fri, 19 May 2023 07:17:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48C7922179;
        Fri, 19 May 2023 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684505837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+VZ1HyTsuRdYwi+hWd9cIzn7uyvdspX3l+sCDgOvwM=;
        b=lUR/RERVITvOIkTMYj6gZ+8JeXHqan3Bnna1FOBmjp847w9ZHf0T6hzhM7Eq/A1T0L/dJx
        4wI5ealbv3H9+kP1cNsE/jTxKje5DwlQj8mmbM95l7QnmE1+pQihUz/KdlG3xypRVqbmYZ
        7C0GNrUdzrqlPr3V5FwR/UHrQKpeLp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684505837;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+VZ1HyTsuRdYwi+hWd9cIzn7uyvdspX3l+sCDgOvwM=;
        b=0H/DQLixAzELypiG8mcDJ4c7dKWgixPm6jvK/14EDBieNR/7dM/kD/ybovU/M5icvpLBTz
        2GDt3VvKWgu74TCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7D5313A12;
        Fri, 19 May 2023 14:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cB26M+yEZ2ThHQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 19 May 2023 14:17:16 +0000
Message-ID: <adb6e8d5-9bc5-e988-f21a-1c3e5191e66b@suse.de>
Date:   Fri, 19 May 2023 16:17:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 01/17] fs: unexport buffer_check_dirty_writeback
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
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
 <20230424054926.26927-2-hch@lst.de>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230424054926.26927-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/24/23 07:49, Christoph Hellwig wrote:
> buffer_check_dirty_writeback is only used by the block device aops,
> remove the export.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/buffer.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 9e1e2add541e07..eb14fbaa7d35f7 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -111,7 +111,6 @@ void buffer_check_dirty_writeback(struct folio *folio,
>   		bh = bh->b_this_page;
>   	} while (bh != head);
>   }
> -EXPORT_SYMBOL(buffer_check_dirty_writeback);
>   
>   /*
>    * Block until a buffer comes unlocked.  This doesn't stop it

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
