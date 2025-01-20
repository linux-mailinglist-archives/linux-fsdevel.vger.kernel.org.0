Return-Path: <linux-fsdevel+bounces-39659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE6EA169D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 10:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA823A2029
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29E31ACEC2;
	Mon, 20 Jan 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2D/GsuR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8383B19995A
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366444; cv=none; b=teSC988cKWRrjuVhvr4kVRGmSpbEVvbst2hzOFg0myfl4oS0Mle++pdO3OOMy/IGJYUnuK3zszUdkz/O5XWh4W281OLfDfuazhmh4LCernmwHAQnCmNqRMYYQ0R1S2WwkWx87dd7Vwk8XWb0rDkuNhNwslLlvW7X03A/mwMQZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366444; c=relaxed/simple;
	bh=1iVJ777YiyLvJG1svDTDIkJijD4bk6V8CR6U63bquaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0lpLKIPS0L3vkVKYEe3JfEhveP61nuPyisePBe34GeKMH4gLQFbJhDeLUq7GZek0DDSU2ZvYCZAINjh6Gwxks7r8qVoCF/4KgiTgJBRty1xYH60xECKiS2uPkccmw5Ky962sjVv2ilIVEC61KZCf/7Nx6QtAICog0RAWtytY98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2D/GsuR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737366441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMIRS59aq0nWbPMSr4yt0OsmWKqGFD8zbWNTG+TDjbc=;
	b=d2D/GsuRyqbxjQbHG2G1xoOGFTTNwz/Kh63bKmN8gn3dA2pjA05SNFISC77GgUos5rVbqt
	E6ndiUaGI/oRKvjPLedmAWoBZJ64Exa12M0aNPuF4Nk6JFtDeY3LFpELp1JyIWf8k6CGzc
	0SYx9taLrw2tyK2h6QCAzb9tJkmdols=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-HIs__OWeNbmDFsjdo6iK4Q-1; Mon, 20 Jan 2025 04:47:19 -0500
X-MC-Unique: HIs__OWeNbmDFsjdo6iK4Q-1
X-Mimecast-MFC-AGG-ID: HIs__OWeNbmDFsjdo6iK4Q
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5da15447991so3482757a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 01:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737366438; x=1737971238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMIRS59aq0nWbPMSr4yt0OsmWKqGFD8zbWNTG+TDjbc=;
        b=hoHOLmBEkPJORzy8BUvS38aJs7uqYZLmiHRrNv8JI3RexKhldzwJ48x+nmbCkxhBzG
         H9wZdoNa4Hn5wCES7nzIuaVcS8dEGS7e/w0cECZy60zH2vo60/+Oy0EiCswl+A2KM8Gm
         8Xa/pYe4fRHYKtSIITxI9opTHRsRQELvNz4s1eOU0D+LtEN0N0gxA2B7/XJQthNBPqNE
         FBySeJltr0O0nVhqCFPQZD0pn/jaQntGwt1btnfLrY4x37f2UNnrGfzvCp3BZRsTma5t
         klMkHRfABNiIRQJPoaL35es3v+0hsJA1HcrQybhB79WIuHUfud7wn6sLROTF9PD/bWpx
         ez7g==
X-Forwarded-Encrypted: i=1; AJvYcCWw6rXjXQpO1690kJvrtyEQ+HUNSopsNS0Ag5u3hLwFKwKtacYLLbOl6EXAO1N53Ymy3hpxgHNZjj4KeLUw@vger.kernel.org
X-Gm-Message-State: AOJu0YwSeuTYaZJRH8NpRF/LocfkOgd2Dp6jyXBGfPFe8zraFP9qT2um
	TMn+MJxNmC4vLUehQKZV9+NuVvtgnhYLDeRJX0PnVRRvRZUZ2upIs0stCDxFulj3DOPiAz1+k+C
	tdc36H7kOnqJCCz4D6lqguUR2YRorfRG853J4toDej72n4wH7u9iGi/gbdf26FXgLnlnyL47vii
	H1EZZo1O6Cz79j+0djwRBI7Z6qtM7noZt+sr5TJw==
X-Gm-Gg: ASbGncueojse9FVotq5EvnOSDSP1kd6mEeKHXUcQWV2R4ahDDuxLnO6cTtKuvuEN3U6
	mGsOVZTO+aF2YHs4YRWwtw15APdPR2/a6g2GH0y3owmAPIv8W3g0=
X-Received: by 2002:a05:6402:5246:b0:5d9:ad1:dafc with SMTP id 4fb4d7f45d1cf-5db7db073f1mr28328195a12.25.1737366438140;
        Mon, 20 Jan 2025 01:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8/pywkRtrHFW64kEGR6AF06UVXslrBiU03MiWk2as6N1vIWW4vX3Wyy4VobrCfoSXDwK0N33Eqa72WvKjZ7U=
X-Received: by 2002:a05:6402:5246:b0:5d9:ad1:dafc with SMTP id
 4fb4d7f45d1cf-5db7db073f1mr28328162a12.25.1737366437849; Mon, 20 Jan 2025
 01:47:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117035044.23309-1-slava@dubeyko.com> <988267.1737365634@warthog.procyon.org.uk>
In-Reply-To: <988267.1737365634@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 20 Jan 2025 11:47:06 +0200
X-Gm-Features: AbW1kvYo_PcQjA16UIVQAxxYVGTwqzpHKIw2jVbvvtE6SL51ZXZyXTdYCzS8GqM
Message-ID: <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
To: David Howells <dhowells@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Easiest is to run xfstets. Ping me on slack I can show you, its simple.

On Mon, Jan 20, 2025 at 11:34=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Is there a way for me to test this?  I have a ceph server set up and can =
mount
> a filesystem from it.  How do a make a file content-encrypted on ceph?
>
> David
>


