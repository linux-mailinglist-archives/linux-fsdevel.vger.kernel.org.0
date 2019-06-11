Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6129A3C31F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 06:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391045AbfFKEyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 00:54:08 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44377 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390081AbfFKEyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:54:08 -0400
Received: by mail-yw1-f68.google.com with SMTP id m80so4719889ywd.11;
        Mon, 10 Jun 2019 21:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D92Lz/Rh1BjfGyZLx2L116GMHEBQEUp5CKPjNSyHoUk=;
        b=rPS5CsArH+Bzwfq5EDZF5xGqZbhZoG2pAaknhbcp8NyHHQ6vj+Z0WoQmsl6Bi/3YQ/
         pzLOky5EBYzgoxdd+Rjk7PJvYqhsy5PejSbTQSObxBI8wIqv32VuVyLEEpHmH1pI/CQ7
         KmS3MzYHiMUeVzmWvZyHx1HTtIF3WHFyXiHWC1fLieNUz08CvIOgOF/WI9JsjlqYb4ea
         pfYRCRhOwOGO0G/aiRlSD1hkcI2LuyRzrCTVMYBYKe7KfXcarIj3nqq/HeF3ZjQepGEe
         tgevCsZTmhdLIJ0rwlmh10UFYJ5BKdJFg3SAudt0prMheLwFdHV0wKxVD8cA/HHhFL66
         xQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D92Lz/Rh1BjfGyZLx2L116GMHEBQEUp5CKPjNSyHoUk=;
        b=s9dr9N0Rx/1Jw01cQIe8nr9J1yr2UFuoP4NHcJVoCM6hVJbd+HbSfsseCUz8YBBOGR
         g6V1iblytOM8nmHPlFzgFV3Wnf4ztstT2I9rnApe2c0jDrsntUxWCIW1MznSQ9EsiMTQ
         2H8KAjEClxTj7ZKbQ8ek8XCGbXImu9EE3JTMEXsrMKboGfibvsHtr+v/8+c/QiGa38ZX
         5m/3BJp/XOwXJmweKiQ4Wv7YaiNsg7pt0WhCgb0C2wVs9lxHhoPWwJbwhdmsbdhgoUzG
         2su48xjFv5DJRj4Nn/DHJEfZeXql2vBH2BiIccJGxAwU/k0D6PXHBYji2LaOrQksRhvf
         xRBA==
X-Gm-Message-State: APjAAAVIJDJEpzeo67etHxNL6q7ihLz3WX4ITnaQwgXul5+Pl36KbdzO
        6lupT3CUpfNyLjQk4URHel57y+RMJXcU+CIdxYU=
X-Google-Smtp-Source: APXvYqysoQxnVQnmDBMIdj+2gL43pCM2fbflJVzJqN2J/q+GkMQYDjobm6hf9NO6lFGIwNQktmpvK3BtEu2XSAZ3EK8=
X-Received: by 2002:a81:13d4:: with SMTP id 203mr8438355ywt.181.1560228847407;
 Mon, 10 Jun 2019 21:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190610173657.4655-1-amir73il@gmail.com> <CAH2r5mtQObwvdtaNr31fd-wDpjrZi5YLZ+ZcaW0ECVvTR-ByXQ@mail.gmail.com>
In-Reply-To: <CAH2r5mtQObwvdtaNr31fd-wDpjrZi5YLZ+ZcaW0ECVvTR-ByXQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 Jun 2019 07:53:55 +0300
Message-ID: <CAOQ4uxhS6153+bo+JKen7E++1cNquGG2Eir1uc37UEcGFyck5w@mail.gmail.com>
Subject: Re: [PATCH] cifs: copy_file_range needs to strip setuid bits and
 update timestamps
To:     Steve French <smfrench@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 11:39 PM Steve French <smfrench@gmail.com> wrote:
>
> Looks good in my testing so far - but also want to do a little more
> testing with the copy_file_range xfstest cases because your patches
> fixed one additional test (not cross mount copy) so we can understand
> why it fixed that test case.

I know which of my patches fixed generic/43[01].
It was 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
More specifically this code:

        /* Shorten the copy to EOF */
        size_in = i_size_read(inode_in);
        if (pos_in >= size_in)
                count = 0;
        else
                count = min(count, size_in - (uint64_t)pos_in);

If CIFS sends an out of range value of copy length to Windows server,
server replies with an error. That is inconsistent with the semantics of
copy_file_range(2) syscall, which expects "short copy", hence need
to shorten length before passing on to server.

I verified with Aurelien that this is the case and I was under the impression
that he was going to create a similar local fix to cifs code for stable.
I thought he told you, so I forgot to report back myself.

Thanks,
Amir.
