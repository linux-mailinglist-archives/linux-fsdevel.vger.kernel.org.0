Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50C671097F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbjEYKJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 06:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjEYKJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 06:09:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD09B12E;
        Thu, 25 May 2023 03:09:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3423B68AFE; Thu, 25 May 2023 12:09:48 +0200 (CEST)
Date:   Thu, 25 May 2023 12:09:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
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
Subject: Re: [PATCH 10/11] fuse: update ki_pos in fuse_perform_write
Message-ID: <20230525100947.GB30242@lst.de>
References: <20230524063810.1595778-1-hch@lst.de> <20230524063810.1595778-11-hch@lst.de> <CAJfpeguxVXm2pDeNk9M_S_0+ing1dFstaCfB30WcTRCjwwsJvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguxVXm2pDeNk9M_S_0+ing1dFstaCfB30WcTRCjwwsJvg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 09:07:22AM +0200, Miklos Szeredi wrote:
> > -               endbyte = pos + written_buffered - 1;
> > +               endbyte = iocb->ki_pos + written_buffered - 1;
> 
> Wrong endpos.
> 
> >
> > -               err = filemap_write_and_wait_range(file->f_mapping, pos,
> > +               err = filemap_write_and_wait_range(file->f_mapping,
> > +                                                  iocb->ki_pos,
> 
> Wrong startpos.

Yeah, fixed for the next version.
