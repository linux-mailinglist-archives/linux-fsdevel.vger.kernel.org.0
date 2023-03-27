Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0696CAD61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjC0Snc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjC0SnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:43:24 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0000119
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=1LIm+lT8mYWnOMIQ3VNsjk9VW408koawzeZSx89bN44=; b=eJQjw7CMhVhExt3n0PDF+FgFFy
        JO7VpFAPxE2U1tmF0UUbFXKOi2l5HWKWpT50ON3ubFM1IAaOSgO2d4LOHBYAIu3lb3pF9BGFl2zEW
        y1LQoDxbonGsOsAElwHyALlRzFSVhBE3f5aAtbjOXuPP94KLmtWzov1yWz3btUfnmY+CZmOGcp8Jz
        wkRRHOCtzFyD2JydCq5DLA7VCQTw3k5np0TdrLLczw6YfXpXAilNFDvgw/jbxyZ9fsW9ELDzvydaz
        X5IqHRr8gVbEK06Q4fymRpT3lyzOvzMLTiWmpKGrb/BtagrsmI3LdyLfy8r2/WbWnKYJvBXXEfjcj
        DAKY2Q7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgrny-002Uvk-2K;
        Mon, 27 Mar 2023 18:42:54 +0000
Date:   Mon, 27 Mar 2023 19:42:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
Subject: Re: [PATCHSET 0/2] Turn single segment imports into ITER_UBUF
Message-ID: <20230327184254.GH3390869@ZenIV>
References: <20230324204443.45950-1-axboe@kernel.dk>
 <20230325044654.GC3390869@ZenIV>
 <1ef65695-4e66-ebb8-3be8-454a1ca8f648@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ef65695-4e66-ebb8-3be8-454a1ca8f648@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:01:08PM -0600, Jens Axboe wrote:
> On 3/24/23 10:46 PM, Al Viro wrote:
> > On Fri, Mar 24, 2023 at 02:44:41PM -0600, Jens Axboe wrote:
> >> Hi,
> >>
> >> We've been doing a few conversions of ITER_IOVEC to ITER_UBUF in select
> >> spots, as the latter is cheaper to iterate and hence saves some cycles.
> >> I recently experimented [1] with io_uring converting single segment READV
> >> and WRITEV into non-vectored variants, as we can save some cycles through
> >> that as well.
> >>
> >> But there's really no reason why we can't just do this further down,
> >> enabling it for everyone. It's quite common to use vectored reads or
> >> writes even with a single segment, unfortunately, even for cases where
> >> there's no specific reason to do so. From a bit of non-scientific
> >> testing on a vm on my laptop, I see about 60% of the import_iovec()
> >> calls being for a single segment.
> >>
> >> I initially was worried that we'd have callers assuming an ITER_IOVEC
> >> iter after a call import_iovec() or import_single_range(), but an audit
> >> of the kernel code actually looks sane in that regard. Of the ones that
> >> do call it, I ran the ltp test cases and they all still pass.
> > 
> > Which tree was that audit on?  Mainline?  Some branch in block.git?
> 
> It was just master in -git. But looks like I did miss two spots, I've
> updated the series here and will send out a v2:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=iter-ubuf

Just to make sure - head's at 4d0ba2f0250d?

One obvious comment (just about the problems you've dealt with in that branch;
I'll go over that tree and look for other sources of trouble, will post tonight):
all 3 callers of iov_iter_iovec() in there are accompanied by the identical
chunks that deal with ITER_UBUF case; it would make more sense to teach
iov_iter_iovec() to handle that.  loop_rw_iter() would turn into
	if (!iov_iter_is_bvec(iter)) {
		iovec = iov_iter_iovec(iter);
	} else {
		iovec.iov_base = u64_to_user_ptr(rw->addr);
		iovec.iov_len = rw->len;
	}
and process_madvise() and do_loop_readv_writev() patches simply go away.

Again, I'm _not_ saying there's no other problems left, just that these are
better dealt with that way.

Something like

static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
{
	if (WARN_ON(!iter->user_backed))
		return (struct iovec) {
			.iov_base = NULL,
			.iov_len = 0
		};
	else if (iov_iter_is_ubuf(iter))
		return (struct iovec) {
			.iov_base = iter->ubuf + iter->iov_offset,
			.iov_len = iter->count
		}; 
	else
		return (struct iovec) {
			.iov_base = iter->iov->iov_base + iter->iov_offset,
			.iov_len = min(iter->count,
				       iter->iov->iov_len - iter->iov_offset),
		};
}

and no need to duplicate that logics in all callers.  Or get rid of those
elses, seeing that each alternative is a plain return - matter of taste...
