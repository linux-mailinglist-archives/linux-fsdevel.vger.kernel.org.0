Return-Path: <linux-fsdevel+bounces-8695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302AA83A673
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50231F211DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 10:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026918654;
	Wed, 24 Jan 2024 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbSlMkC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8318EB2
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091123; cv=none; b=ozpzWpIY7iQ26uLp5vu/ViClYUWvtCw72WrYxiuGekXxgmq5IMnaX8VWPAD9IlxlUvad6ubuiVFl943qc8wYYicRtNP2mUH6StjM7pDIRrXytwGV/1pM74cAYaVX7sLVWIB5Yw4PAxbpOL9GO3n7cWQG7s2rwBAgNLSXF1nA+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091123; c=relaxed/simple;
	bh=gGdCXMj1+SakUzt5LtDBJY4BNy2EkmbJOpe6v0OniAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaMak0QDXT1+5GQQwLAVcOnqLnV8Hf23IADToeNZrSAmtTWyzUiTqYPqfVNN1aC+FxnvDK7CTZxYz8p/ArjYfUX5seC+tceCaVvy4kZkOcOaOi7pZBInbqcCF1UZxwiVH1nvzfRFwgg1oED/bxj/RTFskTQfaoxwX1d74ome19s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbSlMkC0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso12937a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 02:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706091119; x=1706695919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0dfYPbVXfk5SHs/iVuFsnBUb4kmK2ZHh+R+vrVHhv0=;
        b=JbSlMkC0foUSsQnXhPHn94T+l7jc2R9r2aZ1Lh5/qPR75kH62uhKzqReCEczmDCCE+
         YkgzLH3ReNdom0x7ltjvUyhBXnRM+dg5K6/idAQvv7llg6LMskHXKkKof+cSRyIluhgf
         wb9JX+wgmsffp4VQ6SG2Ow9ZpZuLJ3q3+VFzYtVi/FqODw8uzRkrDXx+e/qxNvzNiKDs
         omu2U1PytammtAfIJgbFJMJGDosBi57A3LGA2LnlFbRDM2bVQnc0v/8kdMz7AI0EeQBl
         oqjBi+ET3YjgbVu+GmsZSF6E0ER13mgWkXeQWKjVJ3Hx65I3IpO8r9fU7lu7xTnklCuE
         T7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706091119; x=1706695919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0dfYPbVXfk5SHs/iVuFsnBUb4kmK2ZHh+R+vrVHhv0=;
        b=obSP9JjCaetW6IHHZCQid8euV411XGyTAufj/mPvF3j4XUyAAMwRgNQEwnXoIt1Kid
         uQeXtQ65n9hFNkUfTdSbjWTLMUVf0f4MUUbjrSl5hY1uxN96oxOPcL4BtPuODEINTzS2
         tK4ldDu3Jw6/DHuE6FzHL1DPaF71zDUShvsiSI6x2HmqXvMpYxrQrqCaIueqQ7fzpA90
         QkJQBgm/+F79pIGHVeHKiyV9iBLhJznl9RqDsbzQ/ytFdF8rODf5eT9GSQTDysvURPiY
         dQv7oqtwh/+R55WghqRfw19m8xzQ95BFR14SwErMcho5NiKmfYUS93a2jeyd7DH1+6fU
         bOMA==
X-Gm-Message-State: AOJu0YwLUt1wIad30eeiJ4dzlD0Yt7Ng28Tqpc4+ZfCRP3OU6m4JSQUa
	QGpz0ly1WOINZCi/7Cwr9pOj3eDtZUWpaY1a+4SYUHJd6q8YW33IPJeD2GqBCv4InkbNdfYyyHe
	APMFGCjGZOJWj1JEdhe7o16itesEG1yGSppm2+NSM/mwzuYBToveI
X-Google-Smtp-Source: AGHT+IEv+2qSS2pv4rZ9VBB2DT8zXK7L7mYtmD72FrK+uY6AgAGcZqRbyGfOEabfIGTLcaRg2pqq+FKwhBjgQukqWXw=
X-Received: by 2002:a05:6402:1d84:b0:55a:4959:4978 with SMTP id
 dk4-20020a0564021d8400b0055a49594978mr38863edb.7.1706091118505; Wed, 24 Jan
 2024 02:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119092024.193066-1-zhangpeng362@huawei.com>
 <Zap7t9GOLTM1yqjT@casper.infradead.org> <5106a58e-04da-372a-b836-9d3d0bd2507b@huawei.com>
 <Za6SD48Zf0CXriLm@casper.infradead.org> <CANn89iL4qUXsVDRNGgBOweZbJ6ErWMsH+EpOj-55Lky8JEEhqQ@mail.gmail.com>
 <Za6h-tB7plgKje5r@casper.infradead.org> <CANn89iJDNdOpb6L6PkrAcbGcsx6_v4VD0v2XFY77g7tEnJEXXQ@mail.gmail.com>
 <4f78fea2-ced6-fc5a-c7f2-b33fcd226f06@huawei.com>
In-Reply-To: <4f78fea2-ced6-fc5a-c7f2-b33fcd226f06@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jan 2024 11:11:47 +0100
Message-ID: <CANn89iKbyTRvWEE-3TyVVwTa=N2KsiV73-__2ASktt2hrauQ0g@mail.gmail.com>
Subject: Re: SECURITY PROBLEM: Any user can crash the kernel with TCP ZEROCOPY
To: "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, arjunroy@google.com, 
	wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:30=E2=80=AFAM zhangpeng (AS) <zhangpeng362@huawe=
i.com> wrote:
>
>
> By using git-bisect, the patch that introduces this issue is 05255b823a61=
7
> ("tcp: add TCP_ZEROCOPY_RECEIVE support for zerocopy receive."). v4.18-rc=
1.
>
> Currently, there are no other repro or c reproduction programs can reprod=
uce
> the issue. The syz log used to reproduce the issue is as follows:
>
> r3 =3D socket$inet_tcp(0x2, 0x1, 0x0)
> mmap(&(0x7f0000ff9000/0x4000)=3Dnil, 0x4000, 0x0, 0x12, r3, 0x0)
> r4 =3D socket$inet_tcp(0x2, 0x1, 0x0)
> bind$inet(r4, &(0x7f0000000000)=3D{0x2, 0x4e24, @multicast1}, 0x10)
> connect$inet(r4, &(0x7f00000006c0)=3D{0x2, 0x4e24, @empty}, 0x10)
> r5 =3D openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)=3D'./file0\x00',
> 0x181e42, 0x0)
> fallocate(r5, 0x0, 0x0, 0x85b8818)
> sendfile(r4, r5, 0x0, 0x3000)
> getsockopt$inet_tcp_TCP_ZEROCOPY_RECEIVE(r4, 0x6, 0x23,
> &(0x7f00000001c0)=3D{&(0x7f0000ffb000/0x3000)=3Dnil, 0x3000, 0x0, 0x0,
> 0x0, 0x0, 0x0, 0x0, 0x0}, &(0x7f0000000440)=3D0x10)
> r6 =3D openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)=3D'./file0\x00',
> 0x181e42, 0x0)
>

Could you try the following fix then ?

(We also could remove the !skb_frag_off(frag) condition, as the
!PageCompound() is necessary it seems :/)

Thanks a lot !

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1baa484d21902d2492fc2830d960100dc09683bf..ee954ae7778a651a9da4de057e3=
bafe35a6e10d6
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1785,7 +1785,9 @@ static skb_frag_t *skb_advance_to_frag(struct
sk_buff *skb, u32 offset_skb,

 static bool can_map_frag(const skb_frag_t *frag)
 {
-       return skb_frag_size(frag) =3D=3D PAGE_SIZE && !skb_frag_off(frag);
+       return skb_frag_size(frag) =3D=3D PAGE_SIZE &&
+              !skb_frag_off(frag) &&
+              !PageCompound(skb_frag_page(frag));
 }

 static int find_next_mappable_frag(const skb_frag_t *frag,

