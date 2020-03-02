Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421C9175DDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 16:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgCBPFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 10:05:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33812 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBPFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:05:30 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8mdM-0000jw-RJ; Mon, 02 Mar 2020 15:05:28 +0000
Date:   Mon, 2 Mar 2020 16:05:28 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, cyphar@cyphar.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200302150528.okjdx2mkluicje4w@wittgenstein>
References: <20200302143546.srzk3rnh4o6s76a7@wittgenstein>
 <20200302115239.pcxvej3szmricxzu@wittgenstein>
 <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
 <848282.1583159228@warthog.procyon.org.uk>
 <888183.1583160603@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <888183.1583160603@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 02:50:03PM +0000, David Howells wrote:
> Christian Brauner <christian.brauner@ubuntu.com> wrote:
> 
> > I think we settled this and can agree on RESOLVE_NO_SYMLINKS being the
> > right thing to do, i.e. not resolving symlinks will stay opt-in.
> > Or is your worry even with the current semantics of openat2()? I don't
> > see the issue since O_NOFOLLOW still works with openat2().
> 
> Say, for example, my home dir is on a network volume somewhere and /home has a
> symlink pointing to it.  RESOLVE_NO_SYMLINKS cannot be used to access a file
> inside my homedir if the pathwalk would go through /home/dhowells - this would
> affect fsinfo() - so RESOLVE_NO_SYMLINKS is not a substitute for
> AT_SYMLINK_NOFOLLOW (O_NOFOLLOW would not come into it).

I think we didn't really have this issue/face that question because
openat() never supported AT_SYMLINK_{NO}FOLLOW. Whereas e.g. fsinfo()
does. So in such cases we are back to: either allow both AT_* and
RESOLVE_* flags (imho not the best option) or add (a) new RESOLVE_*
variant(s). It seems we leaned toward the latter so far...

Christian
