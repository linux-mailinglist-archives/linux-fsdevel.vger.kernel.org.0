Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787E31648BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgBSPge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 10:36:34 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50724 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726645AbgBSPgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:36:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C8E7E8EE3C5;
        Wed, 19 Feb 2020 07:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582126592;
        bh=Olisob633QW5LfExi8a7Lh6PWpLjGpBMyExTbRd7Pdk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sMELI4Dv6IfAbGlqQCjDKaFb+F5bS8Ikx7LEV6RQPYrgTG4tqtMwI5n/x9AHlu21V
         lji/5z5uQav4OvhsoGGnbM5e7HpCKAkv91/3YIL5FJT1M2FMitGqNkAydb+5BoQaWT
         gT0awUIFgCzQyD8Bw/W27GG1ZGAzxGF5C2fA5Qro=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DuU4QiKOBDg9; Wed, 19 Feb 2020 07:36:32 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DC9F58EE144;
        Wed, 19 Feb 2020 07:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582126592;
        bh=Olisob633QW5LfExi8a7Lh6PWpLjGpBMyExTbRd7Pdk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sMELI4Dv6IfAbGlqQCjDKaFb+F5bS8Ikx7LEV6RQPYrgTG4tqtMwI5n/x9AHlu21V
         lji/5z5uQav4OvhsoGGnbM5e7HpCKAkv91/3YIL5FJT1M2FMitGqNkAydb+5BoQaWT
         gT0awUIFgCzQyD8Bw/W27GG1ZGAzxGF5C2fA5Qro=
Message-ID: <1582126590.10671.18.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 00/25] user_namespace: introduce fsid mappings
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?ISO-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, smbarber@chromium.org,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Wed, 19 Feb 2020 07:36:30 -0800
In-Reply-To: <20200219122752.jalnsmsotigwxwsw@wittgenstein>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
         <1582069856.16681.59.camel@HansenPartnership.com>
         <20200219122752.jalnsmsotigwxwsw@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-02-19 at 13:27 +0100, Christian Brauner wrote:
> On Tue, Feb 18, 2020 at 03:50:56PM -0800, James Bottomley wrote:
> > On Tue, 2020-02-18 at 15:33 +0100, Christian Brauner wrote:
[...]
> > > With fsid mappings we can solve this by writing an id mapping of
> > > 0 100000 100000 and an fsid mapping of 0 300000 100000. On
> > > filesystem access the kernel will now lookup the mapping for
> > > 300000 in the fsid mapping tables of the user namespace. And
> > > since such a mapping exists, the corresponding files will have
> > > correct ownership.
> > 
> > So I did compile this up in order to run the shiftfs tests over it
> > to see how it coped with the various corner cases.  However, what I
> > find is it simply fails the fsid reverse mapping in the
> > setup.  Trying to use a simple uid of 0 100000 1000 and a fsid of
> > 100000 0 1000 fails the entry setuid(0) call because of this code:
> 
> This is easy to fix. But what's the exact use-case?

Well, the use case I'm looking to solve is the same one it's always
been: getting a deprivileged fake root in a user_ns to be able to write
an image at fsuid 0.

I don't think it's solvable in your current framework, although
allowing the domain to be disjoint might possibly hack around it.  The
problem with the proposed framework is that there are no backshifts
from the filesystem view, there are only forward shifts to the
filesystem view.  This means that to get your framework to write a
filesystem at fsuid 0 you have to have an identity map for fsuid. Which
I can do: I tested uid shift 0 100000 1000 and fsuid shift 0 0 1000. 
It does all work, as you'd expect because the container has real fs
root not a fake root.  And that's the whole problem:  Firstly, I'm fs
root for any filesystem my userns can see, so any imprecision in
setting up the mount namespace of the container and I own your host and
secondly any containment break and I'm privileged with respect to the
fs uid wherever I escape to so I will likewise own your host.

The only way to keep containment is to have a zero fsuid inside the
container corresponding to a non-zero one outside.  And the only way to
solve the imprecision in mount namespace issue is to strictly control
the entry point at which the writing at fsuid 0 becomes active.

James



