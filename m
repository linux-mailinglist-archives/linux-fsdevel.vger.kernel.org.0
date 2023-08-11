Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EB07785AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 04:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjHKC4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 22:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHKC4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:56:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86032D60;
        Thu, 10 Aug 2023 19:56:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so23579531fa.1;
        Thu, 10 Aug 2023 19:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691722570; x=1692327370;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LgNyfiqMR8MSjMTyVJ2fWh3nxzqMezQIw1Nb6XC5XxQ=;
        b=OI9gHZ5O9PdIJr9euYd5uuAtF0FtS1uXyqHx4dZXhFykRTIb1mo76GjhVlVTcW3UgA
         9yxB8luzywDd7mOQ7wRnPiaoD3kUmglMMz3VyIykcHKrHzBTMbiQ7HBEaf12PvrTKJ8R
         I1hXaRYlGwEZzch+uXsmi4A2UNWEnIDq8dJO09I4YynqDtwN8xF0ruMcMo3WQigPu9QB
         QzhUbF4VuOXixLDspEnF+HwKhftsjQbgqp1MuBt7HP66IA5wO6TIr8u4OCvCx0XqNoNu
         rgVKJvS9OpP5EODin0Ws4+Blgo/TjKUofmaxdlfE7HfZwZGViw7IaenDKN7NlXuK4Fcs
         e/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691722570; x=1692327370;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgNyfiqMR8MSjMTyVJ2fWh3nxzqMezQIw1Nb6XC5XxQ=;
        b=E7iY5AgJrNFOKw0CQ+FKzChUujx7Bm3fSzMWgTQOGakszgMolYtE2u7paj+szLf8ql
         nKFAP05fE0VhJhw3XkFfvDt8ohLYeQtox4x/yLyDA1KdMz4TGrEz8aGL0f3PnqQc/xAj
         fkPw9e3p+bhGH6MC0ffFS87lYmuZkukWoAmp7DSK9hX8w6ysgQpNDxxcD+bWGpLoi3q7
         Xu04Z9Lkt2SQRNExMmdta6xBZ6SC/a8VbVxD/fdHJ/PFt6wtN9NeRggP7tq4MRZXt0ul
         llAVWFnJWQRNRehQKF3Uhs//lGSG5wlkIeZ8zbp51jyDg8NhHIWwuQKXGzU9Z4YgcRil
         ZvOQ==
X-Gm-Message-State: AOJu0YzDB2Z6qWWt3+XgLJxcd/abZRxXJikQG5MQma0S75nbu/KRbcvf
        +llyb39yTQaGOrwuRGTHv8jKkMJ0b+wN+93NfTw3S0+He1irEQ==
X-Google-Smtp-Source: AGHT+IFtm/b41SnZd2MkRipNs43n/4c27YfQuT26DpS3yH4CuiuP9Mjf7GYuhQFfS44sIi1s0Fq7iYKUZa50GinlesY=
X-Received: by 2002:a2e:a287:0:b0:2b6:e7ff:4b2e with SMTP id
 k7-20020a2ea287000000b002b6e7ff4b2emr590843lja.33.1691722569407; Thu, 10 Aug
 2023 19:56:09 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 10 Aug 2023 21:55:57 -0500
Message-ID: <CAH2r5msH+At+cAU8kPKaOjxnmHvMO=9wUaCvNmibCK+He7HO-Q@mail.gmail.com>
Subject: [PATCH][SMB3] display network namespace in debug information
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000cf3e1206029cda84"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000cf3e1206029cda84
Content-Type: text/plain; charset="UTF-8"

    We recently had problems where a network namespace was deleted
    causing problems for reconnect.  To help deal with problems
    like this it is useful to dump the network namespace to debug
    what happened.

    Add this to information displayed in /proc/fs/cifs/DebugData for
    the server (and channels if mounted if multichannel). For example:

       Local Users To Server: 1 SecMode: 0x1 Req On Wire: 0 Net
namespace: 4026531840

    This can be easily compared with what is displayed for the
    processes on the system. For example /proc/1/ns/net in this case
    showed and we can see that the namespace is still valid.

       'net:[4026531840]'

    Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index fb4162a52844..aec6e9137474 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -153,6 +153,11 @@ cifs_dump_channel(struct seq_file *m, int i,
struct cifs_chan *chan)
                   in_flight(server),
                   atomic_read(&server->in_send),
                   atomic_read(&server->num_waiters));
+#ifdef CONFIG_NET_NS
+       if (server->net)
+               seq_printf(m, " Net namespace: %u ", server->net->ns.inum);
+#endif /* NET_NS */
+
 }

 static inline const char *smb_speed_to_str(size_t bps)
@@ -430,10 +435,15 @@ static int cifs_debug_data_proc_show(struct
seq_file *m, void *v)
                                server->reconnect_instance,
                                server->srv_count,
                                server->sec_mode, in_flight(server));
+#ifdef CONFIG_NET_NS
+               if (server->net)
+                       seq_printf(m, " Net namespace: %u ",
server->net->ns.inum);
+#endif /* NET_NS */

                seq_printf(m, "\nIn Send: %d In MaxReq Wait: %d",
                                atomic_read(&server->in_send),
                                atomic_read(&server->num_waiters));
+
                if (server->leaf_fullpath) {
                        seq_printf(m, "\nDFS leaf full path: %s",
                                   server->leaf_fullpath);


--
Thanks,

Steve

--000000000000cf3e1206029cda84
Content-Type: application/x-patch; 
	name="0001-smb3-display-network-namespace-in-debug-information.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-display-network-namespace-in-debug-information.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ll5zvez00>
X-Attachment-Id: f_ll5zvez00

RnJvbSBhYzQ2OWRmNjI0MGY5ZTg1NDcxOTNjZDU5ZGQ5ODcxMTBjZDY3ZWMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFRodSwgMTAgQXVnIDIwMjMgMjE6NDE6MDMgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBkaXNwbGF5IG5ldHdvcmsgbmFtZXNwYWNlIGluIGRlYnVnIGluZm9ybWF0aW9uCgpXZSBy
ZWNlbnRseSBoYWQgcHJvYmxlbXMgd2hlcmUgYSBuZXR3b3JrIG5hbWVzcGFjZSB3YXMgZGVsZXRl
ZApjYXVzaW5nIHByb2JsZW1zIGZvciByZWNvbm5lY3QuICBUbyBoZWxwIGRlYWwgd2l0aCBwcm9i
bGVtcwpsaWtlIHRoaXMgaXQgaXMgdXNlZnVsIHRvIGR1bXAgdGhlIG5ldHdvcmsgbmFtZXNwYWNl
IHRvCmJldHRlciBkZWJ1ZyB3aGF0IGhhcHBlbmVkLgoKU28gYWRkIHRoaXMgdG8gaW5mb3JtYXRp
b24gZGlzcGxheWVkIGluIC9wcm9jL2ZzL2NpZnMvRGVidWdEYXRhIGZvcgp0aGUgc2VydmVyIChh
bmQgY2hhbm5lbHMgaWYgbW91bnRlZCBpZiBtdWx0aWNoYW5uZWwpLiBGb3IgZXhhbXBsZToKCiAg
IExvY2FsIFVzZXJzIFRvIFNlcnZlcjogMSBTZWNNb2RlOiAweDEgUmVxIE9uIFdpcmU6IDAgTmV0
IG5hbWVzcGFjZTogNDAyNjUzMTg0MAoKVGhpcyBjYW4gYmUgZWFzaWx5IGNvbXBhcmVkIHdpdGgg
d2hhdCBpcyBkaXNwbGF5ZWQgZm9yIHRoZQpwcm9jZXNzZXMgb24gdGhlIHN5c3RlbS4gRm9yIGV4
YW1wbGUgL3Byb2MvMS9ucy9uZXQgaW4gdGhpcyBjYXNlCnNob3dlZCBhbmQgd2UgY2FuIHNlZSB0
aGF0IHRoZSBuYW1lc3BhY2UgaXMgc3RpbGwgdmFsaWQuCgogICAnbmV0Ols0MDI2NTMxODQwXScK
CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8
c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9zbWIvY2xpZW50L2NpZnNfZGVidWcuYyB8
IDEwICsrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvZnMvc21iL2NsaWVudC9jaWZzX2RlYnVnLmMgYi9mcy9zbWIvY2xpZW50L2NpZnNfZGVi
dWcuYwppbmRleCBmYjQxNjJhNTI4NDQuLmFlYzZlOTEzNzQ3NCAxMDA2NDQKLS0tIGEvZnMvc21i
L2NsaWVudC9jaWZzX2RlYnVnLmMKKysrIGIvZnMvc21iL2NsaWVudC9jaWZzX2RlYnVnLmMKQEAg
LTE1Myw2ICsxNTMsMTEgQEAgY2lmc19kdW1wX2NoYW5uZWwoc3RydWN0IHNlcV9maWxlICptLCBp
bnQgaSwgc3RydWN0IGNpZnNfY2hhbiAqY2hhbikKIAkJICAgaW5fZmxpZ2h0KHNlcnZlciksCiAJ
CSAgIGF0b21pY19yZWFkKCZzZXJ2ZXItPmluX3NlbmQpLAogCQkgICBhdG9taWNfcmVhZCgmc2Vy
dmVyLT5udW1fd2FpdGVycykpOworI2lmZGVmIENPTkZJR19ORVRfTlMKKwlpZiAoc2VydmVyLT5u
ZXQpCisJCXNlcV9wcmludGYobSwgIiBOZXQgbmFtZXNwYWNlOiAldSAiLCBzZXJ2ZXItPm5ldC0+
bnMuaW51bSk7CisjZW5kaWYgLyogTkVUX05TICovCisKIH0KIAogc3RhdGljIGlubGluZSBjb25z
dCBjaGFyICpzbWJfc3BlZWRfdG9fc3RyKHNpemVfdCBicHMpCkBAIC00MzAsMTAgKzQzNSwxNSBA
QCBzdGF0aWMgaW50IGNpZnNfZGVidWdfZGF0YV9wcm9jX3Nob3coc3RydWN0IHNlcV9maWxlICpt
LCB2b2lkICp2KQogCQkJCXNlcnZlci0+cmVjb25uZWN0X2luc3RhbmNlLAogCQkJCXNlcnZlci0+
c3J2X2NvdW50LAogCQkJCXNlcnZlci0+c2VjX21vZGUsIGluX2ZsaWdodChzZXJ2ZXIpKTsKKyNp
ZmRlZiBDT05GSUdfTkVUX05TCisJCWlmIChzZXJ2ZXItPm5ldCkKKwkJCXNlcV9wcmludGYobSwg
IiBOZXQgbmFtZXNwYWNlOiAldSAiLCBzZXJ2ZXItPm5ldC0+bnMuaW51bSk7CisjZW5kaWYgLyog
TkVUX05TICovCiAKIAkJc2VxX3ByaW50ZihtLCAiXG5JbiBTZW5kOiAlZCBJbiBNYXhSZXEgV2Fp
dDogJWQiLAogCQkJCWF0b21pY19yZWFkKCZzZXJ2ZXItPmluX3NlbmQpLAogCQkJCWF0b21pY19y
ZWFkKCZzZXJ2ZXItPm51bV93YWl0ZXJzKSk7CisKIAkJaWYgKHNlcnZlci0+bGVhZl9mdWxscGF0
aCkgewogCQkJc2VxX3ByaW50ZihtLCAiXG5ERlMgbGVhZiBmdWxsIHBhdGg6ICVzIiwKIAkJCQkg
ICBzZXJ2ZXItPmxlYWZfZnVsbHBhdGgpOwotLSAKMi4zNC4xCgo=
--000000000000cf3e1206029cda84--
