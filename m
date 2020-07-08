Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3525E21802D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 09:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgGHHD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 03:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbgGHHD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:03:58 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90398C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 00:03:58 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4B1qzH2Lhxzlhcqk;
        Wed,  8 Jul 2020 09:03:55 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4B1qz772rqzlh8TH;
        Wed,  8 Jul 2020 09:03:47 +0200 (CEST)
Subject: Re: [PATCH v19 07/12] landlock: Support filesystem access-control
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
References: <20200707180955.53024-1-mic@digikod.net>
 <20200707180955.53024-8-mic@digikod.net>
 <6a80b712-a7b9-7b47-083a-08b7769016f8@infradead.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <b5d5326f-cf37-36f0-7bce-8494c5a65cb5@digikod.net>
Date:   Wed, 8 Jul 2020 09:03:46 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <6a80b712-a7b9-7b47-083a-08b7769016f8@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 07/07/2020 22:11, Randy Dunlap wrote:
> Hi--
> 
> On 7/7/20 11:09 AM, Mickaël Salaün wrote:
>> ---
>>  arch/Kconfig                  |   7 +
>>  arch/um/Kconfig               |   1 +
>>  include/uapi/linux/landlock.h |  78 +++++
>>  security/landlock/Kconfig     |   2 +-
>>  security/landlock/Makefile    |   2 +-
>>  security/landlock/fs.c        | 609 ++++++++++++++++++++++++++++++++++
>>  security/landlock/fs.h        |  60 ++++
>>  security/landlock/setup.c     |   7 +
>>  security/landlock/setup.h     |   2 +
>>  9 files changed, 766 insertions(+), 2 deletions(-)
>>  create mode 100644 include/uapi/linux/landlock.h
>>  create mode 100644 security/landlock/fs.c
>>  create mode 100644 security/landlock/fs.h
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 8cc35dc556c7..483b7476ac69 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -845,6 +845,13 @@ config COMPAT_32BIT_TIME
>>  config ARCH_NO_PREEMPT
>>  	bool
>>  
>> +config ARCH_EPHEMERAL_STATES
>> +	def_bool n
>> +	help
>> +	  An arch should select this symbol if it do not keep an internal kernel
> 
> 	                                       it does not
> 
>> +	  state for kernel objects such as inodes, but instead rely on something
> 
> 	                                               instead relies on
> 
>> +	  else (e.g. the host kernel for an UML kernel).
>> +
>>  config ARCH_SUPPORTS_RT
>>  	bool
>>  
> 
> thanks.
> 

Thanks Randy!
