Return-Path: <linux-fsdevel+bounces-61934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4F0B7F859
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCED8175D85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 13:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29D731A7F4;
	Wed, 17 Sep 2025 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WMHj4Kqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EBA301712
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116394; cv=none; b=sOK61MAuq11Ww6lS13MV0z2Pn0cI9cAmd+byqAgjaE3oQdbZHWn0PW4Vr/hG2GIH1z7KaTp1/p+u5UFqSjg0szPSsnJERdGoIUw5J2w18dyK2z/KM2LluzBNy8iaR6jcifrl+XQanNJzX4gl2BuFw3u4CEKUBkww8X5gWbQJ2Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116394; c=relaxed/simple;
	bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3cYwFmVHaM7W/eHSlCDqUOuryMBsMNu2tohazQLanVMOELr3Oz10aUmAX8OF+cbAmiENRUCq22aOLyyEnzlGwUKYbGTE4wjwY1iQl+x0eT9I8EdrpPIpd0YW6D2IrRqBo2EYEW3pDu9zZk1N+EUtS5TpDXwC13u8O2DCJMkeCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WMHj4Kqu; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0428b537e5so912960366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758116391; x=1758721191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
        b=WMHj4Kquf++/0XnW5YC9J7arXXohiQsxOYLXNSGWpEwSWxTZm3dA5ZfkRVvmrPMpxi
         OaHNNUiU4DJvvGYMqtj53GtqsEV5o90ZkfVzhh2J9olnk2AQ+nDUI6VtPii+JHT7an7z
         FU3Htq5MZlkeX878lHh43KqdqgUfAJnF+Z8Ilrin+oHGViB4Nd1nVMIFBDrW/NuJ6QWH
         /Kd1FroK9Ehdh4d+d5qQvKMxMf1ENpFNyqs65ZY8uGYv7JL299Lu0Idi5w1pLZibh22J
         vSijhuR40zd05xAkZdOiKk+Kp8Mp0cBX7F0nY3+Q6m1mJGHDDMbIlLLr/NOi6dOxm2ht
         6btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116391; x=1758721191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
        b=WKlpN2CgP3liyydBf4QX5b2XUv8PZhgo7Aw7YkNa1bTH/l6uj1uCxG5YzXhm+raJkk
         72sNclW1htse8MlYjxDVNoXdaCFsPNoNta4d8hM70/b6CHm7JLaY90tajMMs9w/Nj7qf
         +K+2rp1T2t7nM6UmVbxU3R+Q6yqIMy0Mgjq7q12lKYR5wZRxu02JR2YtSViJuXolvDd4
         xZ4hwgNWbfzCCjF+1w/Wo3tlcm5ZPfmiXti/ONyiqEuEMv4rnm+bFi3L0xVEeTGLZfLP
         apMAsgHPYZLlfji/ozvrREA2LNxgWYvdB5LUT7dM27xR33fZ6Ezkw0lChTXzveHEsZIf
         RPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDR8b+YwCy/1M3PBDOrOl9km5/dLeYWpL7gOnLBgP4g/iorJm3mAOfJk1oNUdhO0RB56FM6o8UCfbQt+ZX@vger.kernel.org
X-Gm-Message-State: AOJu0YwmlYKC/EwNusVZ1hwpVUy8SwlUF8TnxRN4Wi0twWwxp9pdOeh9
	0n9tarmlXRynrRPjw1c/GQEHb5qpK1U0BUsg5JR8Ljbu7hFf5L9jhtuiAiWjsGbv1SsBJVtmhdL
	P1xrTxrcugbLx7F/6m3AE5yzlnkNtEL3wmLffFo0NTg==
X-Gm-Gg: ASbGncvF+OyDFiYYWObFSY/5tI0NfXFk3NqoXtDrgQqDfM1w+JDoao3Ay6RG1/Pvc3P
	OglAESPZEJcI8h7+MCXxGc4N7f9ilHsXhJ16C3dlrIztNMTtOPu7Flj4g4VZ/4VKXsGhNxpbsQh
	2Hzamp5baODq1JV7PWzcMJnskQ32QQb8/1fI2Q8bbwwOZGGWIE2H4mMjyDbdv+MEYNwFq2PceQe
	Qp/xq/bus1uI9x8qEugGEi9bwBLyIvdNngn
X-Google-Smtp-Source: AGHT+IGqqKefXP8WxcN/+l1jwy9unDcdcYQ+LOIaW5Cks3BIj9V+aI0trws7o6JbFaSx8xHpY7sjGGzFBBSJONjxZms=
X-Received: by 2002:a17:907:9687:b0:aff:9906:e452 with SMTP id
 a640c23a62f3a-b1bbb0678f2mr302885666b.31.1758116390548; Wed, 17 Sep 2025
 06:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
In-Reply-To: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 15:39:39 +0200
X-Gm-Features: AS18NWCdr6GqUOQd4v8IrrCyA7jXtDhoQx-mp5NUMtPzl5TNlq5K2XQ23QjAEV8
Message-ID: <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> Does the patch convert literally all iput calls within ceph into the
> async variant? I would be worried that mandatory deferral of literally
> all final iputs may be a regression from perf standpoint.

(Forgot to reply to this part)
No, I changed just the ones that are called from Writeback+Messenger.

I don't think this affects performance at all. It almost never happens
that the last reference gets dropped by somebody other than dcache
(which only happens under memory pressure).
It was very difficult to reproduce this bug:
- "echo 2 >drop_caches" in a loop
- a kernel patch that adds msleep() to several functions
- another kernel patch that allows me to disconnect the Ceph server via ioc=
tl
The latter was to free inode references that are held by Ceph caps.
For this deadlock to occur, all references other than
writeback/messenger must be gone already.
(It did happen on our production servers, crashing all of them a few
days ago causing a major service outage, but apparently in all these
years we're the first ones to observe this deadlock bug.)

(I don't know the iput() ordering on umount/shutdown - that might be
worth a closer look.)

