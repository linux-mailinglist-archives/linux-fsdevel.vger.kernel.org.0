Return-Path: <linux-fsdevel+bounces-13624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B247872144
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEFD1B271E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69386639;
	Tue,  5 Mar 2024 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="q0gH49ay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041086634
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648126; cv=none; b=PU2u4vkae1fZxy+Lqq8bbbh2aT1oNPLQXmmXiyx3cUgpNT6bLvBtD23oMlaWD+vtw80mDru3x3E/3z1f4Ffk6yFL8Fk/DvAODFKx4AX/Pg6CEkFlcS5UdKJP7aJBiP6YdMxMxcJ0el1RWtChArtei6I8XyOssBTQgGPKTD8rllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648126; c=relaxed/simple;
	bh=QsdGzhL+fCOCO8FhB0FNlu0id910oc2XXzXXLl0NfRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7BJQxp3faJSthMdKdkuxRqoMMwXJTI0xAKGBDcgSzSEpbrph6PyCnm97R7VLfClvs/2Wn8Kivh93rHI21plV4z2gbt0sVAabmSNelbc2jSgs1kyyJT5QUeokJ53X7mXKbA9mnw/FcxM56yLzhazVwc6C9YhTs8yD+aNR+j9EaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=q0gH49ay; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4429c556efso772389166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 06:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709648123; x=1710252923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+qN6o+pBuUZiE6aW8wZJuPXv9S9i537FwCR0xXcOtJo=;
        b=q0gH49ayauNQVQfuRM2PD7VrY4hPnd5YvT/WsipEqiY1YmdX5sNmvH974Q74mXSN/p
         1NYsPIim69+5rlMfCNP//lEbZ2BScnTMC8L3+WdDN+nAoL8VpzDAVzJqS51aYAg5d5E7
         ytaNXXeQHwDezH+sfqo4TXnEK3Qqn7C2+Rx4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709648123; x=1710252923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qN6o+pBuUZiE6aW8wZJuPXv9S9i537FwCR0xXcOtJo=;
        b=mrKuTV/jbQ5pb1IksnwuzoOeH5QouvBj38QPwS3aKbuPHHX1O9tEkwMePasD/EGKUa
         Q3Z7XRUMKtOxVEXEJL5ZbhCfPoOHBdn6YVJZP+cYmvu0dfxPpFqb/+yjsjs+OLA1J0tc
         HYEj0RmWV8NtSXocNvCmogJ/52U9ivMq+Ipa04xFpI32XRrE86CeKT40WEqpoXuPwlSR
         IGuf94EFt0D6vNrO7wlpYtxExJKZZmn9eLeqIfGjaNYIEvR0e56OAK/ICGDD+JFo42/J
         Mrc/H1sU7v2H0fGZeaTxetQvUexgNfSK5jrWrFAQGF72BaFSVWWIL2a7OLJekrCKNvif
         CkQQ==
X-Gm-Message-State: AOJu0YxY5I9Bc8WpzQFR0nWLgBTIj/ZhBMOCbL2DlS7YF76VzZDd7vT6
	qdhSnpy+bV9ILIo69UkQuawRQ3y4T9kpfFpGpkCN+0POIFvam9oA0EDVey7QUAfaX7sGluo7Zu1
	e/miTKPWszjI9i3Xxkes4CuEhOLfUgPh9ousk7g==
X-Google-Smtp-Source: AGHT+IEQVz8FQCPWncPk36eLLeFDG6gTV0TEt2FP9R9DY8ila7vunYnOfw1bEabhUhgzlLm+DAa539/xD4fqYLGv9J8=
X-Received: by 2002:a17:906:b291:b0:a45:a0c4:4bc1 with SMTP id
 q17-20020a170906b29100b00a45a0c44bc1mr1657951ejz.69.1709648122771; Tue, 05
 Mar 2024 06:15:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228182940.1404651-1-willy@infradead.org>
In-Reply-To: <20240228182940.1404651-1-willy@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 15:15:11 +0100
Message-ID: <CAJfpegtDz3f1df7ioSHo-Rhc7G0cwec_wTh4XU=h_6vG6V6otQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: Remove fuse_writepage
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 19:29, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> The writepage operation is deprecated as it leads to worse performance
> under high memory pressure due to folios being written out in LRU order
> rather than sequentially within a file.  Use filemap_migrate_folio() to
> support dirty folio migration instead of writepage.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Applied series, thanks.

Miklos

