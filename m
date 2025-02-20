Return-Path: <linux-fsdevel+bounces-42142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB81A3D118
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 07:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B9D1889BFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 06:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7FE1B2194;
	Thu, 20 Feb 2025 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDglXJtR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4E179BC;
	Thu, 20 Feb 2025 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031317; cv=none; b=GynV57Z2SzdLNHY4uP3ax7yI5MBbut2gv7KloBpBHeAT8UZ5VojmqfWFMcD7ANwGhQlq47N5Slp39454YlojP0gojRKJpnRqhEZ1eLCLwJu1GlBtEFY2V11dslvW9btOgr1ZXtirgb0gQ6ngsoDa0745X00HNO2Fz5C3Z27xm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031317; c=relaxed/simple;
	bh=9C7GalXDNpRN1s0FWvwP3LdMQ/uTcVOs3vy246T4DcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8p0aqU6A50dyWh35fQ9SLF+dgvBOLdFxh14XNNJyRq7JfBQ9MOCLkmwt1azrAkplHmIbhq/niLEtQgNq+h3DaKrmYV2F4xY5ROc+i9UZQj5O1nDw/jCwWrTIKu910eoCpRxxwHHvvv9RQflsVulLfqjyF30pxmWv7IUK3/nL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDglXJtR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so651911e87.1;
        Wed, 19 Feb 2025 22:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740031313; x=1740636113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1TUOP5JGHi5U7PjVMb2rHP874qjAsCEPguVt9MseEI=;
        b=mDglXJtRF2ymFX0F7A55ncRPtDXuUd6+Wo4EXkUVJVBeoG9nfL42RX0w/PsYVtXKve
         SB5EmDG0j8hRmLtVXiQQmpkNuQnvdlGmiGftseBfvtBMhfNxWVxmCnvbj0hzMuIIl1bM
         ctJTJKC6f1LC4XZPF8IszQiIyPc7daSedY6fBnKjPm8dTav1BD7PuvQwaFais3DfUn1c
         Q5tba32kBlbMQXK6COg5UfJpqtwSbpyuPoXZzEcr88hy7l3OuMJ4SB4+gbRN7gkn0Woj
         IjhcJh0gCIcGObKYJay3UjxXn7KSq8Q7d6MVhOFEDALXgs8tlOhoNxI030vgA+zoYpKK
         OdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740031313; x=1740636113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1TUOP5JGHi5U7PjVMb2rHP874qjAsCEPguVt9MseEI=;
        b=XvXfxyjcQxEg5jHSos4NubDx/yOQT4/WiMCARYRrVcwUqCFcBmz01pGFyNwG1VEpBU
         c2H1HcNOEnmaqOf1lCjYBguBVLbnjDmaVoCWtjWpg5YuwQUckESV6uNeE8KfxNqZe8oe
         ScmmuiwGKNsaXzjphWqgr0Mft9qNIFdx1+lHy2hYUYjO/ozKaCILwhKKs15iuzyC52Oj
         XtCDmfKPeiLnfFF5n8pnhZbbE3nVP0JYjxpGN97V4TNJu0gNgwTvbM/CDrJLPDY9zpUo
         4NxxwdSfLK655s9zqCxnjb5S3ZmSkZv7152Mk9b/kJ91CgG96KpNzjc77g4UV0LFs2a8
         7MaA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/jdwnnfdO+l//Ug7WvH+1W7mTpey7Rfgix8A0UtGuAGlIGrmZqQQhKcbAr6iYPR1cK1ez/YRfDA4tGHA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuqmro9YHx4hbSp9L+K/JSHURfXItp+Wgj6HEN48Y+VFqwI3V/
	tDbo+EdGycNdFjuqO/KfKJpWszwYHR4hzXZu1BfeHv+egOhVSv/eC1/u89DCk71/GjgWdxssq1q
	lrzzA4UTUdLnTHB0WuyXk0XgIdEwwVOaf
X-Gm-Gg: ASbGncu9ObD0/IgHMABUL17pXV/wi5rXeHrOh+5WpMuHq9CM9kj4PK/LlP42IYJWKks
	bVMCjEYDOHaqcyujy+wZjlvUvGPpxM6nDD4/HXjSnJD1HFENidm6jLJyOeTp7CClh3MQZT85/
X-Google-Smtp-Source: AGHT+IEnW2vZIlFxU0c5YKA09HUsOM3D6VZ4G8gwcFJJiP2s9hIU5t9LZQzWQCPRRe2KRO7hUMvPEkEhg88iEHIRrJA=
X-Received: by 2002:a05:6512:3da9:b0:540:1f75:1b05 with SMTP id
 2adb3069b0e04-5462eee6fbcmr3005253e87.19.1740031312414; Wed, 19 Feb 2025
 22:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mvgkPdLQ_oz_faa=4CVCaHNDcNVZfqBbdKTENrW5COSTA@mail.gmail.com>
 <526482.1739982363@warthog.procyon.org.uk>
In-Reply-To: <526482.1739982363@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Thu, 20 Feb 2025 00:01:37 -0600
X-Gm-Features: AWEUYZll2Jfq_2grz7XzNP4Xg8dKU2recFJJmsUbeN2KjQTGAauBHyOagA1jAEU
Message-ID: <CAH2r5muW+LW8i9VDB9_WknzAo_ubXJEKiY10k46OxKVLvqXHbw@mail.gmail.com>
Subject: Re: netfs read failures with current mainline
To: David Howells <dhowells@redhat.com>
Cc: CIFS <linux-cifs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

test cifs/102 (a test for handle leaks) does appear to pass with
current mainline (it should return "no locked files" in the output)
but here is the test:

# Test for Open leaks
#
seq=3D`basename $0`
seqres=3D$RESULT_DIR/$seq
echo "QA output created by $seq"

here=3D`pwd`
tmp=3D/tmp/$$
status=3D1        # failure is the default!

_cleanup()
{
        rm -f $tmp.*
}

trap "_cleanup ; exit \$status" 0 1 2 3 15

# get standard environment, filters and checks
. ./common/rc
. ./common/filter

# real QA test starts here
_supported_fs cifs
_require_test

mkdir -p $TEST_DIR/$$ || _fail "failed to create test dir"

# Create a file to test with
echo "hello world" > $TEST_DIR/leak
# Try to kill a 'cat' when it is opening/closing a file
(for i in {1..5000} ; do cat $TEST_DIR/leak & sleep 0.0001 ; kill -9
$! ; done) >/dev/null 2>&1
sleep 3
# and verify if we have any leaked filehandles
smbstatus | grep -i Locked -A1000

status=3D0
exit

On Wed, Feb 19, 2025 at 10:26=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Steve French <smfrench@gmail.com> wrote:
>
> > cifs/102
>
> What's cifs/102?
>
> David
>


--=20
Thanks,

Steve

