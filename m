Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43716377E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 00:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgBRXu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 18:50:59 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35564 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgBRXu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:50:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CECF68EE367;
        Tue, 18 Feb 2020 15:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582069858;
        bh=uAmYYHSWRiJ7Jt65f/eBWdihBlK1KFIAAWXVc9m7yt0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KhPrEaLpdk5FFgsYKEuwFY/rqCQlUMnKPGm2py/twY0ZtW2iIguWNWc8WFKNn2a8s
         5anURAu22KldxiQZCLKx46Rfz58z1zsxEFuyiy1CPDao4Ru/8YS+lSURC0sO/oUk7S
         yIehdox1DGMePvRq0uPTOqchbx7i1wAEhSQw2u0U=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ilGQnuwfvJXX; Tue, 18 Feb 2020 15:50:58 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 73D138EE0D5;
        Tue, 18 Feb 2020 15:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582069858;
        bh=uAmYYHSWRiJ7Jt65f/eBWdihBlK1KFIAAWXVc9m7yt0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KhPrEaLpdk5FFgsYKEuwFY/rqCQlUMnKPGm2py/twY0ZtW2iIguWNWc8WFKNn2a8s
         5anURAu22KldxiQZCLKx46Rfz58z1zsxEFuyiy1CPDao4Ru/8YS+lSURC0sO/oUk7S
         yIehdox1DGMePvRq0uPTOqchbx7i1wAEhSQw2u0U=
Message-ID: <1582069856.16681.59.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 00/25] user_namespace: introduce fsid mappings
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        =?ISO-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, smbarber@chromium.org,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Tue, 18 Feb 2020 15:50:56 -0800
In-Reply-To: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-02-18 at 15:33 +0100, Christian Brauner wrote:
> In the usual case of running an unprivileged container we will have
> setup an id mapping, e.g. 0 100000 100000. The on-disk mapping will
> correspond to this id mapping, i.e. all files which we want to appear
> as 0:0 inside the user namespace will be chowned to 100000:100000 on
> the host. This works, because whenever the kernel needs to do a
> filesystem access it will lookup the corresponding uid and gid in the
> idmapping tables of the container. Now think about the case where we
> want to have an id mapping of 0 100000 100000 but an on-disk mapping
> of 0 300000 100000 which is needed to e.g. share a single on-disk
> mapping with multiple containers that all have different id mappings.
> This will be problematic. Whenever a filesystem access is requested,
> the kernel will now try to lookup a mapping for 300000 in the id
> mapping tables of the user namespace but since there is none the
> files will appear to be owned by the overflow id, i.e. usually
> 65534:65534 or nobody:nogroup.
> 
> With fsid mappings we can solve this by writing an id mapping of 0
> 100000 100000 and an fsid mapping of 0 300000 100000. On filesystem
> access the kernel will now lookup the mapping for 300000 in the fsid
> mapping tables of the user namespace. And since such a mapping
> exists, the corresponding files will have correct ownership.

So I did compile this up in order to run the shiftfs tests over it to
see how it coped with the various corner cases.  However, what I find
is it simply fails the fsid reverse mapping in the setup.  Trying to
use a simple uid of 0 100000 1000 and a fsid of 100000 0 1000 fails the
entry setuid(0) call because of this code:

long __sys_setuid(uid_t uid)
{
	struct user_namespace *ns =
current_user_ns();
	const struct cred *old;
	struct cred *new;
	int
retval;
	kuid_t kuid;
	kuid_t kfsuid;

	kuid = make_kuid(ns, uid);
	if
(!uid_valid(kuid))
		return -EINVAL;

	kfsuid = make_kfsuid(ns, uid);
	if
(!uid_valid(kfsuid))
		return -EINVAL;

which means you can't have a fsid mapping that doesn't have the same
domain as the uid mapping, meaning a reverse mapping isn't possible
because the range and domain have to be inverse and disjoint.

James

