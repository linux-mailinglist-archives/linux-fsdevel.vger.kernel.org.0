Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A31470EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 19:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAWSiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 13:38:51 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36075 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWSiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:38:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so3124234lfh.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2020 10:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQ25OTOBjFwniHXaIhyRIPei9koK1Vea3aQMS9ddWaY=;
        b=CO5Rx/d/+juGBR+FFLJo0Qdw3RYFgTLIf+Mnl29p0mNIytugs2NcVQlE2/w2WUc19a
         r7ybFhTMI9YigwXFyviyqQt0NfnDBfayvOxgRYe2KBPKF1sYRQ5QUo2wzCyUmR6GFB8N
         XlNGtwTb4WQwbGi39oResI6dOVY+bDpk8CA2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQ25OTOBjFwniHXaIhyRIPei9koK1Vea3aQMS9ddWaY=;
        b=VWtO5Nf6oAksxAo6OEaSHyoAiMwY0ZIgizmAk/QFnfHrhaCTTYPd20Q4TnGrWwNGhX
         izD1BuHXZcivk/WobdM2SUEXp8/lLTEHGia50FZoRWmeu7LWdSiBR/DckHs3FWaamRHL
         T+oipoV4ziho0kL1hhVX2yc8P7IU4wFIF9R7yN8AdLuiBzWc+ZUR/bLVg/7drFdyh2qv
         exXp9WkhHybbTxi9yOidLJNXRmAPKLWOwvJaGYvHYfZ/7G5EUsvIEL4irA3PJ7/ANWvz
         KDFiY/CvidcOVccTixxxR99NNolaTXS1k2IDEXjFI85xkFzO+ibDpi9ZqKxwt5M9460A
         nQCA==
X-Gm-Message-State: APjAAAVvNxNhm+Fpz3rYS3THHBIAG1W5kU9nesESgjek3lQ5iRjr16if
        lZSc9sNNmS9+GvA4nkJQebXbxZ+kSmk=
X-Google-Smtp-Source: APXvYqxtoZ1loHcpH0NRuD1wDs7x61uOqwBNS8Zu8SFiVVEdFFyVgGN/qlK4krQiH0qyX1YjL3/Nmw==
X-Received: by 2002:a19:844:: with SMTP id 65mr5476398lfi.20.1579804727287;
        Thu, 23 Jan 2020 10:38:47 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u15sm1503744lfl.87.2020.01.23.10.38.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:38:46 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id w1so4748856ljh.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2020 10:38:46 -0800 (PST)
X-Received: by 2002:a2e:990e:: with SMTP id v14mr22668549lji.23.1579804725767;
 Thu, 23 Jan 2020 10:38:45 -0800 (PST)
MIME-Version: 1.0
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
 <87muaeidyc.fsf@mpe.ellerman.id.au> <87k15iidrq.fsf@mpe.ellerman.id.au>
In-Reply-To: <87k15iidrq.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 10:38:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCk8z2_kggSCoAGMne8PNSvcT2T4bBH62ngoFrsTyV6w@mail.gmail.com>
Message-ID: <CAHk-=whCk8z2_kggSCoAGMne8PNSvcT2T4bBH62ngoFrsTyV6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fs/readdir: Fix filldir() and filldir64() use of user_access_begin()
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 4:00 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> So I guess I'll wait and see what happens with patch 1.

I've committed my fixes to filldir[64]() directly - they really were
fixing me being lazy about the range, and the name length checking
really is a theoretical "access wrong user space pointer" issue with
corrupted filesystems regardless (even though I suspect it's entirely
theoretical - even a corrupt filesystem hopefully won't be passing in
negative directory entry lengths or something like that).

The "pass in read/write" part I'm not entirely convinced about.
Honestly, if this is just for ppc32 and nobody else really needs it,
make the ppc32s thing always just enable both user space reads and
writes. That's the semantics for x86 and arm as is, I'm not convinced
that we should complicate this for a legacy platform.

                Linus
