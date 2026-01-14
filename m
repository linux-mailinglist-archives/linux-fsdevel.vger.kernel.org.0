Return-Path: <linux-fsdevel+bounces-73815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BB2D21526
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 208053024597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F568361674;
	Wed, 14 Jan 2026 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E7lGpSBh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11835CB73
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425917; cv=none; b=YUdJgvIZGCaCRujCEKna3oyn3lDMIZREqwRt1xJ6dUtLajvOE5xlLNNZt9oGBHQ4nXayMpjyhsjvpGZRg+b46ZBoqIoDsuBsRGbbNzrtbPt6x30Qz0hqL+aRd5AiMMfdfTDVoEJWqSm8vsA6/E6WyQp2RVUTjz/sQpMYjZ6wP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425917; c=relaxed/simple;
	bh=rFssR9m6JmSEdLkwkhdloyBA1rXuH0CiSKtaJh/W87w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+3alhott56XPRhsOvawhn6Vsso2+e+nmpDsJpYSLzXac8hEkf/klnSZyNp+pTvkKvDy8/cXbqJqdnEzwNCnnmlLn08KUUN0WUskdaXTntAVu972v4horeuwcFK07uRkomR4bkoApMcHhazBJ5qYN3/E4d/RBuQy1rqfznUPPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E7lGpSBh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so1032955e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768425914; x=1769030714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rFssR9m6JmSEdLkwkhdloyBA1rXuH0CiSKtaJh/W87w=;
        b=E7lGpSBhnJ2X2R2WUnnupQj4qpiLi2gEr/LvXHw4qjN/iw2V5AjH0nNXDTKui3xToA
         uN4HCaifX4b5PSRpHx57y3RkpwK4jygJIw2DPM+iOJMuGLVne5S8G6n8Qih4y3Z9/gkg
         yCYgCm2e1BUlkfupzuvfWog3/XtXhqWyh3G9x5qf7g+g9GYYZiBOebMyGwvvBmOq3CLj
         onAvDyYUcHemZVWEsZUHMzHFzfx0dijOpiS2t5x/s/ohUaIIEmy9dlGceWiVG+h7R8ND
         wdHlv5xz7mYHz9peLSuErOGBnWTVEAhypLo4nZezGkSHDxsy9QCaqiWIDEUwKGofEPYc
         novA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768425914; x=1769030714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFssR9m6JmSEdLkwkhdloyBA1rXuH0CiSKtaJh/W87w=;
        b=QJc+Mq8/jzOUBeUEenjbTmvRj5aOX3b5D+gqdjOMxGh8ZwB0XDk6R5RiDxYv36tLBH
         jxxQNRgGMmmNYPr23MtuI3F38wKcTg4QTXIHUhzshxyR7mKYcFxDRhKTvxZctC7qk3NS
         0Zub13KUc+wZDkwBZ3bYr1a/yzJLmSKfXRqRVDs7johbCEqPfGiNIsaPkugm0l28VY4Z
         FEwkpxP9ur2oRoi7XvsneUpoCwcpaiU/LdTOPMc6AocLF1ZCUaaei4wg6RH0kfuP4BrW
         LyU1MaleCDNtwnwGUTrih5skWiSFg9V/6ibg840pGtRblNM/nhw+nN1WZF7KCuLaWJq/
         FCtw==
X-Forwarded-Encrypted: i=1; AJvYcCWtBlw93hsTbGeHQwyHvViqaDBVZOGOD4fyKhNGPe71isWv75ytSuTV2DtGsPSEJItB9XK4LZkO6rb6C6j+@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGCNmO2JD5fyGGICQc8kU+U/uW/IBqcoxXRdlN0hfpM36pgGg
	AQiD+UTjfEmSXRyd8mbQ4IV4MR0lazxUKxr9y9geK8MojAIMnfcW409bKv2XegWNUwM=
X-Gm-Gg: AY/fxX6Sqm55pkMvbFSg3r4cjZnUcQBBT4x2ZQCnwrOAHOny1cC0GiobwCAXKk374wv
	9EJAAco+HZKama1q9GjkKhnGlzNtKpoHDL5iNLluREVhOSsNnl7gevXhr7hy43a2yna08VISPNF
	Yq+sHE0wdOB3Ss6h/MQgY9qNS814TwOSyDeQnyb24kvtbaJ0R340TA+hUlwbMOylCXPMei9r71e
	e9nEJKskC7SuExKUIkBSFh2u36/80lSbSdHandT57aTSA+9krXAPLIYq/RlbhrSZLEdHoRM4a8E
	fhBOMs0V2N37HWf6ry9Mazta+Zy9UEdo2dsakPkmuPCJ0VQF+lJhRY03xVpDU8xJNRiP353ivYG
	i87vKEjbKrkxuBnPHOLDgF3Vddq1kZNOxYe4C75HQZlIo+cW8+jqPjicQUWsXeqD2eRwpzH/XF7
	I1EA==
X-Received: by 2002:a05:600c:444a:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-47ee32fd1a9mr50887305e9.10.1768425914375;
        Wed, 14 Jan 2026 13:25:14 -0800 (PST)
Received: from blackbook2 ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428bc400sm10109435e9.7.2026.01.14.13.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:25:13 -0800 (PST)
Date: Wed, 14 Jan 2026 22:25:11 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH 2/3] exec: inherit HWCAPs from the parent process
Message-ID: <sp5yxpqi62ymfhjysggmuvxxcwsxtz5kthu64h6kr2poymesbd@3tjqlq7z372p>
References: <20260108050748.520792-1-avagin@google.com>
 <20260108050748.520792-3-avagin@google.com>
 <wfl47fj3l4xhffrwuqfn5pgtrrn3s64lxxodnz5forx7d4x443@spsi3sx33lnf>
 <CAEWA0a4s+Uhm405CnvNsE61ed5_xJ8PUZqL74zfeZnivw1BChA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEWA0a4s+Uhm405CnvNsE61ed5_xJ8PUZqL74zfeZnivw1BChA@mail.gmail.com>

On Mon, Jan 12, 2026 at 02:18:18PM -0800, Andrei Vagin <avagin@google.com> =
wrote:
> It is true for all existing arch-es. I can't imagine why we would want to
> define ELF_HWCAP{n+1} without having ELF_HWCAP{n}. If you think we need
> to handle this case, I can address it in the next version.
>=20
> It is just a small optimization to stop iterating after handling all
> entries. The code will work correctly even when HWCAP n+1 exists but n
> doesn't.

Indeed (I accidentally ignored the AT_VECTOR_SIZE condition), it turns
out no big deal then.
I like that it's not needlessly searched (and copied altogether).

> The inherit_hwcap function is only called if MMF_USER_HWCAP is set (auxv =
was
> modified via prctl). However, even if mm->saved_auxv hasn't been
> modified, it still contains valid values.

Hm, bprm_mm_init/mm_alloc/mm_init would tranfser the flag from
current, I'm still unclear whether it is necessary here. (It should make
no harm though.)

saved_auxv validity seems OK then.

One more thing came up to my mind -- synchronization between prctl'ing
and exec'ing threads (I see de_thread() is relatively late after
bprm__mm_init()).

Thanks,
Michal

