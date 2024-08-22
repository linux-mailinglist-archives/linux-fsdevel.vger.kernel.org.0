Return-Path: <linux-fsdevel+bounces-26726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F91A95B6DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0998128713C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02661CB33A;
	Thu, 22 Aug 2024 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RJjWqYFg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957F71CB30F
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333562; cv=none; b=itao1w3XFWfFgQdqx19UNlh+OnFPuSYvg9Gg2lDctAkkqCMo1qsB53e7w0isn6PHaY5fzsYiB9e07Ymk/9ZuNUEG3NgniMwGPPigGK0VR3gE3YjU1dO1YZKsmNO49nzVpv86ZEkpbAciwDBwV1cI4aCbNVki6Hk+9WrpJUjdOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333562; c=relaxed/simple;
	bh=Lf9V6fCYIzF7uJsd37I3JGDUO0MwQp04hM5OFcip8cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6PbgNbUotG9g3SlEEG0KusxWfzVt2uqw6ROsdc7tEbVXTiT/oogyHbZubTDK1JD4yEM34ZsVID9YYKiMqUmUCPGelE8aoFP/SD3RhkJPLI2bWLClYbykqO9dAX36OGovke5+QGug/KKANOmr6j6kAquVVQk3P/DjNWIplQuk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RJjWqYFg; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso1005310e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724333559; x=1724938359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dgJuqwjtLsqyzeFlzrgcjfBD8cjaZKtP6bxn0dldtik=;
        b=RJjWqYFgqJhon7kDh1B9SPKGT8hR5dFUgy39eLG1NzV8qhh2YTRyTClJba/EsiY+uW
         /50uFAUMAbUjVOKT31ui1pPihyMiNuKY+eQd2kl5FmWH1xNM7n8zZIXGYkWevFaFeh5S
         AwJYJ9Zhto9LvxrPDNeRQTGxA0s0j/u8VZ0pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333559; x=1724938359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgJuqwjtLsqyzeFlzrgcjfBD8cjaZKtP6bxn0dldtik=;
        b=ErunX01FqEzAtGFmoCBsDAMfk7/wzZ8iYOH5hmHlYmmnFFVYL8R/+ODDn9s1y6BCti
         nZJc6RMOoPlTs3Bh1E2hjoM64mWroXGrEoJg7WaDCjeqiE4w8zXs6mkD+acc+31tBC3F
         AVGsXj4wQNXQfUJ/e0+jsmy8W1riOKhzJvYqH3m36dImaRPpcNh3XjO+sSFG0bmBlIqZ
         JuDdQvy5tfGG/NomPNBi4zkEl8hoNa/vlD3AC6aPZFgBP/SJIn5Gx5u6Hl+4vQW4tvRh
         /UaztG2poVK/6NlmKvmwpxulJjtc/1y2ZfP/2eGGM98ifot8UxyzKOoRstcRTpUh/lWy
         O/2w==
X-Forwarded-Encrypted: i=1; AJvYcCXTalnXI6ZIw1jZjMNIL2CONJ+GiZQHNoXmyKcMSocZMgkMAyVsM03OwIOVDJmh4PuB/7kv75GlxTktFfwy@vger.kernel.org
X-Gm-Message-State: AOJu0YwgF0lu+hFWDht910yvcMMP8bD8Y/NnrehASlQbKmMSeilA3Rq2
	bLHe1sZqrTXd9niUwlf6Hy/3uoHuJQLEbSkvCVKFBsU8GNuNvwzYPseZtc+BYSui3gI4/F1L5AU
	QCMxYONUhJ/0whZ85CGn/UxBbQAYn2xYqCONsUw==
X-Google-Smtp-Source: AGHT+IFxNxuP3oMGnbzWP9FzrEwwGRUp3/JCB+vBes1tnAcy1svABdOqo5NFhOzDuT85yBCt8YtTorS/phZDihyIgSA=
X-Received: by 2002:a05:6512:b16:b0:52b:c27c:ea1f with SMTP id
 2adb3069b0e04-5334fd59032mr1323306e87.55.1724333558605; Thu, 22 Aug 2024
 06:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <792a3f54b1d528c2b056ae3c4ebaefe46bca8ef9.camel@bitron.ch>
 <ZrY97Pq9xM-fFhU2@casper.infradead.org> <5b54cb7e5bfdd5439c3a431d4f86ad20c9b22e76.camel@bitron.ch>
 <ZreDcghI8t_1iXzQ@casper.infradead.org> <CAJfpegvVc_bZbL1bjcEbEh4+WU=XVS94NMyBPKbcHzAzyxM6_Q@mail.gmail.com>
 <ea297a16508dbf8ecfa4417cc88eef95b5d697e8.camel@bitron.ch> <CAJfpegsvQLtxk-2zEqa_ZsY5J_sLd0m4XhWXn1nVoLoSs8tjrw@mail.gmail.com>
In-Reply-To: <CAJfpegsvQLtxk-2zEqa_ZsY5J_sLd0m4XhWXn1nVoLoSs8tjrw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 15:32:26 +0200
Message-ID: <CAJfpegtNF4yCH_00xzBB1OnPBHk+EP0ojxDPp=qCFVKC=c14ag@mail.gmail.com>
Subject: Re: [REGRESSION] fuse: copy_file_range() fails with EIO
To: =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000003d0742062045b1fb"

--0000000000003d0742062045b1fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Aug 2024 at 15:14, Miklos Szeredi <miklos@szeredi.hu> wrote:

> > > What I don't understand is how this results in the -EIO that J=C3=BCr=
g
> > > reported.
> >
> > I'm not really familiar with this code but it seems `folio_end_read()`
> > uses xor to update the `PG_uptodate` flag. So if it was already set, it
> > will incorrectly clear the `PG_uptodate` set, which I guess triggers
> > the issue.

Untested patch attached.  Could you please try this?

Thanks,
Miklos

--0000000000003d0742062045b1fb
Content-Type: text/x-patch; charset="US-ASCII"; name="test.patch"
Content-Disposition: attachment; filename="test.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m05bnet90>
X-Attachment-Id: f_m05bnet90

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGV2LmMgYi9mcy9mdXNlL2Rldi5jCmluZGV4IDFmMWQ4YTAy
M2QzNS4uN2NjNGY4YzliODk2IDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rldi5jCisrKyBiL2ZzL2Z1
c2UvZGV2LmMKQEAgLTc4OSw3ICs3ODksNiBAQCBzdGF0aWMgaW50IGZ1c2VfY2hlY2tfZm9saW8o
c3RydWN0IGZvbGlvICpmb2xpbykKIAkgICAgKGZvbGlvLT5mbGFncyAmIFBBR0VfRkxBR1NfQ0hF
Q0tfQVRfUFJFUCAmCiAJICAgICB+KDEgPDwgUEdfbG9ja2VkIHwKIAkgICAgICAgMSA8PCBQR19y
ZWZlcmVuY2VkIHwKLQkgICAgICAgMSA8PCBQR191cHRvZGF0ZSB8CiAJICAgICAgIDEgPDwgUEdf
bHJ1IHwKIAkgICAgICAgMSA8PCBQR19hY3RpdmUgfAogCSAgICAgICAxIDw8IFBHX3dvcmtpbmdz
ZXQgfApAQCAtODM0LDkgKzgzMyw3IEBAIHN0YXRpYyBpbnQgZnVzZV90cnlfbW92ZV9wYWdlKHN0
cnVjdCBmdXNlX2NvcHlfc3RhdGUgKmNzLCBzdHJ1Y3QgcGFnZSAqKnBhZ2VwKQogCiAJbmV3Zm9s
aW8gPSBwYWdlX2ZvbGlvKGJ1Zi0+cGFnZSk7CiAKLQlpZiAoIWZvbGlvX3Rlc3RfdXB0b2RhdGUo
bmV3Zm9saW8pKQotCQlmb2xpb19tYXJrX3VwdG9kYXRlKG5ld2ZvbGlvKTsKLQorCWZvbGlvX2Ns
ZWFyX3VwdG9kYXRlKG5ld2ZvbGlvKTsKIAlmb2xpb19jbGVhcl9tYXBwZWR0b2Rpc2sobmV3Zm9s
aW8pOwogCiAJaWYgKGZ1c2VfY2hlY2tfZm9saW8obmV3Zm9saW8pICE9IDApCg==
--0000000000003d0742062045b1fb--

