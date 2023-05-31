Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1004718478
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjEaOPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbjEaOPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 10:15:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20592717;
        Wed, 31 May 2023 07:12:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 545E463C99;
        Wed, 31 May 2023 14:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15DDC4339B;
        Wed, 31 May 2023 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685542277;
        bh=CGLL01Wm70Z32tapHLX9z2kfk8hHrHa2+CbAAqxp8sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j90kb5FfsprOPsl/05r4it2PURvWGBJ+EOjep2awpbg3jtHdlNM6GV2Z0Zwq3heiL
         HNkiomrYm3kiXvMdyEm5j15UhlWjd515dmOZ9sek/CyGBJCWhNwnW8BMDzUbjWsjOC
         5kT8PxmKPDqm2yZZIRLSP89PtnJFpdIGeMFTWEGnCzYTobP8d7lOBbXYvlC1ui/qzb
         TVnq+RkCvAa9SwER+euHKv5NWjz8E7RER4tAe64pZb64vGFI7YiU6fP9a3r7fIjDDg
         rnnsR83JSLepj2yHG2y0VevVaeBOW6SaW9ASGH+knv60NJsyOY+SYjyfygNwbTDZ34
         329M6cHexyEfw==
Date:   Wed, 31 May 2023 16:11:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/12] backing_dev: remove current->backing_dev_info
Message-ID: <20230531-wirkt-attraktion-d97bdcbc3aee@brauner>
References: <20230531075026.480237-1-hch@lst.de>
 <20230531075026.480237-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230531075026.480237-2-hch@lst.de>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 09:50:15AM +0200, Christoph Hellwig wrote:
> The last user of current->backing_dev_info disappeared in commit
> b9b1335e6403 ("remove bdi_congested() and wb_congested() and related
> functions").  Remove the field and all assignments to it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---

I somehow thought I'd already acked this... Anyway,
Reviewed-by: Christian Brauner <brauner@kernel.org>
