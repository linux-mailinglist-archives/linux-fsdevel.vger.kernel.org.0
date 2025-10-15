Return-Path: <linux-fsdevel+bounces-64240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DEEBDEEF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 16:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0AA44E12A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E567725784A;
	Wed, 15 Oct 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FR//ueYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A1248F78
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537396; cv=none; b=jJUSsT7xNVoT+mMIzOe1Bvr+JVEh22VqD5TjsxaDYF3SuTIvgOWlHXDUDEC2FQgfRNEb313WSqlt5Le6kZW0fF03RZ4Vg6N468th2htlOYTlokr+i/VAhuD31e9no/ZSv27Gak3S5zPiXUqPQ1sts2nHCSZCKuYCEsxGZzy0SJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537396; c=relaxed/simple;
	bh=ueAPcAKd95DlUlHNrl+EoTK5BIT733y+JKr2Y7z5db0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVa9mWpPe7k/02hwhdMPl2WfM097KE3K9hJXm7HJY3ry9yJ3VcFaLh4zaTUU1TyHZ5LuMiNUama15YDoFDtYqfH89Q7ITAw0fdD5vrm/nsz+J6eUWAI3CHPCFiTKa9kmxoLAFiqOrjw8YuDfCsEs4WZ6qNVP5u9KuGohTy8HCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FR//ueYY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-79ad9aa2d95so113854366d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760537392; x=1761142192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJw9d2/S1sIkDambLTqUWzTpf4g0ZgdJfHoZlc+Zm/c=;
        b=FR//ueYY5nZT88CAaSjgz6oyHu1XyLT1Gdfm5oH35rnha/fdNI4x3Dplz3Ouo4DmC3
         CRvqVsEuSEj+RtWdaV4BGuO2XnPiY0qvdeMisXTRkhcvkiQxUMKkpV9iCudSYEIaetj3
         Hl4xExG9clgVTMt41+NzV3Yql4rfhdzcbty24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537392; x=1761142192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJw9d2/S1sIkDambLTqUWzTpf4g0ZgdJfHoZlc+Zm/c=;
        b=VKWcvOFQEZM0XtxNT6BYkWiFTRq0ZEW5fJpmLF3TXDvh4zSjv0/D3UrRyVW1KHjr/d
         rU8gF6aS2+arKi7VA0XcR3G0xNdUVa6pUn1+99EgtfyZIRcbBjaSVP8Jw3ciXuFI2UCX
         CIjOuk9Yy8uRXj3BKbHRi8IIgD1hIMiXkBJvFcqS0w7QFoEyekW3OFpCwt5TJM23gDE5
         hdMjgJmXEp8mBvccypckRIdw2VLbVvBlkp9zjAmsz8i1CTy/uvWgAWxiqbt0msqidCBe
         VquGrQD+Mr1heg9Mv+I/VkUWanYKHzGJGcpTJD5vyCUuwhwtpxWFSosr/leeigjhDtqB
         NZnw==
X-Forwarded-Encrypted: i=1; AJvYcCUJdQzVl5An8BblP88VzlFNQsAaUCzTfeUKKPRSrjhQImtwcks43BMkjJAeEXr2EDFoFr0mv2Y13s5q/PYQ@vger.kernel.org
X-Gm-Message-State: AOJu0YymmnrtqSfYN4CEiu4LGalOFQfNDFe7g9RDxrY9XnvPiILGIrTc
	OeDr2Z1UQej0jn9cnPYbwk9i1RuOrJNDHJIxmLq3T8BE/zQ4Kdhz+SOZ3fwk8Q4xadARnMbK3YP
	n8AbY7/t0ywUV9z7gxv0FI0ondV9fKKx6qCiVxIknRg==
X-Gm-Gg: ASbGncsjWSfZ39aqzkSVp0apG4CLMGGt/7Rm4aVWECPT+tmyPkd66tVY1RlQPJhHGym
	gH35jwr2QO3pyLJXiF+bU3m/omiti6uOnVYFJyiVNF1C1c7n0HhwBHCZctV88EjFH4yieZ7hKn6
	YO9qzXNR0iYWYy0gvFDjo8UvRdMY09jWN5hCO/5lDa/8Xt5RdyjPOzMtvvkYDgcV/VDVjzo2UZL
	/BFn4x46Ti90j6EYYypC/ljwdr2BESGDrQ/00Jz7IZ/M1NV02Z0nhpnWo31GFmEnHsDPQ==
X-Google-Smtp-Source: AGHT+IEaWdyaHQI8r4t0qrf/XPV9EZti7+8f4BRQk8rubHGqJicp5k1Sm/lfOZlVeGah/3cuF/BlfoHYF57zroEGCks=
X-Received: by 2002:a05:6214:1247:b0:781:a369:ef8c with SMTP id
 6a1803df08f44-87b2101d557mr382199256d6.16.1760537392117; Wed, 15 Oct 2025
 07:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
 <CAJnrk1Z26+c_xqTavib=t4h=Jb3CFwb7NXP=4DdLhWzUwS-QtQ@mail.gmail.com>
 <aO6N-g-y6VbSItzZ@bfoster> <CAFS-8+Ug-B=vCRYnz5YdEySfJM6fTDS3hRH04Td5+1GyJJGtgA@mail.gmail.com>
In-Reply-To: <CAFS-8+Ug-B=vCRYnz5YdEySfJM6fTDS3hRH04Td5+1GyJJGtgA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 15 Oct 2025 16:09:40 +0200
X-Gm-Features: AS18NWAembAnYxHtTcjEqMRHJYUSfMII9X6KtNuPbhvjafrsuc1QQcqP0zqeIus
Message-ID: <CAJfpegsiREizDTio4gO=cBjJnaLQQNsmeKOC=tCR0p5fkjQfSg@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: lu gu <giveme.gulu@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>, 
	Brian Foster <bfoster@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000df80eb0641330d35"

--000000000000df80eb0641330d35
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 06:00, lu gu <giveme.gulu@gmail.com> wrote:
>
> >  Attaching a test patch, minimally tested.
> Since I only have a test environment for kernel 5.15, I ported this
> patch to the FUSE module in 5.15. I ran the previous LTP test cases
> more than ten times, and the data inconsistency issue did not reoccur.
> However, a deadlock occur. Below is the specific stack trace.

This is does not reproduce for me on 6.17 even after running the test
for hours.  Without seeing your backport it is difficult to say
anything about the reason for the deadlock.

Attaching an updated patch that takes care of i_wb initialization on
CONFIG_CGROUP_WRITEBACK=y.

Thanks,
Miklos

--000000000000df80eb0641330d35
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-write-through-set-writeback-v2.patch"
Content-Disposition: attachment; 
	filename="fuse-write-through-set-writeback-v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mgs2hwbx0>
X-Attachment-Id: f_mgs2hwbx0

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZmlsZS5jIGIvZnMvZnVzZS9maWxlLmMKaW5kZXggZjFlZjc3
YTBiZTA1Li4wNDJjMzVmMDQ2NmUgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZmlsZS5jCisrKyBiL2Zz
L2Z1c2UvZmlsZS5jCkBAIC0xMTI2LDkgKzExMjYsNiBAQCBzdGF0aWMgc3NpemVfdCBmdXNlX3Nl
bmRfd3JpdGVfcGFnZXMoc3RydWN0IGZ1c2VfaW9fYXJncyAqaWEsCiAJYm9vbCBzaG9ydF93cml0
ZTsKIAlpbnQgZXJyOwogCi0JZm9yIChpID0gMDsgaSA8IGFwLT5udW1fZm9saW9zOyBpKyspCi0J
CWZvbGlvX3dhaXRfd3JpdGViYWNrKGFwLT5mb2xpb3NbaV0pOwotCiAJZnVzZV93cml0ZV9hcmdz
X2ZpbGwoaWEsIGZmLCBwb3MsIGNvdW50KTsKIAlpYS0+d3JpdGUuaW4uZmxhZ3MgPSBmdXNlX3dy
aXRlX2ZsYWdzKGlvY2IpOwogCWlmIChmbS0+ZmMtPmhhbmRsZV9raWxscHJpdl92MiAmJiAhY2Fw
YWJsZShDQVBfRlNFVElEKSkKQEAgLTExNTgsNiArMTE1NSw4IEBAIHN0YXRpYyBzc2l6ZV90IGZ1
c2Vfc2VuZF93cml0ZV9wYWdlcyhzdHJ1Y3QgZnVzZV9pb19hcmdzICppYSwKIAkJfQogCQlpZiAo
aWEtPndyaXRlLmZvbGlvX2xvY2tlZCAmJiAoaSA9PSBhcC0+bnVtX2ZvbGlvcyAtIDEpKQogCQkJ
Zm9saW9fdW5sb2NrKGZvbGlvKTsKKwkJZWxzZQorCQkJZm9saW9fZW5kX3dyaXRlYmFja19ub19k
cm9wYmVoaW5kKGZvbGlvKTsKIAkJZm9saW9fcHV0KGZvbGlvKTsKIAl9CiAKQEAgLTEyMzYsNyAr
MTIzNSw5IEBAIHN0YXRpYyBzc2l6ZV90IGZ1c2VfZmlsbF93cml0ZV9wYWdlcyhzdHJ1Y3QgZnVz
ZV9pb19hcmdzICppYSwKIAkJaWYgKHRtcCA9PSBmb2xpb19zaXplKGZvbGlvKSkKIAkJCWZvbGlv
X21hcmtfdXB0b2RhdGUoZm9saW8pOwogCisJCWZvbGlvX3dhaXRfd3JpdGViYWNrKGZvbGlvKTsK
IAkJaWYgKGZvbGlvX3Rlc3RfdXB0b2RhdGUoZm9saW8pKSB7CisJCQlmb2xpb19zdGFydF93cml0
ZWJhY2soZm9saW8pOwogCQkJZm9saW9fdW5sb2NrKGZvbGlvKTsKIAkJfSBlbHNlIHsKIAkJCWlh
LT53cml0ZS5mb2xpb19sb2NrZWQgPSB0cnVlOwpAQCAtMTI2OCw2ICsxMjY5LDggQEAgc3RhdGlj
IHNzaXplX3QgZnVzZV9wZXJmb3JtX3dyaXRlKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlv
dl9pdGVyICppaSkKIAlpbnQgZXJyID0gMDsKIAlzc2l6ZV90IHJlcyA9IDA7CiAKKwlpbm9kZV9h
dHRhY2hfd2IoaW5vZGUsIE5VTEwpOworCiAJaWYgKGlub2RlLT5pX3NpemUgPCBwb3MgKyBpb3Zf
aXRlcl9jb3VudChpaSkpCiAJCXNldF9iaXQoRlVTRV9JX1NJWkVfVU5TVEFCTEUsICZmaS0+c3Rh
dGUpOwogCg==
--000000000000df80eb0641330d35--

