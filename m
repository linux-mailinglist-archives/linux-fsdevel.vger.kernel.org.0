Return-Path: <linux-fsdevel+bounces-13613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C82871F70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 13:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C653A1F22997
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0459E85920;
	Tue,  5 Mar 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dKC+KEve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC684FAE
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709642626; cv=none; b=XX3dl7IaAg8wEzN59NXdS1AV8Qg2QGRaNkRaSXN6YNZgrlzCbAugH2AKo6mDs+VIyYBYTkbdRi3HSVgerx5WWmhMKZ35ndeGQZsMQgWbeUIKxD982Ko42N86Z/PT/mbKjAN1HHCoDs0EkmISwwlfxYSYOQWEkbiQqT04KziQBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709642626; c=relaxed/simple;
	bh=hqXu4Imvd+YZYd3LEDpX+ZnPOXEZjX0E+C7N/22uaKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKmpfLfUzdUhJDMkmN2FuS6/ucTDcWjkIy5xZRoEGVxdz3kN5ad4AFRutdCweYG5blMe1es7QXLU7evo6n7AouyT3bj9NUMQ/OCt82NDMnm4Nd/5lxAK1Ec7IZ61DpxWNMLo4Y/udmGeQekfNV/jYED4OlwTT5mW8ZoLxQh7Yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dKC+KEve; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51320ca689aso6769732e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 04:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709642623; x=1710247423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hqXu4Imvd+YZYd3LEDpX+ZnPOXEZjX0E+C7N/22uaKY=;
        b=dKC+KEveoMrJox2JYoN1rvvJPEQQ5mCmK3iLWi4q4dPWC+fFRrXaIlNn1m/iKZ10cP
         nZeuPDRqkY+/3JruQ5n7cNfVoY9390s/JhFXC1tW0Qhc1LLfB2JFqWhBMHgPOxs48N93
         WQ+YO514bBN++CfZKG7X0nrtv1qxDtPJMscfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709642623; x=1710247423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqXu4Imvd+YZYd3LEDpX+ZnPOXEZjX0E+C7N/22uaKY=;
        b=Wt7N/yN3Wn4WM7V5CxquVQ3A2VdIYWyzB5DZbMeRIHil52Hh7Dci5wG+quLvNqeNHf
         t5n0JfiEu2wYC8hZOef4upq7kOl0uIrb5N/MqHaifX2yqADlBA6YAJzslKv+o0FjdMyu
         Wd2Zr2d9eqT7M6EjRApPi915K6TSiypr26I2oKi/oVO9izKG6McCS576zgJNA7GBL38T
         Tn3A6uzJ9ZCdsO/BxbexPx7ufqJ1IQ999yZ1iOA0SuB5LAIL2SodS/GppEGvdppisU/3
         iQa2S/FifJebO8jPBtgx2hxAejbsosYBtJMVgjHFJszW+sKlbsm3SfuMvNudZwHb+iLp
         q3mg==
X-Forwarded-Encrypted: i=1; AJvYcCXt2+caM83doKuRTXoVzPIEfYIcUP7aLg0Zle44I3PiC/PmpHjN81J7LC9XYOVTsw+Dy13qRdlS4oo3+s91PT2kM6JNtP2EkbDSYFOYow==
X-Gm-Message-State: AOJu0YyVzzsljpbZLUGibYWktqBo9OkKfOd9LxdVFm/ZHocp5f7xr1tx
	+Ji/GOzAapLxTXnS0+loMo1Pay6RHlHrhqwA39UWORmK+H3NqYBb/ZgJxTQbsSisEqqDatkiA4K
	1Oo4n/Pkd24gdtWit6bXpSrL9Jca4JdB3AVQMRA==
X-Google-Smtp-Source: AGHT+IFDaUTfRvZDVguiUspJ8bW9xNWfKoMVLiqWzzQ2oinl9J77SQ70Ly+nbCnni8ZMPAqYVspxryxBQbzNkvrnVDU=
X-Received: by 2002:ac2:5e7c:0:b0:512:f5af:3bdf with SMTP id
 a28-20020ac25e7c000000b00512f5af3bdfmr1088535lfr.68.1709642622758; Tue, 05
 Mar 2024 04:43:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204021436.GH2087318@ZenIV> <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-11-viro@zeniv.linux.org.uk> <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
 <CAJfpegtJtrCTeRCT3w3qCLWsoDopePwUXmL5O9JtJfSJg17LNg@mail.gmail.com> <CAOQ4uxhBwmZ1LDcWD6jdaheUkDQAQUTeSNNMygRAg3v_0H5sDQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhBwmZ1LDcWD6jdaheUkDQAQUTeSNNMygRAg3v_0H5sDQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 13:43:31 +0100
Message-ID: <CAJfpegtQ5+3Fn8gk_4o3uW6SEotZqy6pPxG3kRh8z-pfiF48ow@mail.gmail.com>
Subject: Re: [PATCH 11/13] fuse: fix UAF in rcu pathwalks
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 15:36, Amir Goldstein <amir73il@gmail.com> wrote:

> Note that fuse_backing_files_free() calls
> fuse_backing_id_free() => fuse_backing_free() => kfree_rcu()
>
> Should we move fuse_backing_files_free() into
> fuse_conn_put() above fuse_dax_conn_free()?
>
> That will avoid the merge conflict and still be correct. no?

Looks like a good cleanup.

Force-pushed to fuse.git#for-next.

Thanks,
Miklos

