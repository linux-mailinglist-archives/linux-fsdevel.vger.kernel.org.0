Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C686849B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfGOHuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 03:50:44 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33297 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfGOHuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:50:44 -0400
Received: by mail-yw1-f68.google.com with SMTP id l124so7074873ywd.0;
        Mon, 15 Jul 2019 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PPKKiy4TOkySs84erSTaGPrR7iQ7CdeTu3bd/bWAIQ=;
        b=jtFWvSggLjAdlRoLceRlD3L8mhrjoJM+b0hNi6SVyoUIjpIXh+1F1+YFQT/gTco5dG
         YOxQod8ltqERqXGxaHtsPX6i9FbySs8UfKp7XsGbfrYXJWBGYgnA1baouQncNkf4apuu
         QiZzFEcrjgqh2/rbw4fMJ2mE1x8tbTBoWLxa5m7hWHCUP97jGjeL0Yoc5PEplVb4Ocsi
         0IMYSmkyG/2z7OFEi/xdE4IA+v56nG3HEecfIDojLpKKF9Loav6H1bw4KCprkvAq2fNl
         JbbqfG9sP3mybUuHsb8iDiJBjasVnMssEQALlAHSOBpclwfIaZwZ9SOx6HWFrJnrgCHP
         3z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PPKKiy4TOkySs84erSTaGPrR7iQ7CdeTu3bd/bWAIQ=;
        b=DmTZnizGocCjRg7zINPh8aR/iqY2kSPlSM0sywe4SESL7iKOFeeE4mmlqj8PYjyh9G
         lej2wg8owvRv6UAdsg6+fvdx+bAqWG3RdrIH24rge12OSBtTKpveXotRFpzPTKVOu/bR
         aggHFGs1y8AZxxbO0WodlhdgsALfXBP9DxxzK8Y2JWnBHtQyJPkjbxnc7CNPTqj7sHSc
         t+GgCTWyGT3Y7l9tCwhhxbAYAbFsOmWUT0x7Coj55m3B9irbLfTWJs12ymYllfZIwjkE
         Q93PsRxSHsetPtcKPwAqNBFVw8KXKe09jZmAeaSEk1PwF6I5sf/mRFUyp1g1Iv94Uauy
         njLA==
X-Gm-Message-State: APjAAAXne7RJlj+oZJKHsChg7+AB2DWI+twZJV/K8Uiyg6LTqzrXUgpu
        R7a9m3gUsgrqQZhYwJcodv04aSJ5vfIH5f7HDd4=
X-Google-Smtp-Source: APXvYqxlHNixHRSxJaTHsrNyfNsQ/iEjX941UVv5ReMsihu6kuOIKxsk1kVQyd+N4jh7C6Kvt7BZ7YjXMrjrZ/jqRf8=
X-Received: by 2002:a81:3c12:: with SMTP id j18mr15450493ywa.294.1563177042978;
 Mon, 15 Jul 2019 00:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
 <CAH2r5muC=cEH1u2L+UvSJ8vsrrQ2LV68yojgVYUAP7MDx3Y1Mw@mail.gmail.com> <CAH2r5mu0yMPX+JFrWvnciYdWVRxGYgPsSX2UKOj2O70-bxzrsw@mail.gmail.com>
In-Reply-To: <CAH2r5mu0yMPX+JFrWvnciYdWVRxGYgPsSX2UKOj2O70-bxzrsw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Jul 2019 10:50:31 +0300
Message-ID: <CAOQ4uxiQC9_OnrdzV+XniFeTDorAe-YHxWEC5c9pT_mxa62JxQ@mail.gmail.com>
Subject: Re: [SMB3][PATCH] fix copy_file_range when copying beyond end of
 source file
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 11, 2019 at 6:19 PM Steve French <smfrench@gmail.com> wrote:
>
> I noticed that the copy_file_range patches were merged (which is good)
> - see below.
>
> Anything else to merge for the changes to cifs.ko that we discussed
> earlier.

There was the cifs patch that I sent you:

cifs: copy_file_range needs to strip setuid bits and update timestamps

That was not included in Darrick's branch.

> I wasn't sure about the "SMB3: fix copy file when beyond
> size of source" patch - it may be redundant.  I will need to check

It is redundant, but if you plan to forward a patch to stable, it
will be easier for you to forward just the CIFS patch, so up to you.
I am not sure if and when I will get to testing and forwarding
copy_file_range patches to stable. Not sure it makes sense.

> with current mainline.  Anything else needed for the enabling of
> copy_file_range cross mount etc.

The mtime update patch is not *needed* for enabling of
copy_file_range cross mount. It is a correctness patch.
So copy_file_range cross mount should work in mainline
with cifs as long as other cifs related bugs have been fixed.

Thanks,
Amir.
