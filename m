Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3C229CE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 18:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgGVQQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 12:16:53 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52263 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGVQQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:16:52 -0400
X-Originating-IP: 90.63.246.187
Received: from gandi.net (laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr [90.63.246.187])
        (Authenticated sender: thibaut.sautereau@clip-os.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BF6C5E0002;
        Wed, 22 Jul 2020 16:16:39 +0000 (UTC)
Date:   Wed, 22 Jul 2020 18:16:39 +0200
From:   Thibaut Sautereau <thibaut.sautereau@clip-os.org>
To:     Kees Cook <keescook@chromium.org>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 5/7] fs,doc: Enable to enforce noexec mounts or file
 exec through O_MAYEXEC
Message-ID: <20200722161639.GA24129@gandi.net>
References: <20200714181638.45751-1-mic@digikod.net>
 <20200714181638.45751-6-mic@digikod.net>
 <202007151312.C28D112013@keescook>
 <35ea0914-7360-43ab-e381-9614d18cceba@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35ea0914-7360-43ab-e381-9614d18cceba@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 04:39:14PM +0200, Mickaël Salaün wrote:
> 
> On 15/07/2020 22:37, Kees Cook wrote:
> > On Tue, Jul 14, 2020 at 08:16:36PM +0200, Mickaël Salaün wrote:
> >> @@ -2849,7 +2855,7 @@ static int may_open(const struct path *path, int acc_mode, int flag)
> >>  	case S_IFLNK:
> >>  		return -ELOOP;
> >>  	case S_IFDIR:
> >> -		if (acc_mode & (MAY_WRITE | MAY_EXEC))
> >> +		if (acc_mode & (MAY_WRITE | MAY_EXEC | MAY_OPENEXEC))
> >>  			return -EISDIR;
> >>  		break;
> > 
> > (I need to figure out where "open for reading" rejects S_IFDIR, since
> > it's clearly not here...)

Doesn't it come from generic_read_dir() in fs/libfs.c?

> > 
> >>  	case S_IFBLK:
> >> @@ -2859,13 +2865,26 @@ static int may_open(const struct path *path, int acc_mode, int flag)
> >>  		fallthrough;
> >>  	case S_IFIFO:
> >>  	case S_IFSOCK:
> >> -		if (acc_mode & MAY_EXEC)
> >> +		if (acc_mode & (MAY_EXEC | MAY_OPENEXEC))
> >>  			return -EACCES;
> >>  		flag &= ~O_TRUNC;
> >>  		break;
> > 
> > This will immediately break a system that runs code with MAY_OPENEXEC
> > set but reads from a block, char, fifo, or socket, even in the case of
> > a sysadmin leaving the "file" sysctl disabled.
> 
> As documented, O_MAYEXEC is for regular files. The only legitimate use
> case seems to be with pipes, which should probably be allowed when
> enforcement is disabled.

By the way Kees, while we fix that for the next series, do you think it
would be relevant, at least for the sake of clarity, to add a
WARN_ON_ONCE(acc_mode & MAY_OPENEXEC) for the S_IFSOCK case, since a
socket cannot be open anyway?

-- 
Thibaut Sautereau
CLIP OS developer
