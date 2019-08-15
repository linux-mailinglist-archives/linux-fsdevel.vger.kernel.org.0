Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0BA8F674
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfHOVd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 17:33:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36711 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbfHOVd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:33:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so2641276lfp.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNmCV0iorJaJ/4B9x9ItjW/vosEJYPNXmEbrNDaYkR4=;
        b=L+KglY9k08E6DLTAvhzP71uPOvFH0ftX6F+VX6R+6Jsi2p0IcQc8kW9P6CTAdz+ndG
         2kHE25Y449pIcxNGVW2Op3sdiMJJ9RxY3h2rJ0z0jJaXhD3+gB6DpMdtXJ9CF9GYMiqO
         DsQMqEq1Yqt+5nFrJdaikQRam9z2lK0MBPn2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNmCV0iorJaJ/4B9x9ItjW/vosEJYPNXmEbrNDaYkR4=;
        b=dbA6ISeFxrepRJ/1JZhkXJDAA1dI91x5B4gVoQOjndJGfrs0boK0NZAI6RVdEnz4i8
         Wo8wJSB778zk++Z6/sgH3Q9Q6Px9Q5CGg9DQo29HXArDuFlV4UY3d+OEFtifHxdJTPhQ
         iU16RnAIEpruEud2qOW++n8tX9ljx0xRXVS3D+E1ULkrRiVUPzyjcanoD5fCDVxdkN0K
         bPthMedPKQqn9iAXYysZBVp//IIP2IaycacT/JQ7yDKcPmaFuSBjARD/C2sU5dVPWBJV
         szqxWzoZMlzhFHDQS5kbE1wkc1fS219Bx5KOjXJUR+0+Hq1Gwe7jiOyCBi+0uFvThwnn
         69fg==
X-Gm-Message-State: APjAAAUS2pscm/+Tokw20Pic7zUkj881kXxuCFArhopHyzz2deuapmdK
        s4iuX4lcppVoLMni0AuHF2je91cdHpE=
X-Google-Smtp-Source: APXvYqy5n494gfUMbhTGciR9Yex2pxhUDyttvP1haoVJQMz3ayZMti3T0eLg4cT0Nxqc+buAkRLLPA==
X-Received: by 2002:a19:7006:: with SMTP id h6mr3418303lfc.5.1565904834305;
        Thu, 15 Aug 2019 14:33:54 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u3sm616738lfm.16.2019.08.15.14.33.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 14:33:53 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id u15so3502907ljl.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 14:33:53 -0700 (PDT)
X-Received: by 2002:a2e:9702:: with SMTP id r2mr2870914lji.84.1565904833142;
 Thu, 15 Aug 2019 14:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190815171347.GD15186@magnolia> <CAHk-=wiHuHLK49LKQhtERXaq0OYUnug4DJZFLPq9RHEG2Cm+bQ@mail.gmail.com>
 <20190815200534.GF15186@magnolia>
In-Reply-To: <20190815200534.GF15186@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Aug 2019 14:33:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJm9OEfJ1gL66jzXsavhXxJCmu9g9jWCCeQPcsFVSO7g@mail.gmail.com>
Message-ID: <CAHk-=wgJm9OEfJ1gL66jzXsavhXxJCmu9g9jWCCeQPcsFVSO7g@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: fixes for 5.3-rc5
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 1:05 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> FWIW I've wondered off and on if the VFS syscalls should be generating
> some kind of audit trail when something returns an error message to
> userspace?

I don't think it makes sense for any random errors. ENOENT / EPERM /
EACCES / EISDIR etc are generally part of normal operation and
expected.

Things like actual filesystem corruption is different, but we haven't
really had good patterns for it. And I'd hate to add something like a
test for -EFSCORRUPTED when it's so rare. It makes more sense to do
any special handling when that is actually detected (when you might
want to do other things too, like make the filesystem be read-only or
whatever)

             Linus
