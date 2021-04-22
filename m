Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAD1367647
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 02:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343924AbhDVAgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 20:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343930AbhDVAgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:36:00 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E333AC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 17:35:24 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id e12-20020a056820060cb02901e94efc049dso4663704oow.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 17:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=6Bo/151Dx6SDWNJTYqVzspMT+/EPJItqGJiDq5IFPhE=;
        b=lZQSVZ93U5rlTaerOyCDp4WG8GDFqrv9GVEloGw69RwcLC0p+ynNriAAKh5cZDNNXx
         CAsk+uxmxIfAIl7Wsg1oFEbCHaU1TWUHOr3cj2p+741eCW2yUgwyWyzG3UoCAxw/EC1U
         aAj653CNTXmYfHx4RdS2hgqpaDLUe29SnqfUf+798jlihuK4S1MWHUJRv57Osz46TJU3
         Rm5Gq/Dfqq280Hg20VRpEyq9kshF1QKKyaJo7+nc9AzzVgmvqvOImJYlGcQqQtW597zj
         8ZZM4vdDmKael5jMXrnDl8FMdarffo0VnJb6CoJQpbA+MRsEwoR8rCa4TQhcbh/hvifp
         1arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=6Bo/151Dx6SDWNJTYqVzspMT+/EPJItqGJiDq5IFPhE=;
        b=Mf6nmNJYl94alUwFOw3sVtO7MBStww+l9BfvmXVHcG0K8W7EHedwe36Spu6o9JRJhJ
         HXtezHmN42CiixRhBh4/nZmMVxjB8MU59tKjxaIw5MLQ2ecaDfRE0o4ojFqzm++tdgTK
         MQPdGS9Tw/HjjJJQkMfIPcHN7Bi/HQ6yPVp7Bce5R/HdrogPr8gzmbhWIr3s4LCLcJQE
         tPyj7xGTFl/rkpbjufC5vPSu7km30fRdGb6R5ccbJiPD4TuYBWQ1Jl6kbB87ythGUqam
         vrEJzGXU6zhJjsYjvWD9Tirbw2ewMZQsBVM+BJqkRnxPs4JcB7fMYRfsuD96zIwVRruM
         bXJg==
X-Gm-Message-State: AOAM5325AwZ/8Te8A8zpr6LIYBV7scHD9cxBh5HbOAf4erqpDRlJqiFX
        AGw3SK4tnl0ZgpHrlTOwlCq4dA==
X-Google-Smtp-Source: ABdhPJwFzhYjOmf19XP6vFVF5ayvGGwv/sOGwQVx1iv6azXxg6h6OiC9H6bNf01WjKJQRw0sJ9zcrg==
X-Received: by 2002:a4a:851a:: with SMTP id k26mr395631ooh.27.1619051724106;
        Wed, 21 Apr 2021 17:35:24 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h28sm255325oof.47.2021.04.21.17.35.22
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 21 Apr 2021 17:35:23 -0700 (PDT)
Date:   Wed, 21 Apr 2021 17:35:11 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/2] mm/filemap: fix 5.12-rc regressions
Message-ID: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-897914698-1619051723=:3299"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-897914698-1619051723=:3299
Content-Type: TEXT/PLAIN; charset=US-ASCII

Andrew, I'm very sorry, this is so late: I thought we had already
tested 5.12-rc's mm/filemap changes earlier, but running xfstests
on 32-bit huge tmpfs last weekend revealed a hang (fixed in 1/2);
then looking closer at test results, found SEEK_HOLE/SEEK_DATA
discrepancies that I'd previously assumed benign (surprises there
not surprising when huge pages get used) were in fact indicating
regressions in the new seek_hole_data implementation (fixed in 2/2).

Complicated by xfstests' seek_sanity_test needing some adjustments
to work correctly on huge tmpfs; but not yet submitted because I've
more to do there.  seek_sanity combo patch attached, to allow anyone
here to verify the fixes on generic 308 285 286 436 445 448 490 539.

Up to you and Matthew whether these are rushed last minute into
5.12, or held over until the merge window, adding "Cc: stable"s.

1/2 mm/filemap: fix find_lock_entries hang on 32-bit THP
2/2 mm/filemap: fix mapping_seek_hole_data on THP & 32-bit

 mm/filemap.c |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

Thanks,
Hugh
--0-897914698-1619051723=:3299
Content-Type: TEXT/x-patch; name=seek_sanity.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LSU.2.11.2104211735110.3299@eggly.anvils>
Content-Description: 
Content-Disposition: attachment; filename=seek_sanity.patch

eGZzdGVzdHM6IHNlZWtfc2FuaXR5X3Rlc3QgYWRqdXN0bWVudHMNCg0KSHVn
ZSB0bXBmcyBoYWJpdHVhbGx5IGZhaWxlZCBnZW5lcmljLzI4NSBzZWVrX3Nh
bml0eV90ZXN0IDExLjA4IGFuZA0KMTIuMDggYmVjYXVzZSB0aGUgbmVhci1F
T0YgZGF0YSB3YXMgd3JpdHRlbiBhdCBhbiBvZmZzZXQgb2YgMU1pQiBpbnRv
DQp0aGUgeDg2XzY0IDJNaUIgaHVnZSBwYWdlIGFsbG9jYXRlZCBmb3IgaXQs
IHNvIFNFRUtfREFUQSB0aGVuIGZvdW5kDQphbiBvZmZzZXQgMU1pQiBsb3dl
ciB0aGFuIGV4cGVjdGVkLiAgV29yayBhcm91bmQgdGhpcyBieSBleHRlbmRp
bmcNCnRoYXQgZXh0cmEgMU1pQiBhdCBFT0YgdG8gYWxsb2Nfc2l6ZSBpbiB0
ZXN0MTEoKSBhbmQgdGVzdDEyKCkuDQoNCkh1Z2UgdG1wZnMgb24gaTM4NiB3
aXRob3V0IFBBRSBoYWJpdHVhbGx5IGZhaWxlZCBnZW5lcmljLzQ5MA0Kc2Vl
a19zYW5pdHlfdGVzdCAyMC4wMyBhbmQgMjAuMDQ6IGJlY2F1c2UgaXRzIDRN
aUIgYWxsb2Nfc2l6ZSwgdXNlZA0KZm9yIGJ1ZnN6LCBoYXBwZW5zIHRvIHNj
cmFwZSB0aHJvdWdoIHRoZSBpbml0aWFsIGZpbHN6IEVGQklHIGNoZWNrLA0K
YnV0IGl0cyBvdmVyZmxvd3MgZmFpbCBvbiB0aG9zZSB0d28gdGVzdHMuIHRt
cGZzIGRvZXMgbm90IHVzZSBleHRbMjNdDQp0cmlwbHkgaW5kaXJlY3QgYmxv
Y2tzIGFueXdheSwgc28gYWx0aG91Z2ggaXQncyBhbiBpbnRlcmVzdGluZyB0
ZXN0LA0KanVzdCB0YWtlIHRoZSBlYXN5IHdheSBvdXQ6IGNsYW1waW5nIHRv
IDJNaUIsIHdoaWNoIHNraXBzIHRlc3QgMjAuDQpTdXJlbHkgc29tZXRoaW5n
IGNsZXZlcmVyIGNvdWxkIGJlIGRvbmUsIGJ1dCBpdCdzIG5vdCB3b3J0aCB0
aGUgbWF0aC4NCkFuZCB3aGlsZSB0aGVyZSwgcmVudW1iZXIgc2Vjb25kIGFu
ZCB0aGlyZCAyMC4wMyB0byAyMC4wNCBhbmQgMjAuMDUuDQoNCkFkanVzdCBz
ZWVrX3Nhbml0eV90ZXN0IHRvIGNhcnJ5IG9uIGFmdGVyIGl0cyBmaXJzdCBm
YWlsdXJlLg0KQWRqdXN0IHNlZWtfc2FuaXR5X3Rlc3QgdG8gc2hvdyBmaWxl
IG9mZnNldHMgaW4gaGV4IG5vdCBkZWNpbWFsLg0KDQpUZW1wb3JhcmlseSBz
aWduZWQgb2ZmLCBidXQgdG8gYmUgc3BsaXQgaW50byBmb3VyIHdoZW4gcG9z
dGluZyB0bw0KZnN0ZXN0c0B2Z2VyLmtlcm5lbC5vcmc7IGFuZCBuZWVkcyBh
IGZpZnRoIHRvIGZpeCBnZW5lcmljLzQzNiB0b28NCih3aGljaCBjdXJyZW50
bHkgcGFzc2VzIGJlY2F1c2Ugb2YgYW4gb2xkIHN0dXBpZGl0eSBpbiBtbS9z
aG1lbS5jLA0KYnV0IHdpbGwgcHJvYmFibHkgbmVlZCBhZGp1c3RtZW50IGhl
cmUgb25jZSB0aGUga2VybmVsIGlzIGZpeGVkKS4NCg0KU2lnbmVkLW9mZi1i
eTogSHVnaCBEaWNraW5zIDxodWdoZEBnb29nbGUuY29tPg0KLS0tDQoNCiBz
cmMvc2Vla19zYW5pdHlfdGVzdC5jIHwgICAyNyArKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkNCg0KLS0tIGEvc3JjL3NlZWtfc2FuaXR5X3Rl
c3QuYw0KKysrIGIvc3JjL3NlZWtfc2FuaXR5X3Rlc3QuYw0KQEAgLTIwNyw3
ICsyMDcsNyBAQCBzdGF0aWMgaW50IGRvX2xzZWVrKGludCB0ZXN0bnVtLCBp
bnQgc3VidGVzdCwgaW50IGZkLCBvZmZfdCBmaWxzeiwgaW50IG9yaWdpbiwN
CiAJCXJldCA9ICEoZXJybm8gPT0gRU5YSU8pOw0KIAl9IGVsc2Ugew0KIA0K
LQkJeCA9IGZwcmludGYoc3Rkb3V0LCAiJTAyZC4lMDJkICVzIGV4cGVjdGVk
ICVsbGQgb3IgJWxsZCwgZ290ICVsbGQuICIsDQorCQl4ID0gZnByaW50Zihz
dGRvdXQsICIlMDJkLiUwMmQgJXMgZXhwZWN0ZWQgMHglbGx4IG9yIDB4JWxs
eCwgZ290IDB4JWxseC4gIiwNCiAJCQkgICAgdGVzdG51bSwgc3VidGVzdCwN
CiAJCQkgICAgKG9yaWdpbiA9PSBTRUVLX0hPTEUpID8gIlNFRUtfSE9MRSIg
OiAiU0VFS19EQVRBIiwNCiAJCQkgICAgKGxvbmcgbG9uZylleHAsIChsb25n
IGxvbmcpZXhwMiwgKGxvbmcgbG9uZylwb3MpOw0KQEAgLTMyMiw2ICszMjIs
OSBAQCBzdGF0aWMgaW50IHRlc3QyMChpbnQgZmQsIGludCB0ZXN0bnVtKQ0K
IAlsb2ZmX3QgYnVmc3osIGZpbHN6Ow0KIA0KIAlidWZzeiA9IGFsbG9jX3Np
emU7DQorCS8qIGkzODYgNE1pQiBidWZzeiBwYXNzZXMgZmlsc3ogRUZCSUcg
Y2hlY2sgYnV0IHRvbyBiaWcgZm9yIDIwLjMgMjAuNCAqLw0KKwlpZiAoYnVm
c3ogPiAyKjEwMjQqMTAyNCkNCisJCWJ1ZnN6ID0gMioxMDI0KjEwMjQ7DQog
CWJ1ZiA9IGRvX21hbGxvYyhidWZzeik7DQogCWlmICghYnVmKQ0KIAkJZ290
byBvdXQ7DQpAQCAtMzQ5LDkgKzM1Miw5IEBAIHN0YXRpYyBpbnQgdGVzdDIw
KGludCBmZCwgaW50IHRlc3RudW0pDQogCS8qIE9mZnNldHMgaW5zaWRlIGV4
dFsyM10gdHJpcGx5IGluZGlyZWN0IGJsb2NrICovDQogCXJldCArPSBkb19s
c2Vlayh0ZXN0bnVtLCAzLCBmZCwgZmlsc3osIFNFRUtfREFUQSwNCiAJCSgx
MiArIGJ1ZnN6IC8gNCArIGJ1ZnN6IC8gNCAqIGJ1ZnN6IC8gNCArIDMgKiBi
dWZzeiAvIDQgKyA1KSAqIGJ1ZnN6LCBmaWxzeiAtIGJ1ZnN6KTsNCi0JcmV0
ICs9IGRvX2xzZWVrKHRlc3RudW0sIDMsIGZkLCBmaWxzeiwgU0VFS19EQVRB
LA0KKwlyZXQgKz0gZG9fbHNlZWsodGVzdG51bSwgNCwgZmQsIGZpbHN6LCBT
RUVLX0RBVEEsDQogCQkoMTIgKyBidWZzeiAvIDQgKyA3ICogYnVmc3ogLyA0
ICogYnVmc3ogLyA0ICsgNSAqIGJ1ZnN6IC8gNCkgKiBidWZzeiwgZmlsc3og
LSBidWZzeik7DQotCXJldCArPSBkb19sc2Vlayh0ZXN0bnVtLCAzLCBmZCwg
Zmlsc3osIFNFRUtfREFUQSwNCisJcmV0ICs9IGRvX2xzZWVrKHRlc3RudW0s
IDUsIGZkLCBmaWxzeiwgU0VFS19EQVRBLA0KIAkJKDEyICsgYnVmc3ogLyA0
ICsgOCAqIGJ1ZnN6IC8gNCAqIGJ1ZnN6IC8gNCArIGJ1ZnN6IC8gNCArIDEx
KSAqIGJ1ZnN6LCBmaWxzeiAtIGJ1ZnN6KTsNCiBvdXQ6DQogCWlmIChidWYp
DQpAQCAtNjY3LDggKzY3MCwxMyBAQCBvdXQ6DQogICovDQogc3RhdGljIGlu
dCB0ZXN0MTIoaW50IGZkLCBpbnQgdGVzdG51bSkNCiB7DQorCWJsa3NpemVf
dCBleHRyYSA9IDEgPDwgMjA7DQorDQorCS8qIE9uIGh1Z2UgdG1wZnMgKG90
aGVycz8pIHRlc3QgbmVlZHMgd3JpdGUgYmVmb3JlIEVPRiB0byBiZSBhbGln
bmVkICovDQorCWlmIChleHRyYSA8IGFsbG9jX3NpemUpDQorCQlleHRyYSA9
IGFsbG9jX3NpemU7DQogCXJldHVybiBodWdlX2ZpbGVfdGVzdChmZCwgdGVz
dG51bSwNCi0JCQkJKChsb25nIGxvbmcpYWxsb2Nfc2l6ZSA8PCAzMikgKyAo
MSA8PCAyMCkpOw0KKwkJCQkoKGxvbmcgbG9uZylhbGxvY19zaXplIDw8IDMy
KSArIGV4dHJhKTsNCiB9DQogDQogLyoNCkBAIC02NzcsOCArNjg1LDEzIEBA
IHN0YXRpYyBpbnQgdGVzdDEyKGludCBmZCwgaW50IHRlc3RudW0pDQogICov
DQogc3RhdGljIGludCB0ZXN0MTEoaW50IGZkLCBpbnQgdGVzdG51bSkNCiB7
DQorCWJsa3NpemVfdCBleHRyYSA9IDEgPDwgMjA7DQorDQorCS8qIE9uIGh1
Z2UgdG1wZnMgKG90aGVycz8pIHRlc3QgbmVlZHMgd3JpdGUgYmVmb3JlIEVP
RiB0byBiZSBhbGlnbmVkICovDQorCWlmIChleHRyYSA8IGFsbG9jX3NpemUp
DQorCQlleHRyYSA9IGFsbG9jX3NpemU7DQogCXJldHVybiBodWdlX2ZpbGVf
dGVzdChmZCwgdGVzdG51bSwNCi0JCQkJKChsb25nIGxvbmcpYWxsb2Nfc2l6
ZSA8PCAzMSkgKyAoMSA8PCAyMCkpOw0KKwkJCQkoKGxvbmcgbG9uZylhbGxv
Y19zaXplIDw8IDMxKSArIGV4dHJhKTsNCiB9DQogDQogLyogVGVzdCBhbiA4
RyBmaWxlIHRvIGNoZWNrIGZvciBvZmZzZXQgb3ZlcmZsb3dzIGF0IDEgPDwg
MzIgKi8NCkBAIC0xMjg5LDkgKzEzMDIsNyBAQCBpbnQgbWFpbihpbnQgYXJn
YywgY2hhciAqKmFyZ3YpDQogCWZvciAoaSA9IDA7IGkgPCBudW10ZXN0czsg
KytpKSB7DQogCQlpZiAoc2Vla190ZXN0c1tpXS50ZXN0X251bSA+PSB0ZXN0
c3RhcnQgJiYNCiAJCSAgICBzZWVrX3Rlc3RzW2ldLnRlc3RfbnVtIDw9IHRl
c3RlbmQpIHsNCi0JCQlyZXQgPSBydW5fdGVzdCgmc2Vla190ZXN0c1tpXSk7
DQotCQkJaWYgKHJldCkNCi0JCQkJYnJlYWs7DQorCQkJcmV0IHw9IHJ1bl90
ZXN0KCZzZWVrX3Rlc3RzW2ldKTsNCiAJCX0NCiAJfQ0KIA0K

--0-897914698-1619051723=:3299--
