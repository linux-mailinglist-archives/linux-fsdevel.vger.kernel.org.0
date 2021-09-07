Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC6402BBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345219AbhIGP0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 11:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345211AbhIGP0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:26:15 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659FC061757
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Sep 2021 08:25:09 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id l24so5758187uai.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfHP2sgThQg8v8lbN+JggZp2tkzNElpWzdFKXLFCG6Q=;
        b=CjL6dPNn7z3OXHGFEWoI6jzNsXPr5UxuLKeWIUNRcv+4BVTpWYG3/Uhuy6WxSQX+5a
         zCAZFfkFMA2rVvsG+osJcjlvLByKHuE4Mf9hlernIpqK8Ptrxcd7l4DCITyB85wt8yUd
         9+Ow4qpzjpH2yODj7NoeC+N3GQd/EqTxTQsaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfHP2sgThQg8v8lbN+JggZp2tkzNElpWzdFKXLFCG6Q=;
        b=tegBxjBCtOfuOuqOe8cSQsDG9Vzs3DPsKudx0DuqTO+Ewz8Yf8nATDIA06WmCiU5lc
         65hyWdOU+4jTajwbRVyF4xDthCpAPV6ZpRJ/6uZyCq8QtX8Dpt8Eupgo4L3sUeYar8Cg
         OUS0g+ifeOC1pSePlEtYj7Xa+Pxg4SfGUMfo5ChR+wOEXltmdhQM/7qK4xDYVVXVAjCv
         1SyiOhztRwPhu8WHkFfsHIEXpCx2iMDqiXBJITRuS8elAO2IX9qKorBxZH+nddue//VZ
         5hIHovzDlzx3+TIPoDDrmmDsLq6aKWNU8F+4AoORzVCdjjXIuTIcKnYlK9cL776Hoj2y
         rKfw==
X-Gm-Message-State: AOAM531biuLeYuNHOfQBoOJPouFjFg0PSu+iWpxNNj7231zPFC+X36jQ
        Uzv0HxtBfh+7RUwg1LnVRgHNXidUMV7FllIMDJdfoYVraLjN4Q==
X-Google-Smtp-Source: ABdhPJyaSPIaBUI16PkzloKRKGzn7kYbkTsVtsV/EG3nkEafmSeiOXKMvyXw3/fFt4HAVmQwz1Au77pTUYJOQXvu7H4=
X-Received: by 2002:a9f:234a:: with SMTP id 68mr505653uae.13.1631028308416;
 Tue, 07 Sep 2021 08:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a4cc9405c95d0e1c@google.com>
In-Reply-To: <000000000000a4cc9405c95d0e1c@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Sep 2021 17:24:56 +0200
Message-ID: <CAJfpegvr1y9VTXb3Gm2F1Y9mZzWYAEYutV8kdhnD2Yyo8FTvcQ@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in fuse_reverse_inval_entry
To:     syzbot <syzbot+9f747458f5990eaa8d43@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000f13b0d05cb695ed9"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000f13b0d05cb695ed9
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

--000000000000f13b0d05cb695ed9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-annotate-lock-in-inval_entry.patch"
Content-Disposition: attachment; 
	filename="fuse-annotate-lock-in-inval_entry.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kta842p30>
X-Attachment-Id: f_kta842p30

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IGZ1c2U6
IGFubm90YXRlIGxvY2sgaW4gZnVzZV9yZXZlcnNlX2ludmFsX2VudHJ5KCkKCkFkZCBtaXNzaW5n
IGlub2RlIGxvY2sgYW5ub3RhdGF0aW9uOyBmb3VuZCBieSBzeXpib3QuCgpSZXBvcnRlZC1ieTog
c3l6Ym90KzlmNzQ3NDU4ZjU5OTBlYWE4ZDQzQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KU2ln
bmVkLW9mZi1ieTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+Ci0tLQogZnMv
ZnVzZS9kaXIuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKLS0tIGEvZnMvZnVzZS9kaXIuYworKysgYi9mcy9mdXNlL2Rpci5jCkBAIC0x
MDcxLDcgKzEwNzEsNyBAQCBpbnQgZnVzZV9yZXZlcnNlX2ludmFsX2VudHJ5KHN0cnVjdCBmdXNl
CiAJaWYgKCFwYXJlbnQpCiAJCXJldHVybiAtRU5PRU5UOwogCi0JaW5vZGVfbG9jayhwYXJlbnQp
OworCWlub2RlX2xvY2tfbmVzdGVkKHBhcmVudCwgSV9NVVRFWF9QQVJFTlQpOwogCWlmICghU19J
U0RJUihwYXJlbnQtPmlfbW9kZSkpCiAJCWdvdG8gdW5sb2NrOwogCg==
--000000000000f13b0d05cb695ed9--
