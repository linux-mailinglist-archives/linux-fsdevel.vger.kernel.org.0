Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4A51041B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 18:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfKTRGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 12:06:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42981 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfKTRGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:06:30 -0500
Received: by mail-lj1-f196.google.com with SMTP id n5so28337813ljc.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 09:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1xGFIRtv/OHciMaYQotovOrkugAlju9eBYjRe4Q6E4=;
        b=DcPo504/qUqrmZ1BcRFqtF0UU5vTSdd+gWao6lvT0EFZ+aGIBQn1e6r72M6rhZcJJO
         k87yCCYpvMeEn14+sCKcBaiZm4DGoTLNxWDFEa+HzMxbNVSIe9+z+BHyZheB24FUdThG
         g1eHGXGjEGGSlBlI1ELvrAkPZyn1ohfLkBl7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1xGFIRtv/OHciMaYQotovOrkugAlju9eBYjRe4Q6E4=;
        b=SIFPb4PUvY9wiTGyuTxbDKG1FWDbER8nFcnmkVs6xgp3qVxfO8+O1JK0AFEF1NuC+u
         pplaEEb96lm1nxDU68JXPpdeCaeHQ3vr55QC2FycpjZ3sxbob64FBVVYexs+oNq8gugY
         z3K1ZABSOdxrmdl/r1/+BApWkg9RovNog2Crypei2EjmQ1saDSiejCIWVPLAb5qLaajE
         1ePEN7MM/OwmHQrTG8bMgheLxUqLbysOSAI40ZfUKSkBfxOvQOrz8qzKLMX7LSBPDBDK
         xLBTOLHp1XkVmFJTX+DAu9DFW38VZyxcUkXxSYfYG5ZQlb4ziM4yhemAHrGadO5xXLrg
         ZOZw==
X-Gm-Message-State: APjAAAX8vVsI3uhjDyi91Ck3u1nVESwHYcjNONfEBBFD4nStmgXMmymK
        ri4XMYnwlbgfu5xK1xS6sL7NxL5AgME=
X-Google-Smtp-Source: APXvYqylPl7QDeXN5pMYjehA0GqUOeCEyG6SItK5ojhxciXqtyg3weeBHxpC8L5d7lU0TMbXzano8w==
X-Received: by 2002:a2e:9a41:: with SMTP id k1mr3572909ljj.11.1574269588285;
        Wed, 20 Nov 2019 09:06:28 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id u4sm12169388ljj.87.2019.11.20.09.06.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 09:06:27 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id q2so28391875ljg.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 09:06:27 -0800 (PST)
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr3802648lji.1.1574269586670;
 Wed, 20 Nov 2019 09:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20191120154111.9788-1-hubcap@kernel.org>
In-Reply-To: <20191120154111.9788-1-hubcap@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Nov 2019 09:06:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whZLTTCN9pFZhisjJZp8JarO_iveEaS2SrAU+COd_hzSA@mail.gmail.com>
Message-ID: <CAHk-=whZLTTCN9pFZhisjJZp8JarO_iveEaS2SrAU+COd_hzSA@mail.gmail.com>
Subject: Re: [PATCH] orangefs: posix read and write on open files.
To:     hubcap@kernel.org
Cc:     Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 20, 2019 at 7:41 AM <hubcap@kernel.org> wrote:
>
> From: Mike Marshall <hubcap@omnibond.com>
>
> Orangefs doesn't have an open function. Orangefs performs
> permission checks on files each time they are accessed.

This is completely broken, and your fix doesn't even fix the brokenness.

Giving a user access rights as a workaround for the breakage is wrong,
and has nothing at all to do with POSIX. It just breaks things even
more in other ways - now you open other processes to re-open the file
when they really really shouldn't be able to. So your "fix" is quite
possibly a security issue.

Also, the much more common case - that your patch doesn't fix - is
that a file is opened with one set of credentials, and then used with
another set entirely. Trying to use some kind of ACL to say "original
opener can write to this" is wrong, and doesn't fix that.

For example, the file may be opened by root, and then root drops all
privileges and reverts to the original user. The file should still be
writable, even though the UID changed.

(Another case of that is to just transfer the fd over unix domain
sockets to a different process entirely, but that is much more
unusual).

The fact is, permission checks at the time of access are simply
*wrong*. They cannot work. No amount of "give the file a fake ACL"
will ever make it work.

The permission checks are done at open time. After that, they are
simply not done. That's the POSIX model.

                  Linus
