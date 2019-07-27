Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEE7775FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 04:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfG0C2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 22:28:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50178 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfG0C2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 22:28:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hrCRe-00045F-6X; Sat, 27 Jul 2019 02:28:26 +0000
Date:   Sat, 27 Jul 2019 03:28:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Regression in 5.3 for some FS_USERNS_MOUNT (aka
 user-namespace-mountable) filesystems
Message-ID: <20190727022826.GO1131@ZenIV.linux.org.uk>
References: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
 <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
 <20190726232220.GM1131@ZenIV.linux.org.uk>
 <878sskqp7p.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sskqp7p.fsf@xmission.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 07:46:18PM -0500, Eric W. Biederman wrote:

> If someone had bothered to actually look at how I was proposing to clean
> things up before the new mount api we would already have that.  Sigh.
> 
> You should be able to get away with something like this which moves the
> checks earlier and makes things clearer.  My old patch against the pre
> new mount api code.

Check your instances of ->permission(); AFAICS in all cases it's (in
current terms)
	return ns_capable(fc->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;

In principle I like killing FS_USERNS_MOUNT flag, but when a method
is always either NULL or exact same function...
