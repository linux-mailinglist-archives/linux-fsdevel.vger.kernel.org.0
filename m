Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273DC1604DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 17:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgBPQlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 11:41:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48353 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgBPQlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 11:41:18 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j3MyN-0000uq-KZ; Sun, 16 Feb 2020 16:40:47 +0000
Date:   Sun, 16 Feb 2020 17:40:46 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 00/28] user_namespace: introduce fsid mappings
Message-ID: <20200216164046.3g2nqvyrd6nis5tm@wittgenstein>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
 <87pneesf0a.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pneesf0a.fsf@mid.deneb.enyo.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 16, 2020 at 04:55:49PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > With fsid mappings we can solve this by writing an id mapping of 0
> > 100000 100000 and an fsid mapping of 0 300000 100000. On filesystem
> > access the kernel will now lookup the mapping for 300000 in the fsid
> > mapping tables of the user namespace. And since such a mapping exists,
> > the corresponding files will have correct ownership.
> 
> I'm worried that this is a bit of a management nightmare because the
> data about the mapping does not live within the file system (it's
> externally determined, static, but crucial to the interpretation of
> file system content).  I expect that many organizations have

Iiuc, that's already the case with user namespaces right now e.g. when
you have an on-disk mapping that doesn't match your user namespace
mapping.

> centralized allocation of user IDs, but centralized allocation of the
> static mapping does not appear feasible.

I thought we're working on this right now with the new nss
infrastructure to register id mappings aka the shadow discussion we've
been having.

> 
> Have you considered a more complex design, where untranslated nested
> user IDs are store in a file attribute (or something like that)?  This

That doesn't sound like it would be feasible especially in the nesting
case wrt. to performance.

Christian
