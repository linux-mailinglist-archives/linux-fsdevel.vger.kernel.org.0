Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B19C497A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 10:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfJBIaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 04:30:23 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35687 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfJBIaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:30:23 -0400
Received: by mail-ot1-f50.google.com with SMTP id z6so14013885otb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2019 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3g7sPB+uxpFa+6VT99oY4N+Xm4FhM1jYprfkGGGvb0c=;
        b=avhHK03hshJU0eaI1hVp361DTlYDXcLy3nuxFtLtOqZKxh0uA7XaHGvb01zrR9Ce0B
         te4LfziSDv0AfflVGeHUpDEd4YrR9r91na1Oj30we/lsznVPzIZ4MpCV3jTcddwvMtAb
         izt33eaWpw3OLKrCruMDNKbX4SZEkeEsKjBjavXDdoLFXzN9e/F6sGSTR4vlftKfgtOF
         OV4E+FU46oqpufVFoV0CQ/4lP4U9oa5s6dd54v+8SrNI2vIwIgdfj5nXda26Pp7Sj+GU
         x2iDa1rljPXzw8m/rf7GCM8YH6w5GWxSMNl4UXASO6CdneR8RIHg+9f0Co4WUcq4RQP4
         yV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3g7sPB+uxpFa+6VT99oY4N+Xm4FhM1jYprfkGGGvb0c=;
        b=ULXVR/6iupWXLo7Fn69px2f/5pXIywFdFb0iVPDZtc9HErYBF9d7FDWcBuT2Zpkn+N
         EenXRVIzm52qf+LD0WvYzjUHuvRioLzPp4jhwk+xKMnQtABDV8/91fJfqqgrVxGtLOCr
         gy1X34+dRxfNW1VW7Upi+d79O9lvjtlCiCBwNeGU0sXlSIc+qSksgkzdYZVp5eCuAF2a
         lUDSl5oGx3PF6t/C2Itz4CmXzsHlYUPSbyDYzn5XR5h0c5J+zWfaoyWV4HR7CX7vq5ys
         yk+3gJHlLukmK6hb34WF19S8LWkLj1RAX0W5nI28ErS9HDoOvfMx9ie5KIYVBLuj7Zm9
         cFcQ==
X-Gm-Message-State: APjAAAWU+16NgaFfgzBj2IMc+DgOAAT8yq+FCqCurXU5Xs78nzUmyUs4
        isCZ5Fqr43+yEBA2h81OGnCbtlC5JhekjkcpvmxXjr0i
X-Google-Smtp-Source: APXvYqwkbgEPqGbDki/KaIiPljLxccrLy06MC+8K2r/1sOPNQTVj8zxGcGchg3pwC/zHVTanlkFB/FkuA/4j/McW2xM=
X-Received: by 2002:a9d:3476:: with SMTP id v109mr1763463otb.179.1570005022089;
 Wed, 02 Oct 2019 01:30:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:17c2:0:0:0:0:0 with HTTP; Wed, 2 Oct 2019 01:30:21 -0700 (PDT)
From:   Daegyu Han <dgswsk@gmail.com>
Date:   Wed, 2 Oct 2019 17:30:21 +0900
Message-ID: <CA+i3KrYpvd4X7uD_GMAp8UZMbR_DhmWvgzw2bHuSQ7iBvpsJQg@mail.gmail.com>
Subject: How can I completely evict(remove) the inode from memory and access
 the disk next time?
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi linux file system experts,

I'm so sorry that I've asked again the general question about Linux
file systems.

For example, if there is a file a.txt in the path /foo/ bar,
what should I do to completely evict(remove) the inode of bar
directory from memory and read the inode via disk access?

A few weeks ago. I asked a question about dentry and Ted told me that
there is a negative dentry on Linux.

I tried to completely evict(remove) the dentry cache using FS API in
include/fs.h and dcache.h, and also evict the inode from memory, but I
failed.

The FS API I used is:
dput() // to drop usage count and remove from dentry cache
iput() // to drop usage count and remove from inode cache.

To be honest, I'm confused about which API to cope with my question.

As far as I know, even though metadata is released from the file
system cache, it is managed as an LRU list.

I also saw some code related to CPU cacheline.
When I look at the superblock structure, there are also inodes, dcache
lists, and LRUs.

How can I completely evict the inode from memory and make disk access
as mentioned above?

Thank you in advance
