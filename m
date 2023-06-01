Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D0971919A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 06:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjFAEHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 00:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFAEHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:07:40 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7143DB2
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 21:07:39 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35146rfn026616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 00:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685592418; bh=Pcqpw1QSxFJZ0laXH9+QWQRNycHSOlFzpRuiP0DXgks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FjRInq5K/Q3cIGhgP5U9E5iShqilarKB9GHVrxpK7UTub19CoZpiUGVYb2Kd/qTiO
         60WVYoMBBeuCMkLY0PBqv2lvD0rBxGigRShQtB3TFTi72Q36gZXIOQZlVfbKoWgQja
         MiN7Kpoj30BBOMjqnNaw5noqs9AprbSoEVjkZmfrr0gkBtRm/pfeSS7xWPQAA92PTB
         7+LobHEEkerjTevwU1Dz3lLidbde40aBREVBPnGEJcvu/AEVDU1auLGuWQOWhoRvJL
         AB5IgvwmjasK1wNGrzxcGznmZSUPOPGT3bAl3rdT3hOxMOgEqb0Ucdg/1RPWYp/3Vw
         Jt3BLckbYB7sw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5765C15C02EE; Thu,  1 Jun 2023 00:06:53 -0400 (EDT)
Date:   Thu, 1 Jun 2023 00:06:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
Subject: Re: [PATCH 03/12] filemap: update ki_pos in generic_perform_write
Message-ID: <20230601040653.GB896851@mit.edu>
References: <20230531075026.480237-1-hch@lst.de>
 <20230531075026.480237-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531075026.480237-4-hch@lst.de>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 09:50:17AM +0200, Christoph Hellwig wrote:
> All callers of generic_perform_write need to updated ki_pos, move it into
> common code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xiubo Li <xiubli@redhat.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Acked-by: Darrick J. Wong <djwong@kernel.org>

Acked-by: Theodore Ts'o <tytso@mit.edu>
