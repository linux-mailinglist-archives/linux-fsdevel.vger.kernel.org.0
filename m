Return-Path: <linux-fsdevel+bounces-37053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820309ECB1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 12:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AEC286984
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4344238E01;
	Wed, 11 Dec 2024 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5QPRR7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05690238E0F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916249; cv=none; b=pjZIvT4TcjJruSanybRjDMFUkcv1Z4Xmf7jsFWGUAPLq1BmRbzn5bwBpa+p6xYK7zVkX1OGwCJ7/rhEpDL2AQnmr6dQX3gpRAoDmf1zJLUqvs3Csuwmshi2TzSN5XJ6ZAHqcFSSyd2j1CVCGVG+mUOi+RABpvV994E8iU/1ktrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916249; c=relaxed/simple;
	bh=+nsVqHPb/W171mY0+/up7Otw02A2ORLB9J3dnLNdgwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/feZozxMYZ0LVKiTdfVEm9X2UDMKo2DwLOpkbJKylzGvchVm+Dwak7JWA4KEa177KtMGO/QdTn7fRQTQcbqBPS/MtUXCJlPTbzOrkeCZ8YwdAOocGfbIctSuOtfhr9jyonl6MO2+ITcapkcp76WYx2baCWvzo2XeTzOrj7yZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5QPRR7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D994C4CED2;
	Wed, 11 Dec 2024 11:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733916248;
	bh=+nsVqHPb/W171mY0+/up7Otw02A2ORLB9J3dnLNdgwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5QPRR7J1+udESlbG1LymTo2lBTlOpLHB/iNyViFpAYeTiYLq7FY42e5o5Rr0qKJK
	 6BwvuvnMPDSku83H7DZGjSWQI3pqCHgZ9N9F9wQ/ExtYD3vpb7ZDh0F2OkvMZY4Qui
	 vmvlIRaEkT7ZkxScVg9Y4ZYu6Dfz9q1hA1BSRLd5aMqI5AlZe4tHyxVNMNYFK6VCdY
	 xBtp+T8JvqD8KluHwpInY5ZPOYMVRStp7UDkiibuBfL2VNYj1j+31tNUT+1GtXkHZa
	 M9041NDpMrVtXIWdLmmyYUSRhP2aazbSdlMept9rjPdMVM0RTRFcRTjc0wi7oJbzaI
	 11sVwqAcKMIFA==
Date: Wed, 11 Dec 2024 12:24:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
Message-ID: <20241211-wachleute-sumpf-81627ef94a90@brauner>
References: <20241206151154.60538-1-mszeredi@redhat.com>
 <20241206-aneinander-riefen-a9cc5e26d6ac@brauner>
 <20241207-weihnachten-hackordnung-258e3b795512@brauner>
 <CAJfpegsFV6CNC0OKeiOYnTZ+MjE2Xiyd0yJaMwvUBHfmfvWz4w@mail.gmail.com>
 <20241211-mitnichten-verfolgen-3b1f3d731951@brauner>
 <CAJfpegttXVqfjTDVSXyVmN-6kqKPuZg-6EgdBnMCGudnd6Nang@mail.gmail.com>
 <20241211-boiler-akribisch-9d6972d0f620@brauner>
 <CAJfpegscVUhCLBdj9y+VQHqhTnXrR_DaZZ6LndL3Cavi3Appwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegscVUhCLBdj9y+VQHqhTnXrR_DaZZ6LndL3Cavi3Appwg@mail.gmail.com>

On Wed, Dec 11, 2024 at 11:55:37AM +0100, Miklos Szeredi wrote:
> On Wed, 11 Dec 2024 at 11:34, Christian Brauner <brauner@kernel.org> wrote:
> 
> > For that the caller has to exit or switch to another mount namespace.
> > But that can only happen when all notifications have been registered.
> > I may misunderstand what you mean though.
> 
> Ah, umount can only be done by a task that is in the namespace of the
> mount.  I cannot find a hole in that logic, but it does seem rather

Currently... I have a finished patch series that allows unmounting by
mount id including support for unmounting mounts in other namespaces
without requiring setns(). That's sitting in my tree since v6.11-rc1. I
should get that out.

