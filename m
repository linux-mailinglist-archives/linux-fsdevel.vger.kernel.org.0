Return-Path: <linux-fsdevel+bounces-20314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346008D157A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F96283335
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F07347C;
	Tue, 28 May 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QR+UxKYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45694D5AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882406; cv=none; b=fe86A/1yuyD8fl/yLDUiANTC31iSogTe+k+jXGskAUWhsi9xRQK9+k+OlDeiAAt0dggc1DZhGWNVLJHEvZDnxv5kut4amKElrNMtgfUadx4m53hLpBLWW7KLQfrbcZEvcXtfwvZcOGhOAUurf8OkXIwPqGvNWiP29PAozETOo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882406; c=relaxed/simple;
	bh=lQBm+txKkb0wgL6NnmmxdOP2NJmTDpJ9VMzSHsCqbUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeDJeyXxQhVsP6SE+f/Vn+VwCMI4+lJq66J9AHupsiBHvZj6ZQbofy88uy5xov5UT8rXqoUzxJzG5IKwYbdExy/DRk0xDN4JaW1B2ybN7gAUIrc7yAq+43l3/W/Lkk2xvqEUe/5nz1GqPaZtniF23WKXj1pxmR4gAFHN7OVBJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QR+UxKYm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a62db0c8c9cso47179266b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 00:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716882403; x=1717487203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQBm+txKkb0wgL6NnmmxdOP2NJmTDpJ9VMzSHsCqbUs=;
        b=QR+UxKYmAIurPcvYsQ49l2RvA8e6X6z++XpqBQUXw2aD8GnikpHbmW4SE1yQeKKghW
         kWCoC/Dj26/7fcOx7m/Ppqua+hyGlqTS3M55Xpc8B6AS/jSprW5WwdGo/ObQtPIu9Eoy
         JjGjn0dLNk+JlcwhlXpTxotuKL44aEEBpO3wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716882403; x=1717487203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQBm+txKkb0wgL6NnmmxdOP2NJmTDpJ9VMzSHsCqbUs=;
        b=PzW7pHGmyiotHXBlrB/vy6IG/dvSam+M+LxcM/dxFPTohn1btDtmojtExrGSn6h2No
         pSiC9xEPdF9EpaEUXgPN907403xv2EiswnLDuN+kdwIlzX05s1RYZLbXxDvGydFPTPwz
         RNBM92JNYFl832DZBz5JRDaUWuvtsmBc9J+EW1rzgscfVLvVNcHV3lVSYkFtYi2uZcYw
         4nO4ntSoucUOjL+jHJyzqKTEHIaFE5TjNBLB1KnOoucejHRXTg3G1JmR6HmbTc9m+CYm
         E0tixJmfVvrvSK+w2T1d2bLh0uj3jg97KufCfxKlkZC0iipY8yWTZVLXD85X+BZQCAa4
         jHZg==
X-Gm-Message-State: AOJu0YwvOPi/cWQ6/Flrlt6By+L7jM1XTT5BJmWGeAJy/4h5j9T8CazZ
	17usrbbatn+GdTcyQm9Ax7/mUmySVNQ/W/U/IbcncoguJVYM8W2cw9wo6vpaGGaCznl9jAq3cYu
	yFIm2Gxnjqre5fhNaOOYAsYlOS3b1Ig8KL6H46Q==
X-Google-Smtp-Source: AGHT+IF/Ew2plZF2Kqsv63rBiWqN/s4Z7WvHoNaXunztjkeSXCfGTAIOFFjx29aG9ozCzDr14ANDgCJt6bbZBNrL8Gk=
X-Received: by 2002:a17:906:b0c:b0:a5a:1bd8:b7d9 with SMTP id
 a640c23a62f3a-a62646d61a3mr1087023066b.46.1716882403140; Tue, 28 May 2024
 00:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
 <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com>
 <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com> <6a3c3035-b4c4-41d9-a7b0-65f72f479571@linux.alibaba.com>
In-Reply-To: <6a3c3035-b4c4-41d9-a7b0-65f72f479571@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 May 2024 09:46:32 +0200
Message-ID: <CAJfpegvxbqrBsU3QMnfjT0bhK697UdQqdgcVDYhthWhu4t2UyQ@mail.gmail.com>
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	winters.zc@antgroup.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 05:08, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> There was an RFC for kernel-side fdstore [1], though it's also
> implemented upon FUSE.

I strongly believe that this needs to be disassociated from fuse.

It could be a pseudo filesystem, though.

Thanks,
Miklos

