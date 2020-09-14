Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AEF2686E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgINIME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgINIL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:11:56 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A2CC061788
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 01:11:41 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y194so9097371vsc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 01:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mujLzZxv6K8HJkadQTf4aGq5PnjtCVNSEWzC7w4RVvg=;
        b=JqW4LyvHk8vYRiMppGec2ngfRyT7xqssvylEyUdxa2vwrxknCV8GAOXif0QW5wSOvi
         6wdE5QVEKzSSpXfN7gfFyxhCFnMs+Dri/5cMlTV6KsjPHxW6WsavWNCrP1eHkZtIqAbx
         Y7PULZjT1wMnmbkU5CgKvPu5mBAPYQQO17GV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mujLzZxv6K8HJkadQTf4aGq5PnjtCVNSEWzC7w4RVvg=;
        b=Ebs9NgrN26OAgQgnZQUxAx8XXCTTX9v0sVi4IaBMotZgQ7QEn4S6YDg+XAwHauKjzV
         rTt7whjGoEkVWmaR43pCtBVPKM0lel16M5WA0oMm4RAXrJyU8KT1rfSAzAOqpwImD0+6
         grW3fjgJrnVG3q1GeuoMMu0MAHIbBGdHb9VYlCBNm0Kx7DAKfU+vzG/vbYyh/j/rRHkG
         51K6A4JY1pQIYZoZtVRquYNxdvG5u8GQyO4TW7lCSH4eYh7ACTJCB8IL+5MSxj4iA0IC
         vSPq1mYSSw1uuQ5rRU1tG2qHyGD6Nh7u8cA3N8v38iSOS9uop22M7x/rg19xucDPdn5g
         lYsg==
X-Gm-Message-State: AOAM531CfDNVRd63svrxkgU29/MChevlUraC/lz4lGl+PKcuh1grJIEG
        iFMrtQkj/51SV++dqVyZbAt2mDqygQFWHwA4GdoO1gOi8xo=
X-Google-Smtp-Source: ABdhPJy1YtbE3/hCCXOC0z3h9dsC3kGNrIO2Bn2dMRp4t4E6lDhvtYhT+kPMbpICEXp+FerOXyl1gkMhAeKWvgnsOkI=
X-Received: by 2002:a67:d514:: with SMTP id l20mr6813723vsj.66.1600071100703;
 Mon, 14 Sep 2020 01:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <1599553026-11745-1-git-send-email-pragalla@qti.qualcomm.com>
 <CAJfpegunet-5BOG74seeL3Gr=xCSStFznphDnuYPWEisbenPog@mail.gmail.com> <0101017478aef256-c8471520-26b1-4b87-a3b8-8266627b704f-000000@us-west-2.amazonses.com>
In-Reply-To: <0101017478aef256-c8471520-26b1-4b87-a3b8-8266627b704f-000000@us-west-2.amazonses.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 14 Sep 2020 10:11:29 +0200
Message-ID: <CAJfpegtpLoskZDWwZpsEi=L_5jrvr7=xFG9GZJd8dTdJr647ww@mail.gmail.com>
Subject: Re: [PATCH V4] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero
 ref count page
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     Pradeep P V K <pragalla@qti.qualcomm.com>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        sayalil@codeaurora.org
Content-Type: multipart/mixed; boundary="00000000000092d03f05af41959a"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000092d03f05af41959a
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 10, 2020 at 5:42 PM <ppvk@codeaurora.org> wrote:
>
> On 2020-09-08 16:55, Miklos Szeredi wrote:
> > On Tue, Sep 8, 2020 at 10:17 AM Pradeep P V K
> > <pragalla@qti.qualcomm.com> wrote:
> >>
> >> From: Pradeep P V K <ppvk@codeaurora.org>
> >>
> >> There is a potential race between fuse_abort_conn() and
> >> fuse_copy_page() as shown below, due to which VM_BUG_ON_PAGE
> >> crash is observed for accessing a free page.
> >>
> >> context#1:                      context#2:
> >> fuse_dev_do_read()              fuse_abort_conn()
> >> ->fuse_copy_args()               ->end_requests()
> >
> > This shouldn't happen due to FR_LOCKED logic.   Are you seeing this on
> > an upstream kernel?  Which version?
> >
> > Thanks,
> > Miklos
>
> This is happen just after unlock_request() in fuse_ref_page(). In
> unlock_request(), it will clear the FR_LOCKED bit.
> As there is no protection between context#1 & context#2 during
> unlock_request(), there are chances that it could happen.

Ah, indeed, I missed that one.

Similar issue in fuse_try_move_page(), which dereferences oldpage
after unlock_request().

Fix for both is to grab a reference to the page from ap->pages[] array
*before* calling unlock_request().

Attached untested patch.   Could you please verify that it fixes the bug?

Thanks,
Miklos

--00000000000092d03f05af41959a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-fix-page-dereference-after-free.patch"
Content-Disposition: attachment; 
	filename="fuse-fix-page-dereference-after-free.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kf28zkvz0>
X-Attachment-Id: f_kf28zkvz0

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IGZ1c2U6
IGZpeCBwYWdlIGRlcmVmZXJlbmNlIGFmdGVyIGZyZWUKCkFmdGVyIHVubG9ja19yZXF1ZXN0KCkg
cGFnZXMgZnJvbSB0aGUgYXAtPnBhZ2VzW10gYXJyYXkgbWF5IGJlIHB1dCBhbmQgY2FuCmJlIGZy
ZWVkLgoKUHJldmVudCB1c2UgYWZ0ZXIgZnJlZSBieSBncmFiYmluZyBhIHJlZmVyZW5jZSB0byB0
aGUgcGFnZSBiZWZvcmUgY2FsbGluZwp1bmxvY2tfcmVxdWVzdCgpLgoKVGhpcyB3YXMgb3JpZ2lu
YWxseSByZXBvcnRlZCBieSBrZXJuZWwgdGVzdCByb2JvdCBhbmQgdGhlIG9yaWdpbmFsIHBhdGNo
CndhcyBjcmVhdGVkIGJ5IFByYWRlZXAgUCBWIEsuCgpSZXBvcnRlZC1ieTogUHJhZGVlcCBQIFYg
SyA8cHB2a0Bjb2RlYXVyb3JhLm9yZz4KU2lnbmVkLW9mZi1ieTogTWlrbG9zIFN6ZXJlZGkgPG1z
emVyZWRpQHJlZGhhdC5jb20+Ci0tLQogZnMvZnVzZS9kZXYuYyB8ICAgMjggKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQoKLS0tIGEvZnMvZnVzZS9kZXYuYworKysgYi9mcy9mdXNlL2Rldi5jCkBAIC03
ODUsMTUgKzc4NSwxNiBAQCBzdGF0aWMgaW50IGZ1c2VfdHJ5X21vdmVfcGFnZShzdHJ1Y3QgZnVz
CiAJc3RydWN0IHBhZ2UgKm5ld3BhZ2U7CiAJc3RydWN0IHBpcGVfYnVmZmVyICpidWYgPSBjcy0+
cGlwZWJ1ZnM7CiAKKwlnZXRfcGFnZShvbGRwYWdlKTsKIAllcnIgPSB1bmxvY2tfcmVxdWVzdChj
cy0+cmVxKTsKIAlpZiAoZXJyKQotCQlyZXR1cm4gZXJyOworCQlnb3RvIG91dF9wdXRfb2xkOwog
CiAJZnVzZV9jb3B5X2ZpbmlzaChjcyk7CiAKIAllcnIgPSBwaXBlX2J1Zl9jb25maXJtKGNzLT5w
aXBlLCBidWYpOwogCWlmIChlcnIpCi0JCXJldHVybiBlcnI7CisJCWdvdG8gb3V0X3B1dF9vbGQ7
CiAKIAlCVUdfT04oIWNzLT5ucl9zZWdzKTsKIAljcy0+Y3VycmJ1ZiA9IGJ1ZjsKQEAgLTgzMyw3
ICs4MzQsNyBAQCBzdGF0aWMgaW50IGZ1c2VfdHJ5X21vdmVfcGFnZShzdHJ1Y3QgZnVzCiAJZXJy
ID0gcmVwbGFjZV9wYWdlX2NhY2hlX3BhZ2Uob2xkcGFnZSwgbmV3cGFnZSwgR0ZQX0tFUk5FTCk7
CiAJaWYgKGVycikgewogCQl1bmxvY2tfcGFnZShuZXdwYWdlKTsKLQkJcmV0dXJuIGVycjsKKwkJ
Z290byBvdXRfcHV0X29sZDsKIAl9CiAKIAlnZXRfcGFnZShuZXdwYWdlKTsKQEAgLTg1MiwxNCAr
ODUzLDE5IEBAIHN0YXRpYyBpbnQgZnVzZV90cnlfbW92ZV9wYWdlKHN0cnVjdCBmdXMKIAlpZiAo
ZXJyKSB7CiAJCXVubG9ja19wYWdlKG5ld3BhZ2UpOwogCQlwdXRfcGFnZShuZXdwYWdlKTsKLQkJ
cmV0dXJuIGVycjsKKwkJZ290byBvdXRfcHV0X29sZDsKIAl9CiAKIAl1bmxvY2tfcGFnZShvbGRw
YWdlKTsKKwkvKiBEcm9wIHJlZiBmb3IgYXAtPnBhZ2VzW10gYXJyYXkgKi8KIAlwdXRfcGFnZShv
bGRwYWdlKTsKIAljcy0+bGVuID0gMDsKIAotCXJldHVybiAwOworCWVyciA9IDA7CitvdXRfcHV0
X29sZDoKKwkvKiBEcm9wIHJlZiBvYnRhaW5lZCBpbiB0aGlzIGZ1bmN0aW9uICovCisJcHV0X3Bh
Z2Uob2xkcGFnZSk7CisJcmV0dXJuIGVycjsKIAogb3V0X2ZhbGxiYWNrX3VubG9jazoKIAl1bmxv
Y2tfcGFnZShuZXdwYWdlKTsKQEAgLTg2OCwxMCArODc0LDEwIEBAIHN0YXRpYyBpbnQgZnVzZV90
cnlfbW92ZV9wYWdlKHN0cnVjdCBmdXMKIAljcy0+b2Zmc2V0ID0gYnVmLT5vZmZzZXQ7CiAKIAll
cnIgPSBsb2NrX3JlcXVlc3QoY3MtPnJlcSk7Ci0JaWYgKGVycikKLQkJcmV0dXJuIGVycjsKKwlp
ZiAoIWVycikKKwkJZXJyID0gMTsKIAotCXJldHVybiAxOworCWdvdG8gb3V0X3B1dF9vbGQ7CiB9
CiAKIHN0YXRpYyBpbnQgZnVzZV9yZWZfcGFnZShzdHJ1Y3QgZnVzZV9jb3B5X3N0YXRlICpjcywg
c3RydWN0IHBhZ2UgKnBhZ2UsCkBAIC04ODMsMTQgKzg4OSwxNiBAQCBzdGF0aWMgaW50IGZ1c2Vf
cmVmX3BhZ2Uoc3RydWN0IGZ1c2VfY29wCiAJaWYgKGNzLT5ucl9zZWdzID49IGNzLT5waXBlLT5t
YXhfdXNhZ2UpCiAJCXJldHVybiAtRUlPOwogCisJZ2V0X3BhZ2UocGFnZSk7CiAJZXJyID0gdW5s
b2NrX3JlcXVlc3QoY3MtPnJlcSk7Ci0JaWYgKGVycikKKwlpZiAoZXJyKSB7CisJCXB1dF9wYWdl
KHBhZ2UpOwogCQlyZXR1cm4gZXJyOworCX0KIAogCWZ1c2VfY29weV9maW5pc2goY3MpOwogCiAJ
YnVmID0gY3MtPnBpcGVidWZzOwotCWdldF9wYWdlKHBhZ2UpOwogCWJ1Zi0+cGFnZSA9IHBhZ2U7
CiAJYnVmLT5vZmZzZXQgPSBvZmZzZXQ7CiAJYnVmLT5sZW4gPSBjb3VudDsK
--00000000000092d03f05af41959a--
