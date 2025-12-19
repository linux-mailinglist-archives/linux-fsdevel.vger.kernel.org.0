Return-Path: <linux-fsdevel+bounces-71789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD755CD236F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 00:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51F653034EF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 23:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D12EE608;
	Fri, 19 Dec 2025 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfT0pk/i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i763u8q3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD032D877B
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766188621; cv=none; b=lRGJyA1jkVEq5MZe5QhqEcVh+wB2sQT8eP7e5Hl04xABr42h4seictghz0frZUCt00mLm2aTRj0KrxrQEETCMzfl8rxgdEw6hdJkwyjpu+nZU+M9hlVTt0vmb8Ydb5KdAJSigkGsf/9HgF8ci6Ij9Jkl2u0Q/PsBEKvShuD+6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766188621; c=relaxed/simple;
	bh=/tRE3yygilQhV1ShWcxcY28GjigfzO1hkiNQSQLCyMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1IMRoEm6HpbTv89ym+yFxvIkay/Ovhi6s0LEW0hy0cA3ys25mEa5/b3gzvSNRrw9kiRUs7DLFijCHKcL7a1GKyAFSbsXujVbJy3xJSJ7dXMLQFmqefZxg7Edl9JgTIymmyyN9oO5c8EJKoEidYt4watha7LBNddslgdhr786E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfT0pk/i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i763u8q3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766188617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tRE3yygilQhV1ShWcxcY28GjigfzO1hkiNQSQLCyMY=;
	b=SfT0pk/i6lv5eGsf4kUFsbyy7D3T3DlHyKJEnjK5guksg+RNe7qeg+5TyeGe9u40mDN8/5
	RbUWJUzufPZDHwdnHD/q3GBVjUEU0rXdkAK/m83AWuqVs84dtcMW+rCfS/NAJOh+H3/MVj
	X4FVCE+k1Mp4ZLDCCb6v2lL8mLLMcnc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-ckc7CW_HMluSkvzid0W-tA-1; Fri, 19 Dec 2025 18:56:56 -0500
X-MC-Unique: ckc7CW_HMluSkvzid0W-tA-1
X-Mimecast-MFC-AGG-ID: ckc7CW_HMluSkvzid0W-tA_1766188616
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-450da1dcd2dso585830b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 15:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766188616; x=1766793416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tRE3yygilQhV1ShWcxcY28GjigfzO1hkiNQSQLCyMY=;
        b=i763u8q3sjTKZQg3yLOXIDJPup1fvVwnjh8PSbptBf7GVT4KkB94CjSPVYyFm7rXlD
         Mp98sXh7dVnmTjFNhnj6+37wq8BcE0wfF53goqksEOamvYM//yeNwLP08WSy/WI/9APM
         zGeEJrtzEog2NAsWtfc7cA/U7w6Jq0lNvT7WwinnNtt4Z2QchDaWMUpF3qzgpUTO4O/0
         qrIQlXH8NFQr7U/8Xo6p5TlVjdLQS5PVb6OUDB/CtgqYopTB5ihQJA1R1PH7WKKB7Ift
         oopuBR9uYdh5J/vzTD3nuy+cBQepFc/j1aNwNU3z8vvRAtcNiubQ2wN94tsoE8VdRdCq
         Qi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766188616; x=1766793416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/tRE3yygilQhV1ShWcxcY28GjigfzO1hkiNQSQLCyMY=;
        b=u3UBdE49U9MkAQ3/lYDgbdV1hfKL9334d1s7HDsD0x5+dLfpgpSrm/V+p0ybdS0xIr
         rLYspJnT4DXAegXZOr4B2pZKwl5zsMtlMF/vBZscZNRULQjOBqcfPHDReWqBGbtd7Z71
         HYQx38kRJLEGyCvhtehXTSofKItOUJWzB2N+OnKZEBFhHEElXLhDj+FXCHgZZ8enH7Ql
         8uP71mp6YJu1eqz+iA2u/iWFwU1dbX5MZyvAE53sIQBYTw+mQZ3teyLmJc7RnOcv/onY
         oLwKjmEN21g+7gg8bpnlpqtdZSTplvX4QdLS1N04lzyYQlo86YgPT5ceHIBTdjBi1Sze
         IjQA==
X-Forwarded-Encrypted: i=1; AJvYcCWZcadMuhV+cQB+DRhDo06LO1BYfbfebwan4uxbsertsuLQs/u4gmZnd2Bo/Zaqya+PTUahRp7vAiuop/Cp@vger.kernel.org
X-Gm-Message-State: AOJu0YzdkGQ0nAWM3lvo253z6tsYJkibCxWy7T4wU863pQJ5fntrIG+B
	PXvb5670jV2O6W1/OKWxEK3CNlKDBc46IXipsyOKwNbp7/5OZAho0NmWlf5QtlY1DUEI9INXDxI
	7x1Hj7uMZ8DQ3YwKGAeMDCjG9rTbaJnRBXHec+I7XcBsBvuwbW9tU9LjomwlZoI94m5CrxJL8yI
	nsui+qMfv4LWFFpYoVgeMQEUp+UNd3oPAWiv7C/chQSw==
X-Gm-Gg: AY/fxX6+oaPH6d7vlGCE3wwvTuGvVzkPk2qtPxj9ga61ZYmgA/P9RhiuUv8Ym20hznq
	uDcJ219homRq3vJF7ryqJk+UtrXiHG0s7Ad8gAhlaLLUfeJs20dMLyF1tbVBCqi7WBD0aEOfHi1
	919wtyj+mVJ3C0dfRquUoN374qTvdIcwHrRvWhop7Rjc2edo8rY0vgK+UR2bPAxMCDavhiAuuDl
	kjSTDrZXbVvI1P0ai8JFpUxBg==
X-Received: by 2002:a05:6808:2183:b0:441:c8a2:ba26 with SMTP id 5614622812f47-457b20f56d8mr1917984b6e.7.1766188615828;
        Fri, 19 Dec 2025 15:56:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYMuX/LXJQS1rRwE0tbFbHt/TuIUJruaeyCFmQoKkT6IGi9nRGJgbaP/NyPAgsBuFbjpFEdRCSkAFlNn3OpiY=
X-Received: by 2002:a05:6808:2183:b0:441:c8a2:ba26 with SMTP id
 5614622812f47-457b20f56d8mr1917972b6e.7.1766188615498; Fri, 19 Dec 2025
 15:56:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215215301.10433-2-slava@dubeyko.com> <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com> <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
 <f36a75dbb826b072a2665b89bd60a6d305459bfa.camel@ibm.com>
In-Reply-To: <f36a75dbb826b072a2665b89bd60a6d305459bfa.camel@ibm.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Fri, 19 Dec 2025 18:56:29 -0500
X-Gm-Features: AQt7F2oTMrhviMqrOBkqzeVwWyehYPbS3l33YtKZpjKO7pbEKy7T0Ne1S7lMzkQ
Message-ID: <CA+2bHPYqtgK=7n5+OQ2czX9M5Z9Yrsige4Jj9JJbFdLKPSZGhQ@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	Kotresh Hiremath Ravishankar <khiremat@redhat.com>, Alex Markuze <amarkuze@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 3:29=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> Or, do you mean of using namespace_equals() logic for comparing
> of auth->match.fs_name and fs_name?

This one. (But after discussion with Ilya, you probably should just
make a new procedure for the matching logic which implements "*" only
for this change.)

--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


