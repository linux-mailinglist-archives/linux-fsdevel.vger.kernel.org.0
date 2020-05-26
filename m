Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C61C5B8B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgEEPgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:36:48 -0400
Received: from smtp-190a.mail.infomaniak.ch ([185.125.25.10]:48191 "EHLO
        smtp-190a.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729250AbgEEPgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:36:48 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49GkMz6zCDzlhnlg;
        Tue,  5 May 2020 17:36:15 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49GkMy4bmmzlvfCB;
        Tue,  5 May 2020 17:36:14 +0200 (CEST)
Subject: Re: [PATCH v5 0/6] Add support for O_MAYEXEC
To:     linux-kernel@vger.kernel.org
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200505153156.925111-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <d4616bc0-39df-5d6c-9f5b-d84cf6e65960@digikod.net>
Date:   Tue, 5 May 2020 17:36:14 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20200505153156.925111-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 05/05/2020 17:31, Mickaël Salaün wrote:
> Hi,
> 
> This fifth patch series add new kernel configurations (OMAYEXEC_STATIC,
> OMAYEXEC_ENFORCE_MOUNT, and OMAYEXEC_ENFORCE_FILE) to enable to
> configure the security policy at kernel build time.  As requested by
> Mimi Zohar, I completed the series with one of her patches for IMA.
> 
> The goal of this patch series is to enable to control script execution
> with interpreters help.  A new O_MAYEXEC flag, usable through
> openat2(2), is added to enable userspace script interpreter to delegate
> to the kernel (and thus the system security policy) the permission to
> interpret/execute scripts or other files containing what can be seen as
> commands.
> 
> A simple system-wide security policy can be enforced by the system
> administrator through a sysctl configuration consistent with the mount
> points or the file access rights.  The documentation patch explains the
> prerequisites.
> 
> Furthermore, the security policy can also be delegated to an LSM, either
> a MAC system or an integrity system.  For instance, the new kernel
> MAY_OPENEXEC flag closes a major IMA measurement/appraisal interpreter
> integrity gap by bringing the ability to check the use of scripts [1].
> Other uses are expected, such as for openat2(2) [2], SGX integration
> [3], bpffs [4] or IPE [5].
> 
> Userspace needs to adapt to take advantage of this new feature.  For
> example, the PEP 578 [6] (Runtime Audit Hooks) enables Python 3.8 to be
> extended with policy enforcement points related to code interpretation,
> which can be used to align with the PowerShell audit features.
> Additional Python security improvements (e.g. a limited interpreter
> withou -c, stdin piping of code) are on their way.
> 
> The initial idea come from CLIP OS 4 and the original implementation has
> been used for more than 12 years:
> https://github.com/clipos-archive/clipos4_doc
> 
> An introduction to O_MAYEXEC was given at the Linux Security Summit
> Europe 2018 - Linux Kernel Security Contributions by ANSSI:
> https://www.youtube.com/watch?v=chNjCRtPKQY&t=17m15s
> The "write xor execute" principle was explained at Kernel Recipes 2018 -
> CLIP OS: a defense-in-depth OS:
> https://www.youtube.com/watch?v=PjRE0uBtkHU&t=11m14s
> 
> This patch series can be applied on top of v5.7-rc4.  This can be tested
> with CONFIG_SYSCTL.  I would really appreciate constructive comments on
> this patch series.
> 
> Previous version:
> https://lore.kernel.org/lkml/20200428175129.634352-1-mic@digikod.net/

The previous version (v4) is
https://lore.kernel.org/lkml/20200430132320.699508-1-mic@digikod.net/
