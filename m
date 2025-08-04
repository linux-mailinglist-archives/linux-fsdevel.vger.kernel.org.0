Return-Path: <linux-fsdevel+bounces-56644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F284B1A33F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D3EB4E1678
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711126B2AC;
	Mon,  4 Aug 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="T4ML8oWn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB845029
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314243; cv=none; b=WKYVuYdOKxiJl5cXSS5c/k/iix+tAplMAd2FdVT8CYYtigWxXrv0i2ObQEIuc3fu/Fh0wzF2+Zm3umTknGdcxzi5ACszErwarw5HkGkb2MsiyjhsKG3DfGJ8D5NAAWD4QEBZlAqsPQtrOKExSD8chnihomML1XkLgxUf2sHNE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314243; c=relaxed/simple;
	bh=bFoOwfkzpdGbVKg/8VjkthkcsGob+US83lQ5IAa++NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgB3rEJWxS8cXZeUlUDRe96qn4hBi0MAoePDh3VqftkmuvaGJ3O/ngEx6Pyq9Z19VFBqGw2URV2PsEbp8WSL4P0ePM5geDGWtwZUgiIK+d6adAw642hWgzybde+FqTVYBPR3kyB6A3k9IBvllNmrU5y+H3kgQ+HQ7fjOIqmMbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=T4ML8oWn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4af1c1b5b38so16921701cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754314240; x=1754919040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P0DEJm4ykl78MCkCCnUIUGLbm0eW648bU8lzZM6Zg7k=;
        b=T4ML8oWnUOXuDeBLEJvjW4iRG+zgzlVQq8m/43KFn4jcCQPPtpRKhNNHh88UZfprJ5
         UYxtX/49E4azbMn+TG4EVCZwYch2V/cAyiFsFs0k+O2OGJXrMMwS2NFBoZ+HIofXA9kT
         QDxGRC8IMsDw+KNsMc49kEvHOzJCZKxkwBrCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754314240; x=1754919040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0DEJm4ykl78MCkCCnUIUGLbm0eW648bU8lzZM6Zg7k=;
        b=Yx2JcO0r4DXpcI8xutTah3TbMjXk1WtBOhMQXHzLtohb1mtfvNq6gS0LZKYZHOr5NO
         l1hQIh4BXlDb8/exhnejJ/fzMmvzjjJVNJqGNx4q1NPpfYZKRE9l7ZBn7vN6PmwF5821
         n1Htx1FsjA9VQOVxoJoFw+dCXy1Bg0wtxnEn/NCFcDq/d5YNDIlpY7xsllx3tp/z7sBD
         xnbtdd3tTHr22n3t1jcDNXJh507AkDlS/oCsv7Euk2zS9LrfwZiBnL+4fV1o8YurG+OM
         tMiTppM2cpfFs1zY2MhhG5OhumUjDHPf0MYAWjw4bY35po6CK+UKMbIFf3M2zMomDpI1
         epZg==
X-Forwarded-Encrypted: i=1; AJvYcCWdvOqVr9x+7ejwFpdyACiTPv1jQTPGwivP6Cyhf1VDowXR8o32aGYQxSEN8+t1V3qGGhqI8idwddI/aNQL@vger.kernel.org
X-Gm-Message-State: AOJu0YyVul/WZtFh368/CeHTLKEUE2WEcuAHOnT0UGKwgIOuh7lCEJK9
	y/fDdo/eq6ztuJmMGcQ7G7s2OVtRRpserTGuGrU4aK2tKewUYmmHKW/g0b4d2e6Oiikxpwb0lKa
	Qc3o9K9PKS9WqtMlaUkVsqXCMvadEC167oe/1+91dfg==
X-Gm-Gg: ASbGncsGizoocsQnDyXm/gUD72tD9UtsNQcUxXxjrjO9wsJuR6Fb7OyjgRf4jWiYgNV
	C1j8N+1TfL6ibO2vd0zwD8vWYoSoClupfCp4TxIooMu2bvIisObk5kSiKLEw/ICHgUKcXXbs9ZQ
	1CCbtYkyRx0mvTUUdnzevMyaXtLvjIvYSGnSfuHFkDhyNrHM+0EvGoS9dNOQ2shfrQmuxA79qSY
	J2Pc3PwGQOIrBwZ3T5Fy9GMdUDT
X-Google-Smtp-Source: AGHT+IGFrVNf0V7c35xNID5UvjWNSDTvtM1F6flQzsxXN+EbCJT+kclZAdeU8ofwKhqzMcWnT5Zz1M5pXcp9/xFZqw8=
X-Received: by 2002:ac8:5a54:0:b0:4ae:cc29:82a2 with SMTP id
 d75a77b69052e-4af10d54f0amr117404121cf.59.1754314239974; Mon, 04 Aug 2025
 06:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lhuh5ynl8z5.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuh5ynl8z5.fsf@oldenburg.str.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Aug 2025 15:30:27 +0200
X-Gm-Features: Ac12FXycZviWqMr6BQfOqXkebdWsgz_PSGKdoF2vPFms50tzfoPTnlZ48Ky1plk
Message-ID: <CAJfpegur9fUQ8MaOqrE-XrGUDK40+PGQeMZ+AzzpX6hNV_BKsw@mail.gmail.com>
Subject: Re: [fuse-devel] copy_file_range return value on FUSE
To: Florian Weimer <fweimer@redhat.com>
Cc: fuse-devel@lists.sourceforge.net, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 11:42, Florian Weimer via fuse-devel
<fuse-devel@lists.sourceforge.net> wrote:
>
> The FUSE protocol uses struct fuse_write_out to convey the return value
> of copy_file_range, which is restricted to uint32_t.  But the
> copy_file_range interface supports a 64-bit copy operation.  Given that
> copy_file_range is expected to clone huge files, large copies are not
> unexpected, so this appears to be a real limitation.

That's a nasty oversight.  Fixing with a new FUSE_COPY_FILE_RANGE_64
op, fallback to the legacy FUSE_COPY_FILE_RANGE.

> There is another wrinkle: we'd need to check if the process runs in
> 32-bit compat mode, and reject size_t arguments larger than INT_MAX in
> this case (with EOVERFLOW presumably).  But perhaps this should be
> handled on the kernel side?  Currently, this doesn't seem to happen, and
> we can get copy_file_range results in the in-band error range.
> Applications have no way to disambiguate this.

That's not fuse specific, right?

Thanks,
Miklos

