Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B03D2BA004
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 02:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgKTBxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 20:53:32 -0500
Received: from namei.org ([65.99.196.166]:54324 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgKTBxb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:53:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0AK1qcDI017804;
        Fri, 20 Nov 2020 01:52:38 GMT
Date:   Fri, 20 Nov 2020 12:52:38 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Jann Horn <jannh@google.com>
cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v24 02/12] landlock: Add ruleset and domain management
In-Reply-To: <20201112205141.775752-3-mic@digikod.net>
Message-ID: <alpine.LRH.2.21.2011201251010.15634@namei.org>
References: <20201112205141.775752-1-mic@digikod.net> <20201112205141.775752-3-mic@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1401825409-1605837159=:15634"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1401825409-1605837159=:15634
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 12 Nov 2020, Mickaël Salaün wrote:

> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> ---
> 
> Changes since v23:
> * Always intersect access rights.  Following the filesystem change
>   logic, make ruleset updates more consistent by always intersecting
>   access rights (boolean AND) instead of combining them (boolean OR) for
>   the same layer.  This defensive approach could also help avoid user
>   space to inadvertently allow multiple access rights for the same
>   object (e.g.  write and execute access on a path hierarchy) instead of
>   dealing with such inconsistency.  This can happen when there is no
>   deduplication of objects (e.g. paths and underlying inodes) whereas
>   they get different access rights with landlock_add_rule(2).
> * Add extra checks to make sure that:
>   - there is always an (allocated) object in each used rules;
>   - when updating a ruleset with a new rule (i.e. not merging two
>     rulesets), the ruleset doesn't contain multiple layers.
> * Hide merge parameter from the public landlock_insert_rule() API.  This
>   helps avoid misuse of this function.
> * Replace a remaining hardcoded 1 with SINGLE_DEPTH_NESTING.

Jann: any chance you could review this patch again given the changes 
above?

Thanks.


-- 
James Morris
<jmorris@namei.org>

--1665246916-1401825409-1605837159=:15634--
