Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4167B07ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 17:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjI0PPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 11:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjI0PPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:15:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64223F5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 08:15:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0AFC433C8;
        Wed, 27 Sep 2023 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827732;
        bh=JqnBfv3SzjjGY7+P07WFoLqXWhC3sFQI8FWCLeBjSeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4T5TBgx0xDuJj3lK7d7tpaxtQpHyoB8ZnTlVekdEK/IQLMuK1SwbZiRwox0QFTIj
         oHBn3Gaud/uhmFd3yXuhyxgLo85UPV/2g5mrujDDr12FtAUqaw+nzfcievlFDpNfvv
         xMPEVgBha1f4FYqREKigOJBAm1f1w2OOuRxUprpwdyj8n15W0DHtDayRmfcRl4Pw7p
         gSjORLAWgO9oAGKXJEyKV+oscTiDIqBd8zK0OMzrV+E9O5K9KrSx53uJhRywck0V9u
         C+tWpjjSdOOs/YYMIAAeKmlCKRZ220NYYsO7We5JHpm4m4BeGY7IOCe3QLT0m8BAvX
         Dsf6sZlBpnqaA==
Date:   Wed, 27 Sep 2023 17:15:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] bdev: implement freeze and thaw holder operations
Message-ID: <20230927-werktag-kehlkopf-48d0c4bb0fc3@brauner>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-3-ecc36d9ab4d9@kernel.org>
 <20230927145350.GC11414@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927145350.GC11414@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +		sync_blockdev(bdev);
> 
> Why ignore the return value from sync_blockdev?  It calls
> filemap_write_and_wait, which clears AS_EIO/AS_ENOSPC from the bdev
> mapping, which means that we'll silently drop accumulated IO errors.

Because freeze_bdev() has always ignored sync_blockdev() errors so far
and I'm not sure what we'd do with that error. We can report it but we
might confuse callers that think that the freeze failed when it hasn't.

> 
> > +		mutex_unlock(&bdev->bd_holder_lock);
> 
> Also not sure why this fallback case holds bd_holder_lock across the
> sync_blockdev but fs_bdev_freeze doesn't?

I'll massage that to be consistent. Thanks!
