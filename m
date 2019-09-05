Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB1DEAA11D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 13:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbfIELRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 07:17:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40104 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732773AbfIELRn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:17:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so2023618ljw.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2019 04:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FZQLTiI56V9ejCTERxmKEuoyOsqpXI4ROWUat/u48IQ=;
        b=TmAHYZxqRc6xu2le8iULfxikI7ku0uT9OqruTeiVIjBtHlSUVtr7xfmu4YCFlsjTOs
         Rhq1GYmaO5KwXBXGMlzcAxQ/LcO6e9A60OIH5XcxDVVNn2uwqfJXj5l04xQJTBjas8S+
         rezhJDHHi4QSeAmUuvBdnaXdMHr6k1YEDw8fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FZQLTiI56V9ejCTERxmKEuoyOsqpXI4ROWUat/u48IQ=;
        b=NnoDkI7/0AdesHUfNIgkTi13EomY3lLRjCY7O35L/4YrrDpPIg5FigdIq4CyXD2MWz
         wzqD4Azy7sOqoFcC/5jJDJmXlyKyfkIRSic01IlZ2Oe8IwkF1lDIKoa4Jx48M4cLbjuT
         gqTJoDPsyE85nkByE9lAqoFbTzA3tm6cquRBowUhUKmZ5ehDucHhEgCZ2qtBQHfl4JER
         G+3vW/VwXa1TJOwsElApT5gBH3GeUlX1k8DQJTDH8Ekj59jH1xpbfZM99oC+9vwtUEMa
         QjUUlV5vBYI/Oc+J2aoKhbUOkd6ql0aHA69V54Suawa6SPgpsu5C8yvHacBos88ndrVZ
         TAyg==
X-Gm-Message-State: APjAAAUjH85vxPeQcStTOLPg0zTRsFLUTFvns61biKZyLBmABlpF+YZT
        fnOAoWG2PMmr7PdxfCBMpa/XCg==
X-Google-Smtp-Source: APXvYqy+jIyWA4s/Awrv2CCVQWWEoIb0eYt4SAhqVoZ9KSv6Iim6pns0uTxVPV5vb5IsmAlCA9M4vg==
X-Received: by 2002:a2e:5418:: with SMTP id i24mr1705390ljb.126.1567682261376;
        Thu, 05 Sep 2019 04:17:41 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l3sm377157lfc.31.2019.09.05.04.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 04:17:40 -0700 (PDT)
Subject: Re: [PATCH v12 01/12] lib: introduce copy_struct_{to,from}_user
 helpers
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <20190905110544.d6c5t7rx25kvywmi@wittgenstein>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ae415ea8-4442-d81c-3b46-2ae5fb35bbdf@rasmusvillemoes.dk>
Date:   Thu, 5 Sep 2019 13:17:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905110544.d6c5t7rx25kvywmi@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/09/2019 13.05, Christian Brauner wrote:
> On Thu, Sep 05, 2019 at 06:19:22AM +1000, Aleksa Sarai wrote:

>> +	if (unlikely(!access_ok(dst, usize)))
>> +		return -EFAULT;
>> +
>> +	/* Deal with trailing bytes. */
>> +	if (usize < ksize) {
>> +		if (memchr_inv(src + size, 0, rest))
>> +			return -EFBIG;
>> +	} else if (usize > ksize) {
>> +		if (__memzero_user(dst + size, rest))
>> +			return -EFAULT;
> 
> Is zeroing that memory really our job? Seems to me we should just check
> it is zeroed.

Of course it is, otherwise you'd require userspace to clear the output
buffer it gives us, which in the majority of cases is wasted work. It's
much easier to reason about if we just say "the kernel populates [uaddr,
uaddr + usize)".

It's completely symmetric to copy_struct_from_user doing a memset() of
the tail of the kernel buffer in case of ksize>usize - you wouldn't want
to require the kernel callers to pass a zeroed buffer to
copy_struct_from_user() - it's just that when we memset(__user*),
there's an error check to do.

Rasmus
