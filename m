Return-Path: <linux-fsdevel+bounces-4889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828E3805A18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 17:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AAE1C21006
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A35FEEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RfEqGEkP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263E518F
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 08:28:11 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54cfb03f1a8so1827237a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 08:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701793689; x=1702398489; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=muiyAVAJAt0leyfK62tM9muVpaBfAvMZ24s9nSjukeI=;
        b=RfEqGEkPBpbnLvcRC11pCLETbuBOok356vobgHERyyKfBi0QHDGRWV+L/FlTnoD3IS
         Q9rz789YPh9U3giMGCctA+Y75n61Aw1Y9mpimnu6N/wEl3ecX2IA6Bzgy/WAK/wxV1O5
         I3QWB6xmAF0hfyC/i3/QE9SCbFXNSoROXJgsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793689; x=1702398489;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=muiyAVAJAt0leyfK62tM9muVpaBfAvMZ24s9nSjukeI=;
        b=gMHEiKXZN7BzcHiPIY9kgvx96cMVR8Kwlcnb+7LGq9dHZZKBTGaIU6pUcsHewbMp6U
         ZRyZ4tvNftmDRu923rS2drHZxbagUQcVIQ2iEBLOmacNp4ocY8Fm/6HzWitE73IF9Sn7
         MgHsrKBD6qcoaaMLT73VGzTWz7z7NL+hwr+1e54IumbP7X0jZqpo+RNI8DVNPfw6+a7d
         Ow4HsF/tqgsEzzKCValnn9yE5Ku7eS6Sbf+fvPAEP9NFHH3DJmDLtPBW0vgSF5MaZvmU
         Vso/LsDw2mZ5oNLoTEOvmYCNYkfQYSUAN235mlWA7wAqMx7JLckB+LOCx2Zv8wNB+I2q
         7knA==
X-Gm-Message-State: AOJu0YxShf146ylwOWGRcR0iv4lgtBkxYf7vxAKlvmZyYQYKIHEcsPr0
	V/Xt8M/TOwOSkfr0enUdwji0Ep6Q9jPFdYu+mO5PPQ==
X-Google-Smtp-Source: AGHT+IHzcycGhn66gOmYCXExkBsul/566clabqTonqNySB/dFhIKhTbjBxuOwQJuu1G2xDAvjG3T3lmD0fxBlDjLbis=
X-Received: by 2002:a17:906:3f5b:b0:a19:a19a:eadb with SMTP id
 f27-20020a1709063f5b00b00a19a19aeadbmr506667ejj.148.1701793689524; Tue, 05
 Dec 2023 08:28:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Dec 2023 17:27:58 +0100
Message-ID: <CAJfpeguMViqawKfJtM7_M9=m+6WsTcPfa_18t_rM9iuMG096RA@mail.gmail.com>
Subject: [RFC] proposed libc interface and man page for listmount
To: libc-alpha@sourceware.org, linux-man <linux-man@vger.kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, Linux API <linux-api@vger.kernel.org>, 
	Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/mixed; boundary="00000000000058a05b060bc5b82c"

--00000000000058a05b060bc5b82c
Content-Type: text/plain; charset="UTF-8"

Attaching the proposed man page for listing mounts (based on the new
listmount() syscall).

The raw interface is:

       syscall(__NR_listmount, const struct mnt_id_req __user *, req,
                  u64 __user *, buf, size_t, bufsize, unsigned int, flags);

The proposed libc API is.

       struct listmount *listmount_start(uint64_t mnt_id, unsigned int flags);
       uint64_t listmount_next(struct listmount *lm);
       void listmount_end(struct listmount *lm);

I'm on the opinion that no wrapper is needed for the raw syscall, just
like there isn't one for getdents(2).

Comments?

Thanks,
Miklos

Sample implementation:
--------------------------------

#define LM_BUFSIZE 4096

struct listmount {
        size_t num;
        size_t pos;
        uint64_t mnt_id;
        unsigned int flags;
        uint64_t buf[LM_BUFSIZE];
};

static int do_listmount(struct listmount *lm)
{
        struct mnt_id_req req = {
                .mnt_id = lm->mnt_id,
                .param = lm->buf[LM_BUFSIZE - 1],
        };
        long res;

        res = syscall(__NR_listmount, &req, lm->buf, LM_BUFSIZE, lm->flags);
        if (res != -1) {
                lm->num = res;
                lm->pos = 0;
        }
        return res;
}

struct listmount *listmount_start(uint64_t mnt_id, unsigned int flags)
{
        int res;
        struct listmount *lm = calloc(1, sizeof(*lm));

        if (lm) {
                lm->mnt_id = mnt_id;
                lm->flags = flags;
                res = do_listmount(lm);
                if (res == -1) {
                        free(lm);
                        lm = NULL;
                }
        }

        return lm;
}

uint64_t listmount_next(struct listmount *lm)
{
        int res;

        if (lm->pos == LM_BUFSIZE) {
                res = do_listmount(lm);
                if (res == -1)
                        return 0;
        }

        /* End of list? */
        if (lm->pos == lm->num)
                return 0;

        return lm->buf[lm->pos++];
}

void listmount_end(struct listmount *lm)
{
        free(lm);
}

--00000000000058a05b060bc5b82c
Content-Type: application/x-troff-man; name="listmount_start.3"
Content-Disposition: attachment; filename="listmount_start.3"
Content-Transfer-Encoding: base64
Content-ID: <f_lpsjze2c0>
X-Attachment-Id: f_lpsjze2c0

LlwiIENvcHlyaWdodCAyMDIzIE1pa2xvcyBTemVyZWRpIDxtc3plcmVkaUByZWRoYXQuY29tPgou
XCIKLlwiIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCi5cIgouVEgg
bGlzdG1vdW50X3N0YXJ0IDMgKGRhdGUpICJMaW51eCBtYW4tcGFnZXMgKHVucmVsZWFzZWQpIgou
U0ggTkFNRQpsaXN0bW91bnRfc3RhcnQsIGxpc3Rtb3VudF9uZXh0LCBsaXN0bW91bnRfZW5kIFwt
IGxpc3QgbW91bnRzCi5TSCBMSUJSQVJZClN0YW5kYXJkIEMgbGlicmFyeQouUkkgKCBsaWJjICIs
ICIgXC1sYyApCi5TSCBTWU5PUFNJUwoubmYKLkJSICIjZGVmaW5lIF9HTlVfU09VUkNFIiAiICAg
ICAgICAgLyogU2VlIGZlYXR1cmVfdGVzdF9tYWNyb3MoNykgKi8iCi5CICNpbmNsdWRlIDxzeXMv
bW91bnQuaD4KLlAKLkJJICJzdHJ1Y3QgbGlzdG1vdW50ICpsaXN0bW91bnRfc3RhcnQodWludDY0
X3QgIiBtbnRfaWQgIiwgdW5zaWduZWQgaW50ICIgZmxhZ3MgIik7IgouQkkgInVpbnQ2NF90IGxp
c3Rtb3VudF9uZXh0KHN0cnVjdCBsaXN0bW91bnQgKiIgbG0gIik7IgouQkkgInZvaWQgbGlzdG1v
dW50X2VuZChzdHJ1Y3QgbGlzdG1vdW50ICoiIGxtICIpOyIKLlAKLlNIIERFU0NSSVBUSU9OCi5C
UiBsaXN0bW91bnRfc3RhcnQgKCkKY3JlYXRlcyBhIGhhbmRsZSBmb3IgbGlzdGluZyBtb3VudHMu
ICBNb3VudHMgdGhhdCBhcmUgYmVsb3cgdGhlIG1vdW50IHNwZWNpZmllZApieQouSSBtbnRfaWQK
YXJlIGxpc3RlZC4gIFRvIGxpc3QgYWxsIG1vdW50cyB1bmRlciB0aGUgY3VycmVudCByb290LCB1
c2UgdGhlIHNwZWNpYWwgbW91bnQKSUQgdmFsdWUKLkJSIExTTVRfUk9PVAoodGhpcyB3aWxsIGJl
IHRoZSBzYW1lIGxpc3QgYXMgaW4gL3Byb2Mvc2VsZi9tb3VudGluZm8pLiAgVGhlCi5JIGZsYWdz
CnZhbHVlIGlzIHJlc2VydmVkIGZvciBmdXR1cmUgdXNlIGFuZCBtdXN0IGJlIHNldCB0byB6ZXJv
LgouUAouQlIgbGlzdG1vdW50X25leHQgKCkKcmV0dXJucyB0aGUgbmV4dCBtb3VudCBJRCBpbiB0
aGUgbGlzdC4gIElmIHRoZSBlbmQgb2YgdGhlIGxpc3QgaXMgcmVhY2hlZCBvciBhbgplcnJvciBo
YXBwZW5zLCB0aGVuIHplcm8gaXMgcmV0dXJuZWQuCi5QCi5CUiBsaXN0bW91bnRfZW5kICgpCmRl
c3Ryb3lzIHRoZSBoYW5kbGUgYXNzb2NpYXRlZCB3aXRoIHRoZSBsaXN0aW5nLgouU0ggUkVUVVJO
IFZBTFVFCk9uIHN1Y2Nlc3MsCi5CUiBsaXNtb3VudF9zdGFydCAoKQpyZXR1cm5zIGEgbm9uLU5V
TEwgcG9pbnRlci4gT24gZXJyb3IKLkJSIGxpc3Rtb3VudF9zdGFydCAoKQpyZXR1cm5zIE5VTEws
IHdpdGgKLkkgZXJybm8Kc2V0IHRvIGluZGljYXRlIHRoZSBlcnJvci4KLlAgCk9uIHN1Y2Nlc3Ms
Ci5CUiBsaXNtb3VudF9uZXh0ICgpCnJldHVybnMgYSBtb3VudCBJRCwgb3IgemVybyB3aGVuIHRo
ZSBlbmQgb2YgdGhlIGxpc3QgaGFzIGJlZW4gcmVhY2hlZC4gT24gZXJyb3IKLkJSIGxpc3Rtb3Vu
dF9zdGFydCAoKQpyZXR1cm5zIHplcm8sIHdpdGgKLkkgZXJybm8Kc2V0IHRvIGluZGljYXRlIHRo
ZSBlcnJvci4KLlNIIEVSUk9SUwouVFAKLkIgRU5PRU5UClRoZSBtb3VudCBkZXNpZ25hdGVkIGJ5
Ci5JIG1udF9pZApkb2VzIG5vdCBleGlzdCBpbiB0aGUgY3VycmVudCBtb3VudCBuYW1lc3BhY2Uu
Ci5UUAouQiBFUEVSTQpUaGUgbW91bnQgaXMgbm90IHJlYWNoYWJsZSBmcm9tIHRoZSBjdXJyZW50
IHJvb3QgZGlyZWN0b3J5IGFuZCB0aGUgY2FsbGluZyBwcm9jZXNzIGRvZXMgbm90IGhhdmUgdGhl
Ci5CIENBUF9TWVNfQURNSU4KY2FwYWJpbGl0eS4KLlRQCi5CIEVJTlZBTApJbnZhbGlkIGZsYWcg
c3BlY2lmaWVkIGluCi5JUiBmbGFncyAuCi5UUAouQiBFTk9NRU0KRmFpbGVkIHRvIGFsbG9jYXRl
IG1lbW9yeS4KLlNIIFNUQU5EQVJEUwpMaW51eC4KLlNIIEhJU1RPUlkKTm90IHVwc3RyZWFtIHll
dC4KLlNIIFNFRSBBTFNPCi5CUiBzdGF0bW91bnQoMiksCi5CUiBwcm9jKDUpLAouQlIgc3RhdHgo
MikK
--00000000000058a05b060bc5b82c--

