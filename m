Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5DA6111DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 14:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJ1Mt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 08:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJ1Mt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:49:58 -0400
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA55326E7;
        Fri, 28 Oct 2022 05:49:56 -0700 (PDT)
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 3974B2C3E3;
        Fri, 28 Oct 2022 08:49:56 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id DB442A8006; Fri, 28 Oct 2022 08:49:55 -0400 (EDT)
Date:   Fri, 28 Oct 2022 08:49:55 -0400
From:   John Stoffel <john@quad.stoffel.home>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/12] [xen] fix "direction" argument of
 iov_iter_kvec()
Message-ID: <Y1vP80g820nBUxFI@quad.stoffel.home>
References: <Y1btOP0tyPtcYajo@ZenIV>
 <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
 <20221028023352.3532080-10-viro@zeniv.linux.org.uk>
 <Y1vPlg66EZOYrqpP@quad.stoffel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vPlg66EZOYrqpP@quad.stoffel.home>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 08:48:22AM -0400, John Stoffel wrote:
> On Fri, Oct 28, 2022 at 03:33:50AM +0100, Al Viro wrote:
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  drivers/xen/pvcalls-back.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
> > index d6f945fd4147..21b9c850a382 100644
> > --- a/drivers/xen/pvcalls-back.c
> > +++ b/drivers/xen/pvcalls-back.c
> > @@ -129,13 +129,13 @@ static bool pvcalls_conn_back_read(void *opaque)
> >  	if (masked_prod < masked_cons) {
> >  		vec[0].iov_base = data->in + masked_prod;
> >  		vec[0].iov_len = wanted;
> > -		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 1, wanted);
> > +		iov_iter_kvec(&msg.msg_iter, READ, vec, 1, wanted);
> 
> 
> Wouldn't it make more sense to use READER and WRITER here, since the
> current READ/WRITE are 100% non-obvious?  This is probably a bigger
> change, but this just looks wrong and will be so easy for people to
> screw up again and again down the line.

And if I had only made it down to patch 12, I would have seen that you
fixed this.  Sorry for the noise!

