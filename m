Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90572671E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfGLPAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 11:00:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39588 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfGLPAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:00:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hlx2B-000201-9w; Fri, 12 Jul 2019 15:00:27 +0000
Date:   Fri, 12 Jul 2019 16:00:27 +0100
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
Message-ID: <20190712150026.GO17978@ZenIV.linux.org.uk>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-6-cyphar@cyphar.com>
 <20190712043341.GI17978@ZenIV.linux.org.uk>
 <20190712105745.nruaftgeat6irhzr@yavin>
 <20190712123924.GK17978@ZenIV.linux.org.uk>
 <20190712125552.GL17978@ZenIV.linux.org.uk>
 <20190712132553.GN17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712132553.GN17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 02:25:53PM +0100, Al Viro wrote:

> 	if (flags & LOOKUP_BENEATH) {
> 		nd->root = nd->path;
> 		if (!(flags & LOOKUP_RCU))
> 			path_get(&nd->root);
> 		else
> 			nd->root_seq = nd->seq;

BTW, this assignment is needed for LOOKUP_RCU case.  Without it
you are pretty much guaranteed that lazy pathwalk will fail,
when it comes to complete_walk().

Speaking of which, what would happen if LOOKUP_ROOT/LOOKUP_BENEATH
combination would someday get passed?
