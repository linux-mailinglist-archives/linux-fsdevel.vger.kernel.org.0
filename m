Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79CA565A41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 17:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfGKPTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 11:19:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36948 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbfGKPTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:19:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so3200124plr.4;
        Thu, 11 Jul 2019 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1Scw8EBfXi2sOweYF6caCQ0l43iWeGXOCR41hnkNkXE=;
        b=FvNZk2qoaGjVF6/4FvkTP9ylhK1zu71wjFI4zOWsVHFA2ekzR2J33f6me9dMLXdNB5
         I1Dl8O7Cs3564+v0YkaXzhhHtM2+v2023L27TjsUL2a37hKb2gevEZPDnY9pEHdAQJSP
         3SNVjGqZhzp+/DLSo0AJUWpoedVpiM6GHcMrK6AJGy2mhz4HiI2WR9SQJf1pCJEsj/8O
         W1/z1a6PBbQQqBEj/FdlF4LWq/CJdg+R1/yidOmCJnUCFAFFFhJaCiRuZweE6LxmQGIy
         2CJDMKxu0I8ylli3Qfq1UY6AiVFJ6rNLBaSwobTmnMm441BXXrK5c3QkOwhacvlZcJk+
         6n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1Scw8EBfXi2sOweYF6caCQ0l43iWeGXOCR41hnkNkXE=;
        b=Lk2wsmQ7ED21stdRY9/5y13EyQfoOw+KNHj1aDC+uXMM6OIuMlas0XnsVmABH8Pjzj
         5hqt7EaDxuNVsseEz3aYtfWz5IJh7KxlPr+WnZAN4//RHvwd0amcTfK9mDOhqIHQ52Yd
         yvQYaH+DCC3/cS7v+WpwroBSbrPZ/53wBoPkJUS4ns3sEs3EIqs9K20TV1edKKtQ21Op
         vrNxyCBRZswurG5O8Hr7mT7NHHiHMUPt9rBXLv2hTOP+OziOKYUC2fSg/b1ipeMOcFO0
         2UafRz2XmHX8LbSDidip/dMs+PcsjgTn6y+jtPow69Nqt11oeIXGY2QijCwdsT5ncCgR
         zQ3Q==
X-Gm-Message-State: APjAAAWtEaYahnEbVCygYH4u+CDPhC2s109+85dC+pfvAOUfxZXClTTl
        E5aSBhMZPNk6ikz0GjxmGXuTBkidOnyppAo+4VQIen+yqy8=
X-Google-Smtp-Source: APXvYqxkDmzU6lrXhQVX1vYv3kqYMuM1bSDmHAo339CuovC7LsZitqB6uUcy7Mf+2ml1UdDURTHVdBTW3SXeHPRXvc0=
X-Received: by 2002:a17:902:2a68:: with SMTP id i95mr5336584plb.167.1562858380451;
 Thu, 11 Jul 2019 08:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
 <CAH2r5muC=cEH1u2L+UvSJ8vsrrQ2LV68yojgVYUAP7MDx3Y1Mw@mail.gmail.com>
In-Reply-To: <CAH2r5muC=cEH1u2L+UvSJ8vsrrQ2LV68yojgVYUAP7MDx3Y1Mw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 11 Jul 2019 10:19:29 -0500
Message-ID: <CAH2r5mu0yMPX+JFrWvnciYdWVRxGYgPsSX2UKOj2O70-bxzrsw@mail.gmail.com>
Subject: Re: [SMB3][PATCH] fix copy_file_range when copying beyond end of
 source file
To:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I noticed that the copy_file_range patches were merged (which is good)
- see below.

Anything else to merge for the changes to cifs.ko that we discussed
earlier.  I wasn't sure about the "SMB3: fix copy file when beyond
size of source" patch - it may be redundant.  I will need to check
with current mainline.  Anything else needed for the enabling of
copy_file_range cross mount etc.

commit 40f06c799539739a08a56be8a096f56aeed05731
Merge: a47f5c56b2eb fe0da9c09b2d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jul 10 20:32:37 2019 -0700

    Merge tag 'copy-file-range-fixes-1' of
git://git.kernel.org/pub/scm/fs/xfs/xfs-linux

    Pull copy_file_range updates from Darrick Wong:





On Thu, Jul 11, 2019 at 10:16 AM Steve French <smfrench@gmail.com> wrote:
>
> I noticed that the copy_file_range patches were merged (which is good)
>
> On Wed, Jun 19, 2019 at 8:44 PM Steve French <smfrench@gmail.com> wrote:
> >
> > Patch attached fixes the case where copy_file_range over an SMB3 mount
> > tries to go beyond the end of file of the source file.  This fixes
> > xfstests generic/430 and generic/431
> >
> > Amir's patches had added a similar change in the VFS layer, but
> > presumably harmless to have the check in cifs.ko as well to ensure
> > that we don't try to copy beyond end of the source file (otherwise
> > SMB3 servers will return an error on copychunk rather than doing the
> > partial copy (up to end of the source file) that copy_file_range
> > expects).
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
