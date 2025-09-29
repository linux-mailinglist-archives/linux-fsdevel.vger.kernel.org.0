Return-Path: <linux-fsdevel+bounces-63042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D309BAA227
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 19:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8B93A3129
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8EA30CD97;
	Mon, 29 Sep 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZedHzIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F09130DEB1
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166368; cv=none; b=qd3fLZEoQuyEb8mvHbO0EY4bQuydwhtt/P8kHGcTlu59vju2dQl4dRk7QZBJmL8cFkwOXFi5DV6L1IY7L3Dx1zJAahCkk+xWRH2l1n9Mk9rbORE3H0QHzVLXRftI0jLctLcJ131dZ57B4SwbRBHL1/0Sho5zA6dqzfbO0aMGWL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166368; c=relaxed/simple;
	bh=ZaOZT/04HV6PZLUz00v/8ttbdmnCWAX6kB1KehwDWLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIX5Sg2n6tiDCsx4ONoJpzWxmVlCASHaCuj/3m+EZl1xI6jpMr2e0iQWzsAZI6GmAWsrFeQ5vjHMT9miRFogAIgKLgRwaaZtRatehtOL3Yfwb7cI48MsBxT/O4e4Uq+amHqSoD3K34DbyqlrnDMv1OvI/0U+xEycKZij5ULPNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZedHzIp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a16441so814796566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759166365; x=1759771165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaOZT/04HV6PZLUz00v/8ttbdmnCWAX6kB1KehwDWLw=;
        b=OZedHzIp9IhEAJME9PkNthN/74G1KkcgJVWGBwGy6MTr1C9k55cr+n05W4sOuqlHpE
         ZeVMe9ysyfNk/AVY3JEPQkEavMMbydrL+ge5ZE7Lr1LbpOqhizPFlKu5TWBe75g+Sivs
         ezEnAxv2b3IE8nYRuo908+u0c10Xdqr8CeTjCtn4W8YPTjvuJM3VqzcGWTbUaWk/wq3x
         M/k07+PrYjhheS5smVhE5AvE+/NH+Omd26mnE08vJpeh7j9FCH37fm4MU8YDCYe+9i6P
         XU1bMXKfjVi9KItwZhvxJxfq8CAza1bZND9XQ2xPFAS+qF0TP7M2aCm0mrhqFt4i/lhj
         gKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759166365; x=1759771165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaOZT/04HV6PZLUz00v/8ttbdmnCWAX6kB1KehwDWLw=;
        b=AQE6Mh+RU876Ck8dgTFi2VnnSdLVRB1pU8sPgOeSmWAdpdJC9Ybo/jSvfDXyfXx+qR
         p4RYvTkeZs3fa14oVuTUlUSiLlWmaJ3KhBL2GIq+we71WecsntErmUe45daFrOErU9fT
         J03hDAPs0Iy6cPVHEZlIRfzMiRtpphMrJn5HuJJxlbjt09WcCvB3+zrJyMcYz4bIH4Bw
         X84WxfBCXqImerreQXjL6i4KYnuNaz2KYJXNBg1VmYEBbSvvStyPsVIwyORsZdpuH7N5
         A02GpM/nDW7vL8H3K7hLa/eNZygCHi0200rUlz1I/Q3lGXgJ2eBn1JIRLbHHPjTUhCii
         zPsQ==
X-Gm-Message-State: AOJu0Yy/+R3+20IcjOEKLpDAndRySwOwad4pW5xzYAZwTHNZC5aoGRJ4
	WYB2YnhQJoTzfWPuih9DYjXssBjzg+VZnHH0INFVnzStFCX78agiMZfAGRz233F/tPtf5NFpVVS
	U8FdDgGl1HBq2jluadtkidI6Bq+rCQPndozuzoWM=
X-Gm-Gg: ASbGncsEi1kfzBOGGBl+6IQycWOgmo1aUv3dXseS7dGxR0WuAgf8hasPLzvdyU5Xift
	eij7iv6R/3hUH5L/C5adZ6C72yuCyQWkZMxEkga5GQ8eVpgs9GnUJiyHOZ5JxktEQSj3NnJoW7I
	QJcXZlD2DSR94FsQNHA1zSjm83nV7HJXu+ZBXkh+jUbyu6Xn8H48Xt/20wiTwxENRvhG9maJ9K4
	5H/zAJjvlEPZy/Gvmh3kPQOWsBKaRpfDOs0JGkf9cwFUSeok3ae
X-Google-Smtp-Source: AGHT+IEZXEG2TkJaOHfHz0+rEXY4IPUKKtm1q+/6o50iDRi+ku2MwE2mRe0RqHmWSyJjblaz6hkvSZ4Svq+mWVLEF74=
X-Received: by 2002:a17:907:da9:b0:b29:b4ac:d2a4 with SMTP id
 a640c23a62f3a-b34bc58682bmr1900222466b.43.1759166364479; Mon, 29 Sep 2025
 10:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lhqfyklsgrcabcgduwmycv26ljt4u4ttj2jzf24rjf2rdvbjmn@ei4jfb66h7yg>
In-Reply-To: <lhqfyklsgrcabcgduwmycv26ljt4u4ttj2jzf24rjf2rdvbjmn@ei4jfb66h7yg>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Sep 2025 19:19:12 +0200
X-Gm-Features: AS18NWBUHGD_t7V_IGu6kiJyF44XhFD2rYox9Wze2MKi7EGp3M2w-xRwdjWbueQ
Message-ID: <CAOQ4uxhdE_djxgp-4vy16+6pfPW0ufR3yqh7i1BbRG4theTDXg@mail.gmail.com>
Subject: Re: EXPORT_FH_FID not working properly?
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 5:59=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hello Amir!
>
> I was looking into exportfs_can_encode_fh() today and after commit
> 5402c4d4d200 ("exportfs: require ->fh_to_parent() to encode connectable
> file handles") we immediately return false if the filesystem has no
> export_operations. However for the case with EXPORT_FH_FID I suppose we
> want to allow !nop case as well and use the default encoding function? At
> least that's what all the other code seems to be doing... Am I missing
> something?

I don't think you are missing anything.
That's probably a regression, but a regression in a use case that is
not tested by LTP.
I think that all the filesystems that LTP tests do have export_operations?
so we probably need to add test coverage for this case and fix the regressi=
on.

Thanks,
Amir.

