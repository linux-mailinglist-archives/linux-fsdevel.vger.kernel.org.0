Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06C370ABC7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 02:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjEUA3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 20:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEUA3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 20:29:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619CA128
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 17:29:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34L0SRVZ026415
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 May 2023 20:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684628911; bh=3U2jQyV+om6cEvowDzLHU8bBjtTNByfdH+e84cJttjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=oMMqD/ZUppgCgzKDvbbwVAi5CEoovEfF1QtZ0mMBKR4RhXidI3B7fc+NW3u/9nKyc
         LsQi19iJKHdVv0GmPowknFWlPn3BB27TwXP13cbb8op9sxdbezrXTtDoP0ZdAbz0BE
         ZvyOAOVBRXH4mAhrpeCpv7rLzbYliRhgbSAItfajtlSjs4Nq9Dj9fES2JT7BSn8LM+
         irK4TekIClw7dLE/9zsnl+F7IjdK6A/BnHZgbgWHlOTPbYuLEtl5RRB/esBBW9F82E
         5k16hXvFnB1AWJrjYnz2FM/QeLmDTL4agwbJWTjVLQR3bEQyJRAn00rb7NHMMsZP+w
         O9VIZ6uLT9EQg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C696C15C02EE; Sat, 20 May 2023 20:28:27 -0400 (EDT)
Date:   Sat, 20 May 2023 20:28:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v21 08/30] splice: Make splice from a DAX file use
 copy_splice_read()
Message-ID: <20230521002827.GB207046@mit.edu>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-9-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-9-dhowells@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 01:00:27AM +0100, David Howells wrote:
> Make a read splice from a DAX file go directly to copy_splice_read() to do
> the reading as filemap_splice_read() is unlikely to find any pagecache to
> splice.
> 
> I think this affects only erofs, Ext2, Ext4, fuse and XFS.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-ext4@vger.kernel.org

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
