Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49BA10CC5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 17:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK1QAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 11:00:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59749 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbfK1QAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFSuAdge36j90fnmh0t8BSOJjNPmO3U6ihiE7GdWtqs=;
        b=ddjeI/EBitvtHSWqV5ApZXja2mV0ASWWV3QZ4Pb7AHwec6ZV2XgnbGTrix2vFe8FqZCxI1
        QF7HYbYFjyt+4Bdp73RRw8EYlzqt942hqu6whvdAl/PlxlHSK9V0Gedq8DFwuSOjUDbHkr
        CNPwlwIgDikwY5fu+BTr3zxIAQ8+Ack=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-3q8sdrHtNaWPKUmTnE8NuQ-1; Thu, 28 Nov 2019 10:59:57 -0500
Received: by mail-wr1-f72.google.com with SMTP id h30so463328wrh.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNKbpX5fym9wrjLit+gZRJvW4rINU1u/kj+585xqaFc=;
        b=A1AnVrPcJAK6p0ecFJG8gj8avY+RTzsy828yrrcLeBR6mRpPe+8mlpMtjw47CwjcIX
         nJccx5aUmM4lfOwtlP4iQMXkQfQi8zGveIOVT1v74j0550pjo54MX+iKRhLuhZ458Y5u
         eJLvY0DM/+VliSc2yaF+0JAubeb7yYN9NIxwHEbu+osP4RKZBIuXe0F3uxWyuNOQNjje
         N/TMMf0Zk+b8MwTl7/QQzOQoqOH4JNCwNoXgQ8siprAZ6eXFcr2+pjIUzOnyFdtyFEC+
         fgZORt45cRCHTVCwaGjZ7r4K2c4d8zIbcf3t9AsyWLsVlwKrX/LojI8YbhRaF0dAodSA
         UPcg==
X-Gm-Message-State: APjAAAXbUYO5rX4xc187ItrvTJFZIF5I7Xkjbdaon3VB8IuZjqJa0xzp
        f1+lTTe0OXQgP2I08f+1yy40ORspislGEZA//B9NIX0n2VHN851Usnj8puzRnH27A7mop8sb/s3
        ziJlrBRGzKlAel+0ieseZvQwhjA==
X-Received: by 2002:a1c:98c5:: with SMTP id a188mr10195541wme.133.1574956796447;
        Thu, 28 Nov 2019 07:59:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCtXklvMs6tt6g5DAW+6yaax/wg1SawwnK348LRXf95SC2gR/TR6LVCoKCuP0MuHU6BX0wng==
X-Received: by 2002:a1c:98c5:: with SMTP id a188mr10195524wme.133.1574956796214;
        Thu, 28 Nov 2019 07:59:56 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:55 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/12] vfs: don't parse "posixacl" option
Date:   Thu, 28 Nov 2019 16:59:39 +0100
Message-Id: <20191128155940.17530-12-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 3q8sdrHtNaWPKUmTnE8NuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unlike the others, this is _not_ a standard option accepted by mount(8).

In fact SB_POSIXACL is an internal flag, and accepting MS_POSIXACL on the
mount(2) interface is possibly a bug.

The only filesystem that apparently wants to handle the "posixacl" option
is 9p, but it has special handling of that option besides setting
SB_POSIXACL.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 394a05bc03d5..738f59b6c06a 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -42,7 +42,6 @@ static const struct constant_table common_set_sb_flag[] =
=3D {
 =09{ "dirsync",=09SB_DIRSYNC },
 =09{ "lazytime",=09SB_LAZYTIME },
 =09{ "mand",=09SB_MANDLOCK },
-=09{ "posixacl",=09SB_POSIXACL },
 =09{ "ro",=09=09SB_RDONLY },
 =09{ "sync",=09SB_SYNCHRONOUS },
 };
--=20
2.21.0

