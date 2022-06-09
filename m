Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B75456DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 00:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245602AbiFIWEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 18:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiFIWEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:04:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D386BFF2
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 15:04:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq6so37045829ejb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEoo9nf6uoR86Ps06V8ScDCUYmvkWwacynGHe7RF+ws=;
        b=ghk7xzjGGy/Dz/HTRD96htdkv+0frxmQazCf9uMvgNp1Z1wLEcG5ERbmUjxEESzPQp
         yRM8fjscWfp5jmsENIatZmPJ+qs576kPyOyIvWF+++ET4ShZ1UWYcLDhHWzwT6KNJU9Z
         XlPAcP5otspGV9g6xU4a4P4/9+4XRpzNWEgiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEoo9nf6uoR86Ps06V8ScDCUYmvkWwacynGHe7RF+ws=;
        b=2sxdNKHFrsOkPQlr7PeH5WDgUk5dnov5ZKL8D5KK87E4NMtWTWKygA3dtiFCL5inWN
         IDL1e2QgJ3zWDxfRR9IdeY6dj/Rarqeq1SWpKl2KE1r6+gTgTsTH/yqd9OuoXL022HDs
         8s/rjZ8pfea88DSb7Y70kJL8qx0j7kCN38dsC3YqV50Ai5T+VNWZebwPrwBfEHwOaPVc
         ZEHxujvzFuT/qLNNBhO2uWNn0zLGw88X/2jWIi9dolhq82jR491VwSYmOsH4lbmu3iBQ
         XMSvclDQ3FAK6CD7Ux67BkAU1b6bqfSM4ud5HctWovc8E8I+kuTq+8OWlPg2AT6M+bG7
         gyxw==
X-Gm-Message-State: AOAM530Os9H2lDvZAX/aFKCfWfcFfkFbD8DcYSqGOhQ8A2EcZXKUYnbo
        52Ns1KsERC0DKrfyLA0uikTuZZNLIV0RN57L
X-Google-Smtp-Source: ABdhPJyY88ywkjfdo/O6s9L5HQDqv6xX7ZjUBpS8Gbdb8F1H6Rp04msvSfHMt3866VFN0mc5jL0e4Q==
X-Received: by 2002:a17:907:94c3:b0:711:8b08:e7e with SMTP id dn3-20020a17090794c300b007118b080e7emr24867313ejc.451.1654812269059;
        Thu, 09 Jun 2022 15:04:29 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id ck11-20020a0564021c0b00b0042de3d661d2sm15184179edb.1.2022.06.09.15.04.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 15:04:28 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id v1so39382358ejg.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 15:04:28 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr39748721wrz.281.1654812258016; Thu, 09
 Jun 2022 15:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <40676.1654807564@warthog.procyon.org.uk>
In-Reply-To: <40676.1654807564@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jun 2022 15:04:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkwKyNmNdKpQkqZ6DnmUL-x9hp0YBnUGjaPFEAdxDTbw@mail.gmail.com>
Message-ID: <CAHk-=wgkwKyNmNdKpQkqZ6DnmUL-x9hp0YBnUGjaPFEAdxDTbw@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix gcc-12 warning by embedding vfs inode in netfs_i_context
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <smfrench@gmail.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical@lists.samba.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000cf586f05e10b00da"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000cf586f05e10b00da
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 9, 2022 at 1:46 PM David Howells <dhowells@redhat.com> wrote:
>
>         struct my_inode {
> -               struct {
> -                       /* These must be contiguous */
> -                       struct inode            vfs_inode;
> -                       struct netfs_i_context  netfs_ctx;
> -               };
> +               struct netfs_inode netfs; /* Netfslib context and vfs inode */
>                 ...

Side note: I think this could have been done with an unnamed union as

        struct my_inode {
                union {
                        struct inode            vfs_inode;
                        struct netfs_inode netfs_inode;
                };
        [...]

instead, with the rule that 'netfs_inode' always starts with a 'struct inode'.

The advantage would have been that the old 'vfs_inode' syntax would
have continued to work, and much less of the ugliness.

So a fair amount of the noise in this patch could have been avoided.

That said, I think the end result is fine (and maybe less complicated
than using that union trick), so that's not the big deal.

But what I actually *really* detest in this patch is that

        struct netfs_inode *ctx = netfs_inode(file_inode(file));

pattern.

In several cases that's just a different syntax for almost the same
problem that gcc-12 already complained about.

And yes, in some cases you do need it - particularly in the
"mapping->host" situation, you really have lost sight of the fact that
you really have a "struct netfs_inode *", and all you have is the
"struct inode *".

But in a lot of cases you really could do so much better: you *have* a
"struct netfs_inode" to begin with, but you converted it to just
"struct inode *", and now you're converting it back.

Look at that AFS code, for example, where we have afs_vnode_cache() doing

        return netfs_i_cookie(&vnode->netfs.inode);

and look how it *had* a netfs structure, and it was passing it to a
netfs function, but it explicitly passed the WRONG TYPE, so now we've
lost the type information and it is using that cast to fake it all
back.

So I think the 'netfs' functions should take a 'struct netfs_inode
*ctx' as their argument.

Because the callers know what kind of inode they have, and they can -
and should - then pass the proper netfs context down.

IOW, I think you really should do something like the attached on top
of this all.

Only *very* lightly build-tested, but let me quote part of the diff to explain:

  -static inline struct fscache_cookie *netfs_i_cookie(struct inode *inode)
  +static inline struct fscache_cookie *netfs_i_cookie(struct netfs_inode *ctx)
   {
   #if IS_ENABLED(CONFIG_FSCACHE)
  -       struct netfs_inode *ctx = netfs_inode(inode);
          return ctx->cache;
   #else


look, this part is obvious. If you are doing a "netfs_i_cookie()"
call, you had *better* know that you actually have a netfs_inode, not
some random "inode".

And most of the users already knew exactly that, so other paths of the
patch actually get cleaner too:

  -       return netfs_i_cookie(&v9inode->netfs.inode);
  +       return netfs_i_cookie(&v9inode->netfs);

but even when that wasn't the case, as in netfs_inode_init() use, we have:

   static void v9fs_set_netfs_context(struct inode *inode)
   {
  -       netfs_inode_init(inode, &v9fs_req_ops);
  +       struct v9fs_inode *v9inode = V9FS_I(inode);
  +       netfs_inode_init(&v9inode->netfs, &v9fs_req_ops);
   }

and now we're basically doing that same "taek inode pointer, convert
it to someting else" that I'm complaining about wrt the netfs code,
but notice how we are now doing it within the context of the 9p
filesystem.

So now we're converting not a 'random inode pointer that could come
from many different filesystems', but an *actual* well-defined 'this
is a 9p inode, so doing that V9FS_I(inode) conversion is normal' kind
of situation.

And at that point, we now have that 'struct netfs_inode' directly, and
don't need to play any other games.

Yes, a few 'netfs_inode()' users still remain. I don't love them
either, but they tend to be places where we really did get just the
raw inode pointer from the VFS layer (eg netfs_readahead is just used
directly as the ".readahead" function for filesystems).

Hmm?

                    Linus

--000000000000cf586f05e10b00da
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l47k1pzq0>
X-Attachment-Id: f_l47k1pzq0

IGZzLzlwL3Y5ZnMuaCAgICAgICAgICAgICB8ICAyICstCiBmcy85cC92ZnNfYWRkci5jICAgICAg
ICAgfCAgMiArLQogZnMvOXAvdmZzX2lub2RlLmMgICAgICAgIHwgIDMgKystCiBmcy9hZnMvZHlu
cm9vdC5jICAgICAgICAgfCAgMiArLQogZnMvYWZzL2lub2RlLmMgICAgICAgICAgIHwgIDIgKy0K
IGZzL2Fmcy9pbnRlcm5hbC5oICAgICAgICB8ICAyICstCiBmcy9hZnMvd3JpdGUuYyAgICAgICAg
ICAgfCAgMiArLQogZnMvY2VwaC9hZGRyLmMgICAgICAgICAgIHwgIDMgKystCiBmcy9jZXBoL2Nh
Y2hlLmggICAgICAgICAgfCAgMiArLQogZnMvY2VwaC9pbm9kZS5jICAgICAgICAgIHwgIDIgKy0K
IGZzL2NpZnMvZnNjYWNoZS5oICAgICAgICB8ICAyICstCiBmcy9uZXRmcy9idWZmZXJlZF9yZWFk
LmMgfCAgNCArKy0tCiBpbmNsdWRlL2xpbnV4L25ldGZzLmggICAgfCAxNiArKysrKystLS0tLS0t
LS0tCiAxMyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9mcy85cC92OWZzLmggYi9mcy85cC92OWZzLmgKaW5kZXggMWIyMTljMjFk
MTVlLi42YWNhYmMyZTdkYzkgMTAwNjQ0Ci0tLSBhL2ZzLzlwL3Y5ZnMuaAorKysgYi9mcy85cC92
OWZzLmgKQEAgLTEyNCw3ICsxMjQsNyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCB2OWZzX2lub2Rl
ICpWOUZTX0koY29uc3Qgc3RydWN0IGlub2RlICppbm9kZSkKIHN0YXRpYyBpbmxpbmUgc3RydWN0
IGZzY2FjaGVfY29va2llICp2OWZzX2lub2RlX2Nvb2tpZShzdHJ1Y3Qgdjlmc19pbm9kZSAqdjlp
bm9kZSkKIHsKICNpZmRlZiBDT05GSUdfOVBfRlNDQUNIRQotCXJldHVybiBuZXRmc19pX2Nvb2tp
ZSgmdjlpbm9kZS0+bmV0ZnMuaW5vZGUpOworCXJldHVybiBuZXRmc19pX2Nvb2tpZSgmdjlpbm9k
ZS0+bmV0ZnMpOwogI2Vsc2UKIAlyZXR1cm4gTlVMTDsKICNlbmRpZgpkaWZmIC0tZ2l0IGEvZnMv
OXAvdmZzX2FkZHIuYyBiL2ZzLzlwL3Zmc19hZGRyLmMKaW5kZXggOTBjNmMxYmEwM2FiLi5jMDA0
YjlhNzNhOTIgMTAwNjQ0Ci0tLSBhL2ZzLzlwL3Zmc19hZGRyLmMKKysrIGIvZnMvOXAvdmZzX2Fk
ZHIuYwpAQCAtMjc0LDcgKzI3NCw3IEBAIHN0YXRpYyBpbnQgdjlmc193cml0ZV9iZWdpbihzdHJ1
Y3QgZmlsZSAqZmlscCwgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJICogZmlsZS4g
IFdlIG5lZWQgdG8gZG8gdGhpcyBiZWZvcmUgd2UgZ2V0IGEgbG9jayBvbiB0aGUgcGFnZSBpbiBj
YXNlCiAJICogdGhlcmUncyBtb3JlIHRoYW4gb25lIHdyaXRlciBjb21wZXRpbmcgZm9yIHRoZSBz
YW1lIGNhY2hlIGJsb2NrLgogCSAqLwotCXJldHZhbCA9IG5ldGZzX3dyaXRlX2JlZ2luKGZpbHAs
IG1hcHBpbmcsIHBvcywgbGVuLCAmZm9saW8sIGZzZGF0YSk7CisJcmV0dmFsID0gbmV0ZnNfd3Jp
dGVfYmVnaW4oJnY5aW5vZGUtPm5ldGZzLCBmaWxwLCBtYXBwaW5nLCBwb3MsIGxlbiwgJmZvbGlv
LCBmc2RhdGEpOwogCWlmIChyZXR2YWwgPCAwKQogCQlyZXR1cm4gcmV0dmFsOwogCmRpZmYgLS1n
aXQgYS9mcy85cC92ZnNfaW5vZGUuYyBiL2ZzLzlwL3Zmc19pbm9kZS5jCmluZGV4IGU2NjBjNjM0
OGI5ZC4uNDE5ZDJmM2NmMmMyIDEwMDY0NAotLS0gYS9mcy85cC92ZnNfaW5vZGUuYworKysgYi9m
cy85cC92ZnNfaW5vZGUuYwpAQCAtMjUyLDcgKzI1Miw4IEBAIHZvaWQgdjlmc19mcmVlX2lub2Rl
KHN0cnVjdCBpbm9kZSAqaW5vZGUpCiAgKi8KIHN0YXRpYyB2b2lkIHY5ZnNfc2V0X25ldGZzX2Nv
bnRleHQoc3RydWN0IGlub2RlICppbm9kZSkKIHsKLQluZXRmc19pbm9kZV9pbml0KGlub2RlLCAm
djlmc19yZXFfb3BzKTsKKwlzdHJ1Y3Qgdjlmc19pbm9kZSAqdjlpbm9kZSA9IFY5RlNfSShpbm9k
ZSk7CisJbmV0ZnNfaW5vZGVfaW5pdCgmdjlpbm9kZS0+bmV0ZnMsICZ2OWZzX3JlcV9vcHMpOwog
fQogCiBpbnQgdjlmc19pbml0X2lub2RlKHN0cnVjdCB2OWZzX3Nlc3Npb25faW5mbyAqdjlzZXMs
CmRpZmYgLS1naXQgYS9mcy9hZnMvZHlucm9vdC5jIGIvZnMvYWZzL2R5bnJvb3QuYwppbmRleCAz
YTViYmZmZGYwNTMuLmQ3ZDk0MDJmZjcxOCAxMDA2NDQKLS0tIGEvZnMvYWZzL2R5bnJvb3QuYwor
KysgYi9mcy9hZnMvZHlucm9vdC5jCkBAIC03Niw3ICs3Niw3IEBAIHN0cnVjdCBpbm9kZSAqYWZz
X2lnZXRfcHNldWRvX2RpcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBib29sIHJvb3QpCiAJLyog
dGhlcmUgc2hvdWxkbid0IGJlIGFuIGV4aXN0aW5nIGlub2RlICovCiAJQlVHX09OKCEoaW5vZGUt
Pmlfc3RhdGUgJiBJX05FVykpOwogCi0JbmV0ZnNfaW5vZGVfaW5pdChpbm9kZSwgTlVMTCk7CisJ
bmV0ZnNfaW5vZGVfaW5pdCgmdm5vZGUtPm5ldGZzLCBOVUxMKTsKIAlpbm9kZS0+aV9zaXplCQk9
IDA7CiAJaW5vZGUtPmlfbW9kZQkJPSBTX0lGRElSIHwgU19JUlVHTyB8IFNfSVhVR087CiAJaWYg
KHJvb3QpIHsKZGlmZiAtLWdpdCBhL2ZzL2Fmcy9pbm9kZS5jIGIvZnMvYWZzL2lub2RlLmMKaW5k
ZXggMjI4MTFlOWVhY2Y1Li44OTYzMGFjYmMyY2MgMTAwNjQ0Ci0tLSBhL2ZzL2Fmcy9pbm9kZS5j
CisrKyBiL2ZzL2Fmcy9pbm9kZS5jCkBAIC01OCw3ICs1OCw3IEBAIHN0YXRpYyBub2lubGluZSB2
b2lkIGR1bXBfdm5vZGUoc3RydWN0IGFmc192bm9kZSAqdm5vZGUsIHN0cnVjdCBhZnNfdm5vZGUg
KnBhcmVuCiAgKi8KIHN0YXRpYyB2b2lkIGFmc19zZXRfbmV0ZnNfY29udGV4dChzdHJ1Y3QgYWZz
X3Zub2RlICp2bm9kZSkKIHsKLQluZXRmc19pbm9kZV9pbml0KCZ2bm9kZS0+bmV0ZnMuaW5vZGUs
ICZhZnNfcmVxX29wcyk7CisJbmV0ZnNfaW5vZGVfaW5pdCgmdm5vZGUtPm5ldGZzLCAmYWZzX3Jl
cV9vcHMpOwogfQogCiAvKgpkaWZmIC0tZ2l0IGEvZnMvYWZzL2ludGVybmFsLmggYi9mcy9hZnMv
aW50ZXJuYWwuaAppbmRleCA5ODRiMTEzYTkxMDcuLmE2ZjI1ZDllNzViNSAxMDA2NDQKLS0tIGEv
ZnMvYWZzL2ludGVybmFsLmgKKysrIGIvZnMvYWZzL2ludGVybmFsLmgKQEAgLTY3MCw3ICs2NzAs
NyBAQCBzdHJ1Y3QgYWZzX3Zub2RlIHsKIHN0YXRpYyBpbmxpbmUgc3RydWN0IGZzY2FjaGVfY29v
a2llICphZnNfdm5vZGVfY2FjaGUoc3RydWN0IGFmc192bm9kZSAqdm5vZGUpCiB7CiAjaWZkZWYg
Q09ORklHX0FGU19GU0NBQ0hFCi0JcmV0dXJuIG5ldGZzX2lfY29va2llKCZ2bm9kZS0+bmV0ZnMu
aW5vZGUpOworCXJldHVybiBuZXRmc19pX2Nvb2tpZSgmdm5vZGUtPm5ldGZzKTsKICNlbHNlCiAJ
cmV0dXJuIE5VTEw7CiAjZW5kaWYKZGlmZiAtLWdpdCBhL2ZzL2Fmcy93cml0ZS5jIGIvZnMvYWZz
L3dyaXRlLmMKaW5kZXggZjgwYTYwOTZkOTFjLi4yYzg4NWIyMmRlMzQgMTAwNjQ0Ci0tLSBhL2Zz
L2Fmcy93cml0ZS5jCisrKyBiL2ZzL2Fmcy93cml0ZS5jCkBAIC02MCw3ICs2MCw3IEBAIGludCBh
ZnNfd3JpdGVfYmVnaW4oc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICpt
YXBwaW5nLAogCSAqIGZpbGUuICBXZSBuZWVkIHRvIGRvIHRoaXMgYmVmb3JlIHdlIGdldCBhIGxv
Y2sgb24gdGhlIHBhZ2UgaW4gY2FzZQogCSAqIHRoZXJlJ3MgbW9yZSB0aGFuIG9uZSB3cml0ZXIg
Y29tcGV0aW5nIGZvciB0aGUgc2FtZSBjYWNoZSBibG9jay4KIAkgKi8KLQlyZXQgPSBuZXRmc193
cml0ZV9iZWdpbihmaWxlLCBtYXBwaW5nLCBwb3MsIGxlbiwgJmZvbGlvLCBmc2RhdGEpOworCXJl
dCA9IG5ldGZzX3dyaXRlX2JlZ2luKCZ2bm9kZS0+bmV0ZnMsIGZpbGUsIG1hcHBpbmcsIHBvcywg
bGVuLCAmZm9saW8sIGZzZGF0YSk7CiAJaWYgKHJldCA8IDApCiAJCXJldHVybiByZXQ7CiAKZGlm
ZiAtLWdpdCBhL2ZzL2NlcGgvYWRkci5jIGIvZnMvY2VwaC9hZGRyLmMKaW5kZXggZjVmMTE2ZWQx
YjllLi45NzYzZTdlYTgxNDggMTAwNjQ0Ci0tLSBhL2ZzL2NlcGgvYWRkci5jCisrKyBiL2ZzL2Nl
cGgvYWRkci5jCkBAIC0xMzIyLDEwICsxMzIyLDExIEBAIHN0YXRpYyBpbnQgY2VwaF93cml0ZV9i
ZWdpbihzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJ
CQkgICAgc3RydWN0IHBhZ2UgKipwYWdlcCwgdm9pZCAqKmZzZGF0YSkKIHsKIAlzdHJ1Y3QgaW5v
ZGUgKmlub2RlID0gZmlsZV9pbm9kZShmaWxlKTsKKwlzdHJ1Y3QgY2VwaF9pbm9kZV9pbmZvICpj
aSA9IGNlcGhfaW5vZGUoaW5vZGUpOwogCXN0cnVjdCBmb2xpbyAqZm9saW8gPSBOVUxMOwogCWlu
dCByOwogCi0JciA9IG5ldGZzX3dyaXRlX2JlZ2luKGZpbGUsIGlub2RlLT5pX21hcHBpbmcsIHBv
cywgbGVuLCAmZm9saW8sIE5VTEwpOworCXIgPSBuZXRmc193cml0ZV9iZWdpbigmY2ktPm5ldGZz
LCBmaWxlLCBpbm9kZS0+aV9tYXBwaW5nLCBwb3MsIGxlbiwgJmZvbGlvLCBOVUxMKTsKIAlpZiAo
ciA9PSAwKQogCQlmb2xpb193YWl0X2ZzY2FjaGUoZm9saW8pOwogCWlmIChyIDwgMCkgewpkaWZm
IC0tZ2l0IGEvZnMvY2VwaC9jYWNoZS5oIGIvZnMvY2VwaC9jYWNoZS5oCmluZGV4IDI2YzZhZTA2
ZTJmNC4uZGM1MDJkYWFjNDlhIDEwMDY0NAotLS0gYS9mcy9jZXBoL2NhY2hlLmgKKysrIGIvZnMv
Y2VwaC9jYWNoZS5oCkBAIC0yOCw3ICsyOCw3IEBAIHZvaWQgY2VwaF9mc2NhY2hlX2ludmFsaWRh
dGUoc3RydWN0IGlub2RlICppbm9kZSwgYm9vbCBkaW9fd3JpdGUpOwogCiBzdGF0aWMgaW5saW5l
IHN0cnVjdCBmc2NhY2hlX2Nvb2tpZSAqY2VwaF9mc2NhY2hlX2Nvb2tpZShzdHJ1Y3QgY2VwaF9p
bm9kZV9pbmZvICpjaSkKIHsKLQlyZXR1cm4gbmV0ZnNfaV9jb29raWUoJmNpLT5uZXRmcy5pbm9k
ZSk7CisJcmV0dXJuIG5ldGZzX2lfY29va2llKCZjaS0+bmV0ZnMpOwogfQogCiBzdGF0aWMgaW5s
aW5lIHZvaWQgY2VwaF9mc2NhY2hlX3Jlc2l6ZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3Qg
dG8pCmRpZmYgLS1naXQgYS9mcy9jZXBoL2lub2RlLmMgYi9mcy9jZXBoL2lub2RlLmMKaW5kZXgg
NjUwNzQ2YjNiYTk5Li41NmM1M2FiMzYxOGUgMTAwNjQ0Ci0tLSBhL2ZzL2NlcGgvaW5vZGUuYwor
KysgYi9mcy9jZXBoL2lub2RlLmMKQEAgLTQ2MCw3ICs0NjAsNyBAQCBzdHJ1Y3QgaW5vZGUgKmNl
cGhfYWxsb2NfaW5vZGUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKIAlkb3V0KCJhbGxvY19pbm9k
ZSAlcFxuIiwgJmNpLT5uZXRmcy5pbm9kZSk7CiAKIAkvKiBTZXQgcGFyYW1ldGVycyBmb3IgdGhl
IG5ldGZzIGxpYnJhcnkgKi8KLQluZXRmc19pbm9kZV9pbml0KCZjaS0+bmV0ZnMuaW5vZGUsICZj
ZXBoX25ldGZzX29wcyk7CisJbmV0ZnNfaW5vZGVfaW5pdCgmY2ktPm5ldGZzLCAmY2VwaF9uZXRm
c19vcHMpOwogCiAJc3Bpbl9sb2NrX2luaXQoJmNpLT5pX2NlcGhfbG9jayk7CiAKZGlmZiAtLWdp
dCBhL2ZzL2NpZnMvZnNjYWNoZS5oIGIvZnMvY2lmcy9mc2NhY2hlLmgKaW5kZXggYWI5YTUxZDAx
MjVjLi5hYTNiOTQxYTU1NTUgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvZnNjYWNoZS5oCisrKyBiL2Zz
L2NpZnMvZnNjYWNoZS5oCkBAIC02MSw3ICs2MSw3IEBAIHZvaWQgY2lmc19mc2NhY2hlX2ZpbGxf
Y29oZXJlbmN5KHN0cnVjdCBpbm9kZSAqaW5vZGUsCiAKIHN0YXRpYyBpbmxpbmUgc3RydWN0IGZz
Y2FjaGVfY29va2llICpjaWZzX2lub2RlX2Nvb2tpZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQogewot
CXJldHVybiBuZXRmc19pX2Nvb2tpZShpbm9kZSk7CisJcmV0dXJuIG5ldGZzX2lfY29va2llKCZD
SUZTX0koaW5vZGUpLT5uZXRmcyk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBjaWZzX2ludmFs
aWRhdGVfY2FjaGUoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgaW50IGZsYWdzKQpkaWZm
IC0tZ2l0IGEvZnMvbmV0ZnMvYnVmZmVyZWRfcmVhZC5jIGIvZnMvbmV0ZnMvYnVmZmVyZWRfcmVh
ZC5jCmluZGV4IGQzN2UwMTIzODZmMy4uMmFjY2JhNmVlOWE3IDEwMDY0NAotLS0gYS9mcy9uZXRm
cy9idWZmZXJlZF9yZWFkLmMKKysrIGIvZnMvbmV0ZnMvYnVmZmVyZWRfcmVhZC5jCkBAIC0zMjYs
MTIgKzMyNiwxMiBAQCBzdGF0aWMgYm9vbCBuZXRmc19za2lwX2ZvbGlvX3JlYWQoc3RydWN0IGZv
bGlvICpmb2xpbywgbG9mZl90IHBvcywgc2l6ZV90IGxlbiwKICAqCiAgKiBUaGlzIGlzIHVzYWJs
ZSB3aGV0aGVyIG9yIG5vdCBjYWNoaW5nIGlzIGVuYWJsZWQuCiAgKi8KLWludCBuZXRmc193cml0
ZV9iZWdpbihzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcs
CitpbnQgbmV0ZnNfd3JpdGVfYmVnaW4oc3RydWN0IG5ldGZzX2lub2RlICpjdHgsCisJCSAgICAg
IHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywKIAkJICAg
ICAgbG9mZl90IHBvcywgdW5zaWduZWQgaW50IGxlbiwgc3RydWN0IGZvbGlvICoqX2ZvbGlvLAog
CQkgICAgICB2b2lkICoqX2ZzZGF0YSkKIHsKIAlzdHJ1Y3QgbmV0ZnNfaW9fcmVxdWVzdCAqcnJl
cTsKLQlzdHJ1Y3QgbmV0ZnNfaW5vZGUgKmN0eCA9IG5ldGZzX2lub2RlKGZpbGVfaW5vZGUoZmls
ZSApKTsKIAlzdHJ1Y3QgZm9saW8gKmZvbGlvOwogCXVuc2lnbmVkIGludCBmZ3BfZmxhZ3MgPSBG
R1BfTE9DSyB8IEZHUF9XUklURSB8IEZHUF9DUkVBVCB8IEZHUF9TVEFCTEU7CiAJcGdvZmZfdCBp
bmRleCA9IHBvcyA+PiBQQUdFX1NISUZUOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9uZXRm
cy5oIGIvaW5jbHVkZS9saW51eC9uZXRmcy5oCmluZGV4IDZkYmI0YzljZTUwZC4uZDBlNjBiMmFi
NWJjIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L25ldGZzLmgKKysrIGIvaW5jbHVkZS9saW51
eC9uZXRmcy5oCkBAIC0yNzcsNyArMjc3LDggQEAgc3RydWN0IG5ldGZzX2NhY2hlX29wcyB7CiBz
dHJ1Y3QgcmVhZGFoZWFkX2NvbnRyb2w7CiBleHRlcm4gdm9pZCBuZXRmc19yZWFkYWhlYWQoc3Ry
dWN0IHJlYWRhaGVhZF9jb250cm9sICopOwogaW50IG5ldGZzX3JlYWRfZm9saW8oc3RydWN0IGZp
bGUgKiwgc3RydWN0IGZvbGlvICopOwotZXh0ZXJuIGludCBuZXRmc193cml0ZV9iZWdpbihzdHJ1
Y3QgZmlsZSAqLCBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqLAorZXh0ZXJuIGludCBuZXRmc193cml0
ZV9iZWdpbihzdHJ1Y3QgbmV0ZnNfaW5vZGUgKiwKKwkJCSAgICAgc3RydWN0IGZpbGUgKiwgc3Ry
dWN0IGFkZHJlc3Nfc3BhY2UgKiwKIAkJCSAgICAgbG9mZl90LCB1bnNpZ25lZCBpbnQsIHN0cnVj
dCBmb2xpbyAqKiwKIAkJCSAgICAgdm9pZCAqKik7CiAKQEAgLTMwOCwxMyArMzA5LDExIEBAIHN0
YXRpYyBpbmxpbmUgc3RydWN0IG5ldGZzX2lub2RlICpuZXRmc19pbm9kZShzdHJ1Y3QgaW5vZGUg
Kmlub2RlKQogICogSW5pdGlhbGlzZSB0aGUgbmV0ZnMgbGlicmFyeSBjb250ZXh0IHN0cnVjdC4g
IFRoaXMgaXMgZXhwZWN0ZWQgdG8gZm9sbG93IG9uCiAgKiBkaXJlY3RseSBmcm9tIHRoZSBWRlMg
aW5vZGUgc3RydWN0LgogICovCi1zdGF0aWMgaW5saW5lIHZvaWQgbmV0ZnNfaW5vZGVfaW5pdChz
dHJ1Y3QgaW5vZGUgKmlub2RlLAorc3RhdGljIGlubGluZSB2b2lkIG5ldGZzX2lub2RlX2luaXQo
c3RydWN0IG5ldGZzX2lub2RlICpjdHgsCiAJCQkJICAgIGNvbnN0IHN0cnVjdCBuZXRmc19yZXF1
ZXN0X29wcyAqb3BzKQogewotCXN0cnVjdCBuZXRmc19pbm9kZSAqY3R4ID0gbmV0ZnNfaW5vZGUo
aW5vZGUpOwotCiAJY3R4LT5vcHMgPSBvcHM7Ci0JY3R4LT5yZW1vdGVfaV9zaXplID0gaV9zaXpl
X3JlYWQoaW5vZGUpOworCWN0eC0+cmVtb3RlX2lfc2l6ZSA9IGlfc2l6ZV9yZWFkKCZjdHgtPmlu
b2RlKTsKICNpZiBJU19FTkFCTEVEKENPTkZJR19GU0NBQ0hFKQogCWN0eC0+Y2FjaGUgPSBOVUxM
OwogI2VuZGlmCkBAIC0zMjcsMTAgKzMyNiw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBuZXRmc19p
bm9kZV9pbml0KHN0cnVjdCBpbm9kZSAqaW5vZGUsCiAgKgogICogSW5mb3JtIHRoZSBuZXRmcyBs
aWIgdGhhdCBhIGZpbGUgZ290IHJlc2l6ZWQgc28gdGhhdCBpdCBjYW4gYWRqdXN0IGl0cyBzdGF0
ZS4KICAqLwotc3RhdGljIGlubGluZSB2b2lkIG5ldGZzX3Jlc2l6ZV9maWxlKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIGxvZmZfdCBuZXdfaV9zaXplKQorc3RhdGljIGlubGluZSB2b2lkIG5ldGZzX3Jl
c2l6ZV9maWxlKHN0cnVjdCBuZXRmc19pbm9kZSAqY3R4LCBsb2ZmX3QgbmV3X2lfc2l6ZSkKIHsK
LQlzdHJ1Y3QgbmV0ZnNfaW5vZGUgKmN0eCA9IG5ldGZzX2lub2RlKGlub2RlKTsKLQogCWN0eC0+
cmVtb3RlX2lfc2l6ZSA9IG5ld19pX3NpemU7CiB9CiAKQEAgLTM0MCwxMCArMzM3LDkgQEAgc3Rh
dGljIGlubGluZSB2b2lkIG5ldGZzX3Jlc2l6ZV9maWxlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxv
ZmZfdCBuZXdfaV9zaXplKQogICoKICAqIEdldCB0aGUgY2FjaGluZyBjb29raWUgKGlmIGVuYWJs
ZWQpIGZyb20gdGhlIG5ldHdvcmsgZmlsZXN5c3RlbSdzIGlub2RlLgogICovCi1zdGF0aWMgaW5s
aW5lIHN0cnVjdCBmc2NhY2hlX2Nvb2tpZSAqbmV0ZnNfaV9jb29raWUoc3RydWN0IGlub2RlICpp
bm9kZSkKK3N0YXRpYyBpbmxpbmUgc3RydWN0IGZzY2FjaGVfY29va2llICpuZXRmc19pX2Nvb2tp
ZShzdHJ1Y3QgbmV0ZnNfaW5vZGUgKmN0eCkKIHsKICNpZiBJU19FTkFCTEVEKENPTkZJR19GU0NB
Q0hFKQotCXN0cnVjdCBuZXRmc19pbm9kZSAqY3R4ID0gbmV0ZnNfaW5vZGUoaW5vZGUpOwogCXJl
dHVybiBjdHgtPmNhY2hlOwogI2Vsc2UKIAlyZXR1cm4gTlVMTDsK
--000000000000cf586f05e10b00da--
