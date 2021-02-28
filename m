Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F34F327282
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 14:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhB1N4u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 08:56:50 -0500
Received: from out1.migadu.com ([91.121.223.63]:19062 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhB1N4u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 08:56:50 -0500
X-Greylist: delayed 64310 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Feb 2021 08:56:49 EST
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1614520565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPRqwLQ7R3UvrMGac2JNlWUrHipXXOdI+lOTDeAQJ+E=;
        b=JHOqju67Xe+ESrvtRJttVcpD4RJaxgHsK710BZGlWyTv0kbwMj8svBhH/C+RbsRUyba7O+
        1hf5xvVHqGlfdX2pHLMjaD4U7cujFKWtGY0OZ003ESz/mE2nJtT6gkr723vAYVpbtoiMi0
        cJaXyr72BAb2ba/GcTgUlEVt+4zb64uKKkMpVGy1gVnfAAq4OHAgsizQ6K6Ypi6kaEESWD
        EIbfylHdKArJk2ojETImzGQjGDfcLwpkQH7fFbmiGxXvg2Ix1ZwFAnVcv5mp5sxSToGgfU
        3Qc27jadQMcXD9bfcOV8Kt0gmVR1OcztR2IIivrq9jiZcOzSiZ+qubBqE1gDEw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 28 Feb 2021 08:56:04 -0500
Message-Id: <C9L7RW0S7YU0.16I8160PKEP0K@taiga>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        "Aleksa Sarai" <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <YDr8UihFQ3M469x8@zeniv-ca.linux.org.uk> <C9KSZTRJ2CL6.DWD539LYTVZX@taiga>
 <YDsGzhBzLzSp6nPj@zeniv-ca.linux.org.uk>
In-Reply-To: <YDsGzhBzLzSp6nPj@zeniv-ca.linux.org.uk>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat Feb 27, 2021 at 9:58 PM EST, Al Viro wrote:
> open() *always* returns descriptor or an error, for one thing.
> And quite a few of open() flags are completely wrong for mkdir,
> starting with symlink following and truncation.

So does mkdirat2. Are you referring to the do_mkdirat2 function? I
merged mkdir/mkdirat/mkdirat2 into one function with a flag to enable
the mkdirat2 behavior, to avoid copying and pasting much of the
functionality. However, the syscalls themselves don't overload their
return value as you expect. mkdir & mkdirat both still return 0 or an
error, and mkdirat2 always returns an fd or an error. If you prefer, I
can leave their implementations separate so that this is more clear.

I supposed the flags might be wrong - should I just introduce a new set
of flags, with the specific ones which are useful (which I think is just
O_CLOEXEC)?

> What's more, your implementation is both racy and deadlock-prone -
> it repeats the entire pathwalk with no warranty that it'll
> arrive to the object you've created *AND* if you have
> something like /foo/bar/baz/../../splat and dentry of bar
> gets evicted on memory pressure, that pathwalk will end up
> trying to look bar up. In the already locked /foo, aka
> /foo/bar/baz/../..

This is down to unfamiliarity with this code, I think. I'll try to give
it a closer look.

> TBH, I don't understand what are you trying to achieve -
> what will that mkdir+open combination buy you, especially
> since that atomicity goes straight out of window if you try
> to use that on e.g. NFS. How is the userland supposed to make
> use of that thing?

I'm trying to close what appears to be an oversight in the API. See the
previous threads:

https://lore.kernel.org/linux-fsdevel/C9KKYZ4T5O53.338Y48UIQ9W3H@taiga/T/#t
https://lore.kernel.org/linux-fsdevel/20200316142057.xo24zea3k5zwswra@yavin=
/

Userland uses it the same way they use mkdir+open, but in one call, so
that they can use the directory they make as soon as it's created. The
atomicity goal, if possible, would also add a reference to the new
directory via the open fd, so they can use it even if it's removed by
another process. It makes such applications less error-prone, albiet in
a minor edge case.

I'm not sure what's involved with the NFS case, but I can look into it.
