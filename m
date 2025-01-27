Return-Path: <linux-fsdevel+bounces-40168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A08A20162
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2FD188617B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9B01DD525;
	Mon, 27 Jan 2025 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JJQAe4NB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2E82866
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019304; cv=none; b=cIKYcdHhXis6rJXQeBoNrGtdKuVWZ4kwuzN5HrhUlWHERsHQW2vfJhAOASXU5bsDz3GWhv7RtAfIpMu/RqxcoEyM6e/aOpuX8jBksVPTghE8Y8I2uPGv0BimHw9FqlCVkPV6IRAPlHOElfemxjQMc4tcejo5zc++QNdVXkXYsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019304; c=relaxed/simple;
	bh=QOQL2FpgMeqhUKjCESeMdc/2+HK0Ew/UHhtpqqHE3iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fiui2U+1Mj+tMS6GXyt8enDA3fpxjSieZtCoPwu+0LSH8X0NDRE8RGa2bhjZQ2fNR0vfyo1pAeab69sbFZv0ewOKLvaKzdKduSusRocqDeUeR/nOwJG2zTWOQl5I8LZaIgCzPgXEaVga7lO6bKSrb1HEp2vOKl7PlYJ6LrNujSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JJQAe4NB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa69107179cso1000803466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 15:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738019301; x=1738624101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EnZ1QEo4qVlctfyiBBDxkHDrhDsD5LandCWDWNa8eN4=;
        b=JJQAe4NBBikibcNS6MlNohUjATWIeCKt+DCRFLH91TksEfqTmXNNlFzPOmj842UVEz
         17nFaQQR4cXeAGc0CMMTK2e4Ip6ul5RMkng3rpvI2/iIojflpPtPxZQRc9pQgl24INyC
         FjhwVKhcNJB8LYA/bBX8wPolTDQC/lJOcaa04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738019301; x=1738624101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnZ1QEo4qVlctfyiBBDxkHDrhDsD5LandCWDWNa8eN4=;
        b=v7AgP+/VR0kLgu+VchJ/Do8oLJGryp+z/t7RV6ArJNF/0S9Jjd15DryJgqpBlQljGx
         q5an0c+255wuNIDKO2Xx0vx+kgr/En/fU8JtIlKh14SNzzpFWzIW7oEJ+3AmoiQl4LMt
         R0qvvMw5pdG9I4WW4MFDHHssncECo2n3Yvz0rz6/DVnRk1DjYIrOmLXladR9AulcZECo
         vyWjcNiDC4zMJFGd6XpyMCfT0tREFfuZzFr/BSEieklYmH15YZna/DOwLmxxy/SMvESM
         Rucnq4Ag6qxBqm23AJVUp/6fLmL+y//e/1HF20Qvml9Q61+TqlLj7T7eeGoWO2EJCETO
         j9wg==
X-Forwarded-Encrypted: i=1; AJvYcCXT6AgudqGtgoKv0N+9E+3dilf1lKDxLhvCzWweZ01CxH0M3ZMT2T0FJ2XEaIFoN7DlmJzbkBhvnJ+HGN0l@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8X3ccj8OHLGkh4JgkllbHjiDINKaKNndfLuFcQ0N2wM2RXWFd
	qbITYCmkMiJEX4ny/7cTlSUKw7X5Ij3dLB1jGNT9V6lX/LHHExYpjqaD44PVdTTQ2R2nuUxGTwW
	p79c=
X-Gm-Gg: ASbGncs6c0p2chlSH8gth0YYXoDgCe1or8MKT5EfEdXzQ1LnJFr86V5kOddQXQefdNu
	RQeMvW0mh0in8PdJN3JV4Vu+BcuoWb0kNuIVdcLaYXGF/cGAaAAsrCjAq08oBzLxOuvFf79KFGr
	DOwiFhwHSE9jP01tPagwOQ27JDkOtuPGt2Ex1eaiGgfaQVURO4+BaaM2phkAz5j7T+Aaq6x2px8
	nHVqNHCJV1zs9tc43yq2qq2IanKbUilGpHBORUE7QoUnUMRjCDa7pwzivDKyfhlrS8Pbv450Lny
	0FqexGqkubzGTojLWjrhiiPblEewZuh52V9WKinG4ZS8ukMrXBxpFgQ=
X-Google-Smtp-Source: AGHT+IH9EJYsq5i9addKL5TyTCtCoN0e1UM2e67KNp3wbtxX5snXqfDrAMZ1s6YW95IUJ1V8W3N+3Q==
X-Received: by 2002:a17:907:2da9:b0:ab6:597a:f5ee with SMTP id a640c23a62f3a-ab6597afa99mr2231650966b.12.1738019301055;
        Mon, 27 Jan 2025 15:08:21 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab676117428sm649942766b.182.2025.01.27.15.08.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 15:08:20 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1093288666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 15:08:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjEPB/a7rnWZPsPDhDSlxUy9NdgpxIpC4UdMnpV0gxZQ9+fUp1ELEbq2qxg5Z6F6GnKQfXOJ9pFLCKxfbm@vger.kernel.org
X-Received: by 2002:a17:907:3f9a:b0:aae:ee49:e000 with SMTP id
 a640c23a62f3a-ab38b106513mr3886359066b.18.1738019300073; Mon, 27 Jan 2025
 15:08:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127044721.GD1977892@ZenIV> <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV> <Z5fyAPnvtNPPF5L3@lappy> <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV>
In-Reply-To: <20250127224059.GI1977892@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Jan 2025 15:08:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixxZ0qSGp89FsT_9X_nen6p1T3=qJZ+_iZavRKFk688g@mail.gmail.com>
X-Gm-Features: AWEUYZmEzpUJmVw1rEwsSvBz2LtCxOdNo1VQpVy54FMsXW8_6RuHR6pZBYUD7aI
Message-ID: <CAHk-=wixxZ0qSGp89FsT_9X_nen6p1T3=qJZ+_iZavRKFk688g@mail.gmail.com>
Subject: Re: [git pull] d_revalidate pile
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 14:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Linus, does the following look sane to you as replacement for
> bdd9951f60f9?  I'd rather have explicit __aligned(), along
> with the comment spelling the constraints out...

Ack, looks good to me.

             Linus

