Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DE8330552
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 01:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhCHA2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Mar 2021 19:28:34 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:34924 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhCHA2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Mar 2021 19:28:23 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJ3ks-003qhK-6S; Mon, 08 Mar 2021 00:28:14 +0000
Date:   Mon, 8 Mar 2021 00:28:14 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc:     Ian Kent <raven@themaw.net>, Matthew Wilcox <willy@infradead.org>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, autofs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ross Zwisler <zwisler@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biggers <ebiggers@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        linux-fsdevel@vger.kernel.org, alexander@mihalicyn.com
Subject: Re: [RFC PATCH] autofs: find_autofs_mount overmounted parent support
Message-ID: <YEVvnvFNpfld7MXM@zeniv-ca.linux.org.uk>
References: <20210303152931.771996-1-alexander.mikhalitsyn@virtuozzo.com>
 <832c1a384dc0b71b2902accf3091ea84381acc10.camel@themaw.net>
 <20210304131133.0ad93dee12a17f41f4052bcb@virtuozzo.com>
 <YEVm+KH/R5y2rU7K@zeniv-ca.linux.org.uk>
 <YEVr5jNlpu2jcdzs@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEVr5jNlpu2jcdzs@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 08, 2021 at 12:12:22AM +0000, Al Viro wrote:

> 	Wait, so you have /proc overmounted, without anything autofs-related on
> /proc/sys/fs/binfmt_misc and still want to have the pathname resolved, just
> because it would've resolved with that overmount of /proc removed?
> 
> 	I hope I'm misreading you; in case I'm not, the ABI is extremely
> tasteless and until you manage to document the exact semantics you want
> for param->path, consider it NAKed.

	BTW, if that thing would be made to work, what's to stop somebody from
doing ...at() syscalls with the resulting fd as a starting point and pathnames
starting with ".."?  "/foo is overmounted, but we can get to anything under
/foo/bar/ in the underlying tree since there's an autofs mount somewhere in
/foo/bar/splat/puke/*"?

	IOW, the real question (aside of "WTF?") is what are you using the
resulting descriptor for and what do you need to be able to do with it.
Details, please.
