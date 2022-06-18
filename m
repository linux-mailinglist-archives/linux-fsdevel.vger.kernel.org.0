Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D1D5505AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiFRPT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 11:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiFRPT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:19:27 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322012AD0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iVQ8pR6pXFdDun4bYEsf25ay5kmPwk3xHWTbFiiJMx4=; b=UL4FPVmCaVZ1ph+Vuf1PxXfLaf
        qoi6+OQt7PKkgTFU8UweigMO3gZIT6vwJJ2ZidFlZL1wQdZEILgC39CZ9XWBmzVMwG0qhZcyMhMrY
        g8lADPITt0X/nAm37l41SEfR/pBHQRAuLqkEjkN7622HMjpd6YlcqTJI/8mO1ubSiSgQPbhx0BxSh
        q8sOAjfXFe1y7c2UuUd/dhIE0yAOrjDWwyC/2agJY4wAa0+Kuz1rkE00uEV/aLj/XxhVmAlbWv/pe
        GPG/y1C4ONFquWqWwt6ldjjsmci9Ngjvsz58B5HjqHQ2fhMwZwdkr41qii2p5/8iGB5SlrAgYhUwW
        hKjuhe+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2aEO-001dPm-HF;
        Sat, 18 Jun 2022 15:19:24 +0000
Date:   Sat, 18 Jun 2022 16:19:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] iov_iter: import single segments iovecs as ITER_UBUF
Message-ID: <Yq3s/K31CxG/H+lJ@ZenIV>
References: <b3e19eb1-18c4-8599-b68d-bf28673237d1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3e19eb1-18c4-8599-b68d-bf28673237d1@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 18, 2022 at 08:08:08AM -0600, Jens Axboe wrote:
> Using an ITER_UBUF is more efficient than an ITER_IOV, and for the single
> segment case, there's no reason to use an ITER_IOV when an ITER_UBUF will
> do. Experimental data collected shows that ~2/3rds of iovec imports are
> single segments, from applications using readv/writev or recvmsg/sendmsg
> that are iovec based.
> 
> Explicitly check for nr_segs == 1 and import those as ubuf rather than
> iovec based iterators.

Hadn't we'd been through that before?   There is infinibarf code that
assumes ITER_IOVEC for what its ->write_iter() gets (and yes, that's
the one that has ->write() with different semantics).

And I wouldn't bet a dime on all ->sendmsg() and ->recvmsg() being
flavour-agnostic either...
