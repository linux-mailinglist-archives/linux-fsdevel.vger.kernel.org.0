Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE6AD15F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 02:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfIIAR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 20:17:58 -0400
Received: from namei.org ([65.99.196.166]:43320 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731443AbfIIAR6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 20:17:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x890GNJt027077;
        Mon, 9 Sep 2019 00:16:24 GMT
Date:   Sun, 8 Sep 2019 17:16:23 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?ISO-8859-15?Q?Philippe_Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/5] Add support for O_MAYEXEC
In-Reply-To: <20190906152455.22757-1-mic@digikod.net>
Message-ID: <alpine.LRH.2.21.1909081622240.20426@namei.org>
References: <20190906152455.22757-1-mic@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1665246916-1947903910-1567986261=:20426"
Content-ID: <alpine.LRH.2.21.1909081645470.20426@namei.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1947903910-1567986261=:20426
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.21.1909081645471.20426@namei.org>

On Fri, 6 Sep 2019, Mickaël Salaün wrote:

> Furthermore, the security policy can also be delegated to an LSM, either
> a MAC system or an integrity system.  For instance, the new kernel
> MAY_OPENEXEC flag closes a major IMA measurement/appraisal interpreter
> integrity gap by bringing the ability to check the use of scripts [2].

To clarify, scripts are already covered by IMA if they're executed 
directly, and the gap is when invoking a script as a parameter to the 
interpreter (and for any sourced files). In that case only the interpreter 
is measured/appraised, unless there's a rule also covering the script 
file(s).

See:
https://en.opensuse.org/SDB:Ima_evm#script-behaviour

In theory you could probably also close the gap by modifying the 
interpreters to check for the execute bit on any file opened for 
interpretation (as earlier suggested by Steve Grubb), and then you could 
have IMA measure/appraise all files with +x.  I suspect this could get 
messy in terms of unwanted files being included, and the MAY_OPENEXEC flag 
has cleaner semantics.



-- 
James Morris
<jmorris@namei.org>
--1665246916-1947903910-1567986261=:20426--
