Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14134164431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 13:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBSM2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 07:28:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58298 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgBSM2I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:28:08 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j4OSH-0003l8-Ra; Wed, 19 Feb 2020 12:27:53 +0000
Date:   Wed, 19 Feb 2020 13:27:52 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
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
Subject: Re: [PATCH v3 00/25] user_namespace: introduce fsid mappings
Message-ID: <20200219122752.jalnsmsotigwxwsw@wittgenstein>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <1582069856.16681.59.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1582069856.16681.59.camel@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 03:50:56PM -0800, James Bottomley wrote:
> On Tue, 2020-02-18 at 15:33 +0100, Christian Brauner wrote:
> > In the usual case of running an unprivileged container we will have
> > setup an id mapping, e.g. 0 100000 100000. The on-disk mapping will
> > correspond to this id mapping, i.e. all files which we want to appear
> > as 0:0 inside the user namespace will be chowned to 100000:100000 on
> > the host. This works, because whenever the kernel needs to do a
> > filesystem access it will lookup the corresponding uid and gid in the
> > idmapping tables of the container. Now think about the case where we
> > want to have an id mapping of 0 100000 100000 but an on-disk mapping
> > of 0 300000 100000 which is needed to e.g. share a single on-disk
> > mapping with multiple containers that all have different id mappings.
> > This will be problematic. Whenever a filesystem access is requested,
> > the kernel will now try to lookup a mapping for 300000 in the id
> > mapping tables of the user namespace but since there is none the
> > files will appear to be owned by the overflow id, i.e. usually
> > 65534:65534 or nobody:nogroup.
> > 
> > With fsid mappings we can solve this by writing an id mapping of 0
> > 100000 100000 and an fsid mapping of 0 300000 100000. On filesystem
> > access the kernel will now lookup the mapping for 300000 in the fsid
> > mapping tables of the user namespace. And since such a mapping
> > exists, the corresponding files will have correct ownership.
> 
> So I did compile this up in order to run the shiftfs tests over it to
> see how it coped with the various corner cases.  However, what I find
> is it simply fails the fsid reverse mapping in the setup.  Trying to
> use a simple uid of 0 100000 1000 and a fsid of 100000 0 1000 fails the
> entry setuid(0) call because of this code:

This is easy to fix. But what's the exact use-case?
