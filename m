Return-Path: <linux-fsdevel+bounces-39295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21673A124B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A761670D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A862419F7;
	Wed, 15 Jan 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNLboc/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487EF1F9A81
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947732; cv=none; b=dJboaNtFlVG1KSpJfH/g1t0Y9YlnI7QQksDyQqX/xC9YK6Cy75Xj+9nJHQagEC+2zxPFwW+OhfAQTQr/OjC6s7Kdxn1nQINjPHL4dL672apu15TbQFVACiwpwlFMwNyy0fpCKU23QzDXf/QfTg5f9Ui+tAsHbBOIOFyn+s62glc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947732; c=relaxed/simple;
	bh=dRBtdBIsIBp/bcoo8ZihGHj8zYl9funD16dxlAiO2mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/daSRqfgxqaxpmr9GObYaFD2mjQSSrPgMqIRP15EwRDMmpuu1jvD6zE/0fCjqScXHrv/jubklQ4zjSnUmVMbtt6QXxqKSvagZp8DUYnO1JXFo/fGV6kLZWyjzcJk6sUVFxnDBBuK2V4DvkDWHGe5Lq8GQJmyXMafFWNBAXVg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNLboc/M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736947730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf/bRI9F8H3DG5UlQJaQACm8ygcBNuxPnrAMW4hnfts=;
	b=GNLboc/MJh2lgPpW8vJ6UJ5QzQA0ds6PmQblZ1WPE42pdQgFZyplxeVgFcSfYBBAJGNTxV
	37NzajXjsVTWnBnUNs5N93bBTJfwqg1kjpd6eJ3knl6VmuXZY0T8RtD/JFgvFI6CUluyw8
	vNrq/Le7rKWHtKLCMVgTl92mO2duIp8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-XoCbC8YOPi2HzFxxUhYYSw-1; Wed, 15 Jan 2025 08:28:49 -0500
X-MC-Unique: XoCbC8YOPi2HzFxxUhYYSw-1
X-Mimecast-MFC-AGG-ID: XoCbC8YOPi2HzFxxUhYYSw
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2163dc0f5dbso132424175ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 05:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736947728; x=1737552528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf/bRI9F8H3DG5UlQJaQACm8ygcBNuxPnrAMW4hnfts=;
        b=h483jSwPJNUxvTdhxJOZLjV4JqP5ozT6D7Hp1pDQNMQfX8pc/7lGaJf7ZfbreOuVwK
         j0A3qM8xTh048prTW2Gc1mlL/ChYU8xJhcuU9leafn/v5IgF2Q25z1UdDxnEHMpFEp7W
         ZBsu36a53/3QdfQi6kCZ4Ot4c+ah+Ppv5nxKZNxiqquSAajdQlHKzN+NkQLK/H1TFJsQ
         y8gfIn5NnfvwSGYL/lw4xgYeu7HzQiL9phyR61O34jvMRdTzsvvk+FKGQ/gOpJsAfrLV
         v4Kdx4gGqWzdDJTE79AZY8kX6yPyVY0/bAgN+T7aDQJI7DjRCneHfsjOssuJ2DvAgfim
         TxWA==
X-Forwarded-Encrypted: i=1; AJvYcCUoW+eZZl9h5hoWJ3Z9jf3ytMrT59Hxg8NsDGOGuVaYaQAEx9viOVr0aF0HdjIKmuVNyPpvo3OmFnQ4+Q4z@vger.kernel.org
X-Gm-Message-State: AOJu0YwUehzMDCPn8EDgQyS5FUtMr+zNy+ORcHvAfH+m+ZpY2R1ya9Dn
	aq2QpdQ/wQeq9QHrRJw5MF1NgEqNuspwRhF78tb9gbbpiCi3bEwacxPKLp53SpLII2ENV3AHl1j
	WK9HB6Y5QPwD4xA8jaC1tceTzv1RyScDOAtH3atNZTO/cWcCunkFC3HmRwnSus2MsrDsIBGZFw3
	cl7NiTsVeQ6nWNaEpEsSU5Qw2zPtJnvhw3h7h74Q==
X-Gm-Gg: ASbGncv3WVv5d7PjlggVzXJvlnJU6QTerAXZwy4idGqmGcIs9eaqfxSdRpoamn7LMnK
	drYNOxdviACUgTzgUSjNPS/zAb1jJPzAo/fUa
X-Received: by 2002:a17:902:ea07:b0:217:9172:2ce1 with SMTP id d9443c01a7336-21a83f5db69mr480494785ad.22.1736947728095;
        Wed, 15 Jan 2025 05:28:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWkCFLrwayc2dPGspndw+hcfEp3QAcYd/bnIVRKhsGboPR86dXo/zwFq2qs4H+jDeTVaXTl/HFSSI3mVDNd2I=
X-Received: by 2002:a17:902:ea07:b0:217:9172:2ce1 with SMTP id
 d9443c01a7336-21a83f5db69mr480494425ad.22.1736947727803; Wed, 15 Jan 2025
 05:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-3-hch@lst.de>
In-Reply-To: <20250115094702.504610-3-hch@lst.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 15 Jan 2025 14:28:36 +0100
X-Gm-Features: AbW1kvY2TM4e6V0AysHtF1TdOa092YXLOMhimyjIhR1wLmk0-daNjTVYF4PhKBw
Message-ID: <CAHc6FU6OyLot1pA1dH_wd10YyVzXfOEcqa+LKFghuTpfePDEpw@mail.gmail.com>
Subject: Re: [PATCH 2/8] lockref: improve the lockref_get_not_zero description
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-erofs@lists.ozlabs.org, gfs2 <gfs2@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:56=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
> lockref_put_return returns exactly -1 and not "an error" when the lockref
> is dead or locked.

The function name in the subject needs fixing.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  lib/lockref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/lockref.c b/lib/lockref.c
> index a68192c979b3..b1b042a9a6c8 100644
> --- a/lib/lockref.c
> +++ b/lib/lockref.c
> @@ -86,7 +86,7 @@ EXPORT_SYMBOL(lockref_get_not_zero);
>   * @lockref: pointer to lockref structure
>   *
>   * Decrement the reference count and return the new value.
> - * If the lockref was dead or locked, return an error.
> + * If the lockref was dead or locked, return -1.
>   */
>  int lockref_put_return(struct lockref *lockref)
>  {
> --
> 2.45.2

Thanks,
Andreas


