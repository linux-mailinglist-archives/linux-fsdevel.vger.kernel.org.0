Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962A267F5F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2019 16:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfGNOgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jul 2019 10:36:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42092 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfGNOgy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jul 2019 10:36:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hmfbz-00010j-Kc; Sun, 14 Jul 2019 14:36:23 +0000
Date:   Sun, 14 Jul 2019 15:36:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 05/10] namei: O_BENEATH-style path resolution flags
Message-ID: <20190714143623.GR17978@ZenIV.linux.org.uk>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-6-cyphar@cyphar.com>
 <20190712043341.GI17978@ZenIV.linux.org.uk>
 <20190712105745.nruaftgeat6irhzr@yavin>
 <20190712123924.GK17978@ZenIV.linux.org.uk>
 <20190712125552.GL17978@ZenIV.linux.org.uk>
 <20190712132553.GN17978@ZenIV.linux.org.uk>
 <20190712150026.GO17978@ZenIV.linux.org.uk>
 <20190713024153.GA3817@ZenIV.linux.org.uk>
 <20190714070029.m53etvm3y4etidxt@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190714070029.m53etvm3y4etidxt@yavin>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 14, 2019 at 05:00:29PM +1000, Aleksa Sarai wrote:

> The basic property being guaranteed by LOOKUP_IN_ROOT is that it will
> not result in resolution of a path component which was not inside the
> root of the dirfd tree at some point during resolution (and that all
> absolute symlink and ".." resolution will be done relative to the
> dirfd). This may smell slightly of chroot(2), because unfortunately it
> is a similar concept -- the reason for this is to allow for a more
> efficient way to safely resolve paths inside a rootfs than spawning a
> separate process to then pass back the fd to the caller.

IDGI...  If attacker can modify your subtree, you have already lost -
after all, they can make anything appear inside that tree just before
your syscall is made and bring it back out immediately afterwards.
And if they can't, what is the race you are trying to protect against?
Confused...
