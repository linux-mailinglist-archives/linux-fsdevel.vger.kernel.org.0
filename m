Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD3D53053A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345184AbiEVSjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 14:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiEVSjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 14:39:13 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C298A38D9F
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M+EqpydroNYykAS85I9fMFjHXOZVXMJ7NubFjuMLfyQ=; b=YeIdqgNVD2+ihBeU3YHUyT1miU
        MroJf/a+6j7U1/DfCCgVrS2mLIwieDlOqtvJ47r5pr41ZNUE4c/rgozjgRkExLSm/MA9Q9HHsILuq
        aDwK89u6hqod++dBgztzO5d3hvONq+JmRGRVG0VzaYp/hrazAp/J4Y77CQQVGqp5+ZpRSM0rkODDO
        KV/Nkfxq5jeaABW2jMSPEV5+7F6orlVUh38bp4T48PtoYt1977BMfz79m1M4asql6lp5zkUHoCkNA
        DqmaMDG9V4QpD3wIddspBMz8HXYKUyzCLPRnGWZGJowjn8HbR7YNclLxKRoSQdkI8iPelWcNFwqV6
        ar9BjcGA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsqTt-00HGL5-3P; Sun, 22 May 2022 18:39:09 +0000
Date:   Sun, 22 May 2022 18:39:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
References: <Yoobb6GZPbNe7s0/@casper.infradead.org>
 <20220522114540.GA20469@lst.de>
 <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
 <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
 <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 12:29:16PM -0600, Jens Axboe wrote:
> It was sent out as a discussion point, it's not a submission and it's by
> no means complete (as mentioned!). If you're working on this, I'd be
> happy to drop it, it's not like I really enjoy the iov_iter code... And
> it sounds like you are?

*snort*

Yes, I am working on it.  As for enjoying that thing...  I'm not fond of
forests of macros, to put it mildly.  Even in the trimmed form it still
stinks, and places like copy_page_to_iter for iovec are still fucking
awful wrt misguided microoptimization attempts - mine, at that, so I've
nobody else to curse ;-/
