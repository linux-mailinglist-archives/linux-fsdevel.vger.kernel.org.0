Return-Path: <linux-fsdevel+bounces-45505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F4FA78B91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 11:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEF57A4548
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF02356D7;
	Wed,  2 Apr 2025 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="A1F6fpMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106118D
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743587652; cv=none; b=l2hJDy69wkeBGHNvtmu4y9sHcWJUBu4ApuQV1+WQ5EJTjmgsiyjYQ5HEVuHYQ8qJRmaVec+bLROSQbJ9c03ZhqDS6z4Thwdepo1aCRkLAVAExMoc7UkdM/ThJlIgtg52orlOkceI69w5NkJ+YgiANaKqJSUiGFs6YooRyA9pnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743587652; c=relaxed/simple;
	bh=QsGJocePWgEys7ERZDjJSJa3c7y7WK15axnvcomcXCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNJg3o+/dhgiMaL4eK5ZkM5Yrl4/hDuLQzKcHwZhqWXmnTvOFG0tb/2azbOKh4nbyifyIxTAxdBfQvQ8v3nYWLVHj4RnHYDh8s92fj5qXg5El9WOS4HFQoIx6D6b0FrdscXMbnNWpp8nlKwPgHHclDQb0Y8vxwwmaB2Anb+qUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=A1F6fpMz; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4769bbc21b0so58618311cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743587649; x=1744192449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QsGJocePWgEys7ERZDjJSJa3c7y7WK15axnvcomcXCY=;
        b=A1F6fpMzKNDx+kLvV7eLHoxDeAf5EvfbupJlYujHidxJUyIEVZAV++WBYXgdUS9/zZ
         5k3V1EMfJQ5s1snPPWXQR/sHq/A+0J5Bp5m+Bq2/IdYlHuBKeXZSg7Tl8kNvpoNsvcED
         s3UKPOmN5c9rs12+1F8xdCCqC5Wr9Rh/6YsXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743587649; x=1744192449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsGJocePWgEys7ERZDjJSJa3c7y7WK15axnvcomcXCY=;
        b=rmYovVL33uy9r3S0eei3FO73xi1ApxszRAV1D8JBUWAoCpQ0Aw8MbCsvUQJxnpwvZF
         EhixQRr1mS5uYSn5SoNq65VGCkxSr8eu0hNjXhE5DvfjGDKtWtHu0a8W5gytnyoWU1/t
         T41uOpL/KQ1XeY0JcytHfKlAuG+/WUuEAiCTwxlVbGUmoGkIEhZAuOi4dUURrbUCq4cu
         P7Z3OmvW8zqcnwCaH+eLY0YsgGU+dKXt3ZFRG+7vbCNm48+Fi88T/Cuf52Hw/YSKDIro
         6vIH5mf2UiDYIPkElWMwqmS7afQdc5DFNOvG4GlyLjqqbju8cC6NQ0dSjmvnyGDtr5JS
         T6MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEuO6iAyBLDKixQYKgyjsF1+9eJw9nQjeVlXe92QJrSRE2YFXWBSetORMBxkkKl7PzXp3gzC6GhaCR67ww@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0AyenNP9mtHMmPRzf5q21pRSudm2Ywjou0PiexjFp3ir+KWY
	vykxpSPshtxVryu7fy98PqnU947mrwunANB7HtiwHwTZu4HkZbP1m7pvxS5wrtZ1fm088y0E5zD
	s5wK9UYVsK9U8zl62j+H6kC9EJzZ1LjFVfgT7YA==
X-Gm-Gg: ASbGncuAjMioE8++x5AU2gnDkkMc6XGyul3dJAFNpfL+qT41dI2oAWiRr59A+e8Jzuw
	pufvGibYBVStQ40hxeQ9769UaFOl6FRKfJxf8rUYZMUuXascQoVOqxWMw0zAlMyJncdSpXS4wz0
	WdWecf9eXFy0iKYC1K8Xm/PTT2Ng==
X-Google-Smtp-Source: AGHT+IFO4yhLjmSj4bog7EudUIEUJHYM2bkoDh2fwu/pLE6OmTeNQhAHgR7KchPODCgXJgkBK4tzB2tc+3+4Jj7rlHw=
X-Received: by 2002:a05:622a:5cb:b0:476:ac03:3c2a with SMTP id
 d75a77b69052e-4790a03cb15mr19871671cf.43.1743587649097; Wed, 02 Apr 2025
 02:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401194629.1535477-1-amir73il@gmail.com>
In-Reply-To: <20250401194629.1535477-1-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Apr 2025 11:53:58 +0200
X-Gm-Features: AQ5f1JrrY2G_4dy14qgiJW_ZK0jwjneRAJRt01C6TGC-5AlCncMyPVziWoQ2nZA
Message-ID: <CAJfpegvsiRZ3F-g2WNtOhyN5GiuckBke580Ne+rX97Kmgfte2Q@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: Document mount namespace events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 21:46, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Used to subscribe for notifications for when mounts
> are attached/detached from a mount namespace.
>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos

