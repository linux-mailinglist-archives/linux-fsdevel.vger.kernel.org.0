Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3875F6A88C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCBS7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 13:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCBS7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:59:34 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F24B13D72;
        Thu,  2 Mar 2023 10:59:33 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u5so273807plq.7;
        Thu, 02 Mar 2023 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gB2HUq7BqZ9YE5Jdj4A7pEijY65clFvt/4yvZ8jHPnA=;
        b=ctoOOVTs2qJZKuApqbKVDht7z3QHErqz0+Mwy9oj99d80efA79IBLI5jt11rKV4PBq
         Un1DJ8OWpedoFC+v79LCkrPmSgQrDfKhgO9gFf7chHqG6P8yxCRIqVq/EMhcn6pcjnIp
         +On+ZkiLwNgiXPCrlQgHYs5JyaeLyV390VnE25xfRp7JGk/ij8Kt10URI1yia1PqhVoo
         5nvEjKnqrEuR3f3nMv68a/CQYZTlK+Jb/t3Qidspe0pHPzM6mwph+gN1mHC8dksOk6hZ
         PFwvjEiCZUPlVy9CWIWAKhWWJa04YCVDplaylAYdBhM05HAmLH3KM1UIpovzbo1VWQoQ
         u0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gB2HUq7BqZ9YE5Jdj4A7pEijY65clFvt/4yvZ8jHPnA=;
        b=f3BKW2hPgBB18Yh4EmLXf7UvnY+vKEcFTbH/758Iic8fY8AQKbuAG71W8FZrAkImCM
         kufyGpWYZzG8AIi2N1Z+uxLQ1hjhIOT4vKHA60ZyXxNT7E1OrhHuijGitCpBMMUgR8h2
         7KTBC6JGOBZmJJnoDLASukIw/nAQnNLZiSk3X7az9bzwSDvSCDq8SRzDbAiFUiysuGE/
         loFpNZzq5dhoGRb8u58Me8VsNIUF0OSTVzFXpCoXzMiGNVQ1xyAoqIZmPO8aeBDBwMaH
         ocyCOJpbkxiOQymYIaIr6OWSpPjaCMrkVyhLCRcIFosvXkPiMJAepZMVmtkhewgMrYAB
         8seQ==
X-Gm-Message-State: AO0yUKVJdocZZfeaS8sJLanlUnXGtSINdwZ+KlxWD3TydrpamBzJASC1
        88X4D+HelqXsW4Hdkd5hyVirjN00bqrLsw==
X-Google-Smtp-Source: AK7set/ksNl7Jzc+pfuBBpVrz4NHC/5lbtvgGlz8T80xiBtwr3j5Dw4kVMBI6ThbNKQOKdrg/faMvQ==
X-Received: by 2002:a05:6a20:3d83:b0:cc:8266:9951 with SMTP id s3-20020a056a203d8300b000cc82669951mr14028766pzi.56.1677783572375;
        Thu, 02 Mar 2023 10:59:32 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b005a7bd10bb2asm46481pfu.79.2023.03.02.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 10:59:31 -0800 (PST)
Date:   Fri, 03 Mar 2023 00:29:07 +0530
Message-Id: <87pm9rm138.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFCv3 1/3] iomap: Allocate iop in ->write_begin() early
In-Reply-To: <Y/5Jttk0j4m6dep8@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Mar 01, 2023 at 12:03:48AM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>> > On Mon, Feb 27, 2023 at 01:13:30AM +0530, Ritesh Harjani (IBM) wrote:
>> >> +++ b/fs/iomap/buffered-io.c
>> >> @@ -535,11 +535,16 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>> >>  	size_t from = offset_in_folio(folio, pos), to = from + len;
>> >>  	size_t poff, plen;
>> >>
>> >> +	if (pos <= folio_pos(folio) &&
>> >> +	    pos + len >= folio_pos(folio) + folio_size(folio))
>> >> +		return 0;
>> >> +
>> >> +	iop = iomap_page_create(iter->inode, folio, iter->flags);
>> >> +
>> >>  	if (folio_test_uptodate(folio))
>> >>  		return 0;
>> >>  	folio_clear_error(folio);
>> >>
>> >> -	iop = iomap_page_create(iter->inode, folio, iter->flags);
>> >>  	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
>> >>  		return -EAGAIN;
>> >
>> > Don't you want to move the -EAGAIN check up too?  Otherwise an
>> > io_uring write will dirty the entire folio rather than a block.
>>
>> I am not entirely convinced whether we should move this check up
>> (to put it just after the iop allocation). The reason is if the folio is
>> uptodate then it is ok to return 0 rather than -EAGAIN, because we are
>> anyway not going to read the folio from disk (given it is completely
>> uptodate).
>>
>> Thoughts? Or am I missing anything here.
>
> But then we won't have an iop, so a write will dirty the entire folio
> instead of just the blocks you want to dirty.

Ok, I got what you are saying. Make sense. I will give it a try.

Thanks
-ritesh
