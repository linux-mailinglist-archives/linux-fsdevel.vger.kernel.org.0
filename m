Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8C9343783
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 04:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCVDhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 23:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCVDhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:37:04 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFA5C061574;
        Sun, 21 Mar 2021 20:37:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u10so19288981lju.7;
        Sun, 21 Mar 2021 20:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9waSJCTn3fuSQ1esV0A9hV0F6XhLtg6GpGr6ZwYxGg=;
        b=JPA8nFclnC7khBhwJpLBSWY+YtyvuaalEhkgdf8wuXl53wEFSb1TsJippneGMvUn8A
         GGQmC7ojU4T77eYdgTLeo4u8FTht6MNouaYTy6LeznxfnDg3BV/vj6S8Foh8ClG7YkGq
         U4UiAnB3ow+lsrUE+6q9hjoRiUvUMqxMQQ/RNy9Bfu2T7H+KFOkjKvzMsxPJdxSZ87ND
         tHcRefm6S8kQmknzgvCXxvv6r49hYxlezSUMQHwc6U41id/doXLeGd4ch+2PfStE+8Q5
         A8eAU619+csolDX0cYe3EE5eMgUEYu3EdUTZoF4knwXiU8frmp/zND2gUpcrSUxYcPXa
         hGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9waSJCTn3fuSQ1esV0A9hV0F6XhLtg6GpGr6ZwYxGg=;
        b=n79i77iV26QtSsdrp4opWCLE4AKwuvAbluDiA4iwbcIbWvsYbcybi9+FF8OXinJpc5
         QlCuDhS22JmNXEipeZEngsiJaKs9D7+EfgwQh2hzN5j2csNerRiaZtILS8I+KjGn/eFn
         wHZR0EW3gIxOnTRBeCGLSWoE1Bw2mebeK2Bra5mLXfCPJVp/8enoFnnI9ssOHf/yqzeT
         RYaMhwRL0TsMWyJxv5Vh656YwDk7/Xv6gqeqb5RaPwGyPqFQDL8rtU8/bWnHOWZJ1HcQ
         j0+bwglbMNbHBrstHO8m8vIk9EhVVYs4CSPpi3Ye6x3srsS0Hh5uQ+5Djo9XgUeWYUha
         pTHA==
X-Gm-Message-State: AOAM532dX/FoPL4Hxc/AAzXGJGeY2gCwgTv7XXWLtasDrX289KCAthWy
        89w1AmrF5ZmS2TxnnhmGTGcyfgdkd204lPCoCa8S1Sngvlg=
X-Google-Smtp-Source: ABdhPJzqCM9URldeKRvc3zX3sSdXWmOZYzTvWes2bQ4CWpvzvdrGpC92U3JIgd4Tn+sZZeuiPUX/YEgw5Qs3hWxiqPI=
X-Received: by 2002:a2e:8503:: with SMTP id j3mr8278141lji.272.1616384221531;
 Sun, 21 Mar 2021 20:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk> <CAH2r5mvA0WeeV1ZSW4HPvksvs+=GmkiV5nDHqCRddfxkgPNfXA@mail.gmail.com>
 <CAH2r5msWJn5a7JCUdoyJ7nfyeafRS8TvtgF+mZCY08LBf=9LAQ@mail.gmail.com> <YFgDH6wzFZ6FIs3R@zeniv-ca.linux.org.uk>
In-Reply-To: <YFgDH6wzFZ6FIs3R@zeniv-ca.linux.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 21 Mar 2021 22:36:50 -0500
Message-ID: <CAH2r5mv7NFYiPYvCoDJZ50nnoSgytEB4CKYNfg0RTNSPjox2fw@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] hopefully saner handling of pathnames in cifs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000586a5805be17c7b4"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000586a5805be17c7b4
Content-Type: text/plain; charset="UTF-8"

FYI - on a loosely related point  about / to \ conversion, I had been
experimenting with moving the conversion of '/' to '\' later depending
on connection type (see attached WIP patch for example).


On Sun, Mar 21, 2021 at 9:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Mar 21, 2021 at 09:19:53PM -0500, Steve French wrote:
> > automated tests failed so will need to dig in a little more and see
> > what is going on
> >
> > http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/533
>
> <looks>
>
> Oh, bugger...  I think I see a braino that might be responsible for that;
> whether it's all that's going on or not, that's an obvious bug.  Incremental
> for that one would be
>
> diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
> index 3febf667d119..ed16f75ac0fa 100644
> --- a/fs/cifs/dir.c
> +++ b/fs/cifs/dir.c
> @@ -132,7 +132,7 @@ build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
>         }
>         if (dfsplen) {
>                 s -= dfsplen;
> -               memcpy(page, tcon->treeName, dfsplen);
> +               memcpy(s, tcon->treeName, dfsplen);
>                 if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS) {
>                         int i;
>                         for (i = 0; i < dfsplen; i++) {
>
>
> Folded and force-pushed (same branch).  My apologies...



-- 
Thanks,

Steve

--000000000000586a5805be17c7b4
Content-Type: text/x-patch; charset="US-ASCII"; name="slash-v2.patch"
Content-Disposition: attachment; filename="slash-v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kmk1evr80>
X-Attachment-Id: f_kmk1evr80

ZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc191bmljb2RlLmMgYi9mcy9jaWZzL2NpZnNfdW5pY29k
ZS5jCmluZGV4IDliZDAzYTIzMTAzMi4uNGMwY2MwNjc3ZDgwIDEwMDY0NAotLS0gYS9mcy9jaWZz
L2NpZnNfdW5pY29kZS5jCisrKyBiL2ZzL2NpZnMvY2lmc191bmljb2RlLmMKQEAgLTk4LDYgKzk4
LDkgQEAgY29udmVydF9zZm1fY2hhcihjb25zdCBfX3UxNiBzcmNfY2hhciwgY2hhciAqdGFyZ2V0
KQogCWNhc2UgU0ZNX1BFUklPRDoKIAkJKnRhcmdldCA9ICcuJzsKIAkJYnJlYWs7CisJY2FzZSBT
Rk1fU0xBU0g6CisJCSp0YXJnZXQgPSAnXFwnOworCQlicmVhazsKIAlkZWZhdWx0OgogCQlyZXR1
cm4gZmFsc2U7CiAJfQpAQCAtNDAxLDYgKzQwNCw4IEBAIHN0YXRpYyBfX2xlMTYgY29udmVydF90
b19zZnVfY2hhcihjaGFyIHNyY19jaGFyKQogCXJldHVybiBkZXN0X2NoYXI7CiB9CiAKKyNkZWZp
bmUgVUNTMl9TTEFTSCAweDAwNUMKKwogc3RhdGljIF9fbGUxNiBjb252ZXJ0X3RvX3NmbV9jaGFy
KGNoYXIgc3JjX2NoYXIsIGJvb2wgZW5kX29mX3N0cmluZykKIHsKIAlfX2xlMTYgZGVzdF9jaGFy
OwpAQCAtNDMxLDYgKzQzNiw5IEBAIHN0YXRpYyBfX2xlMTYgY29udmVydF90b19zZm1fY2hhcihj
aGFyIHNyY19jaGFyLCBib29sIGVuZF9vZl9zdHJpbmcpCiAJY2FzZSAnfCc6CiAJCWRlc3RfY2hh
ciA9IGNwdV90b19sZTE2KFNGTV9QSVBFKTsKIAkJYnJlYWs7CisJY2FzZSAnXFwnOgorCQlkZXN0
X2NoYXIgPSBjcHVfdG9fbGUxNihTRk1fU0xBU0gpOworCQlicmVhazsKIAljYXNlICcuJzoKIAkJ
aWYgKGVuZF9vZl9zdHJpbmcpCiAJCQlkZXN0X2NoYXIgPSBjcHVfdG9fbGUxNihTRk1fUEVSSU9E
KTsKQEAgLTQ0Myw2ICs0NTEsMTAgQEAgc3RhdGljIF9fbGUxNiBjb252ZXJ0X3RvX3NmbV9jaGFy
KGNoYXIgc3JjX2NoYXIsIGJvb2wgZW5kX29mX3N0cmluZykKIAkJZWxzZQogCQkJZGVzdF9jaGFy
ID0gMDsKIAkJYnJlYWs7CisJY2FzZSAnLyc6CisKKwkJZGVzdF9jaGFyID0gY3B1X3RvX2xlMTYo
VUNTMl9TTEFTSCk7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCWRlc3RfY2hhciA9IDA7CiAJfQpA
QCAtNTAyLDExICs1MTYsNyBAQCBjaWZzQ29udmVydFRvVVRGMTYoX19sZTE2ICp0YXJnZXQsIGNv
bnN0IGNoYXIgKnNvdXJjZSwgaW50IHNyY2xlbiwKIAkJCWRzdF9jaGFyID0gY29udmVydF90b19z
Zm1fY2hhcihzcmNfY2hhciwgZW5kX29mX3N0cmluZyk7CiAJCX0gZWxzZQogCQkJZHN0X2NoYXIg
PSAwOwotCQkvKgotCQkgKiBGSVhNRTogV2UgY2FuIG5vdCBoYW5kbGUgcmVtYXBwaW5nIGJhY2tz
bGFzaCAoVU5JX1NMQVNIKQotCQkgKiB1bnRpbCBhbGwgdGhlIGNhbGxzIHRvIGJ1aWxkX3BhdGhf
ZnJvbV9kZW50cnkgYXJlIG1vZGlmaWVkLAotCQkgKiBhcyB0aGV5IHVzZSBiYWNrc2xhc2ggYXMg
c2VwYXJhdG9yLgotCQkgKi8KKwogCQlpZiAoZHN0X2NoYXIgPT0gMCkgewogCQkJY2hhcmxlbiA9
IGNwLT5jaGFyMnVuaShzb3VyY2UgKyBpLCBzcmNsZW4gLSBpLCAmdG1wKTsKIAkJCWRzdF9jaGFy
ID0gY3B1X3RvX2xlMTYodG1wKTsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc2dsb2IuaCBiL2Zz
L2NpZnMvY2lmc2dsb2IuaAppbmRleCAzZGUzYzU5MDhhNzIuLmYwZjk2ZGRkYzQ4MyAxMDA2NDQK
LS0tIGEvZnMvY2lmcy9jaWZzZ2xvYi5oCisrKyBiL2ZzL2NpZnMvY2lmc2dsb2IuaApAQCAtMTQz
MCwxMCArMTQzMCwxMCBAQCBDSUZTX0ZJTEVfU0Ioc3RydWN0IGZpbGUgKmZpbGUpCiAKIHN0YXRp
YyBpbmxpbmUgY2hhciBDSUZTX0RJUl9TRVAoY29uc3Qgc3RydWN0IGNpZnNfc2JfaW5mbyAqY2lm
c19zYikKIHsKLQlpZiAoY2lmc19zYi0+bW50X2NpZnNfZmxhZ3MgJiBDSUZTX01PVU5UX1BPU0lY
X1BBVEhTKQorLyoJaWYgKGNpZnNfc2ItPm1udF9jaWZzX2ZsYWdzICYgQ0lGU19NT1VOVF9QT1NJ
WF9QQVRIUykgKi8KIAkJcmV0dXJuICcvJzsKLQllbHNlCi0JCXJldHVybiAnXFwnOworLyoJZWxz
ZQorCQlyZXR1cm4gJ1xcJzsgKi8KIH0KIAogc3RhdGljIGlubGluZSB2b2lkCmRpZmYgLS1naXQg
YS9mcy9jaWZzL2Rpci5jIGIvZnMvY2lmcy9kaXIuYwppbmRleCA5N2FjMzYzYjVkZjEuLmY1MzRl
MmY5OTFkOSAxMDA2NDQKLS0tIGEvZnMvY2lmcy9kaXIuYworKysgYi9mcy9jaWZzL2Rpci5jCkBA
IC0yMDksMTIgKzIxMCwxOCBAQCBjaGVja19uYW1lKHN0cnVjdCBkZW50cnkgKmRpcmVudHJ5LCBz
dHJ1Y3QgY2lmc190Y29uICp0Y29uKQogCQkgICAgIGxlMzJfdG9fY3B1KHRjb24tPmZzQXR0cklu
Zm8uTWF4UGF0aE5hbWVDb21wb25lbnRMZW5ndGgpKSkKIAkJcmV0dXJuIC1FTkFNRVRPT0xPTkc7
CiAKLQlpZiAoIShjaWZzX3NiLT5tbnRfY2lmc19mbGFncyAmIENJRlNfTU9VTlRfUE9TSVhfUEFU
SFMpKSB7Ci0JCWZvciAoaSA9IDA7IGkgPCBkaXJlbnRyeS0+ZF9uYW1lLmxlbjsgaSsrKSB7Ci0J
CQlpZiAoZGlyZW50cnktPmRfbmFtZS5uYW1lW2ldID09ICdcXCcpIHsKLQkJCQljaWZzX2RiZyhG
WUksICJJbnZhbGlkIGZpbGUgbmFtZVxuIik7Ci0JCQkJcmV0dXJuIC1FSU5WQUw7Ci0JCQl9CisJ
LyoKKwkgKiBTTUIzLjEuMSBQT1NJWCBFeHRlbnNpb25zLCBDSUZTIFVuaXggRXh0ZW5zaW9ucyBh
bmQgU0ZNIG1hcHBpbmdzCisJICogYWxsb3cgXCBpbiBwYXRocyAob3IgaW4gbGF0dGVyIGNhc2Ug
cmVtYXBzIFwgdG8gMHhGMDI2KQorCSAqLworCWlmICgoY2lmc19zYi0+bW50X2NpZnNfZmxhZ3Mg
JiBDSUZTX01PVU5UX1BPU0lYX1BBVEhTKSB8fAorCSAgICAoY2lmc19zYi0+bW50X2NpZnNfZmxh
Z3MgJiBDSUZTX01PVU5UX01BUF9TRk1fQ0hSKSkKKwkJcmV0dXJuIDA7CisJCSAKKwlmb3IgKGkg
PSAwOyBpIDwgZGlyZW50cnktPmRfbmFtZS5sZW47IGkrKykgeworCQlpZiAoZGlyZW50cnktPmRf
bmFtZS5uYW1lW2ldID09ICdcXCcpIHsKKwkJCWNpZnNfZGJnKEZZSSwgIkludmFsaWQgZmlsZSBu
YW1lXG4iKTsKKwkJCXJldHVybiAtRUlOVkFMOwogCQl9CiAJfQogCXJldHVybiAwOwpkaWZmIC0t
Z2l0IGEvZnMvY2lmcy9taXNjLmMgYi9mcy9jaWZzL21pc2MuYwppbmRleCA4MmUxNzY3MjBjYTYu
LjkzNjE2NDRmNzMxMCAxMDA2NDQKLS0tIGEvZnMvY2lmcy9taXNjLmMKKysrIGIvZnMvY2lmcy9t
aXNjLmMKQEAgLTExODYsNyArMTE4Niw3IEBAIGludCB1cGRhdGVfc3VwZXJfcHJlcGF0aChzdHJ1
Y3QgY2lmc190Y29uICp0Y29uLCBjaGFyICpwcmVmaXgpCiAJCQlnb3RvIG91dDsKIAkJfQogCi0J
CWNvbnZlcnRfZGVsaW1pdGVyKGNpZnNfc2ItPnByZXBhdGgsIENJRlNfRElSX1NFUChjaWZzX3Ni
KSk7CisJCWNvbnZlcnRfZGVsaW1pdGVyKGNpZnNfc2ItPnByZXBhdGgsIENJRlNfRElSX1NFUChj
aWZzX3NiKSk7IC8qIEJCIERvZXMgdGhpcyBuZWVkIHRvIGJlIGNoYW5nZWQgZm9yIC8gPyAqLwog
CX0gZWxzZQogCQljaWZzX3NiLT5wcmVwYXRoID0gTlVMTDsKIApkaWZmIC0tZ2l0IGEvZnMvY2lm
cy9zbWIybWlzYy5jIGIvZnMvY2lmcy9zbWIybWlzYy5jCmluZGV4IDYwZDRiZDFlYWUyYi4uY2U0
ZjAwMDY5NjUzIDEwMDY0NAotLS0gYS9mcy9jaWZzL3NtYjJtaXNjLmMKKysrIGIvZnMvY2lmcy9z
bWIybWlzYy5jCkBAIC00NzYsMTMgKzQ3NiwxNyBAQCBjaWZzX2NvbnZlcnRfcGF0aF90b191dGYx
Nihjb25zdCBjaGFyICpmcm9tLCBzdHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3NiKQogCWlmIChm
cm9tWzBdID09ICdcXCcpCiAJCXN0YXJ0X29mX3BhdGggPSBmcm9tICsgMTsKIAotCS8qIFNNQjMx
MSBQT1NJWCBleHRlbnNpb25zIHBhdGhzIGRvIG5vdCBpbmNsdWRlIGxlYWRpbmcgc2xhc2ggKi8K
LQllbHNlIGlmIChjaWZzX3NiX21hc3Rlcl90bGluayhjaWZzX3NiKSAmJgotCQkgY2lmc19zYl9t
YXN0ZXJfdGNvbihjaWZzX3NiKS0+cG9zaXhfZXh0ZW5zaW9ucyAmJgotCQkgKGZyb21bMF0gPT0g
Jy8nKSkgewotCQlzdGFydF9vZl9wYXRoID0gZnJvbSArIDE7Ci0JfSBlbHNlCi0JCXN0YXJ0X29m
X3BhdGggPSBmcm9tOworCXN0YXJ0X29mX3BhdGggPSBmcm9tOworCS8qCisJICogT25seSBvbGQg
Q0lGUyBVbml4IGV4dGVuc2lvbnMgcGF0aHMgaW5jbHVkZSBsZWFkaW5nIHNsYXNoCisJICogTmVl
ZCB0byBza2lwIGlmIGZvciBTTUIzLjEuMSBQT1NJWCBFeHRlbnNpb25zIGFuZCBTTUIxLzIvMwor
CSAqLworCWlmIChmcm9tWzBdID09ICcvJykgeworCQlpZiAoKChjaWZzX3NiLT5tbnRfY2lmc19m
bGFncyAmIENJRlNfTU9VTlRfUE9TSVhfUEFUSFMpID09IGZhbHNlKSB8fAorCQkgICAgKGNpZnNf
c2JfbWFzdGVyX3RsaW5rKGNpZnNfc2IpICYmCisJCSAgICAgKGNpZnNfc2JfbWFzdGVyX3Rjb24o
Y2lmc19zYiktPnBvc2l4X2V4dGVuc2lvbnMpKSkKKwkJCXN0YXJ0X29mX3BhdGggPSBmcm9tICsg
MTsKKwl9CiAKIAl0byA9IGNpZnNfc3RybmR1cF90b191dGYxNihzdGFydF9vZl9wYXRoLCBQQVRI
X01BWCwgJmxlbiwKIAkJCQkgICBjaWZzX3NiLT5sb2NhbF9ubHMsIG1hcF90eXBlKTsK
--000000000000586a5805be17c7b4--
