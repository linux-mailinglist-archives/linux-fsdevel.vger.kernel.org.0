Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8EA78A3C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 03:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjH1BFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 21:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjH1BFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:05:04 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECBF4;
        Sun, 27 Aug 2023 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=joEHMg4Vnx51INzte3pGka01/tHMgi/viw3PIuubDEg=; b=tBQRCz5+oVdl3BS/sNcy7bWOX7
        GGqnD2dBYFuddcCAHCZIxNjDzAdi2le5BAt0r8Kntb7pX1JY0YphckowafjvL81vNIQ3iZbSuHB8W
        r/PUBBhyIh5zGyiYSh551Ab8m+qrDF3vUESvq5gmF+156kAmT5ewUZLVGI0pVuCR+wxckZ4BuuSiW
        RJFEDzRbT6/CwsUyBB67HLFUFCa0gDIENAIc4MS7fD/7hjHRH/QwT9ZGKRpKtatGkE8elHlNUeY9H
        K7XCyGgu0m99e9gG1KyKu8v/0XPiv+PZlDfNvSozoVu79X3N9xA7HRVP+E5Pt/Irs6JBUgQAoXzdY
        9136hnSA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qaQgN-001R4E-2B;
        Mon, 28 Aug 2023 01:04:43 +0000
Date:   Mon, 28 Aug 2023 02:04:43 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
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
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 03/12] filemap: update ki_pos in generic_perform_write
Message-ID: <20230828010443.GV3390869@ZenIV>
References: <20230601145904.1385409-1-hch@lst.de>
 <20230601145904.1385409-4-hch@lst.de>
 <20230827194122.GA325446@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827194122.GA325446@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 27, 2023 at 08:41:22PM +0100, Al Viro wrote:

> That part is somewhat fishy - there's a case where you return a positive value
> and advance ->ki_pos by more than that amount.  I really wonder if all callers
> of ->write_iter() are OK with that.

Speaking of which, in case of negative return value we'd better *not* use
->ki_pos; consider e.g. generic_file_write_iter() with O_DSYNC and
vfs_fsync_range() failure.  An error gets returned, but ->ki_pos is left
advanced.  Normal write(2) is fine - it will only update file->f_pos if
->write_iter() has returned a non-negative.  However, io_uring
kiocb_done() starts with
        if (req->flags & REQ_F_CUR_POS)
                req->file->f_pos = rw->kiocb.ki_pos;
        if (ret >= 0 && (rw->kiocb.ki_complete == io_complete_rw)) {
                if (!__io_complete_rw_common(req, ret)) {
                        /*
                         * Safe to call io_end from here as we're inline
                         * from the submission path.
                         */
                        io_req_io_end(req);
                        io_req_set_res(req, final_ret,
                                       io_put_kbuf(req, issue_flags));
                        return IOU_OK;
                }
        } else {
                io_rw_done(&rw->kiocb, ret);
        }
Note that ->f_pos update is *NOT* conditional upon ret >= 0 - it happens
no matter what, provided that original request had ->kiocb.ki_pos equal
to -1 (on a non-FMODE_STREAM file).

Jens, is there any reason for doing that unconditionally?  IMO it's
a bad idea - there's a wide scope for fuckups that way, especially
since write(2) is not sensitive to that and this use of -1 ki_pos
is not particularly encouraged on io_uring side either, AFAICT.
Worse, it's handling of failure exits in the first place, which
already gets little testing...
