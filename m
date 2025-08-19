Return-Path: <linux-fsdevel+bounces-58304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73303B2C69D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3AD3B842B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A3218AC1;
	Tue, 19 Aug 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="J0LjJdue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828AC2EB850
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612454; cv=none; b=DsvbDobMuU3QLAPaWa6nfCyzHbbezymEtoOKu6TsVNxuJA32ZTlECid1ftht6G+wAUI6GJjK96YlCIFxyyFRkzHKu0qmfe9nrj1UCBQqwKem7iegwhTu4BXvIHLPFNhfpXjRAFBNmd01++cqGbv3M8o38JAosO8yRs5JtEx6C0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612454; c=relaxed/simple;
	bh=I/r7XFfAmZT7gE1c9PozZ4C2qUQHNUKLRFQPvVIdUC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdgEHIqLaAWI6XU/vGdV+iqWZiXYkGyEXYjQiiL5n87YVYESQH3T0srxKMuIK81VzhL3KuDevkO+azu7l2+wzm7Nf8w7xfAUDid/LsIscYq6Pt7OwvXc8+aigy7utc2a+m8i/5Jd3lIN5YK90Job+Ewgt6w6qOdIC5JMumsPL9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=J0LjJdue; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b133b24e66so19309101cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755612451; x=1756217251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/r7XFfAmZT7gE1c9PozZ4C2qUQHNUKLRFQPvVIdUC8=;
        b=J0LjJdue71a+qYjzMx+CQjn73jm0Od0nLJupjShdsW5TAaD31FADG4T9WR/Aad4bze
         AlJerWoK1jvfGIwMRp4AyM7PRC8mMwW1Wy6Hjnmrx2kw7KcBvUg1767NRI6Z2DtGqZxk
         n/z3ztMa8vs1BeCeoMKAvxtjcY5HCCbn9Hk9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612451; x=1756217251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/r7XFfAmZT7gE1c9PozZ4C2qUQHNUKLRFQPvVIdUC8=;
        b=r6EE5j1or6kZFGk6H3lRCh3slZKebvjr8dYkq8XBSvMRKbKdkN+80jh7Qlf28xAOor
         qmMSeXT4oCFPNw+ByqzLzF/NuLVXJRXcqkxe+MUWxloWSEdI3rBko/Wg0jwR8qO6F8f1
         XUyCRTMZ7d7cBia0qVEfWmIaJCdtfUO7FzZGFJvlbeDzyhk8A3RPNh8hfn9i/p9ChrQQ
         HXHGE6Bbah4wR34MRg+UacgRUCH+o3sy2icG2n94lPlAoT14Ia9G1rpzetlqusui+xeu
         jglRlRBq6qtnURjlUcR5pvVAlxQMqC3swrERRA1z8MjdbcXXywCRQTIRfDorANbUQxKa
         luuw==
X-Gm-Message-State: AOJu0Yw5uUlfoVFGjRq9+FelEEuq5zJHtbnzGMAJHs+5y2Kbu+RWYgQG
	zx1rLyMzAlqXf1nKUYKJURIyUZ6lWjQnRTVz4eUsUaziRz+u3E63fVHzofFLr0Wbuhqm7G3MTMU
	Xg6bzuloZRLB25httZEnbwCiTsChCSDCHcHN4tcBiyBgQrIujdwUs
X-Gm-Gg: ASbGncsnVygE0Yn/pik4MPmotjNZilaNNfSUsX0bQNS5wOKFVsdTqt4DqImi0MF6UrZ
	4YeyvgEHkKrZ5urTaIm6v70JYuyGc01dGD+mK/Z/KqifYqLqiwjbIdmySMQ/tAKq0E8sYuFv+DP
	XHcy93HRzhCOb4BwhkoCZTKKNeFqZVnXft0vleHkNn5/Wsr2q1/4GDRAHIPuaHw+RZMgiWXlAQV
	4wjeipOHA==
X-Google-Smtp-Source: AGHT+IEm+RDY4x+KUMjDy2xSe/+nwcq7x6ypDW5zM5ME3kChnUS0sUlVc9tK6EdPKsiQBcM6wp5ioyyEcctMgWEXnIE=
X-Received: by 2002:a05:622a:1801:b0:4b2:8ac4:f083 with SMTP id
 d75a77b69052e-4b28ac4fe9amr13087951cf.65.1755612450990; Tue, 19 Aug 2025
 07:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818132905.323-1-luochunsheng@ustc.edu>
In-Reply-To: <20250818132905.323-1-luochunsheng@ustc.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Aug 2025 16:07:19 +0200
X-Gm-Features: Ac12FXyDNAF4QEKI6FENCC8ukwJbwkgNXuP0OKFGWgQOjTPz6NfZYwdmQefpnMI
Message-ID: <CAJfpegsz3fScMWh4BVuzax1ovVN5qEm1yr8g=XEU0DnsHbXCvQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: clarify extending writes handling
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 15:29, Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>
> Only flush extending writes (up to LLONG_MAX) for files with upcoming
> write operations, and Fix confusing 'end' parameter usage.

Patch looks correct, but it changes behavior on input file of
copy_file_range(), which is not explained here.

Thanks,
Miklos

