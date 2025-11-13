Return-Path: <linux-fsdevel+bounces-68276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E0EC57DF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92534A5BE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849872566F5;
	Thu, 13 Nov 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHkVxtj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217B254841
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042216; cv=none; b=VRy8C6zNRHhCO5jy7oRuhw73Dlxu0lJKNAxKNQs6ISCqPOl73sbuORbN+tq9pyQgLnVeV76RayRiYJ7sYrGMVkxAHelO1bhKVgKXfWpAYZPkAsrhlQG3jkwnJUyoASNs60MxyAJrdPhTZitVurlMwZ3tZyny/bJjrRdRvtA7Szc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042216; c=relaxed/simple;
	bh=tOT1HSylb1QN2WLEh7CO5w+hg9dwoeBIKHjNTKOhbjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxLvlD/4kXh2QyROHBWKf1/SUwD5KsrObnKvPGS339n38SlxKTohaTlIdWyRSV8Kbuf+co+2Nm5cgJLDoDg1eugGtqS9aL82RLtrweeD1g+KKY5CSla/iTbtfgF5UgrpsGz94W1Wv1vqoAMLnHvPvK+lDbv9HKm/jt717Bqj1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHkVxtj4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297f35be2ffso12056025ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 05:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763042214; x=1763647014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F17eSc9DJ9T59+bKrH8TjFz8cIjyB5zo77rFUMfx2HI=;
        b=lHkVxtj4a0ESUxg765B44ZhGyfkreVbvjGHgK+/lXga4+BVHbdAk/UdpIcuvDLH2Ps
         XaBtCGga+t5kbHyoZtkGA1Ie75mtyAiOtZswweYS6Lit08fhV07B1kyUNuNerh6UX+17
         JLrpYRONb1JWzRc5z9vhyvlkYVtOxvYX4jmU3k2vH7nYW4TgtFujIoohXNzYcxfdvxz0
         T5nU9cOUG154LZ/5nBIpHvpvBiy3yIhVIbZAzpzJcdxACKv2CrvnOKxAyzeIkHkilDG3
         bTKHu3tfglE0nuCR8MDycPeG6s6iuSjvYTFfTROPtLtsWTuc3LSnPDKlj2AK3RAK1C9D
         nYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763042214; x=1763647014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F17eSc9DJ9T59+bKrH8TjFz8cIjyB5zo77rFUMfx2HI=;
        b=RbtuvV9K4E8Myo+xhzzXT6U1516IbIbrzfZA5vDhipijcXQo9LRpIWs9txqJhm945E
         f6BRH9LFg0cBsVDKwxUhzjBv7uncUjQPQKM2ghlLCuTzdYhe8daglIXXHhS0x0kT6z6i
         6KeQwvrIXaU4neORAJdIvFKU73jIUHVX41IEuLUVDAg58LL+kX26ivEi9g4y6SKesPob
         WhqQdyrjToSIfPPnbJtjQM3fkniNAln7TzbAmr5I4EhNUdxoCn/9psGSn29GgN2QY3D4
         D0ZFc1dufM4RhhTPGUbgtn1sFEIVsQwxZM2Gl4CDsFE44pYKSB5BFwk7CFR1eie5g4KM
         XU1g==
X-Forwarded-Encrypted: i=1; AJvYcCUKZ1emonmDY6zw7w8HoKXw68vxPolQYVj0NuevG0d0yW7nwTDGL3ZOZOKQPauOFTqycbNuSVtP5fdvOjyw@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvwcmMrCH5Ej2UfMbE4pN6ddMMKk9csjCsBHN562aTUAxgW/M
	DDxste/lkhfAlyMjHo5tlUokd7iBWDKJhMOT2U82LM5f69cUsWS9OZRDmsWLrKbTUvTCSUsTZcv
	H4I4OpSq1hQ9eIgD7pyvhBvj/ynUAWTE=
X-Gm-Gg: ASbGncuA6MkXRjOP3iUUO0h8XCmfs9yCF449NgySU/ApRPGan7PeUgDHdZWIkegpIRR
	OWG42z58jMvtkL+Eq701KewHCqeJUBL6cz4SHHh96aULvnAFxaavUdP20VpMemx5XP116CTuAIK
	/5y1xQP9QDfSiH6kMkpSafn8MyTkf4eiG7qrPpi56uEf24bAFwRTo89xkNGQFgTALWKUQlz8HGe
	Mxe7cbRGHMOtX3m8bmTibz6y6TawmuDVKEa6Hyk768gSpABansoq7h9j3mv
X-Google-Smtp-Source: AGHT+IHGr07uWJn+EN8WwafuZ1HRlOhGk+EnhZO9euTybAbZKnv2WX9MhnO40cJiUMNLBb7+jjE8lYwmoLnsY8D/ihM=
X-Received: by 2002:a17:902:c952:b0:295:62d:5004 with SMTP id
 d9443c01a7336-2984ed83897mr90210755ad.26.1763042213851; Thu, 13 Nov 2025
 05:56:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112195246.495313-2-slava@dubeyko.com> <CAOi1vP8swC=q1njp=EPYxkpAMv9cqmcysRNoPzRPpGwCzd3xrQ@mail.gmail.com>
 <fe20de6d968f0c6a2822e77c17545000683bd0f8.camel@ibm.com> <CAOi1vP_spJYpScu3=ZwZ7wR+if_cXB3k67yR35WFAUztYWX6Lg@mail.gmail.com>
In-Reply-To: <CAOi1vP_spJYpScu3=ZwZ7wR+if_cXB3k67yR35WFAUztYWX6Lg@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 13 Nov 2025 14:56:42 +0100
X-Gm-Features: AWmQ_blfxx7cYV-_9_hOWTHC2afjguf2vf1yEaIFZsZP2_SZIlCCLcjaWnKBUG4
Message-ID: <CAOi1vP-Za1ttOum5RmXOMA86vZauVLrnpv_qqytaDi3e1cSESw@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix crash in process_v2_sparse_read() for
 fscrypt-encrypted directories
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>, 
	Alex Markuze <amarkuze@redhat.com>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 1:54=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
> > What is the difference between data_length and sparse_read_total?
>
> In practice probably next to none, but sparse_read_total covers only
> CEPH_OSD_OP_SPARSE_READ extents so it's more on point.  There is some
> provision in the code for handling messages with more than one OSD op
> (e.g. a mix of regular and sparse reads).

Somehow a draft that I later edited got sent out as well.  Please
disregard this bit about mixing regular and sparse reads -- that may
have been the intent at some point but with the code as is it clearly
wouldn't work.

To avoid any confusion, here is what that paragraph was edited to:

> > What is the difference between data_length and sparse_read_total?
>
> In practice probably next to none, but sparse_read_total covers only
> CEPH_OSD_OP_SPARSE_READ extents so it would be more on point.

Thanks,

                Ilya

