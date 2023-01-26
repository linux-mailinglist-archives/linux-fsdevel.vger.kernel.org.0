Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0F167C200
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 01:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbjAZAwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 19:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjAZAwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:52:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7606536447
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 16:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10F5A61706
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 00:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B02C433EF;
        Thu, 26 Jan 2023 00:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674694342;
        bh=dTR39INW/B+/BjtOwIyb2xvKH3qSaRM7IRAUMBc6l38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IC2VhpRt6TUDxusb1ko6zc+EfMS8KmhlhL7oH0oxPpYR4wqbAbcKYJJwfdbN21mX6
         /wO5R3aLEqUZkNUX8y0rlvH3oTjKCkz8eqz8w9K+rnn+DnrWiZ4aNUt+JpbKdD623b
         ImOTPyHIiJBXGs1FsPYsfHmCCd+4bKCNvkWTxlm8=
Date:   Wed, 25 Jan 2023 16:52:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fs: don't allocate blocks beyond EOF from
 __mpage_writepage
Message-Id: <20230125165221.4ac37077497afc84bdf8bf19@linux-foundation.org>
In-Reply-To: <20230125142351.4hfehrbuuacx3thp@quack3>
References: <20230103104430.27749-1-jack@suse.cz>
        <Y7r8dsLV0dcs+jBw@infradead.org>
        <20230125142351.4hfehrbuuacx3thp@quack3>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 25 Jan 2023 15:23:51 +0100 Jan Kara <jack@suse.cz> wrote:

> On Sun 08-01-23 09:25:10, Christoph Hellwig wrote:
> > On Tue, Jan 03, 2023 at 11:44:30AM +0100, Jan Kara wrote:
> > > When __mpage_writepage() is called for a page beyond EOF, it will go and
> > > allocate all blocks underlying the page. This is not only unnecessary
> > > but this way blocks can get leaked (e.g. if a page beyond EOF is marked
> > > dirty but in the end write fails and i_size is not extended).
> > 
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Matthew, Andrew, can one of you please pick up this fix? Thanks!
> 

This was added to mm-stable (and hence linux-next) on Jan 18, as
4b89a37d54a0b.

