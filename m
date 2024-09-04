Return-Path: <linux-fsdevel+bounces-28573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F022C96C25C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88AC28C09C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C381DEFC7;
	Wed,  4 Sep 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEWCH9L9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6141EC017;
	Wed,  4 Sep 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463762; cv=none; b=EiKFvJ6vOfzqDI0h4FkiLnFKUk/t20eo/KPov4clsvq7L3QW0fVNrc0TiR2eZH8grCTumVnSz7W/MEa0Uzr7mQWGHfEjPsv4letiw1Z6IszFZ7XMod6jn5RjUITMGjW28KypiladN01Czl2WMu1XLb28WnLJBSd6QvT5gI/tohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463762; c=relaxed/simple;
	bh=D6HI9Mwch4F78XaYWMZF+PV3MdD/2wFCpUYz7uq7YDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r63MKVVq2+TVK2uzXzvZ6EDWDInHDBJHrfwNADu23rSqlw/bhyhLBh6+N26xeNxPq1qWEcccoew6yrQSxIqIOI3msRH5f/7j6lpVU2UWmlstJhvlETSePMDYv5v+pQL2B/bHKi4ezSEkKeQULqWe+HvbnSy5/poPaDVSropFLJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEWCH9L9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0505C4CEC2;
	Wed,  4 Sep 2024 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725463762;
	bh=D6HI9Mwch4F78XaYWMZF+PV3MdD/2wFCpUYz7uq7YDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEWCH9L9XWmP4pcznNFj5wNA/VGOk0YU8B5xZjetrPXVg6QqAospEtlLW8rnQhVQB
	 qRKSuSPtiX039AZnws9VieP0/1AZirOycrFv69cwp7/lnP0oRAk1WxCQeylcq0avTa
	 URtNzwi8JI2i68isen3BlDvDQVVPEP3K1SuLZzefCmHGNFgQBoKS46zPl2HK+sTaOJ
	 TEjDPqmUeijv3HdBBVYKFXrTi7oHamQeVdaGIrPYQG5F4/JXuwlKRJd3nBdSvPzYG5
	 wItEN/rJBaRxjgrNGtK6qgOfkaylNWScb86Np4Hd0NScchnejenMvLWO30al8xeAlK
	 Cxvq6iw6BZDew==
Date: Wed, 4 Sep 2024 17:29:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	mszeredi@redhat.com, stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/15] fuse: basic support for idmapped mounts
Message-ID: <20240904-kehren-umzug-4dbff956b47e@brauner>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegsouKySsJpYHetSPj2G5oca8Ujxuv+7jpvmF57zYztbZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsouKySsJpYHetSPj2G5oca8Ujxuv+7jpvmF57zYztbZw@mail.gmail.com>

On Wed, Sep 04, 2024 at 05:15:40PM GMT, Miklos Szeredi wrote:
> On Tue, 3 Sept 2024 at 17:16, Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > Dear friends,
> >
> > This patch series aimed to provide support for idmapped mounts
> > for fuse & virtiofs. We already have idmapped mounts support for almost all
> > widely-used filesystems:
> > * local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs, ZFS (out-of-tree))
> > * network (ceph)
> 
> Looks good.
> 
> Applied with some tweaks and pushed.

Ah, I didn't see your reply. Fwiw, if you agree with my suggestion then
Alex can just put that patch on top of the series or do it after we
landed it. I just think passing NULL 38 times is a bit ugly.

