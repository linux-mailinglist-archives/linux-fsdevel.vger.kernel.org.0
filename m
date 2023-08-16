Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D5677DCC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 10:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbjHPIvd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 04:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbjHPIvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CA626AF
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 01:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A70D2636C0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 08:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7939DC433C8;
        Wed, 16 Aug 2023 08:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692175876;
        bh=aov9+dZikvknClxMGQ6YtxA8GafbLEuLUxf9xjg9ukE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SdXwDXLuAMxNHANhLNkH2IW+D2lVgEzdu2eQRgeLrCXn4nCOFAtVCe0l8xD4rlhw1
         cWmdIE4a6UTKJlTmxR3enY5apA5P7sbJRYwJHBcnvexxGSN38KanlycVYbv0My9RzP
         Qz5ZeMgP80wmtItgEHY0jU7hInSHG2YUMnX8uqUuebkTIfYTI+dJBhp/i0Eex4JKy0
         G7R1tTHOq3Bnl+ZuXKQc/FqEcQwGijLbi7TYD3Z6uhWoSjzTQF4sijMuGffm7+8h+F
         B8w0mFcSirfyyoubIxZC5Rff74t+h1xYxZdy5lKFDwMRFBAWTvPconyBOVuGPb9CMH
         c0piaqyxlI0Tw==
Date:   Wed, 16 Aug 2023 10:51:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: create kiocb_{start,end}_write() helpers
Message-ID: <20230816-vergeben-stangen-bf5619e714e6@brauner>
References: <20230815165721.821906-1-amir73il@gmail.com>
 <d8013748-f5ec-47c9-b4ba-75538b7ac93d@kernel.dk>
 <12490760-d3fe-4b9d-b726-be2506eff30b@kernel.dk>
 <CAOQ4uxh4YYs2=mqqZMi-L=a19gmcgi7M+2F7iy2WDUf=iqZtxQ@mail.gmail.com>
 <264fbb0a-5fd1-447d-a373-389f74a12bcf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <264fbb0a-5fd1-447d-a373-389f74a12bcf@kernel.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 15, 2023 at 03:16:15PM -0600, Jens Axboe wrote:
> On 8/15/23 12:48 PM, Amir Goldstein wrote:
> > On Tue, Aug 15, 2023 at 8:06?PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 8/15/23 11:02 AM, Jens Axboe wrote:
> >>> On 8/15/23 10:57 AM, Amir Goldstein wrote:
> >>>> +/**
> >>>> + * kiocb_start_write - get write access to a superblock for async file io
> >>>> + * @iocb: the io context we want to submit the write with
> >>>> + *
> >>>> + * This is a variant of file_start_write() for async io submission.
> >>>> + * Should be matched with a call to kiocb_end_write().
> >>>> + */
> >>>> +static inline void kiocb_start_write(struct kiocb *iocb)
> >>>> +{
> >>>> +    struct inode *inode = file_inode(iocb->ki_filp);
> >>>> +
> >>>> +    iocb->ki_flags |= IOCB_WRITE;
> >>>> +    if (WARN_ON_ONCE(iocb->ki_flags & IOCB_WRITE_STARTED))
> >>>> +            return;
> >>>> +    if (!S_ISREG(inode->i_mode))
> >>>> +            return;
> >>>> +    sb_start_write(inode->i_sb);
> >>>> +    /*
> >>>> +     * Fool lockdep by telling it the lock got released so that it
> >>>> +     * doesn't complain about the held lock when we return to userspace.
> >>>> +     */
> >>>> +    __sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
> >>>> +    iocb->ki_flags |= IOCB_WRITE_STARTED;
> >>>> +}
> >>>> +
> >>>> +/**
> >>>> + * kiocb_end_write - drop write access to a superblock after async file io
> >>>> + * @iocb: the io context we sumbitted the write with
> >>>> + *
> >>>> + * Should be matched with a call to kiocb_start_write().
> >>>> + */
> >>>> +static inline void kiocb_end_write(struct kiocb *iocb)
> >>>> +{
> >>>> +    struct inode *inode = file_inode(iocb->ki_filp);
> >>>> +
> >>>> +    if (!(iocb->ki_flags & IOCB_WRITE_STARTED))
> >>>> +            return;
> >>>> +    if (!S_ISREG(inode->i_mode))
> >>>> +            return;
> >>
> >> And how would IOCB_WRITE_STARTED ever be set, if S_ISREG() isn't true?
> > 
> > Good point.
> > I will pass is_reg argument from callers of kiocb_start_write() and
> > will only check IOCB_WRITE_STARTED in kiocb_end_write().
> 
> Please don't pass in an argument that just makes the function do
> nothing. Just gate calling the function on it instead.

Your commit about avoiding dipping into inodes unnecessarily when not
all callers need it is for perf reasons or what's the worry?

Fwiw, I don't mind if we force the callers to check for prerequisites
instead of the helpers. I'm just curious what the thinking behind it is.

Otherwise I think a cleanup like this might be useful.
