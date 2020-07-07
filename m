Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A921789C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 22:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGGUMQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGGUMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:12:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38D3C061755;
        Tue,  7 Jul 2020 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=B/o5Uj7bv1uKmlSBwdGS6cD2I4R/nsJYtW8ks3eYCiY=; b=yoQ6HpvMh/27T/sXK71yFTTfje
        wz1bO443OdeoeMKq6jb+govoxFts4nlmoEYVMaUMslznkdIIVdHi4593t91yqrOxUYEiJU0QgYJop
        HqXF3TwlrPyLRSzUITc+u6bPEDTSJLmRyIcHci7+5iPz+lH5G/rAxSfh/KEwsyO/LIpP67tsYzMsR
        5/eNbab17s5Yi3XneR2K88y+YYj3l9JAmgUSGZatk/lEmJpwujMJoecbtyfSmt9GeLIBW0MPq89QB
        4Hvx5tEcJ7jvnTmtr7DjjuryhIZS/8xGA9wV0M2WORXS8s4w7B9cifC/ERNsr8MJuujfNiYuTlJSL
        KBfyLNdw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jstwl-0008MJ-Kd; Tue, 07 Jul 2020 20:12:07 +0000
Subject: Re: [PATCH v19 07/12] landlock: Support filesystem access-control
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6a80b712-a7b9-7b47-083a-08b7769016f8@infradead.org>
Date:   Tue, 7 Jul 2020 13:11:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707180955.53024-8-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 7/7/20 11:09 AM, Mickaël Salaün wrote:
> ---
>  arch/Kconfig                  |   7 +
>  arch/um/Kconfig               |   1 +
>  include/uapi/linux/landlock.h |  78 +++++
>  security/landlock/Kconfig     |   2 +-
>  security/landlock/Makefile    |   2 +-
>  security/landlock/fs.c        | 609 ++++++++++++++++++++++++++++++++++
>  security/landlock/fs.h        |  60 ++++
>  security/landlock/setup.c     |   7 +
>  security/landlock/setup.h     |   2 +
>  9 files changed, 766 insertions(+), 2 deletions(-)
>  create mode 100644 include/uapi/linux/landlock.h
>  create mode 100644 security/landlock/fs.c
>  create mode 100644 security/landlock/fs.h
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8cc35dc556c7..483b7476ac69 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -845,6 +845,13 @@ config COMPAT_32BIT_TIME
>  config ARCH_NO_PREEMPT
>  	bool
>  
> +config ARCH_EPHEMERAL_STATES
> +	def_bool n
> +	help
> +	  An arch should select this symbol if it do not keep an internal kernel

	                                       it does not

> +	  state for kernel objects such as inodes, but instead rely on something

	                                               instead relies on

> +	  else (e.g. the host kernel for an UML kernel).
> +
>  config ARCH_SUPPORTS_RT
>  	bool
>  

thanks.
-- 
~Randy

