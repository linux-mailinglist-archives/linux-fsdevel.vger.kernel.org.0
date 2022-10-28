Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB7611999
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJ1RsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJ1RsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:48:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213111DF432;
        Fri, 28 Oct 2022 10:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6FD4B82C0C;
        Fri, 28 Oct 2022 17:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27028C433C1;
        Fri, 28 Oct 2022 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666979293;
        bh=oabnR2o9lQ1unf12v+PvLZJIhljZ0IVmBAbEiGR5Fwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MX5901LtgvRG6x+/4ThpmypVAz/UXtdTqOVXEfV/PvMB6mhcwPE+rE/+CJWwVaukA
         5D8Zdw0wj87UwsmmK+FDPOTU/egXys3KarUgA8YZ//tKzfahxWIh3LjaUe+m6GH+X8
         JYDwyt9shBgmFtQ9Tbd/lRLRVB99b0PxS3PMOfUNM6hNJ7PFhLK6B5ee0cfU32JC5n
         ZU92RAYPqAO28XWKH8gU06YPqFvs16DWc3zxSJqKbgL1KeHKmN4jzTPhYBGJ6G4ES5
         wOXfYfYQnqtavr43oUIcOXsYHRg40qnZVz8YZo76esQ21PrJV/73u5KxWBy53HalHn
         oEtiFpB2adKSA==
Date:   Fri, 28 Oct 2022 10:48:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 2/2] fsverity: stop using PG_error to track error
 status
Message-ID: <Y1wV248oIKJX0kCy@sol.localdomain>
References: <20220815235052.86545-1-ebiggers@kernel.org>
 <20220815235052.86545-3-ebiggers@kernel.org>
 <47a86f09-3e9b-f841-4191-d750feda6642@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a86f09-3e9b-f841-4191-d750feda6642@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:43:47PM +0800, Chao Yu wrote:
> > @@ -1768,6 +1745,8 @@ static void f2fs_verify_cluster(struct work_struct *work)
> >   void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
> >   				bool in_task)
> >   {
> > +	int i;
> > +
> >   	if (!failed && dic->need_verity) {
> >   		/*
> >   		 * Note that to avoid deadlocks, the verity work can't be done
> > @@ -1777,9 +1756,28 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
> >   		 */
> >   		INIT_WORK(&dic->verity_work, f2fs_verify_cluster);
> >   		fsverity_enqueue_verify_work(&dic->verity_work);
> > -	} else {
> > -		__f2fs_decompress_end_io(dic, failed, in_task);
> 
> Will it be possible to clean up __f2fs_decompress_end_io() and
> f2fs_verify_cluster(), they looks almost similar...
> 

I feel that it's simpler to keep them separate.

> > +static void f2fs_finish_read_bio(struct bio *bio, bool in_task,
> > +				 bool fail_compressed)
> 
> Not sure, fail_decompress or fail_decompression may looks more readable?
> 

I'll add a field 'bool decompression_attempted' to struct bio_post_read_ctx so
that this extra argument won't be needed.

- Eric
