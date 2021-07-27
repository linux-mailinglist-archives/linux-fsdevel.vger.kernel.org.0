Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9A03D79F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 17:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhG0Ph5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 11:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232512AbhG0Phu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627400269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vR2+7tmtikD9aIM6qjbjOrZOpZBl/Ki+iH8B5KQL91A=;
        b=VaC6KzdQDapk5gJvtTdBypIZgiL+Ob08wQ0h+erEKgREaL7LFq0G4runqdIqmpS0TFmXDA
        gkKj8aj5MFa4JwlBtqOqtxYAVty2xZBKIhbNnjF75AClTFWckVkatjmiGOzJqtVM8pFwx/
        S+Ubj4ytZdXE+g0HUypt1aqShvlNPLk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-Y6C3HVPUNtSO6N658x0RRA-1; Tue, 27 Jul 2021 11:37:48 -0400
X-MC-Unique: Y6C3HVPUNtSO6N658x0RRA-1
Received: by mail-qt1-f199.google.com with SMTP id e16-20020ac867100000b0290257b7db4a28so6564710qtp.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jul 2021 08:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vR2+7tmtikD9aIM6qjbjOrZOpZBl/Ki+iH8B5KQL91A=;
        b=appiaohglsHLqJpxwW4H7OdH+1oF3zwVhtPdHvTmBtm2TOPNjHk6TSvR+kF6p3CG9h
         PmSX5PlswazLTY59NH2OwhMkLrdvfHTEaNm8rjhkAJFZ6ZlpbDfkntGoC2nIx2BSHWOC
         jGdWi1iZ9SZE6fxPz4uELhn9MIC5Obxjl5NMyekMlmT9pGnFpHY0WNnrARNIXxr7HYos
         CRUjHdMvMnXjWH9YAR4lsT6Y50d8r8VdkpZZc6JtbzifcWccQB8Fd+j2jwUoC8Ftpjc9
         FOnhKe+EUeKGViTcppovrQ2K2sLUQwGHM86EvACOzBU2SMFJa/CsGjZWNceJ48ZN69aW
         dRaw==
X-Gm-Message-State: AOAM531LMnDr7AkzrI05awpqIk54dHKjPJ7ReZMNFquLEhSGrl5J3V1l
        wSz5YkIx+IgvITarGaNv+5WHHkni/ti05xn9RV8rn57O4JSYYkg0CSrIUz5cs8NhpyZh8i1P890
        qeC5zcwpwMlkYu85NQsncZhAktRnqYS3/ZvRYEt1DkA==
X-Received: by 2002:a05:6214:2ca:: with SMTP id g10mr23499938qvu.44.1627400267796;
        Tue, 27 Jul 2021 08:37:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4wb9VdRM/n+1TXNm1vLueStF5mK2PArTHU3m5lyvUWaaXl4LQ6PF/Pl40ZIhO0efwe9ZwqeHRGm7QMoLXa6U=
X-Received: by 2002:a05:6214:2ca:: with SMTP id g10mr23499920qvu.44.1627400267624;
 Tue, 27 Jul 2021 08:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c3366805c7e33a92@google.com> <20210725012825.1790-1-hdanton@sina.com>
In-Reply-To: <20210725012825.1790-1-hdanton@sina.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue, 27 Jul 2021 17:37:36 +0200
Message-ID: <CAOssrKdqbOr0jeE1pYqkWnFysVbdi+H7sfoc3c4CaiqBUqQz_g@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in pipe_lock (5)
To:     Hillf Danton <hdanton@sina.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        syzbot <syzbot+579885d1a9a833336209@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        syzkaller-bugs@googlegroups.com, viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/mixed; boundary="000000000000dc534905c81ca6a7"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000dc534905c81ca6a7
Content-Type: text/plain; charset="UTF-8"

On Sun, Jul 25, 2021 at 3:31 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Sat, 24 Jul 2021 12:07:20 -0700
> >syzbot found the following issue on:
> >
> >HEAD commit:    8cae8cd89f05 seq_file: disallow extremely large seq buffer..
> >git tree:       upstream
> >console output: https://syzkaller.appspot.com/x/log.txt?x=1083e8cc300000
> >kernel config:  https://syzkaller.appspot.com/x/.config?x=7273c75708b55890
> >dashboard link: https://syzkaller.appspot.com/bug?extid=579885d1a9a833336209
> >syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163905f2300000
> >C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165bd0ea300000
> >
> >The issue was bisected to:
> >
> >commit 82a763e61e2b601309d696d4fa514c77d64ee1be
> >Author: Miklos Szeredi <mszeredi@redhat.com>
> >Date:   Mon Dec 14 14:26:14 2020 +0000
> >
> >    ovl: simplify file splice
>
>
> If this commit is innocent then is it false positive lockdep warning again,
> given another report [1]?

Appears to be legit.

Attached partial revert + sync with ovl_write_iter() should fix it
(fingers crossed).

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

Thanks,
Miklos

--000000000000dc534905c81ca6a7
Content-Type: text/x-patch; charset="US-ASCII"; name="ovl-fix-deadlock-in-splice-write.patch"
Content-Disposition: attachment; 
	filename="ovl-fix-deadlock-in-splice-write.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_krm81ag60>
X-Attachment-Id: f_krm81ag60

ZGlmZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9maWxlLmMgYi9mcy9vdmVybGF5ZnMvZmlsZS5jCmlu
ZGV4IDRkNTNkM2I3ZTVmZS4uZDA4MWZhYTU1ZTgzIDEwMDY0NAotLS0gYS9mcy9vdmVybGF5ZnMv
ZmlsZS5jCisrKyBiL2ZzL292ZXJsYXlmcy9maWxlLmMKQEAgLTM5Miw2ICszOTIsNTEgQEAgc3Rh
dGljIHNzaXplX3Qgb3ZsX3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92
X2l0ZXIgKml0ZXIpCiAJcmV0dXJuIHJldDsKIH0KIAorLyoKKyAqIENhbGxpbmcgaXRlcl9maWxl
X3NwbGljZV93cml0ZSgpIGRpcmVjdGx5IGZyb20gb3ZlcmxheSdzIGZfb3AgbWF5IGRlYWRsb2Nr
CisgKiBkdWUgdG8gbG9jayBvcmRlciBpbnZlcnNpb24gYmV0d2VlbiBwaXBlLT5tdXRleCBpbiBp
dGVyX2ZpbGVfc3BsaWNlX3dyaXRlKCkKKyAqIGFuZCBmaWxlX3N0YXJ0X3dyaXRlKHJlYWwuZmls
ZSkgaW4gb3ZsX3dyaXRlX2l0ZXIoKS4KKyAqCisgKiBTbyBkbyBldmVyeXRoaW5nIG92bF93cml0
ZV9pdGVyKCkgZG9lcyBhbmQgY2FsbCBpdGVyX2ZpbGVfc3BsaWNlX3dyaXRlKCkgb24KKyAqIHRo
ZSByZWFsIGZpbGUuCisgKi8KK3N0YXRpYyBzc2l6ZV90IG92bF9zcGxpY2Vfd3JpdGUoc3RydWN0
IHBpcGVfaW5vZGVfaW5mbyAqcGlwZSwgc3RydWN0IGZpbGUgKm91dCwKKwkJCQlsb2ZmX3QgKnBw
b3MsIHNpemVfdCBsZW4sIHVuc2lnbmVkIGludCBmbGFncykKK3sKKwlzdHJ1Y3QgZmQgcmVhbDsK
Kwljb25zdCBzdHJ1Y3QgY3JlZCAqb2xkX2NyZWQ7CisJc3RydWN0IGlub2RlICppbm9kZSA9IGZp
bGVfaW5vZGUob3V0KTsKKwlzdHJ1Y3QgaW5vZGUgKnJlYWxpbm9kZSA9IG92bF9pbm9kZV9yZWFs
KGlub2RlKTsKKwlzc2l6ZV90IHJldDsKKworCWlub2RlX2xvY2soaW5vZGUpOworCS8qIFVwZGF0
ZSBtb2RlICovCisJb3ZsX2NvcHlhdHRyKHJlYWxpbm9kZSwgaW5vZGUpOworCXJldCA9IGZpbGVf
cmVtb3ZlX3ByaXZzKG91dCk7CisJaWYgKHJldCkKKwkJZ290byBvdXRfdW5sb2NrOworCisJcmV0
ID0gb3ZsX3JlYWxfZmRnZXQob3V0LCAmcmVhbCk7CisJaWYgKHJldCkKKwkJZ290byBvdXRfdW5s
b2NrOworCisJb2xkX2NyZWQgPSBvdmxfb3ZlcnJpZGVfY3JlZHMoaW5vZGUtPmlfc2IpOworCWZp
bGVfc3RhcnRfd3JpdGUocmVhbC5maWxlKTsKKworCXJldCA9IGl0ZXJfZmlsZV9zcGxpY2Vfd3Jp
dGUocGlwZSwgcmVhbC5maWxlLCBwcG9zLCBsZW4sIGZsYWdzKTsKKworCWZpbGVfZW5kX3dyaXRl
KHJlYWwuZmlsZSk7CisJLyogVXBkYXRlIHNpemUgKi8KKwlvdmxfY29weWF0dHIocmVhbGlub2Rl
LCBpbm9kZSk7CisJcmV2ZXJ0X2NyZWRzKG9sZF9jcmVkKTsKKwlmZHB1dChyZWFsKTsKKworb3V0
X3VubG9jazoKKwlpbm9kZV91bmxvY2soaW5vZGUpOworCisJcmV0dXJuIHJldDsKK30KKwogc3Rh
dGljIGludCBvdmxfZnN5bmMoc3RydWN0IGZpbGUgKmZpbGUsIGxvZmZfdCBzdGFydCwgbG9mZl90
IGVuZCwgaW50IGRhdGFzeW5jKQogewogCXN0cnVjdCBmZCByZWFsOwpAQCAtNjAzLDcgKzY0OCw3
IEBAIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgb3ZsX2ZpbGVfb3BlcmF0aW9ucyA9IHsK
IAkuZmFkdmlzZQk9IG92bF9mYWR2aXNlLAogCS5mbHVzaAkJPSBvdmxfZmx1c2gsCiAJLnNwbGlj
ZV9yZWFkICAgID0gZ2VuZXJpY19maWxlX3NwbGljZV9yZWFkLAotCS5zcGxpY2Vfd3JpdGUgICA9
IGl0ZXJfZmlsZV9zcGxpY2Vfd3JpdGUsCisJLnNwbGljZV93cml0ZSAgID0gb3ZsX3NwbGljZV93
cml0ZSwKIAogCS5jb3B5X2ZpbGVfcmFuZ2UJPSBvdmxfY29weV9maWxlX3JhbmdlLAogCS5yZW1h
cF9maWxlX3JhbmdlCT0gb3ZsX3JlbWFwX2ZpbGVfcmFuZ2UsCg==
--000000000000dc534905c81ca6a7--

