Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15B7C02E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 19:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjJJRmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 13:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjJJRl6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:41:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796A59E;
        Tue, 10 Oct 2023 10:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8KADT/KyjPGcc1Xf+oHoE2sMrSc4JMCxkLgb+ds3fQA=; b=Z2KuIdaENu9/zJWunhLnXpeyEq
        6Pc4N7irImgXsoJ3HLWa0K24hznSLXbsafvGJAJQ7JvdYlwm3Sat2W/ykmNmGHXy5hgyciHlNiGod
        5kJM2qr+EpC/rKvpWsXpxnhf7dEIp4hNH3r1MIxFTeZZw5QZ9e8T3SLUF+eAEeRrldDvIdQF0KOO3
        dN6zZ/wXrX/+5FkHDnAwXS1CpZoZsjUS+MOstEWsckweuSSGtRkx++Tf0CnAmOeOYon5adc0ZNu/d
        Abntq9iKk9u9yJrhDKDI21MDwkmSDkAEIblqFK5YqSkEYFrmxFcP19glHCKwA4c/JLV2OJZQt1Bmw
        2yCu+wpA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqGjq-0000q1-2z;
        Tue, 10 Oct 2023 17:41:47 +0000
Date:   Tue, 10 Oct 2023 18:41:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] fs: store real path instead of fake path in
 backing file f_path
Message-ID: <20231010174146.GQ800259@ZenIV>
References: <20231009153712.1566422-1-amir73il@gmail.com>
 <20231009153712.1566422-4-amir73il@gmail.com>
 <CAJfpegtcNOCMp+QBPFD5aUEok6u7AqwrGqAqMCZeeuyq6xfYFw@mail.gmail.com>
 <CAOQ4uxiAHJy6viXBubm0y7x3J3P7N5XijOU8C340fi2Dpc7zXA@mail.gmail.com>
 <CAOQ4uxipA5oCQXn1-JZ+TbXw2-5O+_++FfNHC6fKqhNXfR7C0w@mail.gmail.com>
 <CAJfpeguEf71ZknP5rGU9YNtJTp1wBGBKyv6M0JZ=5ETuaipDxQ@mail.gmail.com>
 <20231010165504.GP800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010165504.GP800259@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 10, 2023 at 05:55:04PM +0100, Al Viro wrote:
> On Tue, Oct 10, 2023 at 03:34:45PM +0200, Miklos Szeredi wrote:
> > On Tue, 10 Oct 2023 at 15:17, Amir Goldstein <amir73il@gmail.com> wrote:
> > 
> > > Sorry, you asked about ovl mount.
> > > To me it makes sense that if users observe ovl paths in writable mapped
> > > memory, that ovl should not be remounted RO.
> > > Anyway, I don't see a good reason to allow remount RO for ovl in that case.
> > > Is there?
> > 
> > Agreed.
> > 
> > But is preventing remount RO important enough to warrant special
> > casing of backing file in generic code?  I'm not convinced either
> > way...
> 
> You definitely want to guarantee that remounting filesystem r/o
> prevents the changes of visible contents; it's not just POSIX,
> it's a fairly basic common assumption about any local filesystems.

Incidentally, could we simply keep a reference to original struct file
instead of messing with path?

The only caller of backing_file_open() gets &file->f_path as user_path; how
about passing file instead, and having backing_file_open() do get_file()
on it and stash the sucker into your object?

And have put_file_access() do
	if (unlikely(file->f_mode & FMODE_BACKING))
		fput(backing_file(file)->file);
in the end.

No need to mess with write access in any special way and it's closer
to the semantics we have for normal mmap(), after all - it keeps the
file we'd passed to it open as long as mapping is there.

Comments?
