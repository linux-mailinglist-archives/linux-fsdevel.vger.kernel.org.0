Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E0213BADA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgAOI2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:28:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60418 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726220AbgAOI2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579076883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=adl4YTtGwDsGU3mcOyNEDPoRcVEGa1oR2kpCSJ2EC6U=;
        b=Pl3HcE7Hrvu75Zc0j77XI1BUYpRVHzchDfJEiTSx7LgNSEN840opV3qp/BpBaW8oMZbAH6
        IlVIrWgQVKgkVMC2LVae7wtuhIAc/LWsOlD7ze6A3PxlhO3//7Kl9j6iEFe5S9K3KDb719
        ZDG3/GKLT/unCTs+cFUMe2sGGNxu1y8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-LUXfe06_Oj2NThsRC6y0Nw-1; Wed, 15 Jan 2020 03:28:01 -0500
X-MC-Unique: LUXfe06_Oj2NThsRC6y0Nw-1
Received: by mail-qv1-f70.google.com with SMTP id z12so10578032qvk.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 00:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=adl4YTtGwDsGU3mcOyNEDPoRcVEGa1oR2kpCSJ2EC6U=;
        b=B3D0WNZVkIRgAbo0lBGpIw2fa0+5c6MrZBspjhYrPPvZIDa4lF/nDBEhwBclkNbxbJ
         caw++QfT86HJHdUlDfeCYrLLkJMZKh5iiHJZt2SCRYOr0jN/fryoDPXIT45d4Db8+/lN
         8sf/SVndesLAslmEYs4dk4NLXeSqWnFK4OTNJsELkznafHYm9GzoFXj1WLd81wngLSsG
         ZdXDsD0PJGIvtQoYKHwoTwNCsBAh8E4/BeuWv9HLlF1hCdTxMYfTS3kwnu2tXmrm84WA
         3lM9rNKn76bskJKMBOlyw/Mh9bVlytFFXVSw4ivM5YYMJN5Jbi3rpCLgv98EWYPAm7pV
         Jqsw==
X-Gm-Message-State: APjAAAUh9xDjWkbW7hahQ8EVKkEN72Qi2j7A3XQj39j37sN7gdoMhF5X
        Xbtqul0U8zl/Ict5tuNqj0e+cKS1/uvlfa6n8vwXn8NSEDkxtIfJCk7GoYCO20AyWyjbe7OTXtj
        OgxfZSjz9COG40K7x5f5+vRpiTra5FEDQkfywKMBGzg==
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr20837534qvg.197.1579076881139;
        Wed, 15 Jan 2020 00:28:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqynnIvI5Tdl1vtJm+JFA4/fXl3/u2hfPlTaOuV5Y0yec93AWwALsaiQEu+kRVo1l9SynVVGsOGBz9NPoVfX9pQ=
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr20837524qvg.197.1579076880853;
 Wed, 15 Jan 2020 00:28:00 -0800 (PST)
MIME-Version: 1.0
From:   Ondrej Holy <oholy@redhat.com>
Date:   Wed, 15 Jan 2020 09:27:24 +0100
Message-ID: <CA+wuGHCr2zJKFkHyRECOLAXsijLAcQgHVoACcNbvLbXnqarOtg@mail.gmail.com>
Subject: Weird fuse_operations.read calls with Linux 5.4
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I have been directed here from https://github.com/libfuse/libfuse/issues/488.

My issue is that with Linux Kernel 5.4, one read kernel call (e.g.
made by cat tool) triggers two fuse_operations.read executions and in
both cases with 0 offset even though that first read successfully
returned some bytes.

For gvfs, it leads to redundant I/O operations, or to "Operation not
supported" errors if seeking is not supported. This doesn't happen
with Linux 5.3. Any idea what is wrong here?

$ strace cat /run/user/1000/gvfs/ftp\:host\=server\,user\=user/foo
...
openat(AT_FDCWD, "/run/user/1000/gvfs/ftp:host=server,user=user/foo",
O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=20, ...}) = 0
fadvise64(3, 0, 0, POSIX_FADV_SEQUENTIAL) = 0
mmap(NULL, 139264, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x7fbc42b92000
read(3, 0x7fbc42b93000, 131072)         = -1 EOPNOTSUPP (Operation not
supported)
...

$ /usr/libexec/gvfsd-fuse /run/user/1000/gvfs -d
...
open flags: 0x8000 /ftp:host=server,user=user/foo
   open[139679517117488] flags: 0x8000 /ftp:host=server,user=user/foo
   unique: 8, success, outsize: 32
unique: 10, opcode: READ (15), nodeid: 3, insize: 80, pid: 5053
read[139679517117488] 4096 bytes from 0 flags: 0x8000
   read[139679517117488] 20 bytes from 0
   unique: 10, success, outsize: 36
unique: 12, opcode: READ (15), nodeid: 3, insize: 80, pid: 5053
read[139679517117488] 4096 bytes from 0 flags: 0x8000
   unique: 12, error: -95 (Operation not supported), outsize: 16
...

See for other information: https://gitlab.gnome.org/GNOME/gvfs/issues/441

Regards

Ondrej
--
Ondrej Holy
Software Engineer, Core Desktop Development
Red Hat Czech s.r.o

