Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E20512B96A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfE0R1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 13:27:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33496 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfE0R1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 13:27:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so17533707wrx.0;
        Mon, 27 May 2019 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9WX0VFYO4FVs44DMQ1hkSFUp4e1UxuztItybOtfTqFU=;
        b=bMFyDjnJWfw3h9h2ZwPS9hOy1AGomYHeXJCK6ClXR89C0wNpY9a/9Wz5NkiPgSSdeq
         pGwfYJN2uAykqUFZQczPG550z+bac7GaL6d/tDBnk2/L79gM/05lQq1EOp7+XKfGvrtj
         Ec9mA9u6IM+ZZX0VApXrZAzp2ufvxPIbgv4DfHir/N3qcBN+BaFjA4Za0YwZUqjEsvYw
         RsbRzJpc4Xb6CHIVWkPRwmGDMuSDdkkimi0c07OjdHheQbHhEMuC2ghyHkimgeiss2BT
         vbFLIDmjh25v4vZrQAst4l4rYKub7ATLhxPB7P/fLMxTitj1i8VwXDIRyp3DOwe7kmDz
         lcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9WX0VFYO4FVs44DMQ1hkSFUp4e1UxuztItybOtfTqFU=;
        b=AnejTpGUMYFPV7zRSJKp3GHCaJ4+61MEOA6LXMaIBN550piLi+/OKnNF7+d5Oi8IFD
         bUOJMQew5AcWDgQOekI5XeGQv/J5h9Yl2tD+Mh7qHqj3ypMp9VFdI5/S7ZP3drGm63vy
         laQiPobS6XLbM7aY+wUBUleU55hrRZc7vC3kf2BjAFsJPBLu3MclyXdTTFDLDZWjUfGy
         yngQ8BfBNHGZcqo+vgCa8jOFDRYmlthPgh0HsEhsgNUR0ltHifcmsFb6ag3TRiqIJsLP
         PCJQjmzvUM4OitH8OXJS0rBAfqvqaxfmOvw1kBP3Zu1VpCkFqTXUo/b5a7SKRXzjljv3
         1pxQ==
X-Gm-Message-State: APjAAAVem4OsW0jZiT/jgMBfEgzi/K2t4Kp5mhBL23wT0JTqkL1UnciO
        U+XG/tmzsnaOK9TkhEbpinc=
X-Google-Smtp-Source: APXvYqzQM7w/ysae6EMfiq7n42CFJmrcBJPXGbTpco9z9Lrr2GCtadH2djq7ALmpAvtHtPns0pJRDA==
X-Received: by 2002:a5d:488a:: with SMTP id g10mr11069095wrq.344.1558978024064;
        Mon, 27 May 2019 10:27:04 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id o14sm855129wrp.77.2019.05.27.10.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 10:27:02 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
Date:   Mon, 27 May 2019 20:26:55 +0300
Message-Id: <20190527172655.9287-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

New link flags to request "atomic" link.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Guys,

Following our discussions on LSF/MM and beyond [1][2], here is
an RFC documentation patch.

Ted, I know we discussed limiting the API for linking an O_TMPFILE
to avert the hardlinks issue, but I decided it would be better to
document the hardlinks non-guaranty instead. This will allow me to
replicate the same semantics and documentation to renameat(2).
Let me know how that works out for you.

I also decided to try out two separate flags for data and metadata.
I do not find any of those flags very useful without the other, but
documenting them seprately was easier, because of the fsync/fdatasync
reference.  In the end, we are trying to solve a social engineering
problem, so this is the least confusing way I could think of to describe
the new API.

First implementation of AT_ATOMIC_METADATA is expected to be
noop for xfs/ext4 and probably fsync for btrfs.

First implementation of AT_ATOMIC_DATA is expected to be
filemap_write_and_wait() for xfs/ext4 and probably fdatasync for btrfs.

Thoughts?

Amir.

[1] https://lwn.net/Articles/789038/
[2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com/

 man2/link.2 | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/man2/link.2 b/man2/link.2
index 649ba00c7..15c24703e 100644
--- a/man2/link.2
+++ b/man2/link.2
@@ -184,6 +184,57 @@ See
 .BR openat (2)
 for an explanation of the need for
 .BR linkat ().
+.TP
+.BR AT_ATOMIC_METADATA " (since Linux 5.x)"
+By default, a link operation followed by a system crash, may result in the
+new file name being linked with old inode metadata, such as out dated time
+stamps or missing extended attributes.
+One way to prevent this is to call
+.BR fsync (2)
+before linking the inode, but that involves flushing of volatile disk caches.
+
+A filesystem that accepts this flag will guaranty, that old inode metadata
+will not be exposed in the new linked name.
+Some filesystems may internally perform
+.BR fsync (2)
+before linking the inode to provide this guaranty,
+but often, filesystems will have a more efficient method to provide this
+guaranty without flushing volatile disk caches.
+
+A filesystem that accepts this flag does
+.BR NOT
+guaranty that the new file name will exist after a system crash, nor that the
+current inode metadata is persisted to disk.
+Specifically, if a file has hardlinks, the existance of the linked name after
+a system crash does
+.BR NOT
+guaranty that any of the other file names exist, nor that the last observed
+value of
+.I st_nlink
+(see
+.BR stat (2))
+has persisted.
+.TP
+.BR AT_ATOMIC_DATA " (since Linux 5.x)"
+By default, a link operation followed by a system crash, may result in the
+new file name being linked with old data or missing data.
+One way to prevent this is to call
+.BR fdatasync (2)
+before linking the inode, but that involves flushing of volatile disk caches.
+
+A filesystem that accepts this flag will guaranty, that old data
+will not be exposed in the new linked name.
+Some filesystems may internally perform
+.BR fsync (2)
+before linking the inode to provide this guaranty,
+but often, filesystems will have a more efficient method to provide this
+guaranty without flushing volatile disk caches.
+
+A filesystem that accepts this flag does
+.BR NOT
+guaranty that the new file name will exist after a system crash, nor that the
+current inode data is persisted to disk.
+.TP
 .SH RETURN VALUE
 On success, zero is returned.
 On error, \-1 is returned, and
-- 
2.17.1

