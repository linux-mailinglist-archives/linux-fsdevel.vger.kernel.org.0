Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7DD254FBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 22:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgH0UIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 16:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0UIJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 16:08:09 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C7EC061264;
        Thu, 27 Aug 2020 13:08:09 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBOBl-005k79-Px; Thu, 27 Aug 2020 20:08:01 +0000
Date:   Thu, 27 Aug 2020 21:08:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH v9 1/2] Add a "nosymfollow" mount option.
Message-ID: <20200827200801.GB1236603@ZenIV.linux.org.uk>
References: <20200827170947.429611-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827170947.429611-1-zwisler@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:09:46AM -0600, Ross Zwisler wrote:
> From: Mattias Nissler <mnissler@chromium.org>
> 
> For mounts that have the new "nosymfollow" option, don't follow symlinks
> when resolving paths. The new option is similar in spirit to the
> existing "nodev", "noexec", and "nosuid" options, as well as to the
> LOOKUP_NO_SYMLINKS resolve flag in the openat2(2) syscall. Various BSD
> variants have been supporting the "nosymfollow" mount option for a long
> time with equivalent implementations.
> 
> Note that symlinks may still be created on file systems mounted with
> the "nosymfollow" option present. readlink() remains functional, so
> user space code that is aware of symlinks can still choose to follow
> them explicitly.
> 
> Setting the "nosymfollow" mount option helps prevent privileged
> writers from modifying files unintentionally in case there is an
> unexpected link along the accessed path. The "nosymfollow" option is
> thus useful as a defensive measure for systems that need to deal with
> untrusted file systems in privileged contexts.
> 
> More information on the history and motivation for this patch can be
> found here:
> 
> https://sites.google.com/a/chromium.org/dev/chromium-os/chromiumos-design-docs/hardening-against-malicious-stateful-data#TOC-Restricting-symlink-traversal
> 
> Signed-off-by: Mattias Nissler <mnissler@chromium.org>
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
> Changes since v8 [1]:
>  * Look for MNT_NOSYMFOLLOW in link->mnt->mnt_flags so we are testing
>    the link itself rather than the directory holding the link. (Al Viro)
>  * Rebased onto v5.9-rc2.

AFAICS, it applies clean to -rc1; what was the rebase about?
