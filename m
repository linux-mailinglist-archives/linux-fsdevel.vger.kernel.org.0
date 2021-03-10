Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352CA333CA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 13:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhCJMb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 07:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCJMbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:31:18 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCBBC061760;
        Wed, 10 Mar 2021 04:31:18 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 133so17648198ybd.5;
        Wed, 10 Mar 2021 04:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=atKgvCAVpItHVZX4pm9LPMJMeABJeY6Z3gkRYABn5yM=;
        b=CqUqoL9kkvx+9GPDQrx/onWS2YqBsmUkD9RdH3kHKTKq0Cer4EZT4m88Jw1x4Fr3ay
         TiaLyhLOVS3KIjiESjXT/yUrAY3W1sZdEm6TSmA+7EtxpUAPl9UGLAHN1LPhHptz8M4W
         awatnKWJUohL/31zVJXD5w/KHKFHyP/tXqk0Ma2sIXDK6kPy8Zt1D+Va9Mfmvz7UOItG
         5/DBwezK/etsdPHs3GV7GnvF0RLpA9aHGTPlINFPjl6Ceem8bSrdhpjAxCNFrmKNSnM1
         3zAQJZQbW2rR8gGM7xa5X45SmKRn206FsjxUb9Z4X7woqN6A1P+KAmARKYNbS/6aUl9Z
         5FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=atKgvCAVpItHVZX4pm9LPMJMeABJeY6Z3gkRYABn5yM=;
        b=SQbrl3l/NtPbEHU1rGZJPfLlGyJTc8GtuGvk4lIEj61QOvNL60rfTOFnoumjQ4GIu3
         KbsVR0YZPl12N8Wqu52Dmw4FfyS8yerMyDxzDU4zA/x/uSyLu6qpVJhTyWDqkrhiwIEU
         AwI3NxKsumdClXsENMLWCQL8OMvRb6Mh7pC4Qis9XhtHkZ1pgaD/nGdgYiFNdjrGBjAN
         E5nAE5eBI361uUe608tNyItHhQaBDO+p7/O4Y88/P2c8D6SQ1sDlP1CVVY41/owzCYpR
         034JapJRo9eUiQ01bzxIuS4kzh3WAnaaoYbAHWUKcVL8chmp2dfagQhgS9IRbHIgDNR6
         QcVg==
X-Gm-Message-State: AOAM532JBhF3IFVB7X3me15KomSLtdLHGRRea1cA0PDtYPiOzysOedxg
        9I42aJVQfdG+6SQ5sIX971vE7mbXUxXCyz28YUk=
X-Google-Smtp-Source: ABdhPJx2QY4l9cQe75nptZ7Pf1Zho+J5rcKWrpKzrd9BmVRKh3Mvj6bvtkk6JVBRVJMnA8nldnylsisoMg5a0XbleWs=
X-Received: by 2002:a05:6902:1001:: with SMTP id w1mr3859288ybt.176.1615379477739;
 Wed, 10 Mar 2021 04:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 10 Mar 2021 07:30:41 -0500
Message-ID: <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 25, 2021 at 7:23 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrot=
e:
>
> This patchset is attempt to add CoW support for fsdax, and take XFS,
> which has both reflink and fsdax feature, as an example.
>
> Changes from V1:
>  - Factor some helper functions to simplify dax fault code
>  - Introduce iomap_apply2() for dax_dedupe_file_range_compare()
>  - Fix mistakes and other problems
>  - Rebased on v5.11
>
> One of the key mechanism need to be implemented in fsdax is CoW.  Copy
> the data from srcmap before we actually write data to the destance
> iomap.  And we just copy range in which data won't be changed.
>
> Another mechanism is range comparison.  In page cache case, readpage()
> is used to load data on disk to page cache in order to be able to
> compare data.  In fsdax case, readpage() does not work.  So, we need
> another compare data with direct access support.
>
> With the two mechanism implemented in fsdax, we are able to make reflink
> and fsdax work together in XFS.
>
>
> Some of the patches are picked up from Goldwyn's patchset.  I made some
> changes to adapt to this patchset.
>
> (Rebased on v5.11)

Forgive my ignorance, but is there a reason why this isn't wired up to
Btrfs at the same time? It seems weird to me that adding a feature
like DAX to work with CoW filesystems is not being wired into *the*
CoW filesystem in the Linux kernel that fully takes advantage of
copy-on-write. I'm aware that XFS supports reflinks and does some
datacow stuff, but I don't know if I would consider XFS integration
sufficient for integrating this feature now, especially if it's
possible that the design might not work with Btrfs (I hadn't seen any
feedback from Btrfs developers, though given how much email there is
here, it's entirely possible that I missed it).


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
