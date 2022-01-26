Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27249C9E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 13:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbiAZMkg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 07:40:36 -0500
Received: from selene.zem.fi ([178.62.79.47]:43204 "EHLO selene.zem.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234178AbiAZMkf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:40:35 -0500
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 07:40:35 EST
Received: by selene.zem.fi (Postfix, from userid 1000)
        id F22BF4DC4C; Wed, 26 Jan 2022 12:33:39 +0000 (GMT)
Date:   Wed, 26 Jan 2022 12:33:39 +0000
From:   Heikki Kallasjoki <heikki.kallasjoki@iki.fi>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
Message-ID: <YfE/owUY+gVnn2b/@selene.zem.fi>
References: <20220126043947.10058-1-ariadne@dereferenced.org>
 <202201252241.7309AE568F@keescook>
 <39480927-B17F-4573-B335-7FCFD81AB997@chromium.org>
 <44b4472d-1d50-c43f-dbb1-953532339fb4@dereferenced.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44b4472d-1d50-c43f-dbb1-953532339fb4@dereferenced.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 05:18:58AM -0600, Ariadne Conill wrote:
> On Tue, 25 Jan 2022, Kees Cook wrote:
> > Lots of stuff likes to do:
> > execve(path, NULL, NULL);
> 
> I looked at these, and these seem to basically be lazily-written test cases
> which should be fixed.  I didn't see any example of real-world applications
> doing this.  As noted in some of the test cases, there are comments like
> "Solaris doesn't support this," etc.

See also the (small) handful of instances of `execlp(cmd, NULL);` out
there, which I imagine would start to fail:
https://codesearch.debian.net/search?q=execlp%3F%5Cs*%5C%28%5B%5E%2C%5D%2B%2C%5Cs*NULL&literal=0

Two of the hits (ispell, nauty) would seem to be non-test use cases.

As an aside, saying POSIX "disallows" argc == 0 might be overstating it
a little. As far as I can tell (quotes below), while a Strictly
Conforming POSIX Application must provide argc >= 1 to a program it
executes, the argc == 0 case isn't entirely disallowed.

https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/basedefs/V1_chap01.html

"should -- describes a feature or behavior that is recommended but not
mandatory. An application should not rely on the existence of the
feature or behavior."

https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/functions/execve.html

"The value in argv[0] *should* point to a filename string that is
associated with the process --" (emphasis added)

"Early proposals required that the value of argc passed to main() be
"one or greater". This was driven by the same requirement in drafts of
the ISO C standard. In fact, historical implementations have passed a
value of zero when no arguments are supplied to the caller of the exec
functions. This requirement was removed from the ISO C standard and
subsequently removed from this volume of POSIX.1-2017 as well. The
wording, in particular the use of the word should, requires a Strictly
Conforming POSIX Application to pass at least one argument to the exec
function, thus guaranteeing that argc be one or greater when invoked by
such an application. In fact, this is good practice, since many existing
applications reference argv[0] without first checking the value of
argc."

Just to be clear, not disputing the part that disallowing `argc == 0`
would be a reasonable idea, or claiming that there's a valid use case.
Just the part where POSIX would *require* the system to disallow this.

-- 
Heikki Kallasjoki
