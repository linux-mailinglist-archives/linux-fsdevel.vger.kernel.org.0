Return-Path: <linux-fsdevel+bounces-45268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3339A7565D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 14:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D85D7A5650
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931991CAA8A;
	Sat, 29 Mar 2025 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB4HGciT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEFF35972;
	Sat, 29 Mar 2025 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743254016; cv=none; b=DqpZIAegA9SkSV/P3W1kNNcTEIlbAs0kgZma9mxYzEB/90Hp8DSYma7QfD38dxIpuoZM9uDdDrt4uTy5hQIW/nDwB4yR/HNJDFpORLZCiF8PJiRnvT2WVkhODGWbR3J1D0h62aVKJxCtUO/+i1IrEkWmQwNcecQAap6l+cdYGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743254016; c=relaxed/simple;
	bh=k3ENnCvttoTHre0U8Xi/uZbxzNz8OopraBe46cPcNFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFjVMicnJe4Px/KXsKb7NvCUgX0/ls3+LqZ1GvPAK/QoHX2Fmdy0rV5TYlskLOXTJDoa2S/ym9U/0iqHmMO9o/x8VwNdVq84SFyhn3k6QAEjp/bS7ePqNGEY8OAw62lJDUEVunPlE5Z4J3lD+/DKJqWZZQPnhnNcGxuKUpB65oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB4HGciT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E574C4CEE2;
	Sat, 29 Mar 2025 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743254014;
	bh=k3ENnCvttoTHre0U8Xi/uZbxzNz8OopraBe46cPcNFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qB4HGciTPKzEk7PKVOQPn54NaNxY/jz6vqvYTirHN5MoLEK0YQeJ3e1uRxbbKZlFk
	 o02Jjtu9HoIs9ImMrFJ3GMW2aJ1jsw3IOnr0+JnmdJZv4OsGq7hW8XIJtK4ExWSgDF
	 kKbJJ1o1aId3ykmNiptFcAdxShAwgN0aCtphOMmAIa7cNh+3MJLn4XhUb80J6t3jFW
	 X99YkcHNQ1XJx4mqF2jWA6shioCNqw4nAbC6SBt+y6DNfaT6QdPoRCYBZ9kJawUGHz
	 qGGWRCcjJCH52aRmjufvCL6GBfFKbnGHr72n5FjuBeIPWwHvViJgzYqfLfIAjFAstS
	 ktzodHbYvh1qw==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c019869eeso1225000a34.1;
        Sat, 29 Mar 2025 06:13:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUV+VTepVlHv9YUoQD9kn14rhvFAzYNOioRNbR8kKo7vrYIRdbpy8IbPcfNMCRwKQm6lvwpTinU@vger.kernel.org, AJvYcCVJCNzJeastEYvdNTR2Uz8YYV5sBy7kDF2N5mkap7by48zwdJxs6Waz5y9/1+s5sTqMAqS1Yl9yJyl5Ahff@vger.kernel.org, AJvYcCXZ7ZbWu96QUUSbZjHD1wlSeFlhkk8WBeRPIRjQHrqVYeLsyjb+5p+5/9kw3Oz69om5EwM9GAK/AdtSBDJO@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+WpqmpIaye+FW+VZuvK0o7OMgXwgAXsieZagperIWCJpLuuR
	5hRtdEZlyGvTh5O65bYnA4ZZV7jMtibI4K8+W0/+TmFDX/Ccx/lA39byo41m+mYQ5I7gorD5QBy
	eK7AkaGsBwbvkHXCkU/RPGPIu5LE=
X-Google-Smtp-Source: AGHT+IGb7s9gfq5iGJMNRiyccjflHb1IPj491GUyTvFSrYg+i3gX/HLDhiktdy6SWUaq8aTHkGsIy+duWFL0Ccq1VtI=
X-Received: by 2002:a05:6830:710c:b0:72b:81a8:dea5 with SMTP id
 46e09a7af769-72c6380e676mr1774873a34.17.1743254013791; Sat, 29 Mar 2025
 06:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250326144918epcas1p1bf704db657010812a18e9fef5c3a6784@epcas1p1.samsung.com>
 <20250326144848.3219740-1-sj1557.seo@samsung.com>
In-Reply-To: <20250326144848.3219740-1-sj1557.seo@samsung.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 29 Mar 2025 22:13:22 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9Wrb4P+dNBCPiXcAdddkRxQ+2LTo-ocTBdziGLGZ_hZA@mail.gmail.com>
X-Gm-Features: AQ5f1Jp3aG0uMR5wNhC4FcXGtsoFgS6HK7XYP3G6TX-gC90furB2tBygi418j38
Message-ID: <CAKYAXd9Wrb4P+dNBCPiXcAdddkRxQ+2LTo-ocTBdziGLGZ_hZA@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix potential wrong error return from get_block
To: Sungjong Seo <sj1557.seo@samsung.com>
Cc: yuezhang.mo@sony.com, sjdev.seo@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cpgs@samsung.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 11:49=E2=80=AFPM Sungjong Seo <sj1557.seo@samsung.c=
om> wrote:
>
> If there is no error, get_block() should return 0. However, when bh_read(=
)
> returns 1, get_block() also returns 1 in the same manner.
>
> Let's set err to 0, if there is no error from bh_read()
>
> Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied it to dev with Yuezhang's reviewed-by tag.
Thanks!

