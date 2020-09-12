Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EEE2676BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 02:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgILASK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 20:18:10 -0400
Received: from namei.org ([65.99.196.166]:56798 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgILASG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 20:18:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 08C0GnVE018654;
        Sat, 12 Sep 2020 00:16:49 GMT
Date:   Sat, 12 Sep 2020 10:16:49 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?ISO-8859-15?Q?Philippe_Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v8 0/3] Add support for AT_INTERPRETED (was
 O_MAYEXEC)
In-Reply-To: <20200909171316.GW1236603@ZenIV.linux.org.uk>
Message-ID: <alpine.LRH.2.21.2009121014440.17638@namei.org>
References: <20200908075956.1069018-1-mic@digikod.net> <20200908185026.GU1236603@ZenIV.linux.org.uk> <e3223b50-0d00-3b64-1e09-cfb1b9648b02@digikod.net> <20200909171316.GW1236603@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-812025260-1599869810=:17638"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-812025260-1599869810=:17638
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 9 Sep 2020, Al Viro wrote:

> On Wed, Sep 09, 2020 at 09:19:11AM +0200, Mickaël Salaün wrote:
> > 
> > On 08/09/2020 20:50, Al Viro wrote:
> > > On Tue, Sep 08, 2020 at 09:59:53AM +0200, Mickaël Salaün wrote:
> > >> Hi,
> > >>
> > >> This height patch series rework the previous O_MAYEXEC series by not
> > >> adding a new flag to openat2(2) but to faccessat2(2) instead.  As
> > >> suggested, this enables to perform the access check on a file descriptor
> > >> instead of on a file path (while opening it).  This may require two
> > >> checks (one on open and then with faccessat2) but it is a more generic
> > >> approach [8].
> > > 
> > > Again, why is that folded into lookup/open/whatnot, rather than being
> > > an operation applied to a file (e.g. O_PATH one)?
> > > 
> > 
> > I don't understand your question. AT_INTERPRETED can and should be used
> > with AT_EMPTY_PATH. The two checks I wrote about was for IMA.
> 
> Once more, with feeling: don't hide that behind existing syscalls.
> If you want to tell LSM have a look at given fs object in a special
> way, *add* *a* *new* *system* *call* *for* *doing* *just* *that*.

It's not just for LSM, though, and it has identical semantics from the 
caller's POV as faccessat().



-- 
James Morris
<jmorris@namei.org>

--1665246916-812025260-1599869810=:17638--
