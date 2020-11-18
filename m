Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D52B8848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 00:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKRXSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 18:18:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:47926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgKRXSi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:18:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3BB50B1E1;
        Wed, 18 Nov 2020 23:18:36 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id EEC2D603F9; Thu, 19 Nov 2020 00:18:35 +0100 (CET)
Date:   Thu, 19 Nov 2020 00:18:35 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: convert to ->write_iter()
Message-ID: <20201118231835.u6hqivoayq5ej4vg@lion.mk-sys.cz>
References: <8a4f07e6ec47b681a32c6df5d463857e67bfc965.1605690824.git.mkubecek@suse.cz>
 <20201118151806.GA25804@infradead.org>
 <20201118195936.p33qlcjc7gp2zezz@lion.mk-sys.cz>
 <4e4d222c-ed8b-a40d-0cdc-cf152573645c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4d222c-ed8b-a40d-0cdc-cf152573645c@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 02:27:08PM -0700, Jens Axboe wrote:
> On 11/18/20 12:59 PM, Michal Kubecek wrote:
> > On Wed, Nov 18, 2020 at 03:18:06PM +0000, Christoph Hellwig wrote:
> >> On Wed, Nov 18, 2020 at 10:19:17AM +0100, Michal Kubecek wrote:
> >>> While eventfd ->read() callback was replaced by ->read_iter() recently,
> >>> it still provides ->write() for writes. Since commit 4d03e3cc5982 ("fs:
> >>> don't allow kernel reads and writes without iter ops"), this prevents
> >>> kernel_write() to be used for eventfd and with set_fs() removal,
> >>> ->write() cannot be easily called directly with a kernel buffer.
> >>>
> >>> According to eventfd(2), eventfd descriptors are supposed to be (also)
> >>> used by kernel to notify userspace applications of events which now
> >>> requires ->write_iter() op to be available (and ->write() not to be).
> >>> Therefore convert eventfd_write() to ->write_iter() semantics. This
> >>> patch also cleans up the code in a similar way as commit 12aceb89b0bc
> >>> ("eventfd: convert to f_op->read_iter()") did in read_iter().
> >>
> >> A far as I can tell we don't have an in-tree user that writes to an
> >> eventfd.  We can merge something like this once there is a user.
> > 
> > As far as I can say, we don't have an in-tree user that reads from
> > sysctl. But you not only did not object to commit 4bd6a7353ee1 ("sysctl:
> > Convert to iter interfaces") which adds ->read_iter() for sysctl, that
> > commit even bears your Signed-off-by. There may be other examples like
> > that.
> 
> A better justification for this patch is that users like io_uring can
> potentially write non-blocking to the file if ->write_iter() is
> supported.

So you think the patch could be accepted with a modified commit message?
(As long as there are no technical issues, of course.) I did not really
expect there would be so much focus on a justification for a patch which
(1) converts f_ops to a more advanced (and apparently preferred)
interface and (2) makes eventfd f_ops more consistent.

For the record, my original motivation for this patch was indeed an out
of tree module (not mine) using kernel write to eventfd. But that module
can be patched to use eventfd_signal() instead and it will have to be
patched anyway unless eventfd allows kernel_write() in 5.10 (which
doesn't seem likely). So if improving the code is not considered
sufficient to justify the patch, I can live with that easily. 

Michal Kubecek
