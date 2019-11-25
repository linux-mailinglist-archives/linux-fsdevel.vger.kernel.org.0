Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18B109262
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 17:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfKYQ60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 11:58:26 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40391 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfKYQ60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:58:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id a137so11544083qkc.7;
        Mon, 25 Nov 2019 08:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pu8Eznl5GQtTXPjOvQ9qkpsA+I6ie4l2E52E9iodSKg=;
        b=kI85VaEUlSWtCUuPFkbQTFWUQOHiHVp00qvsZKCR40vRjJ7HbRRfRKHmOgeCtFNOHJ
         8DDCLa00uLyj2I6rTtVEjA5+HEtebq+ScYFeXJDfb7hrGvscihd69ZlCg+c7VwuO5NmN
         9Dxl1DLsqBsV65H4fZN2pnbtO82hguY2+I9Ul5SewP0/adDMhSznjp9DMfMRq5H/ZjIx
         r8KIf9ouPRbpWKLAKO51I/K7Ra33s3Xh6+BOuzKvB2smCVeO0KFgLMOXxvPplgi0XNxc
         6JnexIvZikj6CcF1I2baJ2wW9XWWPgDlKdc+QuVoGyhDPclWK9Nbi535sUKs0RXxK9HW
         HxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pu8Eznl5GQtTXPjOvQ9qkpsA+I6ie4l2E52E9iodSKg=;
        b=sE53gTKzBPh2HrjLo5ZBrBLWfNLvODyLtm/zziqmZhGiA+pRnsEbmIy6zDOEgnrhkv
         tp+8BUedWUWXD3EyS8hfx2UwA52cI5mT5qtZ/JlyBfWs7QYiflW794HGjsR1+Nyjg8BY
         ZUhhEkmw5U/55VKjO7r+7PagouJvW76kz13Q/8tsmdLTNafiCmdB21nE+gv5Eb+7L7+C
         LyAG9qVqksS7p0CMX1z6RDecY/wATNN6NkgNd88cnLffs9dKknMHFLXxBSKTF42Tz9GM
         AzKQtUcGglbaX8y60Rwdy2juJmBIhzX4o6twKrN7TSXKgByrlT893qNkg6MzS40yergu
         z2UQ==
X-Gm-Message-State: APjAAAUH2RiMkT9ZZOKUUPCNI1P8gGErDbauS1TxICsqQ/HkHz/sPtPH
        XBsljiHOZHeBlhP+5VhNUg==
X-Google-Smtp-Source: APXvYqxO5SzbSMf2GM1QIJxnbLV23bNiR0O9Mm5BFzBdYR1tMAFMsiVe0B+KMLvPAY93McNzzPGxjQ==
X-Received: by 2002:a37:674d:: with SMTP id b74mr27861468qkc.396.1574701104739;
        Mon, 25 Nov 2019 08:58:24 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id j10sm4205971qtb.34.2019.11.25.08.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Nov 2019 08:58:24 -0800 (PST)
Date:   Mon, 25 Nov 2019 11:58:19 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: Re: [PATCH] fuse: Fix the return code of fuse_direct_IO() to deal
 with the error for aio
Message-ID: <20191125165819.k2ghv7h4tzyvyr6e@gabell>
References: <20191118022410.21023-1-msys.mizuma@gmail.com>
 <CAJfpegveuh3b0GMOmC3SuMOq=yi9sgBeOS2LGEetbfKqyS1xtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegveuh3b0GMOmC3SuMOq=yi9sgBeOS2LGEetbfKqyS1xtQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 25, 2019 at 01:38:38PM +0100, Miklos Szeredi wrote:
> On Mon, Nov 18, 2019 at 3:24 AM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> >
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >
> > exit_aio() is sometimes stuck in wait_for_completion() after aio is issued
> > with direct IO and the task receives a signal.
> >
> > That is because kioctx in mm->ioctx_table is in use by aio_kiocb.
> > aio_kiocb->ki_refcnt is 1 at that time. That means iocb_put() isn't
> > called correctly.
> >
> > fuse_get_req() returns as -EINTR when it's blocked and receives a signal.
> > fuse_direct_IO() deals with the -EINTER as -EIOCBQUEUED and returns as
> > -EIOCBQUEUED even though the aio isn't queued.
> > As the result, aio_rw_done() doesn't handle the error, so iocb_put() isn't
> > called via aio_complete_rw(), which is the callback.
> 
> Hi,
> 
> Thanks for the report.
> 
> Can you please test the attached patch (without your patch)?

The patch you attached works well, thanks! I tested it with virtiofs.

Should I post the patch? Or could you take care of it? Let me know.

Thanks!
Masa
