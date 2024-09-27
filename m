Return-Path: <linux-fsdevel+bounces-30246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F0988529
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECBF283DB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832F518C901;
	Fri, 27 Sep 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+IDZuwQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3218C348;
	Fri, 27 Sep 2024 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440888; cv=none; b=Vwe77P4RjjBZsVIOKT6hquDeujWPfi1fPHzXa05lSo2Syk+C2dL54I5OyVnfeZSqTYIEaEN57dqsn1fOBXynjQakJHNcoLdhqo1Iw6vIqf+GZGQxjamAxQvHi1vL7dsRzdkhCVFBYysn0WuKWpk4Al8pX1CcQflNK0tSFC8fVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440888; c=relaxed/simple;
	bh=kycIQwyqzseho+DCEpoVm3cn5hedlQCJ/fHzY2+vKE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMOjlz4r56r4tIgIO6i42gotcDYrxkRLvZ0xogNT9K2IDV8SowBLYgGZgz4mK7mCu1KfW6CNTObqf+8/MmdK1AFAz4UAwAOWwjQnaQzaKbZVmS3DHLf0JE2XMDbL+urjGH1WM31zMe4ZSV56xVoHPK1CJS4nR6rj+oFab/6Wyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+IDZuwQ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a99de9beb2so143887385a.3;
        Fri, 27 Sep 2024 05:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727440886; x=1728045686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=93DZLQGnfHvZRWQCInahB8EGG1Tzg6N8dIuCOyaVCUY=;
        b=g+IDZuwQ5T8xbwT4Nl6JoE3Wr91QY5gkdvnLZW5EfZ3VvYqjJWdcMgVP3uvJKzeP+f
         oaDYLXqic//g9O2Hth2H+CzZMlhdqE2sfVJH0HP7syqiklcgru1TMl4xV9iS6N+vi4f3
         zbBOIJ5z+N9hLOZhmYI+21Xq/enNZvLn6RNwcNDzYyVab6b8hiJiIrRjRVLzu8cZb8a9
         bACKyP/fGYW5j0Pv2Uo0G7A3OSm9H8G3k71w2VktzWjP25TuvYxFA6Dg+9FHVoS8HF6M
         c1dwB7ajmsIFa7hg1HU9yHLYLUF7lIGZgcogri9d9WC8rE3r8AdudGH9zMBxw3QlHoGu
         8RfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727440886; x=1728045686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93DZLQGnfHvZRWQCInahB8EGG1Tzg6N8dIuCOyaVCUY=;
        b=rBxY6kvnDoiXQVjPNjjA7QsIapcM8jFqU/Q0+CAUG4/Ie4C0aegwGqX3CZYPuFSH7B
         kGvC95JCUa4F/TnjqSIIFODkmfsAg0M1P3dZKiWq+K6vSVQIYydWi02KFjWkOA3/36Lb
         hozO830hIBqY9a5+DRnPBhimwnkAiMfRbm5cnCQXEu3f+3xfsdKxEhtuxFHMXg+AlZgd
         njJhV8gDrvuEOdd9+ZncL0m6VAGaPN/Aku1SbER/GtqAB+TIBbYSK4mijtpHyVrjJIJO
         dIlMO6Vqry2aqcHiJmtAaaSstfg3RAKkztTSRiK+vByCUlswVV9aUuUWrjWS7KrAJVAR
         DOqA==
X-Forwarded-Encrypted: i=1; AJvYcCVBba4Og1Dr8bSFipN6/5gRucAUaJOftzLtLXDJTH1O7cVB07sOHT8HU/UV7E3ezX8h96SIqjvHsLEmFjOl@vger.kernel.org, AJvYcCWa/K2vS2RJ/eLziF4D4vN2wGXPn8GoTyw19+tvC4FJtT4pwJ1xl9TI4pRzgeymu+2XzbcJg2Y2TQzqexoOMw==@vger.kernel.org, AJvYcCX1mwM6EXBrV5C7bG8ExzbhVhUPtLDfnMX1IG1FH/G1fPE7Cya7dD8tT1NzHFgeWRBXPjjTanvtWTF7xMtU@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZcjousKgt5tC7ex6AJjVgCNEVuemB6lNYNrUB4M6MBpWS0x/
	42aF6JCcVSZC91zjwCqlL9yLiMi70yiOpsvj1DVDdz2DBOylfRbOmvdgfVa/xqGwt1kbLSp+IrE
	luQl2yeGYQxMvk1f7iXkpDq+qxPU=
X-Google-Smtp-Source: AGHT+IEXNGhX+HT8vqUBq//AHc7avGluM+x25uPkqijnKxwm+Xa7Osmn6mwUiC2R340SUmi9/z/PgJCff51n1rJUBnk=
X-Received: by 2002:a05:620a:370d:b0:7ac:b1b1:e730 with SMTP id
 af79cd13be357-7ae378dd1c5mr447186385a.61.1727440886241; Fri, 27 Sep 2024
 05:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <k53rd76iiguxb6prfmkqfnlfmkjjdzjvzc6uo7eppjc2t4ssdf@2q7pmj7sstml> <CAOQ4uxhXbTZS3wmLibit-vP_3yQSC=p+qmBLxKkBHL1OgO5NBQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhXbTZS3wmLibit-vP_3yQSC=p+qmBLxKkBHL1OgO5NBQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Sep 2024 14:41:14 +0200
Message-ID: <CAOQ4uxiTOJNk-Sy6RFezv=_kpsM9AqMSej=9DxfKtO53-vqXqA@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_llseek
To: Leo Stone <leocstone@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000065915e0623192cb9"

--00000000000065915e0623192cb9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 2:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Sep 27, 2024 at 9:10=E2=80=AFAM Leo Stone <leocstone@gmail.com> w=
rote:
> >
> > Add a check to avoid using an invalid pointer if ovl_open_realfile fail=
s.
> >
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git master
> >
> > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > index 2b7a5a3a7a2f..67f75eeb1e51 100644
> > --- a/fs/overlayfs/file.c
> > +++ b/fs/overlayfs/file.c
> > @@ -117,7 +117,11 @@ static int ovl_real_fdget_meta(const struct file *=
file, struct fd *real,
> >                 struct file *f =3D ovl_open_realfile(file, &realpath);
> >                 if (IS_ERR(f))
> >                         return PTR_ERR(f);
> > -               real->word =3D (unsigned long)ovl_open_realfile(file, &=
realpath) | FDPUT_FPUT;
> > +               f =3D ovl_open_realfile(file, &realpath);
> > +               if (IS_ERR(f))
> > +                       return PTR_ERR(f);
> > +               real->word =3D (unsigned long)f;
> > +               real->word |=3D FDPUT_FPUT;
> >                 return 0;
> >         }
> >
> >
>
> No, that's the wrong fix.
> There is a braino and a file leak in this code.
>
> Linus,
>
> Could you apply this braino fix manually before releasing rc1.
>

Too quick to send. I messed up the Fixes: tag.
Now fixed.

Thanks,
Amir.

--00000000000065915e0623192cb9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ovl-fix-file-leak-in-ovl_real_fdget_meta.patch"
Content-Disposition: attachment; 
	filename="0001-ovl-fix-file-leak-in-ovl_real_fdget_meta.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1kpox7f0>
X-Attachment-Id: f_m1kpox7f0

RnJvbSA5OTRkNWE2MTg1NWRhMjc1MjkyNzgwYWY3Mjk0OGQ3MjA3MDI1ZWM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDI3IFNlcCAyMDI0IDEzOjU0OjIzICswMjAwClN1YmplY3Q6IFtQQVRDSF0gb3Zs
OiBmaXggZmlsZSBsZWFrIGluIG92bF9yZWFsX2ZkZ2V0X21ldGEoKQoKb3ZsX29wZW5fcmVhbGZp
bGUoKSBpcyB3cm9uZ2x5IGNhbGxlZCB0d2ljZSBhZnRlciBjb252ZXJzaW9uIHRvCm5ldyBzdHJ1
Y3QgZmQuCgpGaXhlczogODhhMmY2NDY4ZDAxICgic3RydWN0IGZkOiByZXByZXNlbnRhdGlvbiBj
aGFuZ2UiKQpSZXBvcnRlZC1ieTogc3l6Ym90K2Q5ZWZlYzk0ZGNiZmEwZGUxYzA3QHN5emthbGxl
ci5hcHBzcG90bWFpbC5jb20KU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2ls
QGdtYWlsLmNvbT4KLS0tCiBmcy9vdmVybGF5ZnMvZmlsZS5jIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvb3Zlcmxh
eWZzL2ZpbGUuYyBiL2ZzL292ZXJsYXlmcy9maWxlLmMKaW5kZXggMmI3YTVhM2E3YTJmLi40NTA0
NDkzYjIwYmUgMTAwNjQ0Ci0tLSBhL2ZzL292ZXJsYXlmcy9maWxlLmMKKysrIGIvZnMvb3Zlcmxh
eWZzL2ZpbGUuYwpAQCAtMTE3LDcgKzExNyw3IEBAIHN0YXRpYyBpbnQgb3ZsX3JlYWxfZmRnZXRf
bWV0YShjb25zdCBzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGZkICpyZWFsLAogCQlzdHJ1Y3Qg
ZmlsZSAqZiA9IG92bF9vcGVuX3JlYWxmaWxlKGZpbGUsICZyZWFscGF0aCk7CiAJCWlmIChJU19F
UlIoZikpCiAJCQlyZXR1cm4gUFRSX0VSUihmKTsKLQkJcmVhbC0+d29yZCA9ICh1bnNpZ25lZCBs
b25nKW92bF9vcGVuX3JlYWxmaWxlKGZpbGUsICZyZWFscGF0aCkgfCBGRFBVVF9GUFVUOworCQly
ZWFsLT53b3JkID0gKHVuc2lnbmVkIGxvbmcpZiB8IEZEUFVUX0ZQVVQ7CiAJCXJldHVybiAwOwog
CX0KIAotLSAKMi4zNC4xCgo=
--00000000000065915e0623192cb9--

