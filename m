Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2F1342561
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 19:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhCSSyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 14:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhCSSyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:54:32 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [IPv6:2001:1600:3:17::8faf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA61FC06175F;
        Fri, 19 Mar 2021 11:54:24 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F2Cjq0h8fzMqSGc;
        Fri, 19 Mar 2021 19:54:23 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F2Cjk3K5rzlh8TH;
        Fri, 19 Mar 2021 19:54:18 +0100 (CET)
Subject: Re: [PATCH v30 12/12] landlock: Add user and kernel documentation
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
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <81c76347-9e92-244f-6f32-600984a6c5cb@digikod.net>
Date:   Fri, 19 Mar 2021 19:54:34 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202103191056.71AB0515A@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 19/03/2021 19:03, Kees Cook wrote:
> On Tue, Mar 16, 2021 at 09:42:52PM +0100, Mickaël Salaün wrote:
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> This documentation can be built with the Sphinx framework.
> 
> Well, yes. :) Maybe describe what the documentation covers instead here.
> Regardless: yay docs! This is great.

Well, I don't know what to describe other than the subject, the rest is
in the patch. :)

> 
>> [...]
>> +Bind mounts and OverlayFS
>> +-------------------------
>> +
>> +Landlock enables to restrict access to file hierarchies, which means that these
>> +access rights can be propagated with bind mounts (cf.
>> +:doc:`/filesystems/sharedsubtree`) but not with :doc:`/filesystems/overlayfs`.
>> +
>> +A bind mount mirrors a source file hierarchy to a destination.  The destination
>> +hierarchy is then composed of the exact same files, on which Landlock rules can
>> +be tied, either via the source or the destination path.  These rules restrict
>> +access when they are encountered on a path, which means that they can restrict
>> +access to multiple file hierarchies at the same time, whether these hierarchies
>> +are the result of bind mounts or not.
>> +
>> +An OverlayFS mount point consists of upper and lower layers.  These layers are
>> +combined in a merge directory, result of the mount point.  This merge hierarchy
>> +may include files from the upper and lower layers, but modifications performed
>> +on the merge hierarchy only reflects on the upper layer.  From a Landlock
>> +policy point of view, each OverlayFS layers and merge hierarchies are
>> +standalone and contains their own set of files and directories, which is
>> +different from bind mounts.  A policy restricting an OverlayFS layer will not
>> +restrict the resulted merged hierarchy, and vice versa.
> 
> Can you include some examples about what a user of landlock should do?
> i.e. what are some examples of unexpected results when trying to write
> policy that runs on top of overlayfs, etc?

Landlock works well with overlayfs, at least from my point of view. It
may be a bit disturbing with bind mount though, but it is the same with
other access-controls (e.g. DAC). Landlock users should just think about
file hierarchies and create their policies accordingly. A user should
not try to adapt a policy according to his/her understanding of
overlayfs, but just think about file hierarchies.

> 
>> [...]
>> +File renaming and linking
>> +-------------------------
>> +
>> +Because Landlock targets unprivileged access controls, it is needed to properly
>> +handle composition of rules.  Such property also implies rules nesting.
>> +Properly handling multiple layers of ruleset, each one of them able to restrict
>> +access to files, also implies to inherit the ruleset restrictions from a parent
>> +to its hierarchy.  Because files are identified and restricted by their
>> +hierarchy, moving or linking a file from one directory to another implies to
>> +propagate the hierarchy constraints.  To protect against privilege escalations
>> +through renaming or linking, and for the sack of simplicity, Landlock currently
> 
> typo: sack -> sake

Indeed

> 
>> [...]
>> +Special filesystems
>> +-------------------
>> +
>> +Access to regular files and directories can be restricted by Landlock,
>> +according to the handled accesses of a ruleset.  However, files that do not
>> +come from a user-visible filesystem (e.g. pipe, socket), but can still be
>> +accessed through /proc/self/fd/, cannot currently be restricted.  Likewise,
>> +some special kernel filesystems such as nsfs, which can be accessed through
>> +/proc/self/ns/, cannot currently be restricted.  For now, these kind of special
>> +paths are then always allowed.  Future Landlock evolutions will enable to
>> +restrict such paths with dedicated ruleset flags.
> 
> With this series, can /proc (at the top level) be blocked? (i.e. can a
> landlock user avoid the weirdness by making /proc/$pid/ unavailable?)

/proc can be blocked, but not /proc/*/ns/* because of disconnected
roots. I plan to address this.

> 
>> +Ruleset layers
>> +--------------
>> +
>> +There is a limit of 64 layers of stacked rulesets.  This can be an issue for a
>> +task willing to enforce a new ruleset in complement to its 64 inherited
>> +rulesets.  Once this limit is reached, sys_landlock_restrict_self() returns
>> +E2BIG.  It is then strongly suggested to carefully build rulesets once in the
>> +life of a thread, especially for applications able to launch other applications
>> +that may also want to sandbox themselves (e.g. shells, container managers,
>> +etc.).
> 
> How was this value (64) chosen?
> 

It was first an implementation constraint to limit the memory allocated
for each rule, but it could now be increased if needed. The
implementation still uses u64 for the sake of simplicity, but we could
switch to a bitmap type.
