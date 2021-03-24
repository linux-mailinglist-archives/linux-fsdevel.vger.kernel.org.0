Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEAE347D92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 17:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhCXQVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhCXQUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:20:35 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0898EC0613E1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 09:20:34 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F5D401XLQzMq2Qd;
        Wed, 24 Mar 2021 17:20:32 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4F5D3w2gZgzlh8TB;
        Wed, 24 Mar 2021 17:20:28 +0100 (CET)
Subject: Re: [PATCH v30 12/12] landlock: Add user and kernel documentation
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-13-mic@digikod.net> <202103191056.71AB0515A@keescook>
 <81c76347-9e92-244f-6f32-600984a6c5cb@digikod.net>
Message-ID: <57a2b232-f5ba-b585-da11-972845ac8067@digikod.net>
Date:   Wed, 24 Mar 2021 17:21:07 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <81c76347-9e92-244f-6f32-600984a6c5cb@digikod.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/03/2021 19:54, Mickaël Salaün wrote:
> 
> On 19/03/2021 19:03, Kees Cook wrote:
>> On Tue, Mar 16, 2021 at 09:42:52PM +0100, Mickaël Salaün wrote:
>>> From: Mickaël Salaün <mic@linux.microsoft.com>
[...]
>>
>>> [...]
>>> +Special filesystems
>>> +-------------------
>>> +
>>> +Access to regular files and directories can be restricted by Landlock,
>>> +according to the handled accesses of a ruleset.  However, files that do not
>>> +come from a user-visible filesystem (e.g. pipe, socket), but can still be
>>> +accessed through /proc/self/fd/, cannot currently be restricted.  Likewise,
>>> +some special kernel filesystems such as nsfs, which can be accessed through
>>> +/proc/self/ns/, cannot currently be restricted.  For now, these kind of special
>>> +paths are then always allowed.  Future Landlock evolutions will enable to
>>> +restrict such paths with dedicated ruleset flags.
>>
>> With this series, can /proc (at the top level) be blocked? (i.e. can a
>> landlock user avoid the weirdness by making /proc/$pid/ unavailable?)
> 
> /proc can be blocked, but not /proc/*/ns/* because of disconnected
> roots. I plan to address this.

It is important to note that access to sensitive /proc files such as
ns/* and fd/* are automatically restricted according to domain
hierarchies. I'll add this detail to the documentation. :)
