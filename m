Return-Path: <linux-fsdevel+bounces-32462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D32E9A6251
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3296D1C2148D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5E1D04BB;
	Mon, 21 Oct 2024 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ITNomkwg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2245D2FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505751; cv=none; b=lYANTkYSbjRqk/KnfrTSNdRbQcHZWx1VXOcPSGsrPu96u0PBYqGWjUs9c5lm1ZM6AzSLxFWRKBHkDiQoKSntDKDr0d4xFapRlNsZIKhgZFpeqPI23S0Olh7+L4uRFJYy7lEB/pPA8n0nLycbSpzSSiYQiN0fQntr0N/5z1YPzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505751; c=relaxed/simple;
	bh=gY8ExC7p87XYOFr2DQ4hrxvA8xjCn4jg2ocbOWNZJ4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxaPYKgOTcfePYf3L8T+0Y+vwo1TMK5FtFTaQTuTBeUkz9+MpC8Fyb9Z042dVEjyKiYgKdXlCxKM/vWm88Xfj1PSw6iF9c1ClM7tG35GrCakeOh3OLV6YuExZlnJB7KvKLyG6+KYhkjwFUoHXzhRDOht3n3bu7CWIIYmffggDbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ITNomkwg; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4609d8874b1so33177091cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729505747; x=1730110547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XQXMo1DFMeFg7OubTtKklZar6mxzRSvb3HbKBHc2oxw=;
        b=ITNomkwg/6PYnMAvmoIVurv/KNwfCi0tInJJzWK8aifhcNh2AxSCZ9pq+PIRoRrMAC
         r8yltjiInqPIyWCBrJESe2Deg9Y9MEd7Z4qkNa3dxtQ8L1AHe8FB1ezHN1owyryhvAA+
         O2VajxhuuhqubzTpfOPdyETiftqU5TbyED8p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729505747; x=1730110547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQXMo1DFMeFg7OubTtKklZar6mxzRSvb3HbKBHc2oxw=;
        b=ZlybEfwRrpT7qarct2QfyzVjhYu1WW7QonFG0zDFlALVMx2Rc8h5Q8c0SZqiIxqXuY
         U0n7XvjUxU6lLcAUwtGMagUFTC8vvVFttP8G2wYiXqMG9rnIVRCyzxQqxskVkD5otsb4
         q6JZyYNmT04bDNgAgRIqJTT06knxHsgbayteao1La2WCeZKtjuuyBLlwXOR/styVVPp4
         eFTh6PI0J2ptCgZC31uN2ZH1igXqcE49hk8UwM9CXJD5AtXuDt+Q9ItALsUVOJa5HQ90
         qB35f7ZSiUos65B1sbJYhlRdr76HPgisMLCvEFh255wVLdpq7aHM4sNgoP3SHRhCOGEi
         teRA==
X-Forwarded-Encrypted: i=1; AJvYcCVg7uUYBUUY9X2ZGe8GTFH68NQnJDA/wT8qubHj6PgbcOI9tHWos09HU0yDq0gRvs19U88gtMX90Z8qk+vk@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrCZI18TB/sboHaYI9eIjz9nwnYRn/ZgEz3HJ4RoziV8VdZqQ
	ayDQ6+SwnMyN+FsZPPGN08TxzubkXf2C3JSP8i+h6VZto97yhoeOtDA4xqpeRYHeTjjMAlo2his
	DUNi+qhKHjTe26jow3L2zrzXxp3+c3ao9lDx9lw==
X-Google-Smtp-Source: AGHT+IGNFq8P9pVugplCf3PEIYHCEWzuYOITZsc46LJ3iqiN8mrrFIp4UkMN0Sbn5njLCnKRIcTAXY61v0qBsR5ZVgQ=
X-Received: by 2002:a05:622a:299a:b0:460:9b2b:5440 with SMTP id
 d75a77b69052e-460aecd06c0mr153221341cf.5.1729505747632; Mon, 21 Oct 2024
 03:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com> <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
In-Reply-To: <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 21 Oct 2024 12:15:36 +0200
Message-ID: <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 07:31, Shakeel Butt <shakeel.butt@linux.dev> wrote:

> I feel like this is too much restrictive and I am still not sure why
> blocking on fuse folios served by non-privileges fuse server is worse
> than blocking on folios served from the network.

Might be.  But historically fuse had this behavior and I'd be very
reluctant to change that unconditionally.

With a systemwide maximal timeout for fuse requests it might make
sense to allow sync(2), etc. to wait for fuse writeback.

Without a timeout allowing fuse servers to block sync(2) indefinitely
seems rather risky.

Thanks,
Miklos

