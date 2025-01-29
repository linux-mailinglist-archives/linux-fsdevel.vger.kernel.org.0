Return-Path: <linux-fsdevel+bounces-40318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02CDA222B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B6E1656F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9686C1E0B8A;
	Wed, 29 Jan 2025 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/aK2qEx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779C1DE3A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171197; cv=none; b=MhSbo9afSWQl/N5NpAOkagepcBZpUh9T/o2JI1eXfCpybFHzeKFYYFxfjOzgZsEmrYa7Zpt5zj5vC67tVTX8FKpRdbzljwZtq33GpTD9IXUqEVR/a3PHhHeCvX+SzDdFPwfZ0HMl5r9uCqvfQI5suu20kUlsuFvIirFjmtr11to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171197; c=relaxed/simple;
	bh=3iaxX73XD6lAe5qkay4u9FZLV/j1SD0tFzq+pKK1qKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akHHv9VJbQwx7tT4aKCXH4gQ/gIc5hHuClZEn/p3kyVNFOYS5SdJsCV+wbQ4fnLVj9qQi4c5roZZfFFnpqSkjemDHtV5fAsQsS7+C2SmC4o+HHrNZkMGB+NJ2RTs784BZLISl5PCnw5wmTC1jQRwVb0GhSYJPVLJAsW2uED6dqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/aK2qEx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738171194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3iaxX73XD6lAe5qkay4u9FZLV/j1SD0tFzq+pKK1qKk=;
	b=J/aK2qEx8WPEJIsd0+W4wLODR+CiwTEBPWRdRUgpbWggniD9ADDDIqiFZb6aGQD3gPoyl8
	FH3UaD88hfqJT0FU7l4wf7kbMyEpwWvjIshwbxpbwr57e8FE2QXFH4ZCw4PXHrmSVf2PER
	ETIjU+d97ENoUPrPVvHEoRhFjbrw04I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-zCNnNWUKNui97pYy-U8LCg-1; Wed, 29 Jan 2025 12:19:52 -0500
X-MC-Unique: zCNnNWUKNui97pYy-U8LCg-1
X-Mimecast-MFC-AGG-ID: zCNnNWUKNui97pYy-U8LCg
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21dcc9f3c8aso36141795ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 09:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738171191; x=1738775991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iaxX73XD6lAe5qkay4u9FZLV/j1SD0tFzq+pKK1qKk=;
        b=sDWzZVzejiAauHn3fTbo2+0hK95M/LPbW1APYbULBIi2vWYS6NeMLaZ5mTZZDv44/l
         BjFlq25791LbG2I6YeFM+qDULAbEgzPfFOni6kwKclEbxveFVEiHYiOCrjHSJls2yO19
         xPGpRhJaw8dQ/WK5iAik5ZuG43kE09BG6kbgGNxJX9K31WbEZAVegU2LHwdD3iZXcz2N
         2i6SFRNtAlv2i0X3N0kr+/tJl+1GeBqgnWJ7muaguECJAsaLvV4HTnfNGlxMJlTE6dOD
         Jo1IY/rm8IqaMVDrB16g/ueYQkRs+AL1dQEMIYqt3+NzAi4F/q3cBt/VVWaZ9kbCMfSB
         SRVg==
X-Forwarded-Encrypted: i=1; AJvYcCXFChRLNcZidqNrQu3LlxS8zUSiifxr2B2peehk6vT19ckDBj8DlbqCIJoy9KX3XLrXvexxS3szIPrVGov6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0q/ohyMXr11X5jBv2jgrW6kakrT28/kiUZsKLNxRnvqtlZ3Z/
	cXoN661jImJuCov/QiXanp/5XHZmr7CTojOuXyxD6nj6sH7MtruxVLr5DzjgV8eY7VyRxNOY7hd
	P1F0h/xXoxnGrcqgkpuQZwO5DM/mrTsL9imFMKCYb3GAV7tqCiv6mnGAciMNxx+kQtdt+4TA2SW
	2L8Wq54MAFDEMLxsy+k9y4rTMQnEssrXvI0lpgTw==
X-Gm-Gg: ASbGnctDP1ooVZRt0W64OrNkgB08lK/PUq+YO+jIje6g7TBDqVyprOjLSVoo+vSs4cx
	OAfWCLatTg1r6SWt6BrDRmf3cIyGWFnp8blepw3re+UU6ej2uCBMUIN8HD+fB
X-Received: by 2002:a17:903:2343:b0:216:1ad4:d8fd with SMTP id d9443c01a7336-21dd7c4994amr48816475ad.8.1738171191605;
        Wed, 29 Jan 2025 09:19:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfABnFfbgeBzDXWCj85MsPaV0ByB2T2rXUb7QjeIORDiHfVnWfBRCYeARi2+5kL4J3zYcmv97e5BnDL5BYRu8=
X-Received: by 2002:a17:903:2343:b0:216:1ad4:d8fd with SMTP id
 d9443c01a7336-21dd7c4994amr48816125ad.8.1738171191101; Wed, 29 Jan 2025
 09:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129143353.1892423-1-agruenba@redhat.com> <20250129143353.1892423-4-agruenba@redhat.com>
 <20250129154413.GD7369@lst.de>
In-Reply-To: <20250129154413.GD7369@lst.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 29 Jan 2025 18:19:39 +0100
X-Gm-Features: AWEUYZk_2Z3s2dY_kkWVLcQgmXKJk2VDezt4d-YIgTtz0UQr4V5Xf2wIXyjUrQM
Message-ID: <CAHc6FU47ToGhxxO1MzcdyL=Mcqrf-E+Wh3dwMiuL365pXSfKsg@mail.gmail.com>
Subject: Re: [PATCH 3/3] lockref: remove count argument of lockref_init
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 4:44=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
> Maybe the lockref_init kerneldoc now needs to say that it's initialized
> to a hold count of 1?

I always feel a bit guilty when adding a comment like "Initializes
@lockref->count to 1" and five lines further down in the code, it says
'lockref->count =3D 1'. But okay.

> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

Thanks,
Andreas


