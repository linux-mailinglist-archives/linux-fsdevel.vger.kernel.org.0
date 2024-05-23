Return-Path: <linux-fsdevel+bounces-20072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90B68CDAC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 21:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248321C22BC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4582084A49;
	Thu, 23 May 2024 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NKfYcF2Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98283CC9
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491831; cv=none; b=n7sSqM7kCsEoMne7HaqGXHjFbE37/e6KMeHIcRTzchKjBo2MeLMVLWKyJDncmsu6pmGbiqLcz72CQUbRcQgPvJjX0UJziTkYj6qzZaDHdGNz3xL23oDEHTNyoCT9QkDFBHvFymKicWFGNZf6hzRjZwXYYYop5VhZtyXyT9mRhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491831; c=relaxed/simple;
	bh=XHGnzUbAu/lgtI7aJJ/7Q88s6FreZQE3Eor2XeaNWGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtyQRAy/CI21DBY6MvH2QAGF1bl27yesVYGlhygrZMkHzZDHkjzY22W24TmDpgxKkBcaWJYO9ovyfG62GjMmo82D0C8/PYPJJhSun7oirnep78+W1lGnbCVCZpN5HNtFDFUTeBCzFl9M8BlGhDtGGs/4LDN5dGCiGsVgLMFQySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NKfYcF2Q; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f8e85a0a5bso144994b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1716491829; x=1717096629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHGnzUbAu/lgtI7aJJ/7Q88s6FreZQE3Eor2XeaNWGQ=;
        b=NKfYcF2QymbfEMgdfzIMJ/eOYu5EXDWmWkCu7rRrIoIhFxG+Zrow+loBYerUX2dWb9
         Sq4bI1tPlEtpvz6Xjgcs5c9TklJmbFI5p44RJzFm7AlB7aPdM7i27IE0lLs8oGpUhLfC
         dM9dxBdsLGPQkzE3/Qo+nQlSC80ThntMlR1fU9KNRPz5KgIO32ViDPwwnOO1qduttzKB
         psRkR5P+iRp80aee3FDUIjiN6wKy8hHykXLaymQa5UuIi8S+EeULXk3wnLJ4z/z10L3r
         jzPFA15W7x2Me8nfVYpii9pUvP3FOKrMkdVg7cZsMuPCD2qUyP87Qp0HJf14rDEoxbye
         m/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491829; x=1717096629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHGnzUbAu/lgtI7aJJ/7Q88s6FreZQE3Eor2XeaNWGQ=;
        b=Z6+6OPVTjlDEcSnAlm/2Vo5HO8qznz6pu/OC/s/ASZxqedXUxdrBqwuo8DfHV+6PXB
         mY8VNdyoXW5DUnBO39QF7aXOxt+gCSyTVrew+Pl7oNy2UQxig8d9fljZwzjh9DT/w2fJ
         Ok1L0ZME7nTdFpXfnIe5/Zydo28nrHkUcmkOu6Iu0WxPKIvOmzFIh4SmMwfbnxU4KeEv
         aeXZmROensr70HvDmqp6qgrxBbuql0PitTfwDln5M0oSW+nwvJBCjxDaaLNi9VoM747p
         jhr+qi5nLgXU6bgu36VkEJHuI5V7cfofPZM/vr/XcyvpfM7Ckphh2l0OsDvvrYRdwMlL
         k1IA==
X-Forwarded-Encrypted: i=1; AJvYcCU83Sg6aeKHbBskAok8zRWePz0LwvDwC1F1CbWBKcbARSti14+awdJMU0z9btK8w2VfSJ1mgu3DMdzDAYx0PDcxdlRRAn60apvD9ARJjg==
X-Gm-Message-State: AOJu0YxT6lkKusf+icG0/AGMAso5o92JbS+X/BcPcoJtqO0ZAmB5K7sm
	d6zyid2id6Qy1nWeXpm1fxc0qH0Coofe8mfsZG5/aF2wQjw8vHEZcb0iq4uP0LG+3pKtLq6gv85
	5uYxJDMDUz74iOXxhQiHb/jfBMg7sLUHHvDHREA==
X-Google-Smtp-Source: AGHT+IGqZmCccDYDP41dqxMcdyQX91RuVAfV5QMY8fV/5WDcPW4VLauQTYRVutnuQ7xeHpjgAi5vfKFxBN65XkeCoGQ=
X-Received: by 2002:a05:6a00:28cd:b0:6f6:7c17:704f with SMTP id
 d2e1a72fcca58-6f8f2c626e6mr187429b3a.5.1716491829330; Thu, 23 May 2024
 12:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523183531.2535436-1-yzhong@purestorage.com> <20240523115624.d068dfb43afc067ed9307cfe@linux-foundation.org>
In-Reply-To: <20240523115624.d068dfb43afc067ed9307cfe@linux-foundation.org>
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Thu, 23 May 2024 12:16:57 -0700
Message-ID: <CA+AMecHUo-sPy5wDszWgX5BWPAqMwrXqCWO1jGE5uMRq2U=BVw@mail.gmail.com>
Subject: Re: [PATCH] mm: /proc/pid/smaps_rollup: avoid skipping vma after
 getting mmap_lock again
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Mohamed Khalfella <mkhalfella@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 11:56=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> Please describe the userspace-visible runtime effects of this bug.
> This aids others in deciding which kernel version(s) need the patch.
>
Otherwise, with some VMAs skipped, userspace observed memory consumption
from /proc/pid/smaps_rollup will be smaller than the sum of the
corresponding fields from /proc/pid/smaps.

Please let me know if separate v2 is needed. Thanks

