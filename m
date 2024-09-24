Return-Path: <linux-fsdevel+bounces-29951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92BF984146
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 10:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F080FB23D28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191B153BF8;
	Tue, 24 Sep 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MnySsFEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E791474CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168328; cv=none; b=hwzz7dan1uUQPz/OfoJBVkbO45Yg6aRbcV4eMuaGF1BfT6ICRHa90oGzdfqVXOM5A1epaVPgSvQhgDiTeTeZsOG82XegXuPAgOrzF3o465g/Tc2DpfNP5S7BhDXN2ceQ5I92gdfHP8KD8B8wrkooOV2tF/6CmZCey8W8SePrx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168328; c=relaxed/simple;
	bh=LL5eYPUDGZfQF2Niu+xArbJer08+qwnrxZ1PNqDOkb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGMYMXKVqo8/w9Y1Hy/CtZWSyb7kynwNZjVYXI/mQGqRrD/VE4Qg4lXHVzyG62K7vD3U2koNz0zl7ktQhzoyoQy6hU/XEbKPkiOHDUSZCHdRcuoa+HhSb0+HEF7EmRYpfuORPsaPAKKrijrxktMjIeN+u7u5yJqIBRDHM2shINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MnySsFEM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d43657255so827482066b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727168323; x=1727773123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/f2ZPyqZojLXd/r4D6DGb8rQdpc8ft3tfH/p5Fvt+Oc=;
        b=MnySsFEMje9o1TzTjBrtwQoABpj0xqTQbNiuj4B2YdwoVh1+RavRLJaScHA0X6nXWA
         yOzNsbnuDKo1wYHB0iAtL/LKMMXmyaXJXtCoxrGP6l+fwdkJkyxn2UlNuWWNlVQnNGnO
         6xkEwAgkSIiLm8VlI4rONl3cjvRLZ4s9AiC3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168323; x=1727773123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/f2ZPyqZojLXd/r4D6DGb8rQdpc8ft3tfH/p5Fvt+Oc=;
        b=il94CRpDlNTPqC2VlTeG1mjo0KxaLbNARzAQnw8GPOzqFTWHQ4TJdbkp8iivzw3K1z
         fEmfIQY+/k8C4mfazBnO63MZXGG6pVU/BThPOqp8WbJ3590IdBI7Kr461jCVFsjYDA42
         IIqceVhSreQ2HNLGafrLH+F8ZiBYri2zPa/FCv3GpmZWCJnmgIeurNKGaUDXJgN2Ftsf
         UAw0E8sdJpwz7ge46v8WycM7KJBUqJx4iLryCED8QcqToFjhQh0h8PmXxZ6nqoIt8g00
         sw9d7eLzw8eVbDnSuRFOXmquitz0A7nQmTpWyFoWdix3UCviTDYLBhP4SmxE1QHJblpy
         vWBg==
X-Forwarded-Encrypted: i=1; AJvYcCVXzMxkkrh+aWLM/c22DFgq0/czatEaPO3mzjXssirsUHixJFOhIHMXWlZdDSipZWkHUfejFAyO7s6z3mUn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5UNMoYdw52E/ZIM8G/AWoE+fCcOfjFjoViGJiNCgtIU1ZglOZ
	tSrUToWrcwBJtDX5ZYJ65Mf7O4NUPHoF3448G6lEfTZT1pLj1ptk88R474zkmeb6WTK6Vrwu/Er
	0gwi37iSg60WwfnT30bRw9VIyz/hIIu2TgK+94w==
X-Google-Smtp-Source: AGHT+IFnv47nHnJX3ib+nC8/SvfdaDodyZ2URyiV+ynPzcZmNqEd4YfzcbUbSSdf0pOra6WpxwVEHMw6xf5ZI8DdHkk=
X-Received: by 2002:a17:907:1b02:b0:a7a:aa35:408c with SMTP id
 a640c23a62f3a-a90d4fbc6c2mr1664993666b.8.1727168323416; Tue, 24 Sep 2024
 01:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529155210.2543295-1-mszeredi@redhat.com> <ZvFEAM6JfrBKsOU0@ly-workstation>
 <CAJnrk1YW10Ex3pxNR1Ew=pm+e1f83qbU4mCAL_TLW-CaEXutZw@mail.gmail.com> <CAJnrk1YA71v6zTE6iNk297VFK6PVP26SUX+zbb29yF+LG4JM7w@mail.gmail.com>
In-Reply-To: <CAJnrk1YA71v6zTE6iNk297VFK6PVP26SUX+zbb29yF+LG4JM7w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Sep 2024 10:58:31 +0200
Message-ID: <CAJfpegtfFtnTrjeuajay4+U+ob4RMgzeygwhXLeYiKqFsHczcw@mail.gmail.com>
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Peter-Jan Gootzen <pgootzen@nvidia.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Yoray Zack <yorayz@nvidia.com>, Vivek Goyal <vgoyal@redhat.com>, virtualization@lists.linux.dev, 
	yi1.lai@intel.com
Content-Type: multipart/mixed; boundary="00000000000063931a0622d9b69a"

--00000000000063931a0622d9b69a
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 01:48, Joanne Koong <joannelkoong@gmail.com> wrote:
> So maybe just clear_bit(FR_PENDING, &req->flags) before we call
> fuse_request_end() is the best.

Agreed.   Attached patch should fix it.

Yi, can you please verify?

Thanks,
Miklos

--00000000000063931a0622d9b69a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fuse-clear-FR_PENDING-if-abort-is-detected-when-send.patch"
Content-Disposition: attachment; 
	filename="0001-fuse-clear-FR_PENDING-if-abort-is-detected-when-send.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1g7ev2o0>
X-Attachment-Id: f_m1g7ev2o0

RnJvbSBmY2QyZDllMWZkY2Q3Y2FkYTYxMmYyZTg3MzdmYjEzYTJiY2U3ZDBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWtsb3MgU3plcmVkaSA8bXN6ZXJlZGlAcmVkaGF0LmNvbT4K
RGF0ZTogVHVlLCAyNCBTZXAgMjAyNCAxMDo0NzoyMyArMDIwMApTdWJqZWN0OiBmdXNlOiBjbGVh
ciBGUl9QRU5ESU5HIGlmIGFib3J0IGlzIGRldGVjdGVkIHdoZW4gc2VuZGluZyByZXF1ZXN0CgpU
aGUgKCFmaXEtPmNvbm5lY3RlZCkgY2hlY2sgd2FzIG1vdmVkIGludG8gdGhlIHF1ZXVpbmcgbWV0
aG9kIHJlc3VsdGluZyBpbgp0aGUgZm9sbG93aW5nOgoKRml4ZXM6IDVkZThhY2I0MWM4NiAoImZ1
c2U6IGNsZWFudXAgcmVxdWVzdCBxdWV1aW5nIHRvd2FyZHMgdmlydGlvZnMiKQpSZXBvcnRlZC1i
eTogTGFpLCBZaSA8eWkxLmxhaUBsaW51eC5pbnRlbC5jb20+CkNsb3NlczogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsL1p2RkVBTTZKZnJCS3NPVTBAbHktd29ya3N0YXRpb24vClNpZ25lZC1v
ZmYtYnk6IE1pa2xvcyBTemVyZWRpIDxtc3plcmVkaUByZWRoYXQuY29tPgotLS0KIGZzL2Z1c2Uv
ZGV2LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBh
L2ZzL2Z1c2UvZGV2LmMgYi9mcy9mdXNlL2Rldi5jCmluZGV4IGNkZjkyNWUwYjMxNy4uNTNjNDU2
OWQ4NWE0IDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rldi5jCisrKyBiL2ZzL2Z1c2UvZGV2LmMKQEAg
LTI5NSw2ICsyOTUsNyBAQCBzdGF0aWMgdm9pZCBmdXNlX2Rldl9xdWV1ZV9yZXEoc3RydWN0IGZ1
c2VfaXF1ZXVlICpmaXEsIHN0cnVjdCBmdXNlX3JlcSAqcmVxKQogCX0gZWxzZSB7CiAJCXNwaW5f
dW5sb2NrKCZmaXEtPmxvY2spOwogCQlyZXEtPm91dC5oLmVycm9yID0gLUVOT1RDT05OOworCQlj
bGVhcl9iaXQoRlJfUEVORElORywgJnJlcS0+ZmxhZ3MpOwogCQlmdXNlX3JlcXVlc3RfZW5kKHJl
cSk7CiAJfQogfQotLSAKMi40Ni4wCgo=
--00000000000063931a0622d9b69a--

