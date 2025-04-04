Return-Path: <linux-fsdevel+bounces-45794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64090A7C4D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 22:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1144C1898195
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 20:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967B20ADC9;
	Fri,  4 Apr 2025 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiQeFvze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD191F561C;
	Fri,  4 Apr 2025 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743797688; cv=none; b=Kh4t6DZX9Q+Kvr5ehEejsgb4LVsLp0YhCiKd+BWlpGpsd7SyO4WU9Z3ANaJmjwt7QVK1pfCqZ4VYclp7/D19D7dvLhq8R7Iyc/BYjtH/h0E/UtwbYUpxnqxan6LSyVO1Qgdj/iScjJMMf8fO8//z5tfE5VDvjkK0baFV3hbhToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743797688; c=relaxed/simple;
	bh=9giadCc401SMQ74ucp/TdFmdzRlEIqlCVfCL3xGUi+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgoxP7fl5zZC+1cKstDoVE2iGQFccE4QCbz5Ckb7atck4CcOrLQBgceKROIuEYN2FUihp3G/unagbpKtVUXEa24C36Qjw3BmRd/JKMeQiKn6FasuMiaUcK58pS0hcSJYVspnFw8gkrTZh0X+kUrLCFEzQefzo0N3uRZRPrQgHPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiQeFvze; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so4751120a12.1;
        Fri, 04 Apr 2025 13:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743797685; x=1744402485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pE76/8QLvJVpupgrz33R3U55AkeTCPlpQjIRUakF35Q=;
        b=SiQeFvzeGup574PRGCpXFWysNC/8N+spmuB+P7ZQb/TXnf9XXK4lvZ6LcOAUlwuywM
         fw32srDxy0Gtjo5cjYQ7NQ2RGdV3MbWYtu13KvSBBj8Z+SqNKQ3CHK+1yCHSOolINkd8
         +U78WfR1PRw2dBxg3PAdFsTr5eH2rN8greTy+Q+7mirmjgUznGwfkDGnxPC4aZFd3RXJ
         WLxVHIvQOt1KSrgVggCZ2HDKVAEMJDen0YPuik+OoHSOH45KA+s4/RLtNMHLFtmsMwwb
         UCRupZ0P3IU0kXKWxM1Li83Aa546lDyVOuOUhm90UrrcTHeqAfhTx8FRuralHgrEqtEb
         YgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743797685; x=1744402485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pE76/8QLvJVpupgrz33R3U55AkeTCPlpQjIRUakF35Q=;
        b=FEuCj9msoXtm3YChFKt93/wHvrsxd6fg8Zj8MBYlq/6LQAQQhHc3pbExf7GWlQjX9C
         zI58HgVGTL5bYlQeDLE6pTQ6seDHIgxw90FUAkb5WMGtIYrZhY+NAAjKuZY+ohIFOJiQ
         HgKszXWeJCR/vU+fJq3nygHr88Q2KtncxoT1DGNJyNQykiBw6m/NzB7HO3x9QiaulrW7
         eL6UTABgNE8PcU7KhYpooGDpmmPdAzlWHs8KMuYOyfroV7LS0bwLouu+JrXM72aDJgWV
         Ohq1B+SG33qFb//v3g2Xfs/FHtnXrTowyR3qrJUY9XN/Dp1ovyzNSa+DC7Hk+PpimXUm
         tTaA==
X-Forwarded-Encrypted: i=1; AJvYcCVnoK0Ekdxv7ikJ2wUNDs6KZl5z3hMgQoBcUGmp1EQrmtTKgoXdi171zfup3VjQwNp6FRgJADq5Ejc1xT/8@vger.kernel.org, AJvYcCWBCbOB2l6Lu92DsfuZT+706MYhwsdpFMtj+2o/urEEdDjlSTqMc3TyTqIJohpxBxN93H2i7D5t4vvPK1IH@vger.kernel.org
X-Gm-Message-State: AOJu0YwTh1SH8OcTPA8mDtIintjbK6A7BTguTAHyD2KSOkddjkESHZu+
	xWAFRoqfVeLxNtUS5qsH015mw7Zkzc2/g7KyeL2Wy1WFmSovLDWsVHHTD7oNiXwbzgG199kTjCC
	MekE51RUaPhMjFUs2hOovE6zY4/E=
X-Gm-Gg: ASbGncuW3MNY3nnW5Fowd/CkoszEjvKfoky0gXeOY44/eFfbJl5PvbqhvjUJh9wl0ra
	O33iihMZs26mKNGF/dEJ4UfXDZAYD5zWtxXVSTtAuqVXczY8ISuHL0u5kZVj5AhD59ze0WWiIjO
	2tWDeR97wNfESUIsvJ4uAeU+48
X-Google-Smtp-Source: AGHT+IF2uM8hQxN7HUob46UxRhgyv1I9Y3TAVUDDUaUyaEZB3P43PfThbj9yNRwxFlPFpEFGK7QMrvl39ISaPE+z5s0=
X-Received: by 2002:a05:6402:26c7:b0:5e5:827d:bb1c with SMTP id
 4fb4d7f45d1cf-5f0db8a1bc0mr368864a12.25.1743797684339; Fri, 04 Apr 2025
 13:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401165252.1124215-1-mjguzik@gmail.com> <Z--ZdiXwzCBskXQK@infradead.org>
In-Reply-To: <Z--ZdiXwzCBskXQK@infradead.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 4 Apr 2025 22:14:32 +0200
X-Gm-Features: ATxdqUFbN1sL6RdvrCs_3Lq3Uo04yfkp3yFxhLpT18YyepySmTNXKULZU8MREUg
Message-ID: <CAGudoHFcUBdZUBDFqWs4aLQfXyN4781-g-8x0mfBWwEMrTFQUg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: make generic_fillattr() tail-callable and utilize
 it in ext2/ext4
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 10:33=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Apr 01, 2025 at 06:52:52PM +0200, Mateusz Guzik wrote:
> > Unfortunately the other filesystems I checked make adjustments after
> > their own call to generic_fillattr() and consequently can't benefit.
>
> This is in no way a useful commit message.
>
> Why do you even do this change?  What's the point of it?  And why do you
> think making a function tail callable for two callers, one of which is
> basically irrelevant warrants adding a pointless return that now needs
> to be generated and checked by all other callers (which this patch fails
> to do)?
>

Callers don't need to check it because it is guaranteed to be 0. Also
returning 0 vs returning nothing makes virtually no difference to
anyone.

As for general context, there are several small slowdowns when issuing
fstat() and I'm tackling them bit by bit (and yes, tail calling vs
returning to the caller and that caller exiting is a small
optimization).
--=20
Mateusz Guzik <mjguzik gmail.com>

