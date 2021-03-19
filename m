Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554853416D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 08:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhCSHsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 03:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhCSHri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:47:38 -0400
X-Greylist: delayed 109 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Mar 2021 00:47:37 PDT
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378A4C06174A;
        Fri, 19 Mar 2021 00:47:37 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 8D0C62E1869;
        Fri, 19 Mar 2021 10:45:46 +0300 (MSK)
Received: from mail.yandex-team.ru (mail.yandex-team.ru [2a02:6b8:0:408:868:71a6:d203:8f53])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with HTTP id RjXCO10PAW21-jkP0U1St;
        Fri, 19 Mar 2021 10:45:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1616139946; bh=oYzw9yBamYcVEFuiIKWorYqGTToWeWfjmDgdEX5vWHw=;
        h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
        b=d8agIJaJs8ywnSwg7SCNLlZvKUboPEkU99qAmepVI/kWfacx5/zGNAiFQSLtjdnap
         WDZJKTgboUw7EpyUJBvPdNpfCbspvi8NnQVJPS4GWkq/EC+181AThp2z61Q5uttG0T
         YGzm0uWYe/hJ6ubzhsIRlMzBsknNvdE2cniUbPoY=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000084479
X-Yandex-Avir: 1
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [2a02:6b8:c14:2704:0:640:ec30:c78b])
        by sas2-3467662b745a.qloud-c.yandex.net with LMTP id xc1xHhWXL8-j8Hy5040
        for <dmtrmonakhov@yandex-team.ru>; Fri, 19 Mar 2021 10:45:36 +0300
Received: by sas1-b43cfc766761.qloud-c.yandex.net with HTTP;
        Fri, 19 Mar 2021 10:45:36 +0300
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
In-Reply-To: <20210319052859.3220-1-dmtrmonakhov@yandex-team.ru>
References: <20210319052859.3220-1-dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] io_uring: Try to merge io requests only for regular files
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 19 Mar 2021 10:45:46 +0300
Message-Id: <61611616138730@mail.yandex-team.ru>
Content-Type: multipart/mixed;
        boundary="----==--bound.300.sas1-b43cfc766761.qloud-c.yandex.net"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


------==--bound.300.sas1-b43cfc766761.qloud-c.yandex.net
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

- stable@



19.03.2021, 08:29, "Dmitry Monakhov" <dmtrmonakhov@yandex-team.ru>:
> Otherwise we may endup blocking on pipe or socket.
>
> Fixes: 6d5d5ac ("io_uring: extend async work merge")
> Testcase: https://github.com/dmonakhov/liburing/commit/16d171b6ef9d68e6db66650a83d98c5c721d01f6
> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> ---
>  fs/io_uring.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 478df7e..848657c 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2183,6 +2183,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>  static struct async_list *io_async_list_from_req(struct io_ring_ctx *ctx,
>                                                   struct io_kiocb *req)
>  {
> + if (!(req->flags & REQ_F_ISREG))
> + return NULL;
> +
IMHO it is reasonable to completely disable  io_should_merge logic because
even with the this fix it still affected by latency spikes like follows:

->submit_read: req1[slow_hdd, sector=z]
->submit_read: req2[nvme, sector=X]
-> wait(req2)  -> fast

->submit_read: req3[nvme, sector=Y] 
--> wait(req3)  ->slow  
  if completes if X and Y belongs to same page merge logic will wait for req1 to complete




------==--bound.300.sas1-b43cfc766761.qloud-c.yandex.net
Content-Disposition: attachment;
	filename="0001-io_uring-completely-disable-io_should_merge-logic.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
	name="0001-io_uring-completely-disable-io_should_merge-logic.patch"

RnJvbSBjMjRjZGE5YWE5MDI3NzVlNGUyMzU3NWI3NThmMDA5ZTlmYWU0NjQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEbWl0cnkgTW9uYWtob3YgPGRtdHJtb25ha2hvdkB5YW5kZXgt
dGVhbS5ydT4KRGF0ZTogRnJpLCAxOSBNYXIgMjAyMSAwODo0ODoxOCArMDMwMApTdWJqZWN0OiBb
UEFUQ0hdIGlvX3VyaW5nOiBjb21wbGV0ZWx5IGRpc2FibGUgaW9fc2hvdWxkX21lcmdlIGxvZ2lj
Cgppb19zaG91bGRfbWVyZ2UgbG9naWMgaXMgd2llcmQgYW5kIHByb25lIHRvIGxhdGVuY3kgc3Bp
a2VzIGJlY2F1c2Ugb2Ygc2xvdyBuZWlnaGJvcnMuCgpTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgTW9u
YWtob3YgPGRtdHJtb25ha2hvdkB5YW5kZXgtdGVhbS5ydT4KCmRpZmYgLS1naXQgYS9mcy9pb191
cmluZy5jIGIvZnMvaW9fdXJpbmcuYwppbmRleCA0NzhkZjdlLi5hNGZiM2E3IDEwMDY0NAotLS0g
YS9mcy9pb191cmluZy5jCisrKyBiL2ZzL2lvX3VyaW5nLmMKQEAgLTEyODgsNyArMTI4OCw3IEBA
IHN0YXRpYyBzc2l6ZV90IGlvX2ltcG9ydF9pb3ZlYyhzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwg
aW50IHJ3LAogCiBzdGF0aWMgaW5saW5lIGJvb2wgaW9fc2hvdWxkX21lcmdlKHN0cnVjdCBhc3lu
Y19saXN0ICphbCwgc3RydWN0IGtpb2NiICpraW9jYikKIHsKLQlpZiAoYWwtPmZpbGUgPT0ga2lv
Y2ItPmtpX2ZpbHApIHsKKwlpZiAoYWwtPmZpbGUgPT0ga2lvY2ItPmtpX2ZpbHAgJiYgMCkgewog
CQlvZmZfdCBzdGFydCwgZW5kOwogCiAJCS8qCi0tIAoyLjcuNAoK
------==--bound.300.sas1-b43cfc766761.qloud-c.yandex.net--
