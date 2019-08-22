Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE7D99517
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 15:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfHVN37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 09:29:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfHVN37 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:29:59 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97DCA2D6A0F
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 13:29:58 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id 15so5058788ioo.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 06:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmooXyrrgVYp/wB0l20MxW5kvxwVXqk3cBGQrgxJh/Q=;
        b=TGg2kJAjoO9EDCXvQKNdGKrKpp4xv2fh8ANNNBiX5F6zscp+GlTU1DWnZ438f8WoqR
         VHeKybnGwHAXr5R+4/zXpvKlrOtp/zgQQKDCu2KVXJyFFTSmOd8qUuex2HfGqbAT0fAw
         mJ6YHlANj1zvybOARnoM+Wv/J6aHMaEOoNfFN5fsqbixpXLEskWWIFlE1QLJKxMyCffz
         rikVak4GlnYzzoM//+xN7g5xlVtpD2r16xuF+tmhZV5k9RDqN8Xc1P0OTszBkLpmSIGg
         LPd04CliOMEPEB/Jz0YX6f26Lf8dTo0NqphyQS9p1/BZbL90LWGnDc8avTuA0ajjL0DE
         c0IQ==
X-Gm-Message-State: APjAAAUjfCe9AgZP+Pc+/q1v3DiYK0WARrJhsFxS9VYj+vnscv9Rq7BN
        Hvr4dVuzWOGNxO/6UHwYmP+0H/iLBc8WYckoKz7+rayzV0MtiUR5szBvggDBwXdMJisl7A5Jy6q
        LAaAaHYBrpzKJlReZLQ8p4bTxvDrF7GI3pBAUFcWqEw==
X-Received: by 2002:a5e:a70b:: with SMTP id b11mr5578253iod.286.1566480598039;
        Thu, 22 Aug 2019 06:29:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqziwS7zD3ZJIkwpl7ZP8vWlFY9HmyyseqxJgSBp6xIf/M59TPv4OAPjKUYbBvVKGc2AMd+TVpTNcziO1HH+qrc=
X-Received: by 2002:a5e:a70b:: with SMTP id b11mr5578223iod.286.1566480597772;
 Thu, 22 Aug 2019 06:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <5abd7616-5351-761c-0c14-21d511251006@huawei.com>
 <20190820091650.GE9855@stefanha-x1.localdomain> <CAJfpegs8fSLoUaWKhC1543Hoy9821vq8=nYZy-pw1+95+Yv4gQ@mail.gmail.com>
 <20190821160551.GD9095@stefanha-x1.localdomain> <954b5f8a-4007-f29c-f38e-dd5585879541@huawei.com>
 <CAJfpegtBYLJLWM8GJ1h66PMf2J9o38FG6udcd2hmamEEQddf5w@mail.gmail.com>
 <0e8090c7-0c7c-bcbe-af75-33054d3a3efb@huawei.com> <CAJfpegurYLAApon5Ai6Q33vEy+GPxtOTUwDCCbJ2JAbg4csDSg@mail.gmail.com>
 <a19866be-3693-648e-ee6c-8d302c830834@huawei.com>
In-Reply-To: <a19866be-3693-648e-ee6c-8d302c830834@huawei.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Thu, 22 Aug 2019 15:29:46 +0200
Message-ID: <CAOssrKd7bKts2tCAZaXLJt+BVoQtqWoJV6HfT76-qxg7W4g9PQ@mail.gmail.com>
Subject: Re: [Virtio-fs] [QUESTION] A performance problem for buffer write
 compared with 9p
To:     wangyan <wangyan122@huawei.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000009451d30590b4afb3"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000009451d30590b4afb3
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 22, 2019 at 3:18 PM wangyan <wangyan122@huawei.com> wrote:

> I used these commands:
> virtiofsd cmd:
>         ./virtiofsd -o vhost_user_socket=/tmp/vhostqemu -o source=/mnt/share/
> -o cache=always -o writeback
> mount cmd:
>         mount -t virtio_fs myfs /mnt/virtiofs -o
> rootmode=040000,user_id=0,group_id=0

Good.

I think I got it now, updated patch attached.

Thanks for your patience!

Miklos

--0000000000009451d30590b4afb3
Content-Type: text/x-patch; charset="US-ASCII"; name="virtio-fs-nostrict-v2.patch"
Content-Disposition: attachment; filename="virtio-fs-nostrict-v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jzmq2zcx0>
X-Attachment-Id: f_jzmq2zcx0

LS0tCiBmcy9mdXNlL3ZpcnRpb19mcy5jIHwgICAgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspCgotLS0gYS9mcy9mdXNlL3ZpcnRpb19mcy5jCisrKyBiL2ZzL2Z1c2Uvdmly
dGlvX2ZzLmMKQEAgLTg5MSw2ICs4OTEsMTAgQEAgc3RhdGljIGludCB2aXJ0aW9fZnNfZmlsbF9z
dXBlcihzdHJ1Y3QgcwogCWlmIChlcnIgPCAwKQogCQlnb3RvIGVycl9mcmVlX2luaXRfcmVxOwog
CisJLyogTm8gc3RyaWN0IGFjY291bnRpbmcgbmVlZGVkIGZvciB2aXJ0aW8tZnMgKi8KKwlzYi0+
c19iZGktPmNhcGFiaWxpdGllcyA9IDA7CisJYmRpX3NldF9tYXhfcmF0aW8oc2ItPnNfYmRpLCAx
MDApOworCiAJZmMgPSBmcy0+dnFzW1ZRX1JFUVVFU1RdLmZ1ZC0+ZmM7CiAKIAkvKiBUT0RPIHRh
a2UgZnVzZV9tdXRleCBhcm91bmQgdGhpcyBsb29wPyAqLwo=
--0000000000009451d30590b4afb3--
