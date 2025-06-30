Return-Path: <linux-fsdevel+bounces-53326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1677BAEDB33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 13:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2004189B045
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 11:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18D425F980;
	Mon, 30 Jun 2025 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9q8UUaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A125F780;
	Mon, 30 Jun 2025 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283327; cv=none; b=hX2RX2C/MhUrmZDn7drhtRr0t7gecm6iqdlOPwfDZvLd1/yDbkjA8qFW4cRuWQb7/NGtbXSGTR4teAl9Ot4KZmlpbChUmNRGtvO/Og/p7n5O/r/PPiVs3x6tp6MLzryEAT6yDvBJhtWPu540d7purUUfScftLNjEncmU52JEa/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283327; c=relaxed/simple;
	bh=jxDgTymgrkOCfaHXF2Y6MXcF4JNlwCcl3zCw9mUO+7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n06ryWl7Yf26TRNXFyw4bMO3Ufl29CLIIv4MVx5BeJbqV+5ZNAx4Sh/jB9HNfrQ4dHmbQyTMJPd/50O83L9I1Phrg6Q396Iz67N7MGU72SxvT2ueB2/3wT2dY5P7YFAlh1P5WXPAa8AYDHVXiLdpo4Gw8BBZDyzxCF2oB1/sqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9q8UUaM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae3a604b43bso6961266b.0;
        Mon, 30 Jun 2025 04:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751283324; x=1751888124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN1pNkGyILLKxYs8q0ZgJa0IyHDHxUxA0RrIfq1B4rM=;
        b=W9q8UUaMrCeeMHwVZpFZG93F04vUq97QIKHlFKmn9hRF9kKU7E5dP2xngBiF/WHW/r
         t5TAajjRCPggG71z7pD5R5zRYDJwewgXx7AGjlXSxfgINgTmkLSowHCdVNXR7tH7gtv9
         tTO0x/X013tY1OHAtDpp/Xo2j3F+I4bV9wueZKhsG/Pqiqds7NPt5H3mrJYNCDkHO6ZF
         SvL41lE7DxZRGLdhK9kp+jcdliVYMB2/whXDJr291omjplMY8p0m2+bGtjsy86gynEBF
         uYUZXNJ6H3e1mVD5NibOPMoG7paDwymkIdsxbslCjCFUmLnQCbk6TH7tcqG4Y+J818sl
         UgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751283324; x=1751888124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN1pNkGyILLKxYs8q0ZgJa0IyHDHxUxA0RrIfq1B4rM=;
        b=gxdgLzaAoBELJ3ItVN7GCo68tn5txc7jM1ZIQHfv1NHQZnrJdyjj/HYlc8d9R2ZoTO
         yKeZ64NxB5zV04ph2td8VhicD3NLhsLWsK66y+PFTvn5hI8fpzsqSnSmT0qkS4BoRkFS
         VXVZluTDFpQJPPgsXUgSBR87anuxhMjM+wiXE/woIaCFRNrWL7fNPlMYFF0ZBdbfwX5t
         5vmtyKeqvHfaqAr5+T0KlqX0+D3jorZ5mwBoV9CgFrtoD5TqdtvGW1gFM5PuzM5d+TXj
         YDjweZX1wl1lvyfC7OqpySGDdHIsRLGlbrRTxAOW6swxKS7AkzhHCCmj9nekBLoc0tu3
         7bgg==
X-Forwarded-Encrypted: i=1; AJvYcCVXhsGYIfczRNZORwo/ZkhAQOJPNrTSw7a3xyt+j9gT+HqjZ1/KkxweGEl+dLZ3N9Y8jJQwuRqY8xuLUHK+@vger.kernel.org, AJvYcCWUgl568lrC93ZWK3ATn6oP1mcp5JDMDHAUaoRG6Jzt3CdH1YKYZMc357Y+ic4aJNAhp+Bfa6hTIqiKiiog@vger.kernel.org, AJvYcCXGwzOHCNYIOYpxe/iZe7Pay86c0N1D7G+s8aLUDw7UvjUpxxAtoonb34ungVWETmkT+XLKaplk@vger.kernel.org
X-Gm-Message-State: AOJu0YwToVPHscd+zOKg860+3moqULrL2NDFufTfo0TZ7+lxQqLAmTEY
	JXDrnE6GTfIh3VFLIJqjFP4n2QJPtEoog+lxsrj3cYMzyhBXtCD+t3bN4+PV/YyZWgmUBj51mlU
	s7Cq/TA8fg7Jpj0NM4JVgYX1UyuE7pk+WnQ==
X-Gm-Gg: ASbGncutM5JWdtUkOgXyJ3rjFbVUGDm91NP0x6IiRI/Ool6nj/ZYhNwJBf7RPAV1Y2K
	bQaDg7SelKmZa0LcVlFu5XHE9eRt4SA1ZRS//+xdqDN+ImREp+TBZXpM5CBgngI4KJU44KyyeK8
	ZxdspUTZQ+piFRvTk/YPtB4SLLojeJ4JpRWg2hEvsTDg==
X-Google-Smtp-Source: AGHT+IGtXw4MK1+g3jT+Sq0XnairCuX39bxiUwT4AmNz3L+jvZSG0RA+WE095s6R3gIsGqhSXEWOHoc0lKUTw6QvQsA=
X-Received: by 2002:a17:907:e84c:b0:ae3:53b3:b67d with SMTP id
 a640c23a62f3a-ae353b3b746mr1037919966b.1.1751283323269; Mon, 30 Jun 2025
 04:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629074021.1038845-1-sashal@kernel.org> <i3l4wxfnnnqfg76yg22zfjwzluog2buvc7rtpp67nnxtbslsb3@sggjxvhv7j2h>
 <aGIA18cgkzv-05A2@lappy>
In-Reply-To: <aGIA18cgkzv-05A2@lappy>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 30 Jun 2025 13:35:08 +0200
X-Gm-Features: Ac12FXxKcLCNFnGjHQv0vFJY-m6rv6DvOVyZJ9Y8NkFLTQErXrsXjDGNf3iGevE
Message-ID: <CAGudoHHuBBX_FWKp96TZV7vs2xvxkFNkukt4wysx7K3OZDsLDw@mail.gmail.com>
Subject: Re: [PATCH] fs: Prevent file descriptor table allocations exceeding INT_MAX
To: Sasha Levin <sashal@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	akpm@linux-foundation.org, dada1@cosmosbay.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 5:13=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Sun, Jun 29, 2025 at 09:58:12PM +0200, Mateusz Guzik wrote:
> >On Sun, Jun 29, 2025 at 03:40:21AM -0400, Sasha Levin wrote:
> >> When sysctl_nr_open is set to a very high value (for example, 10737418=
16
> >> as set by systemd), processes attempting to use file descriptors near
> >> the limit can trigger massive memory allocation attempts that exceed
> >> INT_MAX, resulting in a WARNING in mm/slub.c:
> >>
> >>   WARNING: CPU: 0 PID: 44 at mm/slub.c:5027 __kvmalloc_node_noprof+0x2=
1a/0x288
> >>
> >> This happens because kvmalloc_array() and kvmalloc() check if the
> >> requested size exceeds INT_MAX and emit a warning when the allocation =
is
> >> not flagged with __GFP_NOWARN.
> >>
> >> Specifically, when nr_open is set to 1073741816 (0x3ffffff8) and a
> >> process calls dup2(oldfd, 1073741880), the kernel attempts to allocate=
:
> >> - File descriptor array: 1073741880 * 8 bytes =3D 8,589,935,040 bytes
> >> - Multiple bitmaps: ~400MB
> >> - Total allocation size: > 8GB (exceeding INT_MAX =3D 2,147,483,647)
> >>
> >> Reproducer:
> >> 1. Set /proc/sys/fs/nr_open to 1073741816:
> >>    # echo 1073741816 > /proc/sys/fs/nr_open
> >>
> >> 2. Run a program that uses a high file descriptor:
> >>    #include <unistd.h>
> >>    #include <sys/resource.h>
> >>
> >>    int main() {
> >>        struct rlimit rlim =3D {1073741824, 1073741824};
> >>        setrlimit(RLIMIT_NOFILE, &rlim);
> >>        dup2(2, 1073741880);  // Triggers the warning
> >>        return 0;
> >>    }
> >>
> >> 3. Observe WARNING in dmesg at mm/slub.c:5027
> >>
> >> systemd commit a8b627a introduced automatic bumping of fs.nr_open to t=
he
> >> maximum possible value. The rationale was that systems with memory
> >> control groups (memcg) no longer need separate file descriptor limits
> >> since memory is properly accounted. However, this change overlooked
> >> that:
> >>
> >> 1. The kernel's allocation functions still enforce INT_MAX as a maximu=
m
> >>    size regardless of memcg accounting
> >> 2. Programs and tests that legitimately test file descriptor limits ca=
n
> >>    inadvertently trigger massive allocations
> >> 3. The resulting allocations (>8GB) are impractical and will always fa=
il
> >>
> >
> >alloc_fdtable() seems like the wrong place to do it.
> >
> >If there is an explicit de facto limit, the machinery which alters
> >fs.nr_open should validate against it.
> >
> >I understand this might result in systemd setting a new value which
> >significantly lower than what it uses now which technically is a change
> >in behavior, but I don't think it's a big deal.
> >
> >I'm assuming the kernel can't just set the value to something very high
> >by default.
> >
> >But in that case perhaps it could expose the max settable value? Then
> >systemd would not have to guess.
>
> The patch is in alloc_fdtable() because it's addressing a memory
> allocator limitation, not a fundamental file descriptor limitation.
>
> The INT_MAX restriction comes from kvmalloc(), not from any inherent
> constraint on how many FDs a process can have. If we implemented sparse
> FD tables or if kvmalloc() later supports larger allocations, the same
> nr_open value could become usable without any changes to FD handling
> code.
>
> Putting the check at the sysctl layer would codify a temporary
> implementation detail of the memory allocator as if it were a
> fundamental FD limit. By keeping it at the allocation point, the check
> reflects what it actually is - a current limitation of how large a
> contiguous allocation we can make.
>
> This placement also means the limit naturally adjusts if the underlying
> implementation changes, rather than requiring coordinated updates
> between the sysctl validation and the allocator capabilities.
>
> I don't have a strong opinion either way...
>

Allowing privileged userspace to set a limit which the kernel knows it
cannot reach sounds like a bug to me.

Indeed the limitation is an artifact of the current implementation, I
don't understand the logic behind pretending it's not there.

Regardless, not my call :)
--=20
Mateusz Guzik <mjguzik gmail.com>

