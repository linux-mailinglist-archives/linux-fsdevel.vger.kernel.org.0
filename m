Return-Path: <linux-fsdevel+bounces-24679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5AE942D5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 13:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5551C2231C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666C01AE879;
	Wed, 31 Jul 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bxLoMOPO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078FE1AD9FF
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425834; cv=none; b=lCTYHNc/RFbAGiICmYq0G9BQX70UxnKpTJNF4X5bmHkp9E7Xhu0medqwcnS2/MOq+GGLQwvmVl/18HatfB/cO9YVujlbdbBFS/lODfwfKmVn3lmFJi678I0h0AodBFrCzbJA6yvUvSvmMzlH7n2xE23qBdAopUtcgHGH5luU01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425834; c=relaxed/simple;
	bh=gmAAodUXdgnNESvRXNAekJJqooqvvUxv3wuMM+/4RoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNHyTZidrYpvxns6oAoZoxJIi01xAZ0b3k5JqipQEUk3fR9jaXjMMlORewOJhKW+FE1EJ2npSqIB9sT7aK4eq7kR9V3yKZa380/h3eepmgFBeNrk2GczzZWgEVUuywrQHwNNFzg+iirjWvKxqryUVEKGzOtCaaBYzkljZ2zpRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bxLoMOPO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso440034966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722425831; x=1723030631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iVqiOcI/Lm61Kn6z1In0PhQoNC9BfNgfzLWAbxhDSI=;
        b=bxLoMOPOeudPozRvAPyB7PabtaNkaJp9NcIjy/NUHVUHtZy91XIeOZFdzZEqHTQWgR
         MtUxk5AV7lcG1PbWvNlM5IgjD6iNy1yXFsmlxkuT4AUs1yF5WffguciTZrncOJ4la9TR
         YnI5p6HwgEYW8UjjtNSwuXG2qfKAOMVyQ3/bWbAsiGP8LUIfotLsicQsMs8N9CeyPeti
         ymMXVq94xmEGSpEYKMrQzj1GlB9x9eGADLRR8SxUuZy9RouPx0G15ssbdl4dTK8iEvFt
         QbH8lJT8pSA0UJjyb5oGmX/T5flpOKEkI7sXJzaWW5sh9YXbnhXqil2bD+R6KTzJZtHa
         AcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722425831; x=1723030631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iVqiOcI/Lm61Kn6z1In0PhQoNC9BfNgfzLWAbxhDSI=;
        b=I1j/DI39ztb/VLjdNh8W/kEM/+2+RP+ZaCyw9txOND/k5iuScDqWVtu+Zb/WMwjGeR
         TuBklY5DhSFxQAN+xfO4XihbGmGPYS9i04sQ+iMGWxiB+59ezfAL1lBUUFmLPcwz8r76
         amF3e/bLQQ6swDID1lFrc43VivScHimVdaVBLYFtjwvbwGlzUq67jTfWg0nYda5R7VVZ
         HZvRr7CatX6Zmx0U9JUP0w6K/xvkPbBi704DZxvCbARjKnHeJAcNp7yliDFXk+zGUrBM
         9VrV5lA7D8Re+gLsHCAGMKIu5+1VtxZFz225kyA3NHHn0AhbohFWycGIHG8ZX9xjSveF
         Ie6A==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6QP73AnkzpUW9S6cDRgq0b2mLKCNkHlH34bcSW2kr1HS//yrIfTz28l+fn9m0Ch0xJbHeOdQ6JJgHgpXJN34hMvo+M3G3nGP+HXx+w==
X-Gm-Message-State: AOJu0YxhK915SKelE1Agk1UKeqZKcgiFUT2JbZ13wMEb6ZB3YvSp+uaR
	TpdizKIgJT9vms047Jwxm/1ZYOfBZfpWZ0R1e6+CDiakO3JPzYQ2sHfoaNRHnb/dAJRozdFhAtE
	WhARIlBzW9PIUUQ0U/WrV7AzSa5h9ymBnURfi2A==
X-Google-Smtp-Source: AGHT+IGKzF7L3tGT7YjvoFGJDwdINXnVaS2Vxa/MttoDWTfIP0ZESkvvOTXarzXIGvRKUq2y7x6k6CcvXSEnf4eYun4=
X-Received: by 2002:a17:907:6d1b:b0:a77:e55a:9e8c with SMTP id
 a640c23a62f3a-a7d40128ab4mr796501666b.47.1722425831422; Wed, 31 Jul 2024
 04:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com>
 <3575457.1722355300@warthog.procyon.org.uk> <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
 <CAKPOu+-4C7qPrOEe=trhmpqoC-UhCLdHGmeyjzaUymg=k93NEA@mail.gmail.com> <3717298.1722422465@warthog.procyon.org.uk>
In-Reply-To: <3717298.1722422465@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 31 Jul 2024 13:37:00 +0200
Message-ID: <CAKPOu+-4LQM2-Ciro0LbbhVPa+YyHD3BnLL+drmG5Ca-b4wmLg@mail.gmail.com>
Subject: Re: [PATCH] netfs, ceph: Revert "netfs: Remove deprecated use of
 PG_private_2 as a second writeback flag"
To: David Howells <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, willy@infradead.org, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:41=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:

> >  ------------[ cut here ]------------
> >  WARNING: CPU: 13 PID: 3621 at fs/ceph/caps.c:3386
> > ceph_put_wrbuffer_cap_refs+0x416/0x500
>
> Is that "WARN_ON_ONCE(ci->i_auth_cap);" for you?

Yes, and that happens because no "capsnap" was found, because the
"snapc" parameter is 0x356 (NETFS_FOLIO_COPY_TO_CACHE); no
snap_context with address 0x356 could be found, of course.

Max

