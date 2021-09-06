Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7E8401889
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 11:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbhIFJCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 05:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239748AbhIFJCo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:02:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47DAD60F3A;
        Mon,  6 Sep 2021 09:01:32 +0000 (UTC)
Date:   Mon, 6 Sep 2021 11:01:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        =?utf-8?B?5p2o55S35a2Q?= <nzyang@stu.xidian.edu.cn>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        security@kernel.org
Subject: Re: Report Bug to Linux File System about fs/devpts
Message-ID: <20210906090130.qlej46cxitb2c6d6@wittgenstein>
References: <2f73b89f.266.17bb4a7478b.Coremail.nzyang@stu.xidian.edu.cn>
 <YTT8QQqQ2n63OVSP@kroah.com>
 <YTVwuH4sxcGqT2BP@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTVwuH4sxcGqT2BP@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 05, 2021 at 09:36:56PM -0400, Theodore Ts'o wrote:
> On Sun, Sep 05, 2021 at 07:20:01PM +0200, Greg KH wrote:
> > If you are concerned about this, please restrict the kernel.pty.max
> > value to be much lower.
> 
> The kernel.pty.max value specifies the global maximum limit.  So I
> believe the point solution to *this* particular container resource
> limit is to mount separate instances of /dev/pts in each container
> chroot with the mount option max=NUM, instead of bind-mounting the
> top-level /dev/pts into each container chroot.

Yes, this is literally the standard.

But also, this is a problem for which you don't need any containers. Any
unprivileged user on the host can open as many pty devices as they want
as /dev/ptmx is openable by unprivileged user on every distro. It gets
worse obviously if you set max=1024 on the host obivously as you can
quickly exceed this. But most systems mount devtps without restrictions.
If you're sharing your host's devpts instance then that's a
misconfiguration.

Christian
