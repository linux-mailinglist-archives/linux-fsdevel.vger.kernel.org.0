Return-Path: <linux-fsdevel+bounces-72221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0061CE85F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 01:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F030D30028B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 00:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D259314A91;
	Tue, 30 Dec 2025 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYjCSXys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC846B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767053018; cv=none; b=IKxKMhqhDUB7EFu/bVuaNtld+lQaB2S0FCstgZZbvTYw/6hDzJ0vbJW7wO6Flseu6sAbOAVN7jzJEoRmi27yn9wwye3ms3j2XnOGldUKaK2vOTR25P894q9oNPL8IahVFpOAolrsI5MnAsVM9qs64jZg4wr3ScoLP9mITTXUJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767053018; c=relaxed/simple;
	bh=5mzkhqhuIgD1bfkTQx/SVuKodN+MLNgrHxEykpipJ+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts/aMe+PquDgPj8UEvIjoHDC5rKilxrChIbuIomm//SARSzBu39hiEoIl8CJ+7QChL4+APH/odByeGLXASnjRZUpfAFcquWFF0B8D7Rn1T+7wieH+utA5FDgoGiGMu+9Eb0cneAwfIQq9iSZgwmbr9F0E64GE/BiporPwR/Btl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYjCSXys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF458C2BC9E
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 00:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767053017;
	bh=5mzkhqhuIgD1bfkTQx/SVuKodN+MLNgrHxEykpipJ+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qYjCSXys2J6i0NC/EGUV8j0WRYzp8RfHXw++duQ7LPodZDQhyhtVWAZN/bsB/DfCN
	 ex9aO8aTW2v6AKGiHZx/0vM9Ze1VLRmkUC4/2zju9QTN1eqcAr2h3dr5IxwGovzG+I
	 QXxlap5rBrCSdtCBMjaT7vE5E/j3rGvNi4lYcY1o9Ei2fJ5aTlPFAMf2gn8Tw3r/4c
	 i4xiTeQv5348Ib882nMv/DrrmNWt+7zKdKAG3whM5zsBpr9hRwxkRVx2+MbBW9Bjud
	 VOdan41ZYvDLHFdqb0aDtjDzQnZYbn/c8lKaEtUrZYPe3XOKgDFFRKONHVxbSxBYDf
	 tLY3P/ousGz7g==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b727f452fffso1681645866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 16:03:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW877Yy6TsB7oWi1POtihdwIO88fms3h6PE+iJp/uBhpTzbcIlR7geYhsThT7/qQiyu3wXLevLQ73r7Ys5F@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHZguL/ChnZDiOZSAOEboC9rdp8gHfELqaS4VnKIy/PF2nfOn
	GfCAOmjnwGx8ONpAzk41Ao+YQ2ZMpzWzl9oaLlOdslxYxuw676d3pbCo9+CnAdVujrBbiYMERFj
	SjIkJHMAd2YNWQXz19Dh2eoj/mVN5TJo=
X-Google-Smtp-Source: AGHT+IE4aR0mspxMjH8ErAs8YbBz4uwA+h1N+cWuFJffhC7G+y4GctRDek/vDyFCnE2N5UbpCzyEZvOGWxTJQv1DLRM=
X-Received: by 2002:a17:907:7216:b0:b71:60a3:a8b9 with SMTP id
 a640c23a62f3a-b80358bd67emr3562093966b.29.1767053016240; Mon, 29 Dec 2025
 16:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <20251229105932.11360-13-linkinjeon@kernel.org>
 <aVKvIENB3ihYo6dJ@casper.infradead.org>
In-Reply-To: <aVKvIENB3ihYo6dJ@casper.infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 Dec 2025 09:03:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8wTuU4whPLDN9_vd5Fhv-7gZ0gCLF8w_ry8tqM1Nn_+Q@mail.gmail.com>
X-Gm-Features: AQt7F2peVdDaOO0z1wZJnWjArK7UsJucTC4LDvDnHwd9Q86RZlH9t4X-gNCyLXE
Message-ID: <CAKYAXd8wTuU4whPLDN9_vd5Fhv-7gZ0gCLF8w_ry8tqM1Nn_+Q@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] Revert: ntfs3: serve as alias for the legacy
 ntfs driver
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 1:41=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Dec 29, 2025 at 07:59:30PM +0900, Namjae Jeon wrote:
> > ntfs filesystem has been remade and is returning as a new implementatio=
n.
> > ntfs3 no longer needs to be an alias for ntfs.
>
> I don't think this is right.  If one has selected ntfs3 as built-in
> then one still needs pieces of this to handle classic ntfs
> configurations, no?
ntfsplus has been renamed to ntfs as you requested. Wouldn't it be
confusing for users if they probably expect the new read-write
implementation to be used, but instead the read-only path from ntfs3
could be triggered ?

