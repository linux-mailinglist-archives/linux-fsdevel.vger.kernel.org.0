Return-Path: <linux-fsdevel+bounces-9224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B6E83F045
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 22:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789AF1C21686
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 21:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2021B7E4;
	Sat, 27 Jan 2024 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PcR1edxN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726241B295
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392075; cv=none; b=PGL4y87ukmtQstJ4i7QPCU+8WArvRgSlRd2PcLgwrgXxVx67Bt0YU93uHX2i3xldYYSEplYE1w8db7jj/H1X9/EcO1Y1w9gthdQoUpuo2pse73QKetrXx/X/V4uKGdclOS7c5FGjUrRixH2F3YHcuPfUOpJt2kmCVvLFyx+U8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392075; c=relaxed/simple;
	bh=cWMIXOib9nzT4MkyOUG6ixPqlyMdXgTkM+grMrK09KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5w9ypjOyJno+cAh8hWPCNBg9G2D7xzldTAKjrwGqnEl/MSLh8/rp20KIfEdrr+oqSLioOlwd6YmBsPp0KCG9kAhv6Y8rFHCAf6iPJS8fiQeRu5fuRPa7/xSsyxHvIWUdOYYRiipKlFWfNzgo8C6bwb0Mqg4HAmZIk1EDqbVWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PcR1edxN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55d2d9fe0e0so1429652a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 13:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706392071; x=1706996871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJaXnA9SaBOMDvn0nFXjX3qZzDFfCPfxhRCkv0UC/L0=;
        b=PcR1edxNVXO2i1ZYw3PAL5Eg3pfmGEK64e8hS2wSyWg9VmYEF8grxx3LHD9inFLZ/N
         ceU/2wQve1J8UntOaCQWiQnB6PVedySx51/CUDd9+cAeGrynsp48FxVSCNz7NZC9CgsH
         F72gUR9TocNfuIQrwr4naZ+uPBrQunZzlVrBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706392071; x=1706996871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJaXnA9SaBOMDvn0nFXjX3qZzDFfCPfxhRCkv0UC/L0=;
        b=fx8N57tpc5XZRAIEDEZ8RTl+pLRpBXn8C72J6wPBZzo9V46hEdxEMmYqpiwKaVc8R+
         FRJFwhXHIswD5k9UR5pcqCmmyF28RCbKWEedGzwo1x4fpE5OGt2T+3nF1901bEis6zv1
         4w3JKZ9rRGVrfV1hCSHQTeN5V4iFg4cPT4sSR9B1BToZDNwxUFPUjJpIP9WSRDdIdilY
         u5pPFoXJSX56R7YZaTzsh7TPUw1TOrXHqUWLcM/NCYCWQOQLg3bIWC0GewRjo2F7jnSQ
         RHbpuXIA2L2wOjhYMKMFC+TyQ37M/mNzsvQezuHbB2l713nrtxbttSKr22NNo9Qrqwfh
         p1/A==
X-Gm-Message-State: AOJu0YwLsUw5Ff7MPa2OirWDVDmOqCa/ks2TnJ3EeTpjQZJnpbQ+FQcH
	S3vknzxF54cLaX6FSw1ggc+g23ShndXsL2BXyW0sUDSsHg1nFC0QukEbLUv9D0JnGlzuFMVtcew
	1JKQaKQ==
X-Google-Smtp-Source: AGHT+IGAoo0tLHWbjPtb0kEsfc3tdMgAT5IzLqBnAhwkYxvtRbbcBjYW9eBzJxlVDdPYwvmHS63HyA==
X-Received: by 2002:a17:906:ae55:b0:a30:dae4:e27f with SMTP id lf21-20020a170906ae5500b00a30dae4e27fmr1335436ejb.10.1706392071456;
        Sat, 27 Jan 2024 13:47:51 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id ch21-20020a170906c2d500b00a317346a353sm2113335ejb.123.2024.01.27.13.47.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 13:47:49 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55eb099e299so502308a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 13:47:49 -0800 (PST)
X-Received: by 2002:a05:6402:b10:b0:55e:dc7a:1f14 with SMTP id
 bm16-20020a0564020b1000b0055edc7a1f14mr207718edb.25.1706392068765; Sat, 27
 Jan 2024 13:47:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
In-Reply-To: <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Jan 2024 13:47:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
Message-ID: <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001ba36b060ff45d93"

--0000000000001ba36b060ff45d93
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 13:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> For example, what purpose does 'e->dentry' and 'ei->d_childen[]' have?
> Isn't that entirely a left-over from the bad old days?
>
> So please try to look at things to *fix* and simplify, not at things
> to mess around with and make more complicated.

So here's an attempt at some fairly trivial but entirely untested cleanup.

I have *not* tested this at all, and I assume you have some extensive
test-suite that you run. So these are "signed-off' in the sense that
the patch looks fine, it builds in one configuration for me, but maybe
there's something really odd going on.

The first patch is trivial dead code removal.

The second patch is because I really do not understand the reason for
the 'ei->dentry' pointer, and it just looks messy.

It looks _particularly_ messy when it is mixed up in operations that
really do not need it and really shouldn't use it.

The eventfs_find_events() code was using the dentry parent pointer to
find the parent (fine, and simple), then looking up the tracefs inode
using that (fine so far), but then it looked up the dentry using
*that*. But it already *had* the dentry - it's that parent dentry it
just used to find the tracefs inode. The code looked nonsensical.

Similarly, it then (in the set_top_events_ownership() helper) used
'ei->dentry' to update the events attr, but all that really wants is
the superblock root. So instead of passing a dentry, just pass the
superblock pointer, which you can find in either the dentry or in the
VFS inode, depending on which level you're working at.

There are tons of other 'ei->dentry' uses, and I didn't look at those.
Baby steps. But this *seems* like an obvious cleanup, and many small
obvious cleanups later and perhaps the 'ei->dentry' pointer (and the
'->d_children[]' array) can eventually go away. They should all be
entirely useless - there's really no reason for a filesystem to hold
on to back-pointers of dentries.

Anybody willing to run the test-suite on this?

                    Linus

--0000000000001ba36b060ff45d93
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-tracefs-remove-stale-update_gid-code.patch"
Content-Disposition: attachment; 
	filename="0001-tracefs-remove-stale-update_gid-code.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lrwlqrt70>
X-Attachment-Id: f_lrwlqrt70

RnJvbSBkNzQxY2JmMDM4MDM0ZTM5YTY3YzllNjFjYzljZGMzOTMxYjJhN2EzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgMjcgSmFuIDIwMjQgMTM6MjE6MTQgLTA4MDAKU3ViamVjdDog
W1BBVENIIDEvMl0gdHJhY2VmczogcmVtb3ZlIHN0YWxlICd1cGRhdGVfZ2lkJyBjb2RlCgpUaGUg
J2V2ZW50ZnNfdXBkYXRlX2dpZCgpJyBmdW5jdGlvbiBpcyBubyBsb25nZXIgY2FsbGVkLCBzbyBy
ZW1vdmUgaXQKKGFuZCB0aGUgaGVscGVyIGZ1bmN0aW9uIGl0IHVzZXMpLgoKRml4ZXM6IDgxODZm
ZmY3YWI2NCAoInRyYWNlZnMvZXZlbnRmczogVXNlIHJvb3QgYW5kIGluc3RhbmNlIGlub2RlcyBh
cyBkZWZhdWx0IG93bmVyc2hpcCIpClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2
YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBmcy90cmFjZWZzL2V2ZW50X2lub2RlLmMg
fCAzOCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogZnMvdHJhY2Vmcy9p
bnRlcm5hbC5oICAgIHwgIDEgLQogMiBmaWxlcyBjaGFuZ2VkLCAzOSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9mcy90cmFjZWZzL2V2ZW50X2lub2RlLmMgYi9mcy90cmFjZWZzL2V2ZW50X2lu
b2RlLmMKaW5kZXggNmIyMTE1MjJhMTNlLi4xYzNkZDBhZDQ2NjAgMTAwNjQ0Ci0tLSBhL2ZzL3Ry
YWNlZnMvZXZlbnRfaW5vZGUuYworKysgYi9mcy90cmFjZWZzL2V2ZW50X2lub2RlLmMKQEAgLTI4
MSw0NCArMjgxLDYgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2lub2RlX2F0dHIoc3RydWN0IGRlbnRy
eSAqZGVudHJ5LCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCQlpbm9kZS0+aV9naWQgPSBhdHRyLT5n
aWQ7CiB9CiAKLXN0YXRpYyB2b2lkIHVwZGF0ZV9naWQoc3RydWN0IGV2ZW50ZnNfaW5vZGUgKmVp
LCBrZ2lkX3QgZ2lkLCBpbnQgbGV2ZWwpCi17Ci0Jc3RydWN0IGV2ZW50ZnNfaW5vZGUgKmVpX2No
aWxkOwotCi0JLyogYXQgbW9zdCB3ZSBoYXZlIGV2ZW50cy9zeXN0ZW0vZXZlbnQgKi8KLQlpZiAo
V0FSTl9PTl9PTkNFKGxldmVsID4gMykpCi0JCXJldHVybjsKLQotCWVpLT5hdHRyLmdpZCA9IGdp
ZDsKLQotCWlmIChlaS0+ZW50cnlfYXR0cnMpIHsKLQkJZm9yIChpbnQgaSA9IDA7IGkgPCBlaS0+
bnJfZW50cmllczsgaSsrKSB7Ci0JCQllaS0+ZW50cnlfYXR0cnNbaV0uZ2lkID0gZ2lkOwotCQl9
Ci0JfQotCi0JLyoKLQkgKiBPbmx5IGV2ZW50ZnNfaW5vZGUgd2l0aCBkZW50cmllcyBhcmUgdXBk
YXRlZCwgbWFrZSBzdXJlCi0JICogYWxsIGV2ZW50ZnNfaW5vZGVzIGFyZSB1cGRhdGVkLiBJZiBv
bmUgb2YgdGhlIGNoaWxkcmVuCi0JICogZG8gbm90IGhhdmUgYSBkZW50cnksIHRoaXMgZnVuY3Rp
b24gbXVzdCB0cmF2ZXJzZSBpdC4KLQkgKi8KLQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NyY3UoZWlf
Y2hpbGQsICZlaS0+Y2hpbGRyZW4sIGxpc3QsCi0JCQkJIHNyY3VfcmVhZF9sb2NrX2hlbGQoJmV2
ZW50ZnNfc3JjdSkpIHsKLQkJaWYgKCFlaV9jaGlsZC0+ZGVudHJ5KQotCQkJdXBkYXRlX2dpZChl
aV9jaGlsZCwgZ2lkLCBsZXZlbCArIDEpOwotCX0KLX0KLQotdm9pZCBldmVudGZzX3VwZGF0ZV9n
aWQoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBrZ2lkX3QgZ2lkKQotewotCXN0cnVjdCBldmVudGZz
X2lub2RlICplaSA9IGRlbnRyeS0+ZF9mc2RhdGE7Ci0JaW50IGlkeDsKLQotCWlkeCA9IHNyY3Vf
cmVhZF9sb2NrKCZldmVudGZzX3NyY3UpOwotCXVwZGF0ZV9naWQoZWksIGdpZCwgMCk7Ci0Jc3Jj
dV9yZWFkX3VubG9jaygmZXZlbnRmc19zcmN1LCBpZHgpOwotfQotCiAvKioKICAqIGNyZWF0ZV9m
aWxlIC0gY3JlYXRlIGEgZmlsZSBpbiB0aGUgdHJhY2VmcyBmaWxlc3lzdGVtCiAgKiBAbmFtZTog
dGhlIG5hbWUgb2YgdGhlIGZpbGUgdG8gY3JlYXRlLgpkaWZmIC0tZ2l0IGEvZnMvdHJhY2Vmcy9p
bnRlcm5hbC5oIGIvZnMvdHJhY2Vmcy9pbnRlcm5hbC5oCmluZGV4IDQ1Mzk3ZGY5YmI2NS4uOTFj
MmJmMGI5MWQ5IDEwMDY0NAotLS0gYS9mcy90cmFjZWZzL2ludGVybmFsLmgKKysrIGIvZnMvdHJh
Y2Vmcy9pbnRlcm5hbC5oCkBAIC04Miw3ICs4Miw2IEBAIHN0cnVjdCBpbm9kZSAqdHJhY2Vmc19n
ZXRfaW5vZGUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYik7CiBzdHJ1Y3QgZGVudHJ5ICpldmVudGZz
X3N0YXJ0X2NyZWF0aW5nKGNvbnN0IGNoYXIgKm5hbWUsIHN0cnVjdCBkZW50cnkgKnBhcmVudCk7
CiBzdHJ1Y3QgZGVudHJ5ICpldmVudGZzX2ZhaWxlZF9jcmVhdGluZyhzdHJ1Y3QgZGVudHJ5ICpk
ZW50cnkpOwogc3RydWN0IGRlbnRyeSAqZXZlbnRmc19lbmRfY3JlYXRpbmcoc3RydWN0IGRlbnRy
eSAqZGVudHJ5KTsKLXZvaWQgZXZlbnRmc191cGRhdGVfZ2lkKHN0cnVjdCBkZW50cnkgKmRlbnRy
eSwga2dpZF90IGdpZCk7CiB2b2lkIGV2ZW50ZnNfc2V0X2VpX3N0YXR1c19mcmVlKHN0cnVjdCB0
cmFjZWZzX2lub2RlICp0aSwgc3RydWN0IGRlbnRyeSAqZGVudHJ5KTsKIAogI2VuZGlmIC8qIF9U
UkFDRUZTX0lOVEVSTkFMX0ggKi8KLS0gCjIuNDMuMC41LmczOGZiMTM3YmRiCgo=
--0000000000001ba36b060ff45d93
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-tracefs-avoid-using-the-ei-dentry-pointer-unnecessar.patch"
Content-Disposition: attachment; 
	filename="0002-tracefs-avoid-using-the-ei-dentry-pointer-unnecessar.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lrwlr2bz1>
X-Attachment-Id: f_lrwlr2bz1

RnJvbSA0OWIwMDg0ZTAyMjM1OWYwOTdjMDk1NjljMTk5ZmM3ZGZlY2Q0N2U5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgMjcgSmFuIDIwMjQgMTM6Mjc6MDEgLTA4MDAKU3ViamVjdDog
W1BBVENIIDIvMl0gdHJhY2VmczogYXZvaWQgdXNpbmcgdGhlIGVpLT5kZW50cnkgcG9pbnRlciB1
bm5lY2Vzc2FyaWx5CgpUaGUgZXZlbnRmc19maW5kX2V2ZW50cygpIGNvZGUgdHJpZXMgdG8gd2Fs
ayB1cCB0aGUgdHJlZSB0byBmaW5kIHRoZQpldmVudCBkaXJlY3RvcnkgdGhhdCBhIGRlbnRyeSBi
ZWxvbmdzIHRvLCBpbiBvcmRlciB0byB0aGVuIGZpbmQgdGhlCmV2ZW50ZnMgaW5vZGUgdGhhdCBp
cyBhc3NvY2lhdGVkIHdpdGggdGhhdCBldmVudCBkaXJlY3RvcnkuCgpIb3dldmVyLCBpdCB1c2Vz
IGFuIG9kZCBjb21iaW5hdGlvbiBvZiB3YWxraW5nIHRoZSBkZW50cnkgcGFyZW50LApsb29raW5n
IHVwIHRoZSBldmVudGZzIGlub2RlIGFzc29jaWF0ZWQgd2l0aCB0aGF0LCBhbmQgdGhlbiBsb29r
aW5nIHVwCnRoZSBkZW50cnkgZnJvbSB0aGVyZS4gIFJlcGVhdC4KCkJ1dCB0aGUgY29kZSBzaG91
bGRuJ3QgaGF2ZSBiYWNrLXBvaW50ZXJzIHRvIGRlbnRyaWVzIGluIHRoZSBmaXJzdApwbGFjZSwg
YW5kIGl0IHNob3VsZCBqdXN0IHdhbGsgdGhlIGRlbnRyeSBwYXJlbnRob29kIGNoYWluIGRpcmVj
dGx5LgoKU2ltaWxhcmx5LCAnc2V0X3RvcF9ldmVudHNfb3duZXJzaGlwKCknIGxvb2tzIHVwIHRo
ZSBkZW50cnkgZnJvbSB0aGUKZXZlbnRmcyBpbm9kZSwgYnV0IHRoZSBvbmx5IHJlYXNvbiBpdCB3
YW50cyBhIGRlbnRyeSBpcyB0byBsb29rIHVwIHRoZQpzdXBlcmJsb2NrIGluIG9yZGVyIHRvIGxv
b2sgdXAgdGhlIHJvb3QgZGVudHJ5LgoKQnV0IGl0IGFscmVhZHkgaGFzIHRoZSByZWFsIGZpbGVz
eXN0ZW0gaW5vZGUsIHdoaWNoIGhhcyB0aGF0IHNhbWUKc3VwZXJibG9jayBwb2ludGVyLiAgU28g
anVzdCBwYXNzIGluIHRoZSBzdXBlcmJsb2NrIHBvaW50ZXIgdXNpbmcgdGhlCmluZm9ybWF0aW9u
IHRoYXQncyBhbHJlYWR5IHRoZXJlLCBpbnN0ZWFkIG9mIGxvb2tpbmcgdXAgZXh0cmFuZW91cyBk
YXRhCnRoYXQgaXMgaXJyZWxldmFudC4KClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0
b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBmcy90cmFjZWZzL2V2ZW50X2lub2Rl
LmMgfCAyNiArKysrKysrKysrKystLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3RyYWNlZnMvZXZl
bnRfaW5vZGUuYyBiL2ZzL3RyYWNlZnMvZXZlbnRfaW5vZGUuYwppbmRleCAxYzNkZDBhZDQ2NjAu
LjJkMTI4YmVkZDY1NCAxMDA2NDQKLS0tIGEvZnMvdHJhY2Vmcy9ldmVudF9pbm9kZS5jCisrKyBi
L2ZzL3RyYWNlZnMvZXZlbnRfaW5vZGUuYwpAQCAtMTU2LDMzICsxNTYsMzAgQEAgc3RhdGljIGlu
dCBldmVudGZzX3NldF9hdHRyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgZGVudHJ5
ICpkZW50cnksCiAJcmV0dXJuIHJldDsKIH0KIAotc3RhdGljIHZvaWQgdXBkYXRlX3RvcF9ldmVu
dHNfYXR0cihzdHJ1Y3QgZXZlbnRmc19pbm9kZSAqZWksIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkK
K3N0YXRpYyB2b2lkIHVwZGF0ZV90b3BfZXZlbnRzX2F0dHIoc3RydWN0IGV2ZW50ZnNfaW5vZGUg
KmVpLCBzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQogewotCXN0cnVjdCBpbm9kZSAqaW5vZGU7CisJ
c3RydWN0IGlub2RlICpyb290OwogCiAJLyogT25seSB1cGRhdGUgaWYgdGhlICJldmVudHMiIHdh
cyBvbiB0aGUgdG9wIGxldmVsICovCiAJaWYgKCFlaSB8fCAhKGVpLT5hdHRyLm1vZGUgJiBFVkVO
VEZTX1RPUExFVkVMKSkKIAkJcmV0dXJuOwogCiAJLyogR2V0IHRoZSB0cmFjZWZzIHJvb3QgaW5v
ZGUuICovCi0JaW5vZGUgPSBkX2lub2RlKGRlbnRyeS0+ZF9zYi0+c19yb290KTsKLQllaS0+YXR0
ci51aWQgPSBpbm9kZS0+aV91aWQ7Ci0JZWktPmF0dHIuZ2lkID0gaW5vZGUtPmlfZ2lkOworCXJv
b3QgPSBkX2lub2RlKHNiLT5zX3Jvb3QpOworCWVpLT5hdHRyLnVpZCA9IHJvb3QtPmlfdWlkOwor
CWVpLT5hdHRyLmdpZCA9IHJvb3QtPmlfZ2lkOwogfQogCiBzdGF0aWMgdm9pZCBzZXRfdG9wX2V2
ZW50c19vd25lcnNoaXAoc3RydWN0IGlub2RlICppbm9kZSkKIHsKIAlzdHJ1Y3QgdHJhY2Vmc19p
bm9kZSAqdGkgPSBnZXRfdHJhY2Vmcyhpbm9kZSk7CiAJc3RydWN0IGV2ZW50ZnNfaW5vZGUgKmVp
ID0gdGktPnByaXZhdGU7Ci0Jc3RydWN0IGRlbnRyeSAqZGVudHJ5OwogCiAJLyogVGhlIHRvcCBl
dmVudHMgZGlyZWN0b3J5IGRvZXNuJ3QgZ2V0IGF1dG9tYXRpY2FsbHkgdXBkYXRlZCAqLwogCWlm
ICghZWkgfHwgIWVpLT5pc19ldmVudHMgfHwgIShlaS0+YXR0ci5tb2RlICYgRVZFTlRGU19UT1BM
RVZFTCkpCiAJCXJldHVybjsKIAotCWRlbnRyeSA9IGVpLT5kZW50cnk7Ci0KLQl1cGRhdGVfdG9w
X2V2ZW50c19hdHRyKGVpLCBkZW50cnkpOworCXVwZGF0ZV90b3BfZXZlbnRzX2F0dHIoZWksIGlu
b2RlLT5pX3NiKTsKIAogCWlmICghKGVpLT5hdHRyLm1vZGUgJiBFVkVOVEZTX1NBVkVfVUlEKSkK
IAkJaW5vZGUtPmlfdWlkID0gZWktPmF0dHIudWlkOwpAQCAtMjM1LDggKzIzMiwxMCBAQCBzdGF0
aWMgc3RydWN0IGV2ZW50ZnNfaW5vZGUgKmV2ZW50ZnNfZmluZF9ldmVudHMoc3RydWN0IGRlbnRy
eSAqZGVudHJ5KQogCiAJbXV0ZXhfbG9jaygmZXZlbnRmc19tdXRleCk7CiAJZG8gewotCQkvKiBU
aGUgcGFyZW50IGFsd2F5cyBoYXMgYW4gZWksIGV4Y2VwdCBmb3IgZXZlbnRzIGl0c2VsZiAqLwot
CQllaSA9IGRlbnRyeS0+ZF9wYXJlbnQtPmRfZnNkYXRhOworCQkvLyBUaGUgcGFyZW50IGlzIHN0
YWJsZSBiZWNhdXNlIHdlIGRvIG5vdCBkbyByZW5hbWVzCisJCWRlbnRyeSA9IGRlbnRyeS0+ZF9w
YXJlbnQ7CisJCS8vIC4uLiBhbmQgZGlyZWN0b3JpZXMgYWx3YXlzIGhhdmUgZF9mc2RhdGEKKwkJ
ZWkgPSBkZW50cnktPmRfZnNkYXRhOwogCiAJCS8qCiAJCSAqIElmIHRoZSBlaSBpcyBiZWluZyBm
cmVlZCwgdGhlIG93bmVyc2hpcCBvZiB0aGUgY2hpbGRyZW4KQEAgLTI0NiwxMiArMjQ1LDExIEBA
IHN0YXRpYyBzdHJ1Y3QgZXZlbnRmc19pbm9kZSAqZXZlbnRmc19maW5kX2V2ZW50cyhzdHJ1Y3Qg
ZGVudHJ5ICpkZW50cnkpCiAJCQllaSA9IE5VTEw7CiAJCQlicmVhazsKIAkJfQotCi0JCWRlbnRy
eSA9IGVpLT5kZW50cnk7CisJCS8vIFdhbGsgdXB3YXJkcyB1bnRpbCB5b3UgZmluZCB0aGUgZXZl
bnRzIGlub2RlCiAJfSB3aGlsZSAoIWVpLT5pc19ldmVudHMpOwogCW11dGV4X3VubG9jaygmZXZl
bnRmc19tdXRleCk7CiAKLQl1cGRhdGVfdG9wX2V2ZW50c19hdHRyKGVpLCBkZW50cnkpOworCXVw
ZGF0ZV90b3BfZXZlbnRzX2F0dHIoZWksIGRlbnRyeS0+ZF9zYik7CiAKIAlyZXR1cm4gZWk7CiB9
Ci0tIAoyLjQzLjAuNS5nMzhmYjEzN2JkYgoK
--0000000000001ba36b060ff45d93--

