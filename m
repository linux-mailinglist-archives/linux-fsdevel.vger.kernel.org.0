Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7E6163C58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 06:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgBSFEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 00:04:34 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:37597 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgBSFEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 00:04:33 -0500
Received: by mail-io1-f43.google.com with SMTP id k24so12530295ioc.4;
        Tue, 18 Feb 2020 21:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=T+zw2Qm3/xbBkKSwmBe22NRY31UuKAJITVOOzl+77eA=;
        b=MsfkXTf19mx8D7AP3ycC8KURgWYqrSYRSa5B9TsaVelWDgmBZ6PfipEHS5HG5/eSCV
         SZzTAq2baj0GaDQxM8mV8YKl6TxsaxccUCjiFkQWdO3e6+ZjoNkldMRKeJ5p/1LtHwDU
         KAEZVoW9I26Lf0cOree+jGhIr4D4eoCp+uFIcoU5s9PwZC70GeyqxVUYdU5REGhcOV+b
         PxmjrkoilPk2JZ9rbmJAt4NHmctPsaSIjSxZAHJQl15DbObKInX/aFMW7pQT3saMLXwG
         aw8Qibj9TIkY31Uojjx0bRNu307nIxpaa31RPkL8K8dVehleMxNFln9dSMWbkOg5Rjry
         q0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=T+zw2Qm3/xbBkKSwmBe22NRY31UuKAJITVOOzl+77eA=;
        b=XQMrym71DxCaOGiiRTNPBwbhFCN141EekHI4S8TKYlp+RLXED6CLeIKJx+IIYKT6eV
         y8GOdchW1HG/SznJLjndj85c0/duwW5L5zbdCQ1aqCXX1u7UjoARrZKKPxXoM2RRq/LA
         Kwn5Fda5HPz5bhsFl2H5VSOYWXlyKZXWWVu3/qHB/vvWoapVyMvu7TedI4QkHoDW8cLQ
         X5clIbkpZhkbzD7Q/EwBF3RXVP4nVSQiH1hwIiZP4zX4IoY2kjdWqsZjhp7mMGMaFR2Q
         tBaeNLn8Of+n5kR5/gbLNB7SmAha4ezum09k3VFdOOgmCqUFdUQ0VF1z2BCYfvnfmO4w
         cAyw==
X-Gm-Message-State: APjAAAWPPdX/It3rAW0eFZh4CRCYIZrNWp7UFKoS+zw5rI/WtrBj2BTa
        7R2CRqlyNKEiOPXw93oGajZRyz7ZsgIeQkjaICIQFM0h
X-Google-Smtp-Source: APXvYqybgjrdSWOrhAPtC9bWGiJygbOt/r9tcYOoSyyg1GTQiwGuhSi70XPhYPOhscPlWoXflly7DhKiJvvJFC9UYg8=
X-Received: by 2002:a02:2a06:: with SMTP id w6mr20191742jaw.63.1582088672744;
 Tue, 18 Feb 2020 21:04:32 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 18 Feb 2020 23:04:21 -0600
Message-ID: <CAH2r5ms3dnvhH1L145krNgMZxoe-E58eAW0=vEBpp6Grfu2H0w@mail.gmail.com>
Subject: [CIFS][PATCH] Honor the AT_SYNC_TYPE flags
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000058174d059ee6b99d"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000058174d059ee6b99d
Content-Type: text/plain; charset="UTF-8"

     cifs.ko should not ignore the SYNC flags in getattr

    Check the AT_STATX_FORCE_SYNC flag and force an attribute
    revalidation if requested by the caller, and if the caller
    specificies AT_STATX_DONT_SYNC only revalidate cached attributes
    if required.  In addition do not flush writes in getattr (which
    can be expensive) if size or timestamps not requested by the
    caller.

-- 
Thanks,

Steve

--00000000000058174d059ee6b99d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-do-not-ignore-the-SYNC-flags-in-getattr.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-do-not-ignore-the-SYNC-flags-in-getattr.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k6suq7rh0>
X-Attachment-Id: f_k6suq7rh0

RnJvbSAyOTM2MTU5MGVkMTBmZTVkYjJiMDI1NzRiMTlkM2VkOGFmZWM1YmY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgMTggRmViIDIwMjAgMTg6MDc6NTcgLTA2MDAKU3ViamVjdDogW1BBVENIXSBj
aWZzOiBkbyBub3QgaWdub3JlIHRoZSBTWU5DIGZsYWdzIGluIGdldGF0dHIKCkNoZWNrIHRoZSBB
VF9TVEFUWF9GT1JDRV9TWU5DIGZsYWcgYW5kIGZvcmNlIGFuIGF0dHJpYnV0ZQpyZXZhbGlkYXRp
b24gaWYgcmVxdWVzdGVkIGJ5IHRoZSBjYWxsZXIsIGFuZCBpZiB0aGUgY2FsbGVyCnNwZWNpZmlj
aWVzIEFUX1NUQVRYX0RPTlRfU1lOQyBvbmx5IHJldmFsaWRhdGUgY2FjaGVkIGF0dHJpYnV0ZXMK
aWYgcmVxdWlyZWQuICBJbiBhZGRpdGlvbiBkbyBub3QgZmx1c2ggd3JpdGVzIGluIGdldGF0dHIg
KHdoaWNoCmNhbiBiZSBleHBlbnNpdmUpIGlmIHNpemUgb3IgdGltZXN0YW1wcyBub3QgcmVxdWVz
dGVkIGJ5IHRoZQpjYWxsZXIuCgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNo
QG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9pbm9kZS5jIHwgMjIgKysrKysrKysrKysrKysr
KystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9pbm9kZS5jIGIvZnMvY2lmcy9pbm9kZS5jCmluZGV4IDEy
MTJhY2UwNTI1OC4uNGZlZDdhOTExN2M2IDEwMDY0NAotLS0gYS9mcy9jaWZzL2lub2RlLmMKKysr
IGIvZnMvY2lmcy9pbm9kZS5jCkBAIC0yMTQ4LDggKzIxNDgsOSBAQCBpbnQgY2lmc19nZXRhdHRy
KGNvbnN0IHN0cnVjdCBwYXRoICpwYXRoLCBzdHJ1Y3Qga3N0YXQgKnN0YXQsCiAJICogV2UgbmVl
ZCB0byBiZSBzdXJlIHRoYXQgYWxsIGRpcnR5IHBhZ2VzIGFyZSB3cml0dGVuIGFuZCB0aGUgc2Vy
dmVyCiAJICogaGFzIGFjdHVhbCBjdGltZSwgbXRpbWUgYW5kIGZpbGUgbGVuZ3RoLgogCSAqLwot
CWlmICghQ0lGU19DQUNIRV9SRUFEKENJRlNfSShpbm9kZSkpICYmIGlub2RlLT5pX21hcHBpbmcg
JiYKLQkgICAgaW5vZGUtPmlfbWFwcGluZy0+bnJwYWdlcyAhPSAwKSB7CisJaWYgKChyZXF1ZXN0
X21hc2sgJiAoU1RBVFhfQ1RJTUUgfCBTVEFUWF9NVElNRSB8IFNUQVRYX1NJWkUpKSAmJgorCSAg
ICAhQ0lGU19DQUNIRV9SRUFEKENJRlNfSShpbm9kZSkpICYmCisJICAgIGlub2RlLT5pX21hcHBp
bmcgJiYgaW5vZGUtPmlfbWFwcGluZy0+bnJwYWdlcyAhPSAwKSB7CiAJCXJjID0gZmlsZW1hcF9m
ZGF0YXdhaXQoaW5vZGUtPmlfbWFwcGluZyk7CiAJCWlmIChyYykgewogCQkJbWFwcGluZ19zZXRf
ZXJyb3IoaW5vZGUtPmlfbWFwcGluZywgcmMpOwpAQCAtMjE1Nyw5ICsyMTU4LDIwIEBAIGludCBj
aWZzX2dldGF0dHIoY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsIHN0cnVjdCBrc3RhdCAqc3RhdCwK
IAkJfQogCX0KIAotCXJjID0gY2lmc19yZXZhbGlkYXRlX2RlbnRyeV9hdHRyKGRlbnRyeSk7Ci0J
aWYgKHJjKQotCQlyZXR1cm4gcmM7CisJaWYgKChmbGFncyAmIEFUX1NUQVRYX1NZTkNfVFlQRSkg
PT0gQVRfU1RBVFhfRk9SQ0VfU1lOQykKKwkJQ0lGU19JKGlub2RlKS0+dGltZSA9IDA7IC8qIGZv
cmNlIHJldmFsaWRhdGUgKi8KKworCS8qCisJICogSWYgdGhlIGNhbGxlciBkb2Vzbid0IHJlcXVp
cmUgc3luY2luZywgb25seSBzeW5jIGlmCisJICogbmVjZXNzYXJ5IChlLmcuIGR1ZSB0byBlYXJs
aWVyIHRydW5jYXRlIG9yIHNldGF0dHIKKwkgKiBpbnZhbGlkYXRpbmcgdGhlIGNhY2hlZCBtZXRh
ZGF0YSkKKwkgKi8KKwlpZiAoKChmbGFncyAmIEFUX1NUQVRYX1NZTkNfVFlQRSkgIT0gQVRfU1RB
VFhfRE9OVF9TWU5DKSB8fAorCSAgICAoQ0lGU19JKGlub2RlKS0+dGltZSA9PSAwKSkgeworCQly
YyA9IGNpZnNfcmV2YWxpZGF0ZV9kZW50cnlfYXR0cihkZW50cnkpOworCQlpZiAocmMpCisJCQly
ZXR1cm4gcmM7CisJfQogCiAJZ2VuZXJpY19maWxsYXR0cihpbm9kZSwgc3RhdCk7CiAJc3RhdC0+
Ymxrc2l6ZSA9IGNpZnNfc2ItPmJzaXplOwotLSAKMi4yMC4xCgo=
--00000000000058174d059ee6b99d--
