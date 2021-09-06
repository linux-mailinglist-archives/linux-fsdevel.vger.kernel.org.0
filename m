Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F8C4014D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 03:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbhIFBlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 21:41:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33523 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241205AbhIFBiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:38:18 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1861au7Q027251
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Sep 2021 21:36:57 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D62B315C3403; Sun,  5 Sep 2021 21:36:56 -0400 (EDT)
Date:   Sun, 5 Sep 2021 21:36:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?utf-8?B?5p2o55S35a2Q?= <nzyang@stu.xidian.edu.cn>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        security@kernel.org
Subject: Re: Report Bug to Linux File System about fs/devpts
Message-ID: <YTVwuH4sxcGqT2BP@mit.edu>
References: <2f73b89f.266.17bb4a7478b.Coremail.nzyang@stu.xidian.edu.cn>
 <YTT8QQqQ2n63OVSP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTT8QQqQ2n63OVSP@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 05, 2021 at 07:20:01PM +0200, Greg KH wrote:
> If you are concerned about this, please restrict the kernel.pty.max
> value to be much lower.

The kernel.pty.max value specifies the global maximum limit.  So I
believe the point solution to *this* particular container resource
limit is to mount separate instances of /dev/pts in each container
chroot with the mount option max=NUM, instead of bind-mounting the
top-level /dev/pts into each container chroot.

And <whack> we can use the rubber mallet to hit one more mole in the
whack-a-mole game.  :-)

Or you can just assume that all of the containers are cooperatively
trying to share the OS resources, and if there is a malicious
container, it can be handled out-of-band by non-technical means (e.g.,
by having the Site Reliability Engineer tracking down owner of said
malicious container, and then talking to their manager to tell them
not to do that particular anti-social thing, docking the owner's
social credit account, etc.).

	   	       	      	 	       - Ted
