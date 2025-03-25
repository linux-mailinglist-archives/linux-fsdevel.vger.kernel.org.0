Return-Path: <linux-fsdevel+bounces-44955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CDFA6FAC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A1F189DAE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC0C2571AC;
	Tue, 25 Mar 2025 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPAYZYPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A902566CC;
	Tue, 25 Mar 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904319; cv=none; b=TXlg/3jvXsWyMu5iMm2XabNPh6RL9noblROInLSRd8cKVhXmOPeY9t50fVWd7kevooriizhPTs4ao++ckn3tKvkkT8HUOxFpOr1Z2OYSHYRscwLJIW6/0pYv11Purw2VEc2IYjXLNgagIZV+0BEsjK8ziBqmHHk8dWegjLVIXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904319; c=relaxed/simple;
	bh=4ZitrOvyIpD8U1fVHXQl0H9uYxjJNEF6qPa8mF8SSiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQkqWo03QFavCic/on41GIdIZNu/MqoCvgUoDAyKaUnqYDXipLiwSQSxijp8/E95LeX3TIwoUyEsAm5mfakMW9g6/82qFLNsAeqQD+OuSjzIS+5hdzjg9SdRwaDtTiQzMOdx3dPJGNNVWQ9OoOJj/HmwZiSVQJSrY3TcvM1pFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPAYZYPL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so989335a12.3;
        Tue, 25 Mar 2025 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742904314; x=1743509114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZitrOvyIpD8U1fVHXQl0H9uYxjJNEF6qPa8mF8SSiI=;
        b=aPAYZYPLALKKy7IeX0PuAxzHNhU4PtbijwcHMBGHOA14rdxgKQfdDVIvxhqz4U71Gw
         mMTvahB8HkUnszY/IRVxdswRt4dKDa5ttIu4M0eskegf+sT0SxSd3CGdaG3LvzP8eL0n
         ENC6PEhnRo+ad5exI4T6NfOrQ+XKMP4hncZDmJv9QIwZElUHz18AoIZX8oIZN2d3DJE0
         DWE2vQHW7v++p0xB9ZfQGdZaoXR9vEzdyeF+oT6UGevgQTVq903LHzQF8pBqcfpEXnm9
         3agES5tGfADhU57a55aA/logBWajVvUFn2ykpKI2S2t9V1i4JJBW8Gjcb8YqMUG5xhUG
         ZiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742904314; x=1743509114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZitrOvyIpD8U1fVHXQl0H9uYxjJNEF6qPa8mF8SSiI=;
        b=fxYOVIJlRL8e968Hs4QtyVS4kFkwjFolNnmZ4Skos4IzD4e4xPxLi1AVNDnvkvsRkU
         cXo0h+g6DhfLmz/XqXlFv3rnvd+DTSotWtJBV3WZEQYkwc0LRlGkE5bnQPuGoglFQBpJ
         U0+EA6da/xSx67tZi+0pA1tjvjxUUSHH4TAF5qUM7AH/L+xd3C5FffVvy1zLt8J/Mi1j
         hJ4uVQ9sLsf9QHF1/TtIUGwbNNXzAOEmsgFm9Uet8923jiA5kuLQ6E0W4yqec4uGRhXO
         tjYKxCVduj1V3VbntolPQNjSkcbYd31tDTwL/YrS1ckVmKhrUGzUD53a5RB+iGVIoNhM
         PuSA==
X-Forwarded-Encrypted: i=1; AJvYcCV8/DCGm1JPRH5XM6oeKhnwX7ZzpyuAJsXfMcBxtCbgQuYQgTjKSIFkiW4AaAHyGGaQ3NsRoDWGMetmC2Ja@vger.kernel.org
X-Gm-Message-State: AOJu0YxT0ofZHZi43qYsZHIcupR/6WG+Y7kJ6eeHVbzTRayMmCBnABW6
	4UkBKmu/83bj7D8ObP5QKdQGrYGimO5z0hbzd6tbSLEGHURmVOC4YziuFMsNrzrUXl4vYnf73ez
	7GjOsBnEbTUDkpRH3TVNY1nV1Fvw=
X-Gm-Gg: ASbGncsZDCwUycEpXoN6AA+5EUyL7NCBQEYpUc0cq156AXojaC9JBm1zmt7GQL2HM+K
	brQ19e4YZXT+2DakNv78xELQQ+hv4v81jZYKu1SOPtAmin/AA4G+aF4QFzbH9Zg0VhFRWSCOFcg
	hMLnoZYQYeUDuocSHOp4NCbwd+
X-Google-Smtp-Source: AGHT+IFZp+e8Mx6CAvkqtbE2EnAPL1Mk8hmiYC53bvrs/6rBKw2Id1fZ5cONWVdg7uXCpiJOXZsmtxWai550wvqslI0=
X-Received: by 2002:a17:907:d70c:b0:ac3:eb29:2aef with SMTP id
 a640c23a62f3a-ac3f26ade4fmr1962525266b.41.1742904311272; Tue, 25 Mar 2025
 05:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325104634.162496-1-mszeredi@redhat.com>
In-Reply-To: <20250325104634.162496-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Mar 2025 13:04:57 +0100
X-Gm-Features: AQ5f1JrqR_UmyG8rA2u0bN7iFYb8FJbd2aEe4a-2BPvNVursqnudSZuXKLUZFWA
Message-ID: <CAOQ4uxhcUxZjmLJWp9PXbo1u04nwpWWYkqchR7WfT1ebzCAxOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ovl: metacopy/verity fixes and improvements
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Giuseppe Scrivano <gscrivan@redhat.com>, Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 11:46=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
> The main purpose of this patchset is allowing metadata/data-only layers t=
o
> be usable in user namespaces (without super user privs).

Please add test coverage to this use case.
I think a userxattr variant of test overlay/080 should be easy.

Thanks,
Amir.

