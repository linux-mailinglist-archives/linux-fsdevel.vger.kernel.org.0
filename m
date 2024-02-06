Return-Path: <linux-fsdevel+bounces-10534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C89A84C0B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5311F2566E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 23:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A5A1C69D;
	Tue,  6 Feb 2024 23:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcSQR0gd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA11CD13;
	Tue,  6 Feb 2024 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261297; cv=none; b=ok0iuKQ8IgZHj3F18/d9vBYl4tGHhstc+0fVrHPEZ13RZjhrIOrEufvEmtZaL5uAE0P8NZZWXoPgxX7LGEqZPkw9BP7SFYV6c1lh/DFXNQc/91z6tFBs0QISs8wK6WppBfX8gbJrBpcBhDZJUEBTytQ8uhDa84nWlWPwseKu5mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261297; c=relaxed/simple;
	bh=/uEb6jR0llRxX5SjlEJDt+cYl6TgrmJHrp6Hr9lCEtc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oBupS2q0q3l16ojHBX/ycGDci5ddBNSE/ZW086bt8gI7Fy2EtZzdQ+G0ZyQjqyjVv3ncA6TqyJhLC/UGQSoMUZNu5RNLv9fcEeSoAhRSU11NWo8jDFXmnU2VEnCcozZ6RgOnJwpqBfVA722EK5VbiRFCaHkdT0TRnGrTXKkZzyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcSQR0gd; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51165efb684so7343e87.3;
        Tue, 06 Feb 2024 15:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707261294; x=1707866094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vjqghvpCB2iHALs069ZaG4OVOMOAjrIIrgdIKVWuNVo=;
        b=WcSQR0gd82lfd0xlFKYfz2UvQLmQMou4uvXKAPINBJivEXTCa77C8eRlLUPogBR+QS
         H0y0z8rhn7WZOifPhmR33lAsiocXrcx+BwgXEERCY8AK/yMJQi6bLLQ3CVJaQTco1sh9
         xGXNGS+Le0Q6AxhcCEwrwZBWAoxs1+ct2ZJ8q/SaIwa//XNIbykVlFvQDeHjo0RaeTh/
         MlfBTF56lz65T5ucD529HtBo8xpm45qWRlwX74oh7yrYPeH4kVPPaMa9lKw9PsPlL/7N
         wi/xPwW+RRJGRQAZJHjFF/DZuyBKvplr7zj4Aih8h3GZ8rvpdnlkDXhZA1CZosSaw3kB
         +oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707261294; x=1707866094;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjqghvpCB2iHALs069ZaG4OVOMOAjrIIrgdIKVWuNVo=;
        b=ZniDwAN/lcQcc/CM//rc9hM1X2pWPEvPfoN55vwaerxi01tTv2AAmfG5vRNIDaAKIo
         xfU/ZHqlDc06L3Yb3faf6Hl9OF/zy1uh7CPUCt0cl3vpwfRuuXCh5JVPBzmxhpiwtfh3
         lmHSdgkCQeQkbdPcK/eMHhvXANrqirbRJ8iHHSwsKYAsb7xhei8DepLZWboYzlrSDQhN
         v1QfJfN3Y5YjIK3pwq2blQdhyRcTbALtrwCyS/RYNRTzJxSGoUIajuIw7AaJjtxWKWn1
         s5Qeqm5jTDAr0eC8wBVKrNAZl80/NXAqQS6CxZDZnLslQruC11OMTWD/aLtfvafBufOp
         7AmA==
X-Gm-Message-State: AOJu0Yy9Eax/jV0wVGLs3HTrDZN/90tRigfmkz3A7/G7YmBaLTRUWj44
	7VzMYpgqV2OYUOTA5Z5OK/Tf9pNNNDPCEjbzcNo30gdILlLNYZz1L6SIgeXzl1gx06Uva35cCFh
	P5QJ48UstCPM1aze6OayReDwPVmZZEFffcKs=
X-Google-Smtp-Source: AGHT+IHgpu+5FVFmjZnD51NP10VnrBf8XZMoPIiIk/uea2YJbAdLmFS/d6s4NFyshoMvEjf9M4Lzon1pgrNPMlfsj08=
X-Received: by 2002:ac2:5211:0:b0:511:19b1:95b6 with SMTP id
 a17-20020ac25211000000b0051119b195b6mr2598935lfl.63.1707261293522; Tue, 06
 Feb 2024 15:14:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 6 Feb 2024 17:14:42 -0600
Message-ID: <CAH2r5msJQGww+MAJLpA9qNw_jDt9ymiHO+bcpTkGMJpJdVc=gA@mail.gmail.com>
Subject: [PATCH] fix netfs/folios regression
To: David Howells <dhowells@redhat.com>, CIFS <linux-cifs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, ronnie sahlberg <ronniesahlberg@gmail.com>, 
	"R. Diez" <rdiez-2006@rd10.de>
Content-Type: multipart/mixed; boundary="000000000000f084620610bebe4e"

--000000000000f084620610bebe4e
Content-Type: text/plain; charset="UTF-8"

A case was recently reported where an old (SMB1) server negotiated a
maximum write size that was not a multiple of PAGE_SIZE, and it caused
easy to reproduce data corruptions on sequential writes (e.g. cp) for
files that were bigger than maximum write size.   This could also be
reproduced by setting the optional mount parm ("wsize") to a
non-standard value that was not a multiple of 4096.  The problem was
introduced in 6.3-rc1 or rc2 probably by patch:
"cifs: Change the I/O paths to use an iterator rather than a page list"

The code in question is a little hard to follow, and may eventually
get rewritten by later folio/netfs patches from David Howells but the
problem is in
cifs_write_back_from_locked_folio() and cifs_writepages_region() where
after the write (of maximum write size) completes, the next write
skips to the beginning of the next page (leaving the tail end of the
previous page unwritten).  This is not an issue with typical servers
and typical wsize values because those will almost always be a
multiple of 4096, but in the bug report the server in question was old
and had sent a value for maximum write size that was not a multiple of
4096.

This can be a temporary fix, that can be removed as netfs/folios
implementation improves here - but in the short term the easiest way
to fix this seems to be to round the negotiated maximum_write_size
down if not a multiple of 4096, to be a multiple of 4096 (this can be
removed in the future when the folios code is found which caused
this), and also warn the user if they pick a wsize that is not
recommended, not a multiple of 4096.

-- 
Thanks,

Steve

--000000000000f084620610bebe4e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Disposition: attachment; 
	filename="0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lsayuvt60>
X-Attachment-Id: f_lsayuvt60

RnJvbSAxMTVmOTQyNGUyODk5MjY5MDg0MDY5ZTg4Mjk2YjY0ODFhMDI1MGE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgNiBGZWIgMjAyNCAxNjozNDoyMiAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIHNt
YjogRml4IHJlZ3Jlc3Npb24gaW4gd3JpdGVzIHdoZW4gbm9uLXN0YW5kYXJkIG1heGltdW0gd3Jp
dGUKIHNpemUgbmVnb3RpYXRlZAoKVGhlIGNvbnZlcnNpb24gdG8gbmV0ZnMgaW4gdGhlIDYuMyBr
ZXJuZWwgY2F1c2VkIGEgcmVncmVzc2lvbiB3aGVuCm1heGltdW0gd3JpdGUgc2l6ZSBpcyBzZXQg
YnkgdGhlIHNlcnZlciB0byBhbiB1bmV4cGVjdGVkIHZhbHVlIHdoaWNoIGlzCm5vdCBhIG11bHRp
cGxlIG9mIDQwOTYgKHNpbWlsYXJseSBpZiB0aGUgdXNlciBvdmVycmlkZXMgdGhlIG1heGltdW0K
d3JpdGUgc2l6ZSBieSBzZXR0aW5nIG1vdW50IHBhcm0gIndzaXplIiwgYnV0IHNldHMgaXQgdG8g
YSB2YWx1ZSB0aGF0CmlzIG5vdCBhIG11bHRpcGxlIG9mIDQwOTYpLiAgV2hlbiBuZWdvdGlhdGVk
IHdyaXRlIHNpemUgaXMgbm90IGEKbXVsdGlwbGUgb2YgNDA5NiB0aGUgbmV0ZnMgY29kZSBjYW4g
c2tpcCB0aGUgZW5kIG9mIHRoZSBmaW5hbApwYWdlIHdoZW4gZG9pbmcgbGFyZ2Ugc2VxdWVudGlh
bCB3cml0ZXMgY2F1c2luZyBkYXRhIGNvcnJ1cHRpb24uCgpUaGlzIHNlY3Rpb24gb2YgY29kZSBp
cyBiZWluZyByZXdyaXR0ZW4vcmVtb3ZlZCBkdWUgdG8gYSBsYXJnZQpuZXRmcyBjaGFuZ2UsIGJ1
dCB1bnRpbCB0aGF0IHBvaW50IChmcm9tIDYuMyBrZXJuZWwgdW50aWwgbm93KQp3ZSBjYW4gbm90
IHN1cHBvcnQgbm9uLXN0YW5kYXJkIG1heGltdW0gd3JpdGUgc2l6ZXMuCgpBZGQgYSB3YXJuaW5n
IGlmIGEgdXNlciBzcGVjaWZpZXMgYSB3c2l6ZSBvbiBtb3VudCB0aGF0IGlzIG5vdAphIG11bHRp
cGxlIG9mIDQwOTYsIGFuZCBhbHNvIGFkZCBhIGNoYW5nZSB3aGVyZSB3ZSByb3VuZCBkb3duIHRo
ZQptYXhpbXVtIHdyaXRlIHNpemUgaWYgdGhlIHNlcnZlciBuZWdvdGlhdGVzIGEgdmFsdWUgdGhh
dCBpcyBub3QKYSBtdWx0aXBsZSBvZiA0MDk2LgoKUmVwb3J0ZWQtYnk6IFIuIERpZXoiIDxyZGll
ei0yMDA2QHJkMTAuZGU+CkZpeGVzOiBkMDgwODlmNjQ5YTAgKCJjaWZzOiBDaGFuZ2UgdGhlIEkv
TyBwYXRocyB0byB1c2UgYW4gaXRlcmF0b3IgcmF0aGVyIHRoYW4gYSBwYWdlIGxpc3QiKQpTdWdn
ZXN0ZWQtYnk6IFJvbm5pZSBTYWhsYmVyZyA8cm9ubmllc2FobGJlcmdAZ21haWwuY29tPgpDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZwpDYzogRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0
LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQuY29t
PgotLS0KIGZzL3NtYi9jbGllbnQvY29ubmVjdC5jICAgIHwgMiArLQogZnMvc21iL2NsaWVudC9m
c19jb250ZXh0LmMgfCAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jIGIvZnMvc21i
L2NsaWVudC9jb25uZWN0LmMKaW5kZXggYzVjZjg4ZGUzMmI3Li45Y2ViM2IyYzYxNGIgMTAwNjQ0
Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jCisrKyBiL2ZzL3NtYi9jbGllbnQvY29ubmVj
dC5jCkBAIC0zNDQxLDcgKzM0NDEsNyBAQCBpbnQgY2lmc19tb3VudF9nZXRfdGNvbihzdHJ1Y3Qg
Y2lmc19tb3VudF9jdHggKm1udF9jdHgpCiAJICovCiAJaWYgKChjaWZzX3NiLT5jdHgtPndzaXpl
ID09IDApIHx8CiAJICAgIChjaWZzX3NiLT5jdHgtPndzaXplID4gc2VydmVyLT5vcHMtPm5lZ290
aWF0ZV93c2l6ZSh0Y29uLCBjdHgpKSkKLQkJY2lmc19zYi0+Y3R4LT53c2l6ZSA9IHNlcnZlci0+
b3BzLT5uZWdvdGlhdGVfd3NpemUodGNvbiwgY3R4KTsKKwkJY2lmc19zYi0+Y3R4LT53c2l6ZSA9
IHJvdW5kX2Rvd24oc2VydmVyLT5vcHMtPm5lZ290aWF0ZV93c2l6ZSh0Y29uLCBjdHgpLCA0MDk2
KTsKIAlpZiAoKGNpZnNfc2ItPmN0eC0+cnNpemUgPT0gMCkgfHwKIAkgICAgKGNpZnNfc2ItPmN0
eC0+cnNpemUgPiBzZXJ2ZXItPm9wcy0+bmVnb3RpYXRlX3JzaXplKHRjb24sIGN0eCkpKQogCQlj
aWZzX3NiLT5jdHgtPnJzaXplID0gc2VydmVyLT5vcHMtPm5lZ290aWF0ZV9yc2l6ZSh0Y29uLCBj
dHgpOwpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9mc19jb250ZXh0LmMgYi9mcy9zbWIvY2xp
ZW50L2ZzX2NvbnRleHQuYwppbmRleCA4MmVhZmUwODE1ZGMuLjU1MTU3Nzc4ZTU1MyAxMDA2NDQK
LS0tIGEvZnMvc21iL2NsaWVudC9mc19jb250ZXh0LmMKKysrIGIvZnMvc21iL2NsaWVudC9mc19j
b250ZXh0LmMKQEAgLTExNDEsNiArMTE0MSw4IEBAIHN0YXRpYyBpbnQgc21iM19mc19jb250ZXh0
X3BhcnNlX3BhcmFtKHN0cnVjdCBmc19jb250ZXh0ICpmYywKIAljYXNlIE9wdF93c2l6ZToKIAkJ
Y3R4LT53c2l6ZSA9IHJlc3VsdC51aW50XzMyOwogCQljdHgtPmdvdF93c2l6ZSA9IHRydWU7CisJ
CWlmIChyb3VuZF91cChjdHgtPndzaXplLCA0MDk2KSAhPSBjdHgtPndzaXplKQorCQkJY2lmc19k
YmcoVkZTLCAid3NpemUgc2hvdWxkIGJlIGEgbXVsdGlwbGUgb2YgNDA5NlxuIik7CiAJCWJyZWFr
OwogCWNhc2UgT3B0X2FjcmVnbWF4OgogCQljdHgtPmFjcmVnbWF4ID0gSFogKiByZXN1bHQudWlu
dF8zMjsKLS0gCjIuNDAuMQoK
--000000000000f084620610bebe4e--

