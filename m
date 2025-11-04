Return-Path: <linux-fsdevel+bounces-66926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1759DC30B55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 12:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5110A4E67A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E922E7F14;
	Tue,  4 Nov 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhxN7y0H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DF2E6CD7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255413; cv=none; b=sM6jP/d+g6/w0u5nOAgVs/bAo1rIreSaLDx/G29UdOyL1sWhNLOKyrTOZYCXam6ZAukoFvaORvccCNVBIqIi7O/kqBmshyMy6W/iJKzx6x1VobKB6/X1sR0VMREupGq31p9potfnQAuWybpVN09k7A4WIaJfmv/AgTRqrqFu4wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255413; c=relaxed/simple;
	bh=8QvCktKDhf4f1u1Vq/VpczdWKHQQCXDw1Hw1+e9GXCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0sqhxewx0ZIxUviF5bUY9UNJm8Xe6pLy/ZgrjNEN1w/3jFD6LPJMb+/Bf4OHWaCH/l4tx4nFQ/rvMhbp9Beu8IM/0A/UcottZ0DAVV/c8lWex7UdXgu7RHmjo/ZF2SFNFR7SNrUd+RdWEwuxBeLz14g944lGU4uHDDKVewEMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhxN7y0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD3AC4CEF7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762255413;
	bh=8QvCktKDhf4f1u1Vq/VpczdWKHQQCXDw1Hw1+e9GXCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YhxN7y0H1E6tHFRZe+H2txAymbTrCtUw+gw05ImGrvNAPeqOtJZ0FoWot/BUb/5aK
	 kOEPQ45GhTYFTguqtUZ7Si772nQcNwfdkgsE1HGDJC51T932I29FY/D89eLvCJOdQn
	 A7OA4VhSeJc9wWK12t04+jJ3cVw+1q6GmL7/wfUgSnCWga3lsYg8o9tS7j2nKMCiVu
	 /m6UJ6cctd/LBKAHiBggKg6SLXp9hUzg7r4qwEK3L5jMJ8llwC4vLY1vjGLiGDl6b4
	 k8sijLI6/I24WytXYRVHG8bGlUnZxL49QEqfkXO+G3zFWGJ9KFP5CjWgacl1vgGyKi
	 jibQZbtvgHfpg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7042e50899so943991166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 03:23:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXI57kU9N9euUX52vE1xaOSBjIGTr75B5pJJsq7TarHdkekcYmJSSs1mLGPLX2h1muhL5bd4BepuVd8C+d+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+8Hm6cEfQs4epKfBmNSYG3FrahWibdEo06ZQedfMTMQ0YgRF
	HudIKCdyTWC5UF1ZgyEbqkRsvtmfLTCeTctEXnUXBz63dUUF8pH+ZJmXoNW/v/SsaGAq1pgnt+N
	OiIFgPNQ1N9wDrGa/XzKKp7EplWBdNzU=
X-Google-Smtp-Source: AGHT+IH7LvDNSwoTpF4soNgCygU7sKSb5+rshVWIelKN+H6EyJT9JU/5OphYh+TJs6a21nLr+KJr6DuIz1aY9u05PJo=
X-Received: by 2002:a17:906:5955:b0:b70:7196:c8b3 with SMTP id
 a640c23a62f3a-b707196dce5mr1166773566b.61.1762255411837; Tue, 04 Nov 2025
 03:23:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
 <20251103164722.151563-3-yangyongpeng.storage@gmail.com> <aQndHokFr0ouIEAq@infradead.org>
In-Reply-To: <aQndHokFr0ouIEAq@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 4 Nov 2025 20:23:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-APJnAaKv+HXQQWf5eAJDV6foTxRiMAY6hUjVXn9V33Q@mail.gmail.com>
X-Gm-Features: AWmQ_blghmPbTPJSBe6UZI-JxbMb9_NX_eDplsi0aFEhQKP7xTARlzSrq5ZjKwE
Message-ID: <CAKYAXd-APJnAaKv+HXQQWf5eAJDV6foTxRiMAY6hUjVXn9V33Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>, Christoph Hellwig <hch@infradead.org>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Yongpeng Yang <yangyongpeng@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 8:02=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Tue, Nov 04, 2025 at 12:47:20AM +0800, Yongpeng Yang wrote:
> > From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> >
> > sb_min_blocksize() may return 0. Check its return value to avoid
> > accessing the filesystem super block when sb->s_blocksize is 0.
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Applied it to #dev.
Thanks!
>
>

