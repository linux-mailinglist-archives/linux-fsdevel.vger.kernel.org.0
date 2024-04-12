Return-Path: <linux-fsdevel+bounces-16754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385478A231C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 03:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3796283D73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 01:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBD4A2D;
	Fri, 12 Apr 2024 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHv7sw45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9C2F24
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712884000; cv=none; b=prv1XaMySEORJ4t7/Si+mwL+c6nYqj9P+N86vO/Ggo6GT7BojwQQOhjF9D0e2gQ2WCkJzI9HA0uBI9yenozcvPVnyF0fnyVSILOLrwPAWdCGS4SZwJ+RyoNBan7OvFDkMx6I6z1O0M8Or28Hsimw/WhFdNFTeaaR22SvMkqQgL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712884000; c=relaxed/simple;
	bh=3fE1H1eK1D/qbvqNb2PX9Himtz+6+GSKLYEwStNE2Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+KUI/XMu+3VSTrKuJNsgiBBNKyIroRIShL6Em6F4z3XzVrIGH08KBE6Jtavp0dYpu5H+kakOzO4PcEivHbwbyohpT0cTlyiNjtJMnlG7P/j7yabZIBwr5rUqmSrFbHZ1ktdMipAaBoZVCa0I9cHrPtzYNjKw7qtV3i5CtLgaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHv7sw45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F35C113CD
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 01:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712884000;
	bh=3fE1H1eK1D/qbvqNb2PX9Himtz+6+GSKLYEwStNE2Xk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rHv7sw45vVjkyrpdZHTl0pPl5iZOmgGYcWxn1PwEtSuI4WHPNdXV3rSRodLtVghYg
	 5amVweuRW12b/fQ24tXN/arYU4LJfRaeMHpXh0ikEMgNXGLJwAAS8MglIuh042nriO
	 +6P2HT1t0mH1sjUSE57QvG7gKO6HQqfOMkZ5WBoD1lbJPTWNmBjBfIgH9RZCzwXVEM
	 9PPfN5BHlUtJmVAJhYQmMfgO1md6NKj4KZypWbMnni8IwK8UBO/25FFy09p4Yp8y+l
	 izv2lAIrO8ATbZMbR+iv2WhhCi/e/BuL6B6Mk9+RV69mHM/purm2z9TnCLvMP3c/sa
	 smj2zSlq+iBcQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa2a4dd0ffso633298eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 18:06:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqOaczhoFjXOtg+IV/WSLRd/RDIsUgBXfALTddPkwMwCHSBJItSk1hiqHq8EVeBhC00YXh/qF03x+hTddjWS8UH4tr/rKxPXtghzFiww==
X-Gm-Message-State: AOJu0Yypg/iXL08Jx2/LNaAhLfPQAZmycf8LZYCaWaJTY8uwFWxQEOba
	7t9P7hAsu7kD6u3XYoWniuSDSbKDXigcATL9zEpedtW4FZYRAs/oyy4USEBFPiunJw54+5SCPfS
	Vrx5bP/IWPlY4AV41iyFSuIdV5jw=
X-Google-Smtp-Source: AGHT+IHy1hI/AQguNtP28199U/gi3i4sYeY0mov+k9F/4YHNI6bJGOntxC1mbJ94lvGpy2Ulsf9J7kJcnKO8c8yxiFY=
X-Received: by 2002:a05:6870:d394:b0:22e:dde2:3e30 with SMTP id
 k20-20020a056870d39400b0022edde23e30mr1692084oag.6.1712883999561; Thu, 11 Apr
 2024 18:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB63160EDE1B2FB47D80B717D481002@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB63160EDE1B2FB47D80B717D481002@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 12 Apr 2024 10:06:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9o8o2CPk_i2COJW4JrjNc0_BTha5dvm76X4=FiBnyeuw@mail.gmail.com>
Message-ID: <CAKYAXd9o8o2CPk_i2COJW4JrjNc0_BTha5dvm76X4=FiBnyeuw@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: move extend valid_size into ->page_mkwrite()
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Andy.Wu@sony.com" <Andy.Wu@sony.com>, 
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>, Matthew Wilcox <willy@infradead.org>, 
	"dchinner@redhat.com" <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 8=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 1:09, Yu=
ezhang.Mo@sony.com <Yuezhang.Mo@sony.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> It is not a good way to extend valid_size to the end of the
> mmap area by writing zeros in mmap. Because after calling mmap,
> no data may be written, or only a small amount of data may be
> written to the head of the mmap area.
>
> This commit moves extending valid_size to exfat_page_mkwrite().
> In exfat_page_mkwrite() only extend valid_size to the starting
> position of new data writing, which reduces unnecessary writing
> of zeros.
>
> If the block is not mapped and is marked as new after being
> mapped for writing, block_write_begin() will zero the page
> cache corresponding to the block, so there is no need to call
> zero_user_segment() in exfat_file_zeroed_range(). And after moving
> extending valid_size to exfat_page_mkwrite(), the data written by
> mmap will be copied to the page cache but the page cache may be
> not mapped to the disk. Calling zero_user_segment() will cause
> the data written by mmap to be cleared. So this commit removes
> calling zero_user_segment() from exfat_file_zeroed_range() and
> renames exfat_file_zeroed_range() to exfat_extend_valid_size().
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev.
Thanks for your patch!

