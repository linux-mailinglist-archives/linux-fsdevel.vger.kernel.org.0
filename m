Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD46A147041
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 19:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAWSCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 13:02:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33961 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAWSCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:02:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so3047190lfc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2020 10:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDGhNOsnfRqZ1FkvFFgvc9AjFE5Ddur1Pg9CKAfnAxU=;
        b=R8rUnlTAVJ23suSGKIAk3x/NWMyIV1571Zyk795MWw02ibpxnwpaVKBgIpemglXFyP
         UyAn/M4pPrtxudOzb1Yimjimwf7PBh+D79Avp2N7YtdpAxKItUKS5GifZRNjNI8G6ljo
         pty5cnSbJVgpFW0/1axLB6FvRc4gFKR+F0mc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDGhNOsnfRqZ1FkvFFgvc9AjFE5Ddur1Pg9CKAfnAxU=;
        b=rNUBXKqaVxfOifiz5VtgIMvFyZGLv2T/1BCCkb+c8g6NwKp3uQRQGMXKV2Ttc6sVZ/
         uB45AslLXmMzSfdOrswJRNgL+g/E/yAIyk9AHsQpTPQzrdvtcRys+EQRAxIpHSbb4TRv
         8zZsgxrtp+pqeLHL8aVQ8lCAI6xvXLCNufkSu41Fiu/eATdYkYPovPRMB7h6DXQuHmh1
         BS8MUQlATrGQiYIdQTRx8TYCdWD+62o/U1AM7eCGQBnlL4YvoD5PV1CplteAQTg7hsr4
         jFMPjBsgKnPzYXoa4E7wSknL3wCJQ9duP0pvjU7O8pwiWhm/0rQKZT+4TsyAsdxu1S7/
         GyUg==
X-Gm-Message-State: APjAAAWgpJIBD27uayayrhpQeOwLYq51PBsny/jA57RuYiYoH8DlpXxI
        jfxv3koGiB4SrPFbG+2j/Jsn7DfLpr8=
X-Google-Smtp-Source: APXvYqyTSzgjcY74RFExMJ9CKjv5SRKDE6Ng/9/uXqdEuqlNQVdxAMNxM4LLHX+E1l2PzB4ntU01Ug==
X-Received: by 2002:ac2:5444:: with SMTP id d4mr5142028lfn.49.1579802571159;
        Thu, 23 Jan 2020 10:02:51 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h24sm1653652ljl.80.2020.01.23.10.02.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:02:50 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id j1so4628202lja.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2020 10:02:50 -0800 (PST)
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr23878285ljo.41.1579802569766;
 Thu, 23 Jan 2020 10:02:49 -0800 (PST)
MIME-Version: 1.0
References: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
 <e11a8f0670251267f87e3114e0bdbacb1eb72980.1579783936.git.christophe.leroy@c-s.fr>
In-Reply-To: <e11a8f0670251267f87e3114e0bdbacb1eb72980.1579783936.git.christophe.leroy@c-s.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 10:02:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4HEABOZdjxMzbembNmxs1zYfrNAEc2L+JS9FBSnM8JA@mail.gmail.com>
Message-ID: <CAHk-=wg4HEABOZdjxMzbembNmxs1zYfrNAEc2L+JS9FBSnM8JA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] uaccess: Tell user_access_begin() if it's for a
 write or not
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 4:59 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> On 32 bits powerPC (book3s/32), only write accesses to user are
> protected and there is no point spending time on unlocking for reads.

Honestly, I'm starting to think that 32-bit ppc just needs to look
more like everybody else, than make these changes.

We used to have a read/write argument to the old "verify_area()" and
"access_ok()" model, and it was a mistake. It was due to odd i386 user
access issues. We got rid of it. I'm not convinced this is any better
- it looks very similar and for odd ppc access issues.

But if we really do want to do this, then:

> Add an argument to user_access_begin() to tell when it's for write and
> return an opaque key that will be used by user_access_end() to know
> what was done by user_access_begin().

You should make it more opaque than "unsigned long".

Also, it shouldn't be a "is this a write". What if it's a read _and_ a
write? Only a write? Only a read?

                    Linus
