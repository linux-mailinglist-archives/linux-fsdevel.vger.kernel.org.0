Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27BB76F168
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjHCSFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 14:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjHCSEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:04:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FD94686;
        Thu,  3 Aug 2023 11:03:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D57161E69;
        Thu,  3 Aug 2023 18:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6764C433C9;
        Thu,  3 Aug 2023 18:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691085728;
        bh=JGVnC0J1SM2pfWRkhkzwGN7FQbV5LL71nVPTYha/bKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOzdS3qr4/0+WpRbAleMWXu4JXfsMV6P9uaMoFcuDF6NdGo9NRD3JLYIOhuDmcS4C
         MrVbW5/3s9aMHkDV5QBSsVmgZx0NSJNYc/T2SphRC7S8Ez2e+ffQdtyp/l8ZqvprZX
         ZEs9ztLDUKfPKuSK1QJ7eLavxVvWDpy5/KV71g8Ie+o16XJgjqHkcZizmkEtrbeaMJ
         XX7mwzLUWxCCcjuwrPI0NSz9h8wXI5G3NNo9CJOfhTOmL4MQXR7PvFH8PJDH5/CAHt
         uRTWcZU+SMnxk6MAVd82aMi5gEa0XJQ/Ysf9ipX3pUcnOhgHwmWDciZDeluX10QIoG
         iiVpJ1h8eB9qQ==
Date:   Thu, 3 Aug 2023 20:02:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230803-libellen-klebrig-0a9e19dfa7dd@brauner>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-pyjama-papier-9e4cdf5359cb@brauner>
 <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
 <20230803095311.ijpvhx3fyrbkasul@f>
 <CAHk-=whQ51+rKrnUYeuw3EgJMv2RJrwd7UO9qCgOkUdJzcirWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whQ51+rKrnUYeuw3EgJMv2RJrwd7UO9qCgOkUdJzcirWw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 08:45:54AM -0700, Linus Torvalds wrote:
> On Thu, 3 Aug 2023 at 02:53, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > So yes, atomics remain expensive on x86-64 even on a very moden uarch
> > and their impact is measurable in a syscall like read.
> 
> Well, a patch like this should fix it.
> 
> I intentionally didn't bother with the alpha osf version of readdir,
> because nobody cares, but I guess we could do this in the header too.
> 
> Or we could have split the FMODE_ATOMIC_POS bit into two, and had a
> "ALWAYS" version and a regular version, but just having a
> "fdget_dir()" made it simpler.
> 
> So this - together with just reverting commit 20ea1e7d13c1 ("file:
> always lock position for FMODE_ATOMIC_POS") - *should* fix any
> performance regression.
> 
> But I have not tested it at all. So....

Yeah, this is my suggestion - and your earlier suggestion - in the
thread. Only thing that's missing is exclusion with seek on directories
as that's the heinous part.
