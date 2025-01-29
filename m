Return-Path: <linux-fsdevel+bounces-40329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E80AA22443
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 19:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8AB1888494
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B979D1E0DFE;
	Wed, 29 Jan 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XzCoJoN4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155891E2848
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176503; cv=none; b=lJtSzOd/hjF9p3/TE4/09aJnD9P3ZSLnPq2L2DGOABtNHTEIZzhW59Qte9aoirTS9xFi44Fcbs1cuaesmFbBDEVrcr1lsT8UO97T79PaApbdfBwPOtIxmpe+Phy38AieNGCZPdqkUqJY167aZ6pyGK+EfTo0eKx5LGt4mkEllQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176503; c=relaxed/simple;
	bh=v7t/b1bseEGT07c3FY8utGzEJPHu0vgEf5zHyuSLnLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMIc2zUZWIfgWVTkmJzfz0sDkYD0srg0xpiVUlI4jPBqGHV3JFxaCHfAzmEclKIqlWywPqZxWHLrCFmwzY497eBkA2fjIJtTKO9TicHc2dHy7e3OqWrmAdKoz0NSgcKGSeY80TQGofiEFXuG3ke0VRCZoZviP1ttGTSuJRi5rhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XzCoJoN4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab39f84cbf1so3477066b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 10:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738176499; x=1738781299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h8bf4DZJPP2rSwdY+pwJS8gO4tmZtY2U6WvRvjgGimU=;
        b=XzCoJoN4uhKQoB9+JTgA6ocIJs0Iq6EVGW3dTAqvh0NPSLPa8tYP0QX3Nh6JLYndyc
         dWCDWwg9CIkS7/LFGh3C8KutiFHMYNng1mo//ZHqeDPstWDcGbNJzauVoFtSftGMuA3D
         49/ylYx1bpmTkx6GN/6mCsjgydE7vXuR4iYY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176499; x=1738781299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8bf4DZJPP2rSwdY+pwJS8gO4tmZtY2U6WvRvjgGimU=;
        b=dxMuJFFwU3bWRF5ElLX+N6cRe70eFAnLeKx+d559UYoxK2uU3oUSVBKpsrtlxOjxrm
         pdsDTpwtJg2DqGslsrbOWf6bX06kHUpF7gGr+p3WMecpurrQkdjLFAGzrQ7M1qg2NopK
         jHel5hae6CyNS0M3avWUpUWwRhsP+uLN4TQkA/0BuKTCsTSGCxm2OvjOxqG2+GMADxzj
         px0glvQQcdSswMW3GNaWXcTP/xJqjLKY306OS/2cYe58gqerS9S8S9Ylx+8xI/NLXk0e
         FoElAwVwgahSUswCzQVap1oUs0K9T2WhFJGfc58nnMBWtGnhVUIP18vr5j8R9+xobMoc
         667A==
X-Forwarded-Encrypted: i=1; AJvYcCVHo199Sk0nAh4dzVNchHW4lcOZYrFgCN327WcNFWYfUeo9AIGvDRDysW3EzRuH3JsgFJQWMQFxn65xJxzt@vger.kernel.org
X-Gm-Message-State: AOJu0YxKlL9xxhVCjynk7NWe1dzIccVP8HFmkq5XykJ9NhAT6GYGWtkZ
	e2eXmeKhoTf7itNmrvLxFRHMttu1TXQpN8akcNaOKzSfxBg3X5imwEOrdjfo3Fq33kVIiF4lub0
	ls+U=
X-Gm-Gg: ASbGncsakT4aPfam8N6Zrasp/OWbToeJUdpUa9l6zzx0zDty2XExc/2bSDPKZWlQOXI
	FQrwNPhdvvvzq19zYDkjcxJAL8SKIQoXJw6VRkPktHMZxaE83sIATQUZ4avX7h3vle5avr3ju0e
	HKKlms7tT6sgzsBdZfg4Xhpba6SwwCkN25EcxOy7GSGQZ4wiUPE5BrkJWzBFP25TUvuu1jl2o6e
	yq8oHPMpH2D+euys7OGHT5mO+hErDELZjLD5TSYntwjQ4rTHDVjkSQoY2PRADtZ8aeMoQKEW08A
	vKC6tfuwUvSuEp8uRhApbVR4orfO7lmhIUde4NF7GYO95J7KcmZ8O1gkc4sk6HsMPw==
X-Google-Smtp-Source: AGHT+IEmzDsObSSfxVd82vsDzI5kd9BIm3ALy8iWu4LSgiH5G40DkiEMfFjB04GI+vh/6htPdbdYiQ==
X-Received: by 2002:a17:906:6a0f:b0:ab3:974:3d45 with SMTP id a640c23a62f3a-ab6cfcc680bmr412087366b.1.1738176499304;
        Wed, 29 Jan 2025 10:48:19 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6d8e25707sm90177366b.22.2025.01.29.10.48.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 10:48:19 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab39f84cbf1so3474666b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 10:48:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUb0dNhX81Cp2FZDYk5rzx0YkyQK5IKWv/IcNLR6CVuqBjNGyNXrL7pK054q9ITO+zEFU6AzN6vg5X/6283@vger.kernel.org
X-Received: by 2002:a17:906:da85:b0:ab6:9d92:6d6 with SMTP id
 a640c23a62f3a-ab6cfd0d35dmr415053566b.26.1738176498692; Wed, 29 Jan 2025
 10:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <kndlh7lx2gfmz5m3ilwzp7fcsmimsnjgh434hnaro2pmy7evl6@jfui76m22kig>
In-Reply-To: <kndlh7lx2gfmz5m3ilwzp7fcsmimsnjgh434hnaro2pmy7evl6@jfui76m22kig>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Jan 2025 10:48:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNwJ57GtPM_ZUCGeVN5iJt0pxDf96dRwp0KhuVV4Hjpw@mail.gmail.com>
X-Gm-Features: AWEUYZlqaMWdacM1L6lq7K7jLmz8nrxtrZnee6xpSEfGqjffsjadL1gFNvtIh-4
Message-ID: <CAHk-=wgNwJ57GtPM_ZUCGeVN5iJt0pxDf96dRwp0KhuVV4Hjpw@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.14-rc1
To: Joel Granados <joel.granados@kernel.org>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, 
	Baoquan He <bhe@redhat.com>, "Bill O'Donnell" <bodonnel@redhat.com>, 
	Corey Minyard <cminyard@mvista.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jan 2025 at 00:14, Joel Granados <joel.granados@kernel.org> wrote:
>
>   All ctl_table declared outside of functions and that remain unmodified after
>   initialization are const qualified.

Hmm. A quick grep shows

    static struct ctl_table alignment_tbl[5] = {

in arch/csky/abiv1/alignment.c that didn't get converted.

And a couple of rdma drivers (iwcm_ctl_table and ucma_ctl_table), but
maybe those weren't converted due to being in the "net" address space?

Anyway, taken as-is, I'm just noting the lacking cases.

            Linus

