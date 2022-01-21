Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6914F4961E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 16:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351305AbiAUPTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 10:19:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47968 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351244AbiAUPTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:19:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 106F2B81EDB;
        Fri, 21 Jan 2022 15:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C106C340E1;
        Fri, 21 Jan 2022 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642778338;
        bh=GQxOMg7MVzDCmRtEhr2CwU3Mx4eAuCpyUZKZhjoge+o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RUVN6yhZ8UpWTzGMKYNArObvP+zJklVzwx8vxKgNPhoMc4WIEFQFvSIRPEF45wYbE
         xX/w7cjIGY/WfB6eV6KGGWLDYxPz9COmWsyVGBrGTxKV0imnesU1YKWJeWWDqz0Bx9
         DzoSt5K3YcyREZ2xL3+Zz1KNAwT/BDjmbCkYmzgOQzfkIO/HuYGXfZDZBy9sce0jMp
         oRlkXf6MgyRx/lm2r46dKoFyYnh4Yqf5GiVdVEP1ylq5poCp0UVfQ25W2biuS4d+YC
         GzlK3EQw5Iph5dzGuqz+x+xYLY1X0unCOEj6FDzP7e4D7/1yjM9a1rNkZ5djhaLrhy
         WDbGfXJcoZymA==
Message-ID: <aa6ecc69eeb4c1e25c11f37f86a7796e7c40997b.camel@kernel.org>
Subject: Re: [PATCH v3 2/3] ceph: Make ceph_netfs_issue_op() handle inlined
 data
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 21 Jan 2022 10:18:56 -0500
In-Reply-To: <1130437.1642777077@warthog.procyon.org.uk>
References: <20220121141838.110954-3-jlayton@kernel.org>
         <20220121141838.110954-1-jlayton@kernel.org>
         <1130437.1642777077@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-01-21 at 14:57 +0000, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
> 
> > +	len = iinfo->inline_len;
> > +	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
> > +	err = copy_to_iter(iinfo->inline_data, len, &iter);
> 
> I think this is probably wrong.  It will read the entirety of the inline data
> into the buffer, even if it's bigger than the buffer and you need to offset
> pointer into the buffer.
> 
> You need to limit it to subreq->len.  Maybe:
> 
> 	len = min_t(size_t, iinfo->inline_len - subreq->start, subreq->len);
> 	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
> 			subreq->start, len);
> 	err = copy_to_iter(iinfo->inline_data + subreq->start, len, &iter);
> 
> David
> 

Good point. I'll make that change and re-test, but it makes sense.
-- 
Jeff Layton <jlayton@kernel.org>
