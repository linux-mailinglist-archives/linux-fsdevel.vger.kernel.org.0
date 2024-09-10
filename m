Return-Path: <linux-fsdevel+bounces-29014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4E997356F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 12:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8091C24A03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 10:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A906714D431;
	Tue, 10 Sep 2024 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQHe4QpF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E8C8DF
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965309; cv=none; b=os8Io7Cpz5Ix3VP8Fa1c9aBXlI/H21Nvne31839XRVJpFUNHjkLa1yuz0Grk+x1uG99bc8y2V5EKOO9oIFttaw3Rq5e2zCySRXPtFHprDOVGrh4XN6wNMWHeXzPxnijdbYCoZoE+1bccXXxuxWZtQ38cus1jDuPY2yQTSzPEuns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965309; c=relaxed/simple;
	bh=xajBlZ+sqipOB+Liy3MEcna66uUlUlh2+xObflPVmfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYjEn45cybDN/6Z7y5Tkerer9Nr7cKFbkMe8aCO53SzbeBF3cmtpuOFHqu6PlRY8Dw6npPDx3fuwdsk4fZaeXIBZi/TGcQ52VIPH98IKEiFvW+qZJIzx7vMVjR70i34rABax15vOqyn6tcPxNEl2SNAUdkV/KkZaDnFhWd7c9YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQHe4QpF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428e1915e18so45727085e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725965306; x=1726570106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEprpvXVWCiZFk+ynWRCz8tGtA6h8296EaumvN4a6vY=;
        b=SQHe4QpFCwI07oXx3F2Lf7T4scxz/I0k5Uxn8VR62aTvDEfPnFaqkHiZF9/JORO6kQ
         xvZH8XSXepxE7Hggy/gYorYhBbOp0SAJk7p5HzJTOXNDJMH7bjA7fTn+4x61mkrA82Yu
         29bjjII0s+abio+w4Z4QGnljj8uUUZq4wz4inXeVAh3J3zonyroxSm7FqGLNRUlDLGBe
         QlvvVOh8KghCqP/iip1VzqsdU70HYs5s4CNarBkv4+Ok1BmzT9Jr5daIE9fiZfmAS+/S
         F1uvT4hcrLq6yyjVIoqMwNDFwuTcw+ZYn6FSoz6bCQkYkKLCWnQLIT7Bbj576F9RbD/c
         DBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725965306; x=1726570106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEprpvXVWCiZFk+ynWRCz8tGtA6h8296EaumvN4a6vY=;
        b=RIr4ZP71iPb5e577yujZns/XmIxRJLXixmM4UR2oqGWfS7wQ2Ip1UgKvAv8DDEm7si
         zhQcVmSPFv4HimVpLP2G1zLiZdVJK7NVVapTV4IavX68sJs28LJXgTR9nncmx7+1THYi
         7pnzQS2ZK5sMLqdPUWhJvovutCXsyNagSkMsFA3OWwFv7tRUgO6ttMCMJ1QCIcJBiIfU
         0GfdCbOsc4Ao9RSh93pdgYS417y4EaH2VxZrKzhC0MOmWp9Dq8+oX1f4vqGwbJqrVSJ9
         uYns/I6i+Xvfs8p/ntf/d5RBRg7WOmIzDXp6Ld6aF/CoK59iO/3AHPkzwhSS84GG9IrJ
         b+VA==
X-Forwarded-Encrypted: i=1; AJvYcCUOcjXaj/HUSS1iomRpw3wEKSA2tipZKxkCacfOBhDYbfhzKFONW2HJ5kvD+QfKmrC3lvh30wr0/N7LyQDE@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKuwxrpEjem7WKMm9dayfIi+eC2J+zPtMJRa6f1Vh9N0ziLAm
	iTD/W+B6PifZ+cu4nrzVknXRdDvWqSPcCbeERCbpdAKCpl2Azct0
X-Google-Smtp-Source: AGHT+IEOJ7O7x5apmWWthOxiHhqZ1MsaajVphNb6i468pPtB9mAhKITA2Pkq7itF0Sr5dFXuAe+DDQ==
X-Received: by 2002:a05:600c:19d2:b0:426:6f1e:ce93 with SMTP id 5b1f17b1804b1-42c9f9dd28bmr97271805e9.33.1725965305433;
        Tue, 10 Sep 2024 03:48:25 -0700 (PDT)
Received: from f (cst-prg-85-144.cust.vodafone.cz. [46.135.85.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de00fsm8519165f8f.99.2024.09.10.03.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:48:24 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:48:16 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] uidgid: make sure we fit into one cacheline
Message-ID: <aqoub7lr2zg6mlxmhe4xgulk2vteu6p2rsptqajxol2qawgtef@mz2xks2gkjul>
References: <20240910-work-uid_gid_map-v1-1-e6bc761363ed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910-work-uid_gid_map-v1-1-e6bc761363ed@kernel.org>

On Tue, Sep 10, 2024 at 10:16:39AM +0200, Christian Brauner wrote:
> When I expanded uidgid mappings I intended for a struct uid_gid_map to
> fit into a single cacheline on x86 as they tend to be pretty
> performance sensitive (idmapped mounts etc). But a 4 byte hole was added
> that brought it over 64 bytes. Fix that by adding the static extent
> array and the extent counter into a substruct. C's type punning for
> unions guarantees that we can access ->nr_extents even if the last
> written to member wasn't within the same object. This is also what we
> rely on in struct_group() and friends. This of course relies on
> non-strict aliasing which we don't do.
> 
> Before:
> 
> struct uid_gid_map {
>         u32                        nr_extents;           /*     0     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         union {
>                 struct uid_gid_extent extent[5];         /*     8    60 */
>                 struct {
>                         struct uid_gid_extent * forward; /*     8     8 */
>                         struct uid_gid_extent * reverse; /*    16     8 */
>                 };                                       /*     8    16 */
>         };                                               /*     8    64 */
> 
>         /* size: 72, cachelines: 2, members: 2 */
>         /* sum members: 68, holes: 1, sum holes: 4 */
>         /* last cacheline: 8 bytes */
> };
> 
> After:
> 
> struct uid_gid_map {
>         union {
>                 struct {
>                         struct uid_gid_extent extent[5]; /*     0    60 */
>                         u32        nr_extents;           /*    60     4 */
>                 };                                       /*     0    64 */
>                 struct {
>                         struct uid_gid_extent * forward; /*     0     8 */
>                         struct uid_gid_extent * reverse; /*     8     8 */
>                 };                                       /*     0    16 */
>         };                                               /*     0    64 */
> 
>         /* size: 64, cachelines: 1, members: 1 */
> };

May I suggest adding a compile-time assert on the size? While it may be
growing it will be unavoidable at some point, it at least wont happen
unintentionally.

This is not the first time something unintentionally passes a threshold
of the sort and I would argue someone(tm) should do a sweep.

