Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDB97A4FCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjIRQwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjIRQwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:52:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF9C8E;
        Mon, 18 Sep 2023 09:52:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A407C3277F;
        Mon, 18 Sep 2023 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695047100;
        bh=bg/LX3mqOuFh2MUykLPX8sJt2PS9kAFQ6eTnG58UTJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EBfXDkoAMRPT7S4+Xj60vP1HfqObIMKvq/wufcj4BTWO4eGFitJ5RfrY9p9ubXjOp
         lM+FV/NUGTNcWupIJF59Nw8e9NXYH3w8Xm0zAQrk6PaajxkEQT/V/SvLk1qFLGAshP
         VPzg/ASWwsh/812c5zxB+NYiEZZTkmEHq8rEBcfoF+/aFhplIicJM02o3DeI+b8xMj
         xTai3E6zHtaqmr9dYgv/+EtCOkvOr8oc+e5gm+2fdeVg/iBBVs+reVSVKn8Svba9n9
         I95LoiSutTbHxKW4PF0VJAkJ5bGeD4EP677jrpSDWCf/mDIe1QA97BpDmPTUK7ts9R
         v8Wb0zTVo9HQQ==
Date:   Mon, 18 Sep 2023 16:24:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
 <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner>
 <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:14:02PM +0200, Miklos Szeredi wrote:
> On Mon, Sep 18, 2023 at 3:51 PM Christian Brauner <brauner@kernel.org> wrote:
> 
> > I really would prefer a properly typed struct and that's what everyone
> > was happy with in the session as well. So I would not like to change the
> > main parameters.
> 
> I completely  agree.  Just would like to understand this point:
> 
>   struct statmnt *statmnt(u64 mntid, u64 mask, unsigned int flags);
> 
> What's not properly typed about this interface?
> 
> I guess the answer is that it's not a syscall interface, which will
> have an added [void *buf, size_t bufsize], while the buffer sizing is
> done by a simple libc wrapper.
> 
> Do you think that's a problem?  If so, why?

Sorry, I think we just talked passed each other.
I didn't realize you were talking about a glibc wrapper.
I'm not so much concerned with that they can expose this in whathever
way they like. But we will have a lot of low-level userspace that will
directly use statmount() or not even have glibc like go and other
languages.

The system call should please have a proper struct like you had in your
first proposal. This is what I'm concerned about:

int statmount(u64 mnt_id,
              struct statmnt __user *st,
              size_t size,
              unsigned int flags)

instead of taking an void pointer.


