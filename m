Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3B76F2B8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 01:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjD3Xcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 19:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjD3Xcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 19:32:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D59196
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Apr 2023 16:32:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-518d325b8a2so1679891a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Apr 2023 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1682897565; x=1685489565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ1l0P2ACndSiMdOE4J6ZoGtzrua2glCgXYzPLQsoVU=;
        b=y278rE84hgF07qf8oHa6Q8OwnpsBtAyMg5IJJegAdDN53g3P5HRASS/nJan9lO1hXo
         k6wxU7BGaXN4UcKVcc9oEziAeQchCsNuy+SakzPdJRcqfkrakOk9YGK16p7xcDVwb+1E
         Ca4OByRJS7T24Ql3/sdqMp6vXMOWs10BZeVrsPNApVgLPvrl4UpDFb+uOJwVYicM2wbo
         Fdcx+Kwz0mMJeN1MHz1gPdsRjWUmNdue4K1eKASa2jgqUIcZA2tw7i+XbUDRxv4aIriy
         jkMAm99StEiuUybLpKhpEeG5Zp3H2ypGPJ9ejQZ7h//ud0v6JihUlLFHPSAlgeQTFvb6
         CtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682897565; x=1685489565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ1l0P2ACndSiMdOE4J6ZoGtzrua2glCgXYzPLQsoVU=;
        b=NSNiAyh5nPWBoRKTz2mIQBD05MRaMflVtduHcWkA+9c783PkBVYaIm+YY0h3jn4jiD
         f/OsUfU8JgBSyu3gw80QfGU6xP+MPLQFc1kB8VKP0Xur03gFfy6ijjXm3sonyowYPRTk
         jRIh6Yn+LjFhrQeMfgcLQAaBwDZ7ESF3p6PBcTtjmHPr8DFI/39jVgZ2v69jxUy2HTwX
         9Mwe4sgrkg2SojOSJIW0RQ7QFpzC9WWk+oH1LYX+L720qjOlQyoXZi6HaCjq+vLVUQ5v
         adyuSVemosE6JWaw/+G5k5iH+IgGfme2idYXe7PH61iOkDesvvf19P8Wf3fVF9uUYyM4
         CCAg==
X-Gm-Message-State: AC+VfDzAuFdOeeL8hJqx9XvJzrwzf1aFHMgUj5zMicdZR8XCAu+9rucq
        dDcj27K0lQ3e+pSKOSSpZp5mCA==
X-Google-Smtp-Source: ACHHUZ4bcsaHRdw4JfRA9HqwWWnYHhBR3b4JEOGCFnwr5btm12YkTXuvVM8weSjTnX4VI8UjDuXyaQ==
X-Received: by 2002:a17:90b:1b44:b0:247:4c4b:f4eb with SMTP id nv4-20020a17090b1b4400b002474c4bf4ebmr12550550pjb.21.1682897564831;
        Sun, 30 Apr 2023 16:32:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id fu2-20020a17090ad18200b0024dfcaed451sm852014pjb.52.2023.04.30.16.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 16:32:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ptGX3-009qaD-5p; Mon, 01 May 2023 09:32:41 +1000
Date:   Mon, 1 May 2023 09:32:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Roesch <shr@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] io_uring: add support for getdents
Message-ID: <20230430233241.GC2155823@dread.disaster.area>
References: <20230422-uring-getdents-v1-0-14c1db36e98c@codewreck.org>
 <20230422-uring-getdents-v1-2-14c1db36e98c@codewreck.org>
 <20230423224045.GS447837@dread.disaster.area>
 <ZEXChAJfCRPv9vbs@codewreck.org>
 <20230428050640.GA1969623@dread.disaster.area>
 <ZEtkXJ1vMsFR3tkN@codewreck.org>
 <ZEzQRLUnlix1GvbA@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEzQRLUnlix1GvbA@codewreck.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 29, 2023 at 05:07:32PM +0900, Dominique Martinet wrote:
> Dominique Martinet wrote on Fri, Apr 28, 2023 at 03:14:52PM +0900:
> > > AFAICT, the io_uring code wouldn't need to do much more other than
> > > punt to the work queue if it receives a -EAGAIN result. Otherwise
> > > the what the filesystem returns doesn't need to change, and I don't
> > > see that we need to change how the filldir callbacks work, either.
> > > We just keep filling the user buffer until we either run out of
> > > cached directory data or the user buffer is full.
> > 
> > [...] I'd like to confirm what the uring
> > side needs to do before proceeding -- looking at the read/write path
> > there seems to be a polling mechanism in place to tell uring when to
> > look again, and I haven't looked at this part of the code yet to see
> > what happens if no such polling is in place (does uring just retry
> > periodically?)
> 
> Ok so this part can work out as you said, I hadn't understood what you
> meant by "punt to the work queue" but that should work from my new
> understanding of the ring; we can just return EAGAIN if the non-blocking
> variant doesn't have immediate results and call the blocking variant
> when we're called again without IO_URING_F_NONBLOCK in flags.
> (So there's no need to try to add a form of polling, although that is
> possible if we ever become able to do that; I'll just forget about this
> and be happy this part is easy)
> 
> 
> That just leaves deciding if a filesystem handles the blocking variant
> or not; ideally if we can know early (prep time) we can even mark
> REQ_F_FORCE_ASYNC in flags to skip the non-blocking call for filesystems
> that don't handle that and we get the best of both worlds.
> 
> I've had a second look and I still don't see anything obvious though;
> I'd rather avoid adding a new variant of iterate()/iterate_shared() --
> we could use that as a chance to add a flag to struct file_operation
> instead? e.g., something like mmap_supported_flags:

I don't think that makes sense - the eventual goal is to make
->iterate() go away entirely and all filesystems use
->iterate_shared(). Hence I think adding flags to select iterate vs
iterate_shared and the locking that is needed is the wrong place to
start from here.

Whether the filesystem supports non-blocking ->iterate_shared() or
not is a filesystem implementation option and io_uring needs that
information to be held on the struct file for efficient
determination of whether it should use non-blocking operations or
not.

We already set per-filesystem file modes via the ->open method,
that's how we already tell io_uring that it can do NOWAIT IO, as
well as async read/write IO for regular files. And now we also use
it for FMODE_DIO_PARALLEL_WRITE, too.

See __io_file_supports_nowait()....

Essentially, io_uring already cwhas the mechanism available to it
to determine if it should use NOWAIT semantics for getdents
operations; we just need to set FMODE_NOWAIT correctly for directory
files via ->open() on the filesystems that support it...

[ Hmmmm - we probably need to be more careful in XFS about what
types of files we set those flags on.... ]

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
