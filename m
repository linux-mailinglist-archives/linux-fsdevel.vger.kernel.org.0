Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A764226C99C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgIPTOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 15:14:55 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:50295 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727305AbgIPRkS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600278016; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Type: MIME-Version: Sender;
 bh=DHI9CfAatfFV2SOCqAFE3IYh8PISIY9BnJi78Ee2+2M=; b=pPdgys4yxHaENxu0Wpd3joTrCIskhpFeOWA0d3zYYHzSohRpKwUvqZhyHuoHUo03jl02q27Q
 B/DJqA/XE25IhL98vHqwOH3Qb8cOPEWYR0KWUXIMwI+H4CzUEint4jRoob8/gbleQslN8EmM
 e2UVNTvhwjPxMVHFE2ZjnZAWQoQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f622fc2698ee477d1c4855c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Sep 2020 15:31:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B4CD9C433F0; Wed, 16 Sep 2020 15:31:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppvk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A65EBC433F0;
        Wed, 16 Sep 2020 15:31:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_ab9a7e4af9035e8326feee966c1511e6"
Date:   Wed, 16 Sep 2020 21:01:13 +0530
From:   ppvk@codeaurora.org
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Pradeep P V K <pragalla@qti.qualcomm.com>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        sayalil@codeaurora.org
Subject: Re: [PATCH V4] fuse: Fix VM_BUG_ON_PAGE issue while accessing zero
 ref count page
In-Reply-To: <a98eb58e0aff49ea0b49db1e90155a2d@codeaurora.org>
References: <1599553026-11745-1-git-send-email-pragalla@qti.qualcomm.com>
 <CAJfpegunet-5BOG74seeL3Gr=xCSStFznphDnuYPWEisbenPog@mail.gmail.com>
 <0101017478aef256-c8471520-26b1-4b87-a3b8-8266627b704f-000000@us-west-2.amazonses.com>
 <CAJfpegtpLoskZDWwZpsEi=L_5jrvr7=xFG9GZJd8dTdJr647ww@mail.gmail.com>
 <a98eb58e0aff49ea0b49db1e90155a2d@codeaurora.org>
Message-ID: <3ccc311257ac24096a94fb7b45013737@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=_ab9a7e4af9035e8326feee966c1511e6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

On 2020-09-14 19:02, ppvk@codeaurora.org wrote:
> On 2020-09-14 13:41, Miklos Szeredi wrote:
>> On Thu, Sep 10, 2020 at 5:42 PM <ppvk@codeaurora.org> wrote:
>>> 
>>> On 2020-09-08 16:55, Miklos Szeredi wrote:
>>> > On Tue, Sep 8, 2020 at 10:17 AM Pradeep P V K
>>> > <pragalla@qti.qualcomm.com> wrote:
>>> >>
>>> >> From: Pradeep P V K <ppvk@codeaurora.org>
>>> >>
>>> >> There is a potential race between fuse_abort_conn() and
>>> >> fuse_copy_page() as shown below, due to which VM_BUG_ON_PAGE
>>> >> crash is observed for accessing a free page.
>>> >>
>>> >> context#1:                      context#2:
>>> >> fuse_dev_do_read()              fuse_abort_conn()
>>> >> ->fuse_copy_args()               ->end_requests()
>>> >
>>> > This shouldn't happen due to FR_LOCKED logic.   Are you seeing this on
>>> > an upstream kernel?  Which version?
>>> >
>>> > Thanks,
>>> > Miklos
>>> 
>>> This is happen just after unlock_request() in fuse_ref_page(). In
>>> unlock_request(), it will clear the FR_LOCKED bit.
>>> As there is no protection between context#1 & context#2 during
>>> unlock_request(), there are chances that it could happen.
>> 
>> Ah, indeed, I missed that one.
>> 
>> Similar issue in fuse_try_move_page(), which dereferences oldpage
>> after unlock_request().
>> 
>> Fix for both is to grab a reference to the page from ap->pages[] array
>> *before* calling unlock_request().
>> 
>> Attached untested patch.   Could you please verify that it fixes the 
>> bug?
>> 
> Thanks for the patch. It is an one time issue and bit hard to
> reproduce but still we
> will verify the above proposed patch and update the test results here.
> 
Not seen any issue during 24 hours(+) of stability run with your 
proposed patch.
This covers reads/writes on fuse paths + reboots + other concurrency's.

> Minor comments on the commit text of the proposed patch : This issue
> was originally reported by me and kernel test robot
> identified compilation errors on the patch that i submitted.
> This confusion might be due to un proper commit text note on "changes 
> since v1"
> 
>> Thanks,
>> Miklos
> 
> Thanks and Regards,
> Pradeep

--=_ab9a7e4af9035e8326feee966c1511e6
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=fuse-fix-page-dereference-after-free.patch
Content-Disposition: attachment;
 filename=fuse-fix-page-dereference-after-free.patch;
 size=2325

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
--=_ab9a7e4af9035e8326feee966c1511e6--
