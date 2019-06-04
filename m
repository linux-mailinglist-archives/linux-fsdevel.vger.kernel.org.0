Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9474E34FAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 20:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFDSP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 14:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfFDSP2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:15:28 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57DB920B1F
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2019 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559672127;
        bh=rJp5OtqEAvAiGS7xlsL6faTP+VzkPZmB2r/CXv2dDMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mXf48L0bbJsFlXG4RQ5TuxVD4BUsGDkraMg70yTes9Vx0aGRiVCyUI6hB1cNcXT2T
         EQOTcLwkJrjxfu0oX0teu7kbJBsSOW2daDsKYxp6iPLqEwCk/FAHCvhDbkgSjhsdEG
         9ydu2jm6dSJLG16MzlOqlVPJ6N/Qq8YHvUFWDAm8=
Received: by mail-wr1-f53.google.com with SMTP id n9so4410934wru.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2019 11:15:27 -0700 (PDT)
X-Gm-Message-State: APjAAAUy8Nu61gs2VNUrQWPkbf59LGgZXm70ygLUMJNh6Kbe7u+9I2iK
        zt6lDI+9FEqejtbJa8oBfBCVMww1d/10iCuG7zEfHQ==
X-Google-Smtp-Source: APXvYqywAF/20o2S/0PCTLXbG818xHPa7/+6N3ZxOBZHPZZP2pqS8x/IU/xPvp6CPNvySeFLxMfwJUc/1kZXrxBbZUY=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr7169034wrj.47.1559672125928;
 Tue, 04 Jun 2019 11:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <155966611030.17449.1411028213562548153.stgit@warthog.procyon.org.uk>
In-Reply-To: <155966611030.17449.1411028213562548153.stgit@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Jun 2019 11:15:14 -0700
X-Gmail-Original-Message-ID: <CALCETrXLoowmrHHWWr3OqsOGBkyGsV_x0nADaEyv+_ysGQdM3g@mail.gmail.com>
Message-ID: <CALCETrXLoowmrHHWWr3OqsOGBkyGsV_x0nADaEyv+_ysGQdM3g@mail.gmail.com>
Subject: Re: [PATCH 1/8] security: Override creds in __fput() with last
 fputter's creds [ver #2]
To:     David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 4, 2019 at 9:35 AM David Howells <dhowells@redhat.com> wrote:
>
> So that the LSM can see the credentials of the last process to do an fput()
> on a file object when the file object is being dismantled, do the following
> steps:
>
>  (1) Cache the current credentials in file->f_fput_cred at the point the
>      file object's reference count reaches zero.

I don't think it's valid to capture credentials in close().  This
sounds very easy to spoof, especially when you consider that you can
stick an fd in unix socket and aim it at a service that's just going
to ignore it and close it.

IOW I think this is at least as invalid as looking at current_cred()
in write(), which is a classic bug that gets repeated regularly.

--Andy
