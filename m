Return-Path: <linux-fsdevel+bounces-60312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C89FB449EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 00:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E24F1C86751
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 22:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B85D2F28EC;
	Thu,  4 Sep 2025 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcrrLVqH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF82EBDF9;
	Thu,  4 Sep 2025 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757026102; cv=none; b=neVSF8UULlszuoZhDeXw+XHRL5wyK2gG/I0r5zR8+ktAM4bTCT+Kia4Vk1Pioqjb707HFQ+4DeH0s8rROG8YZxERXXafHe0FXrwUQKGtAc0+5AjwCsykxlyIqBrMKpNek/q4O1I8eZVlVWtj7gpm9C443BsnALKAUgq46FvprF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757026102; c=relaxed/simple;
	bh=ICyy9jCm8mGvrXbma4c1Qv+718ybp6BVwuwxxXT+tpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zprf9iDwx4n1+ZcjHXVGtRbA8Xq/j9TiYiiZEFu+ReGzFQih3UzHrqcMObxjTB/OAmFqfQY/9v0DYFN8SVkGxwF+qpON9PIiGAQKqfHFhva6YK0Hz2GAiJkZxW1GAPQ5Si3DGt3XDS8xN/DPc2oinrACIhkB2OtuOSm8nCVk5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcrrLVqH; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7f901afc2fbso140776385a.0;
        Thu, 04 Sep 2025 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757026100; x=1757630900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICyy9jCm8mGvrXbma4c1Qv+718ybp6BVwuwxxXT+tpE=;
        b=lcrrLVqHLqTo6dd7vavVGIqAxN/RVRrpjHs9PNf6TzzMiUKPICl1EYTDvXVim/NeUo
         PG1W8TbpXYmn6HNrUw47j1Dtjep3xPrvrduOSzmDg5YyNDrUzgyotMkTSnAetHpjiBI0
         PedGGaKbx++qxp+WnC7SOSgf70JrLB/ne8u4s4+1y6u6Xm/75A8tVOCVzpOsAJUh4TFy
         BUOsNYd1ZFGzhol0ufGUBeCDRUhmgVhYcGa7J4vNZHDEmDgS+v0cQXn1zuaEp2uj/JTt
         MDutLFDJ+cbuOcoYixmi3IYaWEKRczPypomIyudtMPSov+xUFg1qjWFso2ADYQ4dYuQg
         v19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757026100; x=1757630900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICyy9jCm8mGvrXbma4c1Qv+718ybp6BVwuwxxXT+tpE=;
        b=QtkqDRen+IZ2Egi2cJoUzRkZ/onP4CQBRt9IChPFJWQb4J2NR1YuSzrM37tT7qyaNt
         QQvIP6CjoX9xIVqe0JqTdYuLiFcaNIzVDa/CKZMz3ARVtNG4xJD+XpVMSHM312pNA7Gg
         N1OrW1sNtwe+jI6y37tVpqqQpIiLy+WSPfmtTnZra/rvr4A8H/TnyKNFsgzIjwZ2LoGx
         JOtLLxfTF9uP/ZarLHMwRivUFYHQNITYtKzvonvvddFXVazVWh9LxcTAFnzpQX/E0Gni
         Ry2B4tRu/+pRpuxxwkv5DJKGNBX0OzNBTKSyk+MdYdiySH07ssV8ObznjwqiXrlRK5Ol
         IVUA==
X-Forwarded-Encrypted: i=1; AJvYcCU4TcNWfIbDArsv1h1mWSP1Y93ABFHGoC0ImQi26jXLCdeBFLcOkgiEDPYP1W7AcQGBg+rLIB9C7PyLT36Xyw==@vger.kernel.org, AJvYcCVG/IFodZrr0WIqBOO0JVMVXc2ZpcvAVN9e8Aic4Vzu81MxxKCRGsCk5RxqZf/YuIuxYTyl8iRZPVE=@vger.kernel.org, AJvYcCXNd2jcOQCSEfu6AIur8YoOdqnGiWNj8FPgq6nlSjy5TX91BoneE7QEtz6SV1vZAefowM9l0tuFVYI9@vger.kernel.org
X-Gm-Message-State: AOJu0YwjtuLbALO96JODzsCt3PlG81TuhyVBppdQUV3kuhwJvxQmiMBz
	LVFt4dH6TZcjfHxr3EUdQSF2oDl/IMODwt41MCI1alB0MbFEYkVZn2UrfpgWs8UJJYB93516zim
	A0P44vglPFxP2EfVxZAcpsHKZsSmd458=
X-Gm-Gg: ASbGnctYhgk4FfkiDTnAs6Tzqtq4iMch3M9pLJe05K8xeFog91DCXSAeLfxO8ZXk7lC
	FT0wtMZcKtbkEi6yhe/SIOcSQxRQ5ge608+iLm2+ZonyQ8kbuqUqwRay2XgTNvRpwanaEgXwaHO
	dEmCcyFarLVDNslcHtOucMzuUb0X6G3atWgIYVEmconWFJFkS4RGGFPrktoyTNj8TdFotTYG+Ll
	3FVVuvd2I7FQVopY0M=
X-Google-Smtp-Source: AGHT+IG1RJTc2OZYkU3OkI+kTREToPaTWbKrOC67KHUozlRXHifc45rbhEOOYjtpCSof2r5ElbKHS5GrtOy90Lf1r4g=
X-Received: by 2002:a05:620a:4628:b0:7f3:c6ab:e836 with SMTP id
 af79cd13be357-8109a54dc48mr179099485a.18.1757026100075; Thu, 04 Sep 2025
 15:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-9-joannelkoong@gmail.com> <aLkuZFPT5ZTtK_gQ@infradead.org>
In-Reply-To: <aLkuZFPT5ZTtK_gQ@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 15:47:51 -0700
X-Gm-Features: Ac12FXykHIIhLxFrU3SV4nktlulARYxLlKN8XnU8jFJjRQepSS9HYbfxQsR7p0E
Message-ID: <CAJnrk1YUNVs2pQJZMhDAPXxCPN7zpgoNOaCqRBT+-eP1jR_3Tw@mail.gmail.com>
Subject: Re: [PATCH v1 08/16] iomap: rename iomap_readpage_iter() to iomap_readfolio_iter()
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:15=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Aug 29, 2025 at 04:56:19PM -0700, Joanne Koong wrote:
> > ->readpage was deprecated and reads are now on folios.
>
> Maybe use read_folio instead of readfolio to match the method name?
>

Good idea, I'll make this change.

Thanks,
Joanne

