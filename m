Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0954A78874D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjHYM2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244847AbjHYM23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500F226B2;
        Fri, 25 Aug 2023 05:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A566E619C2;
        Fri, 25 Aug 2023 12:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C546C433C8;
        Fri, 25 Aug 2023 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692966422;
        bh=IuS22xMDOXhLWj5dSRNrTGi8iu/lZ+v8ul0iyCnqnRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGrJ1H9qLPII+BFyolV4e8E2pcSsMM+Mzt9yz/yMufFFK/PZsoYtzjKPI4tYTkHpr
         3+OkQHTnkmSWzdj3jyJfA5y59eIjumohbQgCW8lmysGu7nwKYsMMWjzfaz55Q4UBoP
         FxdNrzCIKaELdIzOO9SBEff/HfnsN0HZBDPUjFC7FZe/wRKSHcG/b542L/ediEc++D
         tyukPN53f1iHl9gLlO9JfDwSg2C3apPbe0hiExSzJa7sP8goS968Zz73M+3DjHSVUZ
         XYhP0LdajzKYRQVQoPLgjX5FL9WrnRxsolqfkL8S4APyK2kaKLpxQZKFLxBV+hIiqt
         5aZivMOvSfjAA==
Date:   Fri, 25 Aug 2023 14:26:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 20/29] btrfs: Convert to bdev_open_by_path()
Message-ID: <20230825-inhaber-zwirn-1575ae24f4c3@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-20-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-20-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:31PM +0200, Jan Kara wrote:
> Convert btrfs to use bdev_open_by_path() and pass the handle around.  We
> also drop the holder from struct btrfs_device as it is now not needed
> anymore.
> 
> CC: David Sterba <dsterba@suse.com>
> CC: linux-btrfs@vger.kernel.org
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

> -	bdev = blkdev_get_by_path(path, BLK_OPEN_READ, NULL, NULL);
> -	if (IS_ERR(bdev))
> -		return ERR_CAST(bdev);
> +	bdev_handle = bdev_open_by_path(path, BLK_OPEN_READ, NULL, NULL);
> +	if (IS_ERR(bdev_handle))
> +		return ERR_CAST(bdev_handle);

Minor merge conflict with what's in vfs.super because we dropped
unrelated btrfs patches like David asked us to. Very easy to fix for me.
Just an fyi.
