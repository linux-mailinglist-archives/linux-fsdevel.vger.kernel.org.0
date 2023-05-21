Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1116370ABC3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 02:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjEUA1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 20:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjEUA1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 20:27:32 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4BD11F
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 17:27:31 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34L0QXY5025308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 May 2023 20:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684628801; bh=9eqcIzS90vnBQyM2ULk0Xad6DIwhxJd9pXvwxDT5agA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=A7s9yjjs1TBgqn+gjf9Hj7xacMo4w4aYV4pZ4boAwBJMKMvQWe+RMxIaZ5voydTo9
         fzuTP9lDyOjxHdCtB5SC3OFBwx9XCJ9hGZrF99bBo8YVUDZWxn0sBQ2JpVM+dJFMnX
         cnu27yYekG/5ZGpiTVtRgYH40kySbm4j1uBx5FoupvHx0eqEWSK3UnVlERqM4DJJq3
         QcJWADWsI+eON5HwrDf7uUa3hXhp/maoPNGhjV17IvT3oCrs8BdIcsj06okrcGNFMq
         8ePkbEFz+t3D2MhcKaiZGmk9Ff9skg/gyyQxbAqpXlQkwLTgcdgcMGniG7jyULMiNM
         ZQmCn3Cjb/Btg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9EFD915C02EE; Sat, 20 May 2023 20:26:33 -0400 (EDT)
Date:   Sat, 20 May 2023 20:26:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
        Christoph Hellwig <hch@lst.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v21 18/30] ext4: Provide a splice-read stub
Message-ID: <20230521002633.GA207046@mit.edu>
References: <ZGhIpbrgQaPRPC3c@infradead.org>
 <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-19-dhowells@redhat.com>
 <2233565.1684567304@warthog.procyon.org.uk>
 <ZGiMewK8CW7DB4sl@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGiMewK8CW7DB4sl@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 02:01:47AM -0700, Christoph Hellwig wrote:
> On Sat, May 20, 2023 at 08:21:44AM +0100, David Howells wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > Not sure I'd call this a stub, but then again I'm not a native speaker.
> > 
> > "Wrapper"?
> 
> That's what I'd call it, yes.

Agreed, "wrapper" is a better term.

Other than that,

Acked-by: Theodore Ts'o <tytso@mit.edu>


