Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A4D704BC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 13:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjEPLHN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 07:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjEPLG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 07:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0E78698
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684234965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bm37UOLdBp2l5tU1ZMMqW99I666vOnuPt5uI8uOrDaY=;
        b=Y/aFVNXtxZ5Vs2moTDbgeuPUWez3E/Bgl+g0uyY7G0tB57wzI7Pci5BLICXSevjW9sydiw
        W2uOM8CtNsE/Ykm8Y1WH+H9LEw7xgJtEbc6K5F6QGGEFKjJMNaORDh08Nb/1LfqfMcFMFV
        3e3sGcf30E7sb29NzbRfaOabRteyAZo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-6egxe9Y7PQS_n7OjNZcLVg-1; Tue, 16 May 2023 07:02:42 -0400
X-MC-Unique: 6egxe9Y7PQS_n7OjNZcLVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7368381D1E1;
        Tue, 16 May 2023 11:02:41 +0000 (UTC)
Received: from ovpn-8-19.pek2.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 074374078906;
        Tue, 16 May 2023 11:02:36 +0000 (UTC)
Date:   Tue, 16 May 2023 19:02:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <ZGNixzo3WShiInI1@ovpn-8-19.pek2.redhat.com>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505175132.2236632-6-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 01:51:28PM -0400, Christoph Hellwig wrote:
> Add a new blk_holder_ops structure, which is passed to blkdev_get_by_* and
> installed in the block_device for exclusive claims.  It will be used to
> allow the block layer to call back into the user of the block device for
> thing like notification of a removed device or a device resize.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

...

> @@ -542,7 +543,8 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
>   * Finish exclusive open of a block device. Mark the device as exlusively
>   * open by the holder and wake up all waiters for exclusive open to finish.
>   */
> -static void bd_finish_claiming(struct block_device *bdev, void *holder)
> +static void bd_finish_claiming(struct block_device *bdev, void *holder,
> +		const struct blk_holder_ops *hops)
>  {
>  	struct block_device *whole = bdev_whole(bdev);
>  
> @@ -555,7 +557,10 @@ static void bd_finish_claiming(struct block_device *bdev, void *holder)
>  	whole->bd_holders++;
>  	whole->bd_holder = bd_may_claim;
>  	bdev->bd_holders++;
> +	mutex_lock(&bdev->bd_holder_lock);
>  	bdev->bd_holder = holder;
> +	bdev->bd_holder_ops = hops;
> +	mutex_unlock(&bdev->bd_holder_lock);
>  	bd_clear_claiming(whole, holder);
>  	mutex_unlock(&bdev_lock);
>  }

I guess the holder ops may be override in case of multiple claim, can
this be one problem from the holder ops user viewpoint? Or
warn_on_once(bdev->bd_holder_ops && bdev->bd_holder_ops != hops) is needed here?


Thanks,
Ming

