Return-Path: <linux-fsdevel+bounces-46227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2611BA84CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C43B9A7540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CA829344E;
	Thu, 10 Apr 2025 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKl0sbvL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF128FFD8
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312820; cv=none; b=jyzxiMiJ1iUcJrx4QD0XKZXqjo6J1uJmGnwJyB7doT8qieW/2AX4UIILak+O1l4kAW+RFa+dw4qqxDhWCaZ/5pPyuHHPn+hTT1S55E+pF9Oud9we5QHjSHzkziHox39l6IlxFj+SYEtAvHtP/DFJHNUUKuhTadUbY0C8DwT6nOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312820; c=relaxed/simple;
	bh=BUp6dVA/9/DIHAm8btLSsebQGLRoM6QqRKm/vQlyaG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLyrJfad4iBruifm5RXvEZ/ApFh9t7DgBbGFXyK3rxocSW/Y1kLiSQtzaNnjCV5q4fQRCu9+N2LNzux9fd1yEE8tFCRlmHFo4xRcDhE6Kdcn/HdFjF0bPeYgdSpKcGvK4fd6CR1ydE5ieIKqXbJQbX3NwVB4fMG0fF+NoBxXYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKl0sbvL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744312817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qyuCy71sNM096ptCCI9TtV8xzN/TLmJLvM6k58//nE=;
	b=AKl0sbvLTqSfaHiwBrGFiZXPzgz6TrDW4jFZVydZQfNXV2qFOwbnZnk3NqxSWL0QbzHzZ5
	x2YKKyE1jQ2MFR1BQypEqMb08hseDTX/xilnT4vfaLbF5ZlLIpPXSTbcttGfr2tQ9EobS9
	3Q8PYtYhSF5RtHgXByyTZ/l6n/6U0DU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-zFvfDnIFPWOm868RaQD_hA-1; Thu, 10 Apr 2025 15:20:16 -0400
X-MC-Unique: zFvfDnIFPWOm868RaQD_hA-1
X-Mimecast-MFC-AGG-ID: zFvfDnIFPWOm868RaQD_hA_1744312815
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2242ce15cc3so9320015ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 12:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744312815; x=1744917615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qyuCy71sNM096ptCCI9TtV8xzN/TLmJLvM6k58//nE=;
        b=kni97LJCxo7JcNo44VH4edhxHchIeazP8zLE9BCv2uujVeMXLq0LKQMzE9ZBsKm2hX
         yZJQke5Rdg6cxhRIIrj9zW7n4sCH6GNncqXRclowkcU/Tjy+KiQB8McFnoZ1BjaefUyl
         0CFBnQxW6+BDZHYZfKXmexo2WF1IbgFPbGHiMVgi3W5UTiqWm1rfsWTgNP6PT+RTB3FJ
         wWjp4i2D6GMrFwWbzsADCZIlpE2zzYryvbvZUACxpsoWZ3S6HoLlBqumNNbvu7L/xylN
         zv2A0btAhYV1CqUigBrJNT9XbeBGjb0U/pE4pNRgmT3yeEfVOSwTPB/SnLk1PQk0Rw8E
         Lrhg==
X-Forwarded-Encrypted: i=1; AJvYcCWHs7SYvIJ00Ug2XBqNyMxMScT/NQTLTpM6MbRgucOyr3WtcAvCzDfOTj6qeaFnkuqnJGWyxL2UsoB0zbnf@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdtT/zuxpC6nN25xaDnXLQR58NVqIW72gkFYSUn6xgUzfv3Vt
	lLGoeqbyeaSZIOsQYNZm1HyeRVlcgMC2zPtK2BA7yAUip9eHNbRzKUGHUEgnhvRTlWdA0k4KkJH
	3KpCTVNDO+OVFFTMQzWmdHPvAZ6ppslXS9BPGnhY4YVfKXl2eHlYygU449AZw+LnnABWrupZkd5
	ec+79GKXWH4NKa0ROvU3IDF2p6GEBQTVi4hAzE6Q==
X-Gm-Gg: ASbGncsqxbqoMyH800Wii6yBdeh1LmyYV8PBpWEOGM5MTVbAGS/lOkgk4xhYboPcob8
	KnlaR6Z1HSXqCKzKN2jfPAqfl4gtherr4XcMP/rBjh3hWP4BgDmNncYzNFT/ne7TiKo0=
X-Received: by 2002:a17:902:e88f:b0:223:2aab:462c with SMTP id d9443c01a7336-22bea4ab85fmr71685ad.15.1744312815423;
        Thu, 10 Apr 2025 12:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6DNynR3qAzVJ5oYYe87012HehD64MJOEbZmJ5Zs6nbMEMT14kmxUjgfXc/J/nlg5RXQ5jsTdGAdgJRpiy1tQ=
X-Received: by 2002:a17:902:e88f:b0:223:2aab:462c with SMTP id
 d9443c01a7336-22bea4ab85fmr71525ad.15.1744312815145; Thu, 10 Apr 2025
 12:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407182104.716631-1-agruenba@redhat.com> <20250407182104.716631-2-agruenba@redhat.com>
 <Z_eGVWwQ0zCo2aSR@infradead.org>
In-Reply-To: <Z_eGVWwQ0zCo2aSR@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 10 Apr 2025 21:20:03 +0200
X-Gm-Features: ATxdqUHNINlL-pUTFVGgFjmH-0Yv2T34SdJ_H6wPly98qpm7VaT0OlGqfhHJNig
Message-ID: <CAHc6FU4J6MsEaUFUfp_ZpuYKyXRpZ=FTJE9T=iRQgbByQWZOFA@mail.gmail.com>
Subject: Re: [RFC 1/2] gfs2: replace sd_aspace with sd_inode
To: Christoph Hellwig <hch@infradead.org>
Cc: cgroups@vger.kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Jan Kara <jack@suse.cz>, Rafael Aquini <aquini@redhat.com>, gfs2@lists.linux.dev, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 11:01=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> On Mon, Apr 07, 2025 at 08:21:01PM +0200, Andreas Gruenbacher wrote:
> > Use a dummy inode as mapping->host of the address spaces for global as
> > well as per-inode metadata.  The global metadata address space is now
> > accessed as gfs2_aspace(sdp) instead of sdp->sd_aspace.  The per-inode
> > metadata address spaces are still accessed as
> > gfs2_glock2aspace(GFS2_I(inode)->i_gl).
> >
> > Based on a previous version from Bob Peterson from several years ago.
>
> Please explain why you are doing this, not just what.

Right, I have this description now:

    Currently, sdp->sd_aspace and the per-inode metadata address spaces use
    sb->s_bdev->bd_mapping->host as their ->host.  Folios in those address
    spaces will thus appear to be on "bdev" rather than on "gfs2"
    filesystems.  Those "bdev" filesystems will have the SB_I_CGROUPWB flag
    set to indicate cgroup writeback support.  In fact, gfs2 doesn't suppor=
t
    cgroup writeback, though.

    To fix that, use a "dummy" gfs2 inode as ->host of those address spaces
    instead.  This will then allow functions like inode_to_wb() to determin=
e
    that the folio belongs to a a filesystem without cgroup writeback
    support.


Thanks,
Andreas


