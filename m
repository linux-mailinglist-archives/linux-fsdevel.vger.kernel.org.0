Return-Path: <linux-fsdevel+bounces-51406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9889AD67ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 08:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6DD7A7F87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 06:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5D1F2C34;
	Thu, 12 Jun 2025 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oGxaZFuG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594131EEA28
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709374; cv=none; b=bIDHtJu+wrOFRlbyPV8S8lXVLnXs1Rwra6+P4Y0fx3pYskB/ueWp4QSIw6XmeMXtgMJAoYq4XkkaUgjh0yC7QoSF4DZQATNOqxCvZw8noVL8dgiB8g5ssWtx7j2B15+WcSP4LZZ8vM5KzgYMkUlJ4QgudC+2Wr1jZMRzM+bWqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709374; c=relaxed/simple;
	bh=NVSA+aFvs1XO3TlVQr3XMhBpHu6vTAXKDoH9mbxB4wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMXC9PVDOJx9g6Q9NctOP9CBzR4qnt0sBga0FW3Mu7i6tcICAqGBq37HB3E2TL61Ue9Alrk5g9+GzE+kUsCVBwLhWf1eS4FGo9hhkSgJdJv/OBtnxPZrGm5Ume/DNH/FMijxLwpasmyf96iIpeKyIc3oOsQ67Jc9iqydcaKy8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=oGxaZFuG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a58e0b26c4so9992181cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 23:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749709371; x=1750314171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NVSA+aFvs1XO3TlVQr3XMhBpHu6vTAXKDoH9mbxB4wc=;
        b=oGxaZFuGzg2ustNbGNKVleQsTCAYnk7VpaJ0pBE0Gu8xGCkdCeklfkUPIOh2gENeiw
         x2L8jpg4makVjVhiLxNf7ijMxO2AdHtxQR/B9h40D+xj6j2lq0MaHkz2MPJTT2JsnnVP
         mPVl1APKyY2GvXrRK2KTlcBFkougfQYVw1Z7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749709371; x=1750314171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVSA+aFvs1XO3TlVQr3XMhBpHu6vTAXKDoH9mbxB4wc=;
        b=Xwb6gX5+mZyDkC8MAVjOwHeVlNNN/YccsN2Cu4jBf2l3HZ6QVLZ8GE2m9UwNAW22LT
         3FmXguzlMaIhHEoTGqBjDiQW0ZcykAhUuEdHxcd9CSG8V/Zg4UQNegWS2IzGRhNHNJCH
         3oWAkBPn5CkwZKfUyK8HMaI+jhO8D5nwEXD2PV6Xi41qtFp/3lrwVXTktuKmf4KUdRzv
         jOwzm1dOTyS/KBKXhgSDAadKo+wmhKaEOGfaSSG0xHFhtxANw18CPMQLJ/4S60NAZXc2
         d4+tjvZRyhpF5VCkqPW3U25tvcDicJiDdvObZKjCEBQl/zf5ev+wu6d08w1uZ7f6v8r7
         b7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUegtV0MS++/D2enHmlw/IqYjBeyks5qhIZlbJhBPtR7EfzL2obhbWxLK5jfou/Em26h4N3usLBvnmGgoTW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkoq2f3EcIE+++6pDTgxiJtNqcUqTZ6GoK8SLOAsEFixdo9GZz
	u8XIQEKNUD3N6+TOjbTdPqk3X8dNkAtRyMMRfqlNSbGZXwK/ND+PValPhsJMIRI9baZ8S1wdLNs
	WSo/io9B+Bx3cAf8OT2QILz11p4yV+I7JoRBob/c/OA==
X-Gm-Gg: ASbGncv0sLSE93iCX3p39XjCRsIKHQj8kKb2Rlnh9rMAKvb6OBT/h+Ci+vYRFScrYvG
	MhykpWUVN3EoIAgHakbLIgX/BIWBlSojNd9oRC+iFXVzsxt1EK7r8sdtKpy8/Dmyjf62Daalt/R
	yZ5zVWpQs0HzNypUUFQiDXAT2Yki7xt40fsr9OqQOn0HTg
X-Google-Smtp-Source: AGHT+IH2I+YwhsNEN2W/f0jBkF1nxvsiE/H4QK8q+uPATGIvdhpGf8PYgM3jx5R7mR9gdQG0BY/Jl8TKR1yRM88Z5FA=
X-Received: by 2002:a05:622a:1e10:b0:494:5805:c2b9 with SMTP id
 d75a77b69052e-4a72298b30fmr46608091cf.31.1749709371314; Wed, 11 Jun 2025
 23:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610021124.2800951-2-chenlinxuan@uniontech.com>
In-Reply-To: <20250610021124.2800951-2-chenlinxuan@uniontech.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Jun 2025 08:22:38 +0200
X-Gm-Features: AX0GCFtg9rZdO_j-xlB7BjFTfd7v-suiRWlCa3w6oicMUUxJvtRI76Y9_mraJcE
Message-ID: <CAJfpegtF0KUw86m_NHFGUtnfcmPgzO88hv3AOs14=j_OQYuvbQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] doc: fuse: Add max_background and congestion_threshold
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Jonathan Corbet <corbet@lwn.net>, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Jun 2025 at 04:11, Chen Linxuan <chenlinxuan@uniontech.com> wrote:
>
> As I preparing patches adding selftests for fusectl,
> I notice that documentation of max_background and congestion_threshold
> is missing.
>
> This patch add some descriptions about these two files.
>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>

Applied, thanks.

Miklos

