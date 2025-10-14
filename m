Return-Path: <linux-fsdevel+bounces-64142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F74BDA963
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 18:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E951891639
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90573002DD;
	Tue, 14 Oct 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gf51G+rn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C511D54C2
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458541; cv=none; b=hEp5GDjz4DGSGGO3RY9H/VrIh1il55zjPemMvLgWIBAB+sdJs2FN+ROpzsuOZaqTJ1WQIvHlWbK12Hh4qwsSuZ9/9chqtUm+wLWtqPSfcn9K8r90AP3/+jrzEdey+99Jhe1jyBo//CQlqsFpxEfqJJtSulROVWJAOYPGUnnl710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458541; c=relaxed/simple;
	bh=cKgxk6jiTeHyylnHogBfYDP2fUmT+YdxuibvKyiaGXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pj6fkIWB+fuW4aqTw+D1pZLBqYZW0jmSHXwT4pBVJO+wW2kh1rE7ElaZgaJeEkV7S6Zv7vG5t2K5sdx4mgXeMFpuUzwaNZjTuTbgeRH/vFGJUWSxLd9tXnDF3xhwWWeDKaFbE51NDaxMtIR0ay9xXj18wKM2lACcRL2fhV787+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gf51G+rn; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-86302b5a933so16458785a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760458538; x=1761063338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ewrwrknKHXB/uAbS3LbH0U+4arscjhN9e2UHVe6cDww=;
        b=gf51G+rnc9IGAw5NyFtZkvpY3109qyAD3BqWt83Crd7p49RXe9dSmhnAzki74AEEEF
         JboGnzkHho4Gekt3u2XlT/QIU0kGWodn5ER2hWMI1SrC1T7YjO0h/6bB0rpOUIAPcTfY
         rbOZRD/sXT2XUl74M41o2xVTPZmVlqfLiv8Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458538; x=1761063338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewrwrknKHXB/uAbS3LbH0U+4arscjhN9e2UHVe6cDww=;
        b=Bs7Yi26Udpp4oJGjMaZVYz7cGRtED2gwRfhCtw5Yjhx9yiNWQpBpo8N59B7oJCK+9K
         zKJ8d/IVk4SfsFotZbObOSZxEIuPlfh7cs/T/J/MzUyRfUuJr2pP2CJL+Lpd7gdm56OF
         Uc34PLu69uHkNV4VVt46BZ5DxRoshy2vKQRbonb1f1DFuCoLq+oZsFVcUfSzg7wahys5
         9N+FC2ot89Izuwspdr6ByL7tdS525Fd4mpwjX6pkvx5CVrLcv0LZ3UWtukihe4viVEdk
         PFDlibipRFsNO/Krupbh8xHOT4MHG+/+28IXejYqwEqtzO4kEQeud70yT5sHv/f5rybv
         YGww==
X-Forwarded-Encrypted: i=1; AJvYcCVDvs261rFmXTYx0FsCUJoGSPrJDNHHjxylhpypcDcGoeiNHz4fJOsWmlzw4lKpnSYf6MnZfwJyMe1plirq@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtkxB0aGuU5WRoVUblRpHzDoIf7LJMdP0YJujv6IZe58a4PKp
	pzJGE+Yo7v1lWOa64vOlzYZw9/2/Vjo5MbJlT37MtzCMGhJ1ltedcQbAkDmb3NB1OhMK8SbXhmj
	BuMKABmJQS0wVoPt+LwZ3o/VVVOLkctd0YHjM7S9SYw==
X-Gm-Gg: ASbGnctJTprY9TK3QEWi7rBlDEoSweAVmyAfpGtgOSks7saA4F6xuefaFnyV+vAyXVT
	1XyWcXlhT0GwgrQq+dOu6O9nU1Hk6dUjkvKu5VznYH8tIS6vd8cEqvlJzLyBoGPJgv8kBorZxMQ
	tUfYJC4WDNnL9FIyKDBFe0BtXiNl6k4wYJy0ScHEWvq3YsOsCmZwQu6I782ol8GkJwmdfZ9xWf9
	ne3C44DXc/TdTZJ6kBHZaGV3lAfXHNCzU7I6+Cvr5/k14LoJa+MrMuv39W6Y7fuTyEQGA==
X-Google-Smtp-Source: AGHT+IEojfPMQQk3wmAM9Q1dVYdLKmiUUYjXxV3T3mSLdv84y61D1MV9lsjnph7DcvmRn+shS0c8cY2yVTET3hV8Bg4=
X-Received: by 2002:ac8:7d4e:0:b0:4c3:a0ef:9060 with SMTP id
 d75a77b69052e-4e6eacf3e4cmr310503061cf.26.1760458538020; Tue, 14 Oct 2025
 09:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
In-Reply-To: <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Oct 2025 18:15:26 +0200
X-Gm-Features: AS18NWD3DKKeraOhbOarAGzkUEqZ7zC_nG_AO-Oe_1HPhN0h50C60DqtXglynJA
Message-ID: <CAJfpeguCe9-hbK8-XDGhaVHT1TD8oGH6E+vXRyY3cRs1rYYJ=A@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: lu gu <giveme.gulu@gmail.com>
Cc: Brian Foster <bfoster@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: multipart/mixed; boundary="000000000000cdb243064120b1b7"

--000000000000cdb243064120b1b7
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 14:43, Miklos Szeredi <miklos@szeredi.hu> wrote:

> Will try the idea of marking folios writeback for the duration of the write.

Attaching a test patch, minimally tested.

Guangming, can you please test if this fixes the cache corruption?

Thanks,
Miklos

--000000000000cdb243064120b1b7
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-write-through-set-writeback.patch"
Content-Disposition: attachment; 
	filename="fuse-write-through-set-writeback.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mgqrj1m00>
X-Attachment-Id: f_mgqrj1m00

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZmlsZS5jIGIvZnMvZnVzZS9maWxlLmMKaW5kZXggOTA1NzI2
YWMzYTdhLi4yZjEyYTUwMWRmOWQgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZmlsZS5jCisrKyBiL2Zz
L2Z1c2UvZmlsZS5jCkBAIC0xMTIxLDkgKzExMjEsNiBAQCBzdGF0aWMgc3NpemVfdCBmdXNlX3Nl
bmRfd3JpdGVfcGFnZXMoc3RydWN0IGZ1c2VfaW9fYXJncyAqaWEsCiAJYm9vbCBzaG9ydF93cml0
ZTsKIAlpbnQgZXJyOwogCi0JZm9yIChpID0gMDsgaSA8IGFwLT5udW1fZm9saW9zOyBpKyspCi0J
CWZvbGlvX3dhaXRfd3JpdGViYWNrKGFwLT5mb2xpb3NbaV0pOwotCiAJZnVzZV93cml0ZV9hcmdz
X2ZpbGwoaWEsIGZmLCBwb3MsIGNvdW50KTsKIAlpYS0+d3JpdGUuaW4uZmxhZ3MgPSBmdXNlX3dy
aXRlX2ZsYWdzKGlvY2IpOwogCWlmIChmbS0+ZmMtPmhhbmRsZV9raWxscHJpdl92MiAmJiAhY2Fw
YWJsZShDQVBfRlNFVElEKSkKQEAgLTExNTMsNiArMTE1MCw4IEBAIHN0YXRpYyBzc2l6ZV90IGZ1
c2Vfc2VuZF93cml0ZV9wYWdlcyhzdHJ1Y3QgZnVzZV9pb19hcmdzICppYSwKIAkJfQogCQlpZiAo
aWEtPndyaXRlLmZvbGlvX2xvY2tlZCAmJiAoaSA9PSBhcC0+bnVtX2ZvbGlvcyAtIDEpKQogCQkJ
Zm9saW9fdW5sb2NrKGZvbGlvKTsKKwkJZWxzZQorCQkJZm9saW9fZW5kX3dyaXRlYmFja19ub19k
cm9wYmVoaW5kKGZvbGlvKTsKIAkJZm9saW9fcHV0KGZvbGlvKTsKIAl9CiAKQEAgLTEyMzIsNiAr
MTIzMSw4IEBAIHN0YXRpYyBzc2l6ZV90IGZ1c2VfZmlsbF93cml0ZV9wYWdlcyhzdHJ1Y3QgZnVz
ZV9pb19hcmdzICppYSwKIAkJCWZvbGlvX21hcmtfdXB0b2RhdGUoZm9saW8pOwogCiAJCWlmIChm
b2xpb190ZXN0X3VwdG9kYXRlKGZvbGlvKSkgeworCQkJZm9saW9fd2FpdF93cml0ZWJhY2soZm9s
aW8pOworCQkJZm9saW9fc3RhcnRfd3JpdGViYWNrKGZvbGlvKTsKIAkJCWZvbGlvX3VubG9jayhm
b2xpbyk7CiAJCX0gZWxzZSB7CiAJCQlpYS0+d3JpdGUuZm9saW9fbG9ja2VkID0gdHJ1ZTsK
--000000000000cdb243064120b1b7--

