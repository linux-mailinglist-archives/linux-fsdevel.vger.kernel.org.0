Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D251C178C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 16:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgEAOS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 10:18:28 -0400
Received: from smtp-42ac.mail.infomaniak.ch ([84.16.66.172]:53963 "EHLO
        smtp-42ac.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729044AbgEAOS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 10:18:28 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49DDqS3rYhzlhNh9;
        Fri,  1 May 2020 16:17:56 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49DDqR24jbzlrVLQ;
        Fri,  1 May 2020 16:17:55 +0200 (CEST)
Subject: Re: [PATCH v3 2/5] fs: Add a MAY_EXECMOUNT flag to infer the noexec
 mount property
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
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
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200428175129.634352-1-mic@digikod.net>
 <20200428175129.634352-3-mic@digikod.net>
 <alpine.LRH.2.21.2005011357290.29679@namei.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <b63caccf-11d1-2c98-71b0-36898e28b0f4@digikod.net>
Date:   Fri, 1 May 2020 16:17:54 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2005011357290.29679@namei.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 01/05/2020 06:02, James Morris wrote:
> On Tue, 28 Apr 2020, Mickaël Salaün wrote:
> 
>> An LSM doesn't get path information related to an access request to open
>> an inode.  This new (internal) MAY_EXECMOUNT flag enables an LSM to
>> check if the underlying mount point of an inode is marked as executable.
>> This is useful to implement a security policy taking advantage of the
>> noexec mount option.
>>
>> This flag is set according to path_noexec(), which checks if a mount
>> point is mounted with MNT_NOEXEC or if the underlying superblock is
>> SB_I_NOEXEC.
>>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Reviewed-by: Philippe Trébuchet <philippe.trebuchet@ssi.gouv.fr>
>> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Kees Cook <keescook@chromium.org>
> 
> Are there any existing LSMs which plan to use this aspect?

This commit message was initially for the first version of O_MAYEXEC,
which extended Yama. The current enforcement implementation is now
directly in the FS subsystem (as requested by Kees Cook). However, this
MAY_EXECMOUNT flag is still used by the current FS implementation and it
could still be useful for LSMs.
