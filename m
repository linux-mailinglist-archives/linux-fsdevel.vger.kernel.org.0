Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746D1EBD5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 06:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfKAFsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 01:48:14 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43489 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfKAFsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 01:48:14 -0400
Received: by mail-yb1-f194.google.com with SMTP id t11so3462399ybk.10;
        Thu, 31 Oct 2019 22:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GcMXXZghEvnICSboqH8NfPPiAEyVsac7USbTrLyDio=;
        b=WLbcXixH7Z9+igO7PmM+gxQaw5tWIGIRzSvRppuoDhR8SeFlk72xsi7J1pzAamHEy4
         hB+0EKumfJ+bxABCK0lLzSG9RVlzHxWyftdPsEXQz11O5ZsgwpmrlIOlnuBCklPwTaam
         M83+XILXUSmWPUuhVT+tQbn9Aigk77AIYw9C734WNrPJgQAqXdcJh4mdj9BXVwd1Cg3H
         xiwZywaeFDdHeGLSimRaeJz4O/TE5Z7xyigI7TJJye4yep50UyGVQOkCFIG5sUNhVfUb
         MMfd2IZnF+OsX0biWRzf0IUV0riT4sjyxhy1OIB5Y20Ctt6vQl3oyd473PuU6kCHe534
         N32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GcMXXZghEvnICSboqH8NfPPiAEyVsac7USbTrLyDio=;
        b=h4g5TFJA8DYeX/lDlD7Kf9xpi6ZXexXJACXyW2WMzft62eXbAJBrCY+KcM5QTZiwLX
         zRrPvReg/ZJ8GRa+o8qoHqmC3VmO//SXLEhGSqQl+VT/GUBzRNnR9XjzI0Pm+UpjF2V1
         POhBBZUKChZyhOdlE//yhwF9za8LE7C8TtdQjZqngvg5PIEs42qZJkAbuvp/Yc0cT9et
         OFuXXNqac2q9wiEJfL/PsaHNdjo7WFvb9dhUeK928SOEcvE2caFu772A6SW+avsNdkUh
         gH/mDtbqbzB3eE8RN/bmbC4L5rOwqvbiPbOzWVHQymF6SpHCSNtI/Tw9ZtwEE/pYwovs
         4BbA==
X-Gm-Message-State: APjAAAU80GPo2/0htLpOEFT+kL2fDBPfZFSp2vVvdpYdoazxOJJtVp/T
        CsEnTEK1raBhbEzAQybKFWlmRKlIzxe+vHm3bC+MAOhFdQo=
X-Google-Smtp-Source: APXvYqzjiPdBgUNgmf0fdO2mKtJRVEzJH+6FNzliKfqg+C5OAL7gFYfYYn9Q7JxIY5J71/DSa3UpPYiHTR4i1qm6rc8=
X-Received: by 2002:a25:6ec5:: with SMTP id j188mr8092376ybc.207.1572587291819;
 Thu, 31 Oct 2019 22:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <1572521901-5070-1-git-send-email-yili@winhong.com> <20191031140600.GL26530@ZenIV.linux.org.uk>
In-Reply-To: <20191031140600.GL26530@ZenIV.linux.org.uk>
From:   =?UTF-8?B?5p2O5LmJ?= <yilikernel@gmail.com>
Date:   Fri, 1 Nov 2019 13:48:06 +0800
Message-ID: <CAJfdMYDQSKp4AeeBwy5R8qmmtdke693rwArzMf6ay5reemRmRg@mail.gmail.com>
Subject: Re: [PATCH] seq_file: fix condition while loop
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Yi Li <yili@winhong.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:06 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Oct 31, 2019 at 07:38:21PM +0800, Yi Li wrote:
> > From: Yi Li <yilikernel@gmail.com>
> >
> > Use the break condition of loop body.
> > PTR_ERR has some meanings when p is illegal,and return 0 when p is null.
> > set the err = 0 on the next iteration if err > 0.
>
> IDGI.  PTR_ERR() is not going to cause any kind of undefined behaviour for
> any valid pointer and it's trivial to evaluate.  What's the point?
This patch doesn't introduce any functional changes.
Sorry for the noise..
