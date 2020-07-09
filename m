Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41FD21A69A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 20:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGISH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGISH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:07:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1E4C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2020 11:07:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d17so3457422ljl.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGB1Ppz9iVx4FA/xnoM13tjpRPi/F5lN29F79qSyClI=;
        b=XlUxRvTGYZccRYMrKRoB6EWa71eHhhv7TO7Vq+BYwEosgfG77FRVMUrnAizkb/+sIJ
         rFcH3zyCOVKPaTjKMFymNQmA2ANoiIU33O3g7HgDp0mdHKMUF/14/BxYkEd+THUBakSJ
         LuCHx3jBsBS0QnYep3fFl0iBrz4LUkE9/SE2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGB1Ppz9iVx4FA/xnoM13tjpRPi/F5lN29F79qSyClI=;
        b=gkh8caWZDvJW4y5g+ctwUOaT/JYqB/AAuuzv+1+ClzTjICuBsN/MaoJ2KF9aptY3NV
         Y7pi/F259Fxy3AEv1OPNlPKPwkylVAgO9pnFUSWOt74UBuyvQTVjxY3FdjemRa4ZUIlQ
         UrhHNTiFNMyjqPNYOnX6+qheliW0uZ4haKxqRVnxnXfEgX4ieZSWgti5o/LAzotYe9LW
         u4NoRivIIquKCO08bkLro4YpILbuKarm+kPrNSwcQ/96STj/OfbksD3jTorZoxGkwY05
         Uk1Vkd5eStplgKi9oix4FRT95/mLSzGJPxpXZ6wFtZa2C6ml562MmnqvhlSFikigB0sf
         ILyA==
X-Gm-Message-State: AOAM531qrA7p8aksYdp1RYJnGs7sx/i8z2LXcTtQS0gqU8oCDTa40sJ0
        AmZB+ROQn5uqZtibF4qCzZdq1pNum6Y=
X-Google-Smtp-Source: ABdhPJwgxyzz06ww+NvDNux3IvkPmp2WJIs4nxIKpd4zgnE8ai9goe+mGrlirHfUceFkbJPZ2vzdww==
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr27224812ljk.407.1594318046004;
        Thu, 09 Jul 2020 11:07:26 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id k11sm1039529ljg.37.2020.07.09.11.07.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:07:24 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id h22so3431312lji.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 11:07:24 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr36559372ljj.102.1594318044230;
 Thu, 09 Jul 2020 11:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200709151814.110422-1-hch@lst.de> <20200709151814.110422-16-hch@lst.de>
In-Reply-To: <20200709151814.110422-16-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jul 2020 11:07:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXq_149rcDv9ENkKeKpcEQ93MAvcmAOAbU8=bWG55X2A@mail.gmail.com>
Message-ID: <CAHk-=whXq_149rcDv9ENkKeKpcEQ93MAvcmAOAbU8=bWG55X2A@mail.gmail.com>
Subject: Re: [PATCH 15/17] initramfs: switch initramfs unpacking to struct
 file based APIs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 9, 2020 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no good reason to mess with file descriptors from in-kernel
> code, switch the initramfs unpacking to struct file based write
> instead.  As we don't have nice helper for chmod or chown on a struct
> file or struct path use the pathname based ones instead there.  This
> causes additional (cached) lookups, but keeps the code much simpler.

This is the only one I'm not a huge fan of.

I agree about moving to 'struct file'. But then you could just do the
chown/chmod using chown/chmod_common() on file->f_path.

That would keep the same semantics, and it feels like a more
straightforward patch.

It would still remove the nasty ksys_fchmod/fchmod, it would just
require our - already existing - *_common() functions to be non-static
(and maybe renamed to "vfs_chown/chmod()" instead, that "*_common()"
naming looks a bit odd compared to all our other "vfs_operation()"
helpers).

               Linus
