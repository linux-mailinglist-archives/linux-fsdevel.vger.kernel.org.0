Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFED145F06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 00:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAVXOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 18:14:05 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:33832 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVXOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:14:05 -0500
Received: by mail-il1-f176.google.com with SMTP id l4so294379ilj.1;
        Wed, 22 Jan 2020 15:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Kq2IP1hIGuKFw/G8CqaH+hWfQgqsWkoIbXt/bd1XL0Q=;
        b=ktVitgYhBUqR8NzwkRgAs3yeevVeyIhhQcQ82fIVplKqd/mb01nWRf2d1nvzz646iZ
         DTLUqFRXvzB9/IytlnDBWkg9/ilZDlg03hXfWSxLoTbu1jKEuGPtkIu+QGb4+8qYNVtX
         m249WvyimAlaKq4S/Luz+llPW1lhVCn5znaijYjYl0hFyDWHMAZRu/QQQ5nJnjFfu+Py
         tRaxDAndT7EFds/wJaviZrMcoAbjgvkWQyszpvwmZAMgPKzR3VtXH+hMaUEJsdZ0nDqn
         NKypOP2+DM5n9eiwujFqiB27LBO6f6r8fhEU+wKa/ZnVC09BAhxQ354NO7XI9eNpOQxn
         0CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Kq2IP1hIGuKFw/G8CqaH+hWfQgqsWkoIbXt/bd1XL0Q=;
        b=Vt2bSuytBK6TNIFdZPOIt/WNCLX64C16mOpwAFF2eGKbswYXVzs89Ey7ElzSfT0ANa
         EAosmwDDhJv4r9V2vBw4YkhOAp/yZZw6LlIGnzAtjTI7NnGFakVNsWrDImxbc8jdvHY3
         UwfsVQeG22HKWFDSbY1bbqZMzwjPo7KloQHuuELV8OKSJhqw1SfWgecMzAsLGtKmLUJy
         3nUp7Zpw3ikVhYRM1endgcN+/lr5ZGEgOWS1Ey09wz2D72YU0p3433Fm59fyofDA3Kiu
         BCPaVaGKtaC2I41Bl/Eho2PMNgsHY+s71bNyFdSSy/5pZeYQNjL+286b5HZqgrcyrqIf
         e2fQ==
X-Gm-Message-State: APjAAAUhRRrb/lZsgTH1jU5bzdHeHIohsH+pHBug48dJfmyzsDtzVsrR
        d7Y1lBcy0nRPPZiZBhYF+g1ecET9lK9zh0+hYmlv3i5iogY=
X-Google-Smtp-Source: APXvYqzLAqRau6zdAqo/jrMCBTejWOPbgKpEV7QlBIuCkdLF1bAb7z5hojjPYoKPzq8i9RZOqIvIo270Em3XX7utEc0=
X-Received: by 2002:a92:9a90:: with SMTP id c16mr10104878ill.3.1579734844056;
 Wed, 22 Jan 2020 15:14:04 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 22 Jan 2020 17:13:53 -0600
Message-ID: <CAH2r5mvYTimXUfJB+p0mvYV3jAR1u5G4F3m+OqA_5jKiLhVE8A@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Enhancing Linux Copy Performance and Function and
 improving backup scenarios
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As discussed last year:

Current Linux copy tools have various problems compared to other
platforms - small I/O sizes (and most don't allow it to be
configured), lack of parallel I/O for multi-file copies, inability to
reduce metadata updates by setting file size first, lack of cross
mount (to the same file system) copy optimizations, limited ability to
handle the wide variety of server side copy (and copy offload)
mechanisms and error handling problems.   And copy tools rely less on
the kernel file system (vs. code in the user space tool) in Linux than
would be expected, in order to determine which optimizations to use.

But some progress has been made since last year's summit, with new
copy tools being released and improvements to some of the kernel file
systems, and also some additional feedback on lwn and on the mailing
lists.  In addition these discussions have prompted additional
feedback on how to improve file backup/restore scenarios (e.g. to
mounts to the cloud from local Linux systems) which require preserving
more timestamps, ACLs and metadata, and preserving them efficiently.

Let's continue our discussions from last year, and see how we can move
forward on improving the performance and function of Linux fs
(including the VFS and user space tools) for various backup, restore
and copy scenarios operations.
