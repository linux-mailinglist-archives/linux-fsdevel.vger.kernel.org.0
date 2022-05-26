Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF95853565E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 01:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbiEZXT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 19:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiEZXT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 19:19:26 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048ECE52AD
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eXPNllMLiiPd+hgtnK6114RdkDMTRhH/9NzBCmP4k3o=; b=V3zB7iTFtnho0YYPl6+v2L2omZ
        MzKGV2AxatQSrYCPis1o1FdS0PETy+zaB2z3bLcu+zM1PWod92q6WViC99lFTRnV2WdUTYicutaSN
        cjEx3fLhvVXkqRLlccfoREPcgmDaAFVjW+ePWdWBn44CECv+sTUZo64BJuLVhR+Q8jzI+dABkoYQE
        vBQleUvhEgztWYL5DqNURvqlGJ640/+nJm9RJaJ1CG6k2Hrg2lDfRDXLywjdz46KH6CMCDJPnBZLZ
        EkdDbAEGlBiZ/yqXqkorDUQfN56YEyaS44nbZ4ILdcVAlgdRvSirknDNdEiWtGfR8FGnFCe8IRjwE
        XjyjBE9w==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuMlE-000xgb-TP; Thu, 26 May 2022 23:19:21 +0000
Date:   Thu, 26 May 2022 23:19:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YpAK+CG74k1lc5z4@zeniv-ca.linux.org.uk>
References: <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
 <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 07:04:36PM +0000, Al Viro wrote:

> copy_page_{from,to}_iter() iovec side is needed not for the sake of
> optimizations - if you look at the generic variant, you'll see that it's
> basically "kmap_local_page + copy_{to,from}_iter() for the contents +
> kunmap_local_page", which obviously relies upon the copy_{to,from}_iter()
> being non-blocking.  So iovec part of it genuinely needs to differ from
> the generic variant; it's just that on top of that it had been (badly)
> microoptimized.  So were iterators, but that got at least somewhat cleaned
> up a while ago.  And no, turning that into indirect calls ended up with
> arseloads of overhead, more's the pity...

Actually, I take that back - the depth of kmap stack won't be increased
by more than one compared to mainline, so we can switch iovec and ubuf
variants to generic.

See #new.iov_iter; I do like the diffstat - -110 lines of code, with new
flavour added...

Completely untested, though.
