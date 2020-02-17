Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA118161CBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 22:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgBQVUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 16:20:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55236 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgBQVUg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 16:20:36 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j3noV-0004NS-OY; Mon, 17 Feb 2020 21:20:23 +0000
Date:   Mon, 17 Feb 2020 22:20:22 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, smbarber@chromium.org,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v2 00/28] user_namespace: introduce fsid mappings
Message-ID: <20200217212022.2rfex3qsdjyyqrq7@wittgenstein>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
 <1581973568.24289.6.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581973568.24289.6.camel@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 01:06:08PM -0800, James Bottomley wrote:
> On Fri, 2020-02-14 at 19:35 +0100, Christian Brauner wrote:
> [...]
> > People not as familiar with user namespaces might not be aware that
> > fsid mappings already exist. Right now, fsid mappings are always
> > identical to id mappings. Specifically, the kernel will lookup fsuids
> > in the uid mappings and fsgids in the gid mappings of the relevant
> > user namespace.
> 
> This isn't actually entirely true: today we have the superblock user
> namespace, which can be used for fsid remapping on filesystems that
> support it (currently f2fs and fuse).  Since this is a single shift,

Note that this states "the relevant" user namespace not the caller's
user namespace. And the point is true even for such filesystems. fuse
does call make_kuid(fc->user_ns, attr->uid) and hence looks up the
mapping in the id mappings.. This would be replaced by make_kfsuid().

> how is it going to play with s_user_ns?  Do you have to understand the
> superblock mapping to use this shift, or are we simply using this to
> replace s_user_ns?

I'm not sure what you mean by understand the superblock mapping. The
case is not different from the devpts patch in this series.
Fuse needs to be changed to call make_kfsuid() since it is mountable
inside user namespaces at which point everthing just works.
