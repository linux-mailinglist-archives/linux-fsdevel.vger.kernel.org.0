Return-Path: <linux-fsdevel+bounces-3401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA7B7F437A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 11:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49722815F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74575495FB;
	Wed, 22 Nov 2023 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqaC1v2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9043C6AE;
	Wed, 22 Nov 2023 10:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D77C433C8;
	Wed, 22 Nov 2023 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700648298;
	bh=gp/k8axTL80mLxTYMaP+zB2m9z+vv0jOyiBCQflp7F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqaC1v2DxXSoXlJSFnoohu+VPku4+2AH6UvaY/VxcsIbxOvpYQ52Y8VxKRxGyrbKV
	 /mhK362xJT2nIQ0gQdv0bXr9Mzy/SA11wcAh5VM7bXDosCtQLWzcww3TLcVhhm/dRi
	 9U5NrM++/wOdhi+urDGBl9esWuwxCHKiLF67nXsgehtNl+hy7nRWgw5mYzlboBUD7j
	 pI/xKV+8IoLvDI9906VxnuQ1V9aVT9NqtSQC/fLhOoZDuzcVnIHHosyjSC7CFwWryU
	 pZmRjgtszs+sxsqr8+msZYRLhE2vQLc6gkVokAhv2BAacK+AqBAcLWgffN3iW/vb07
	 s786vurUs7m9w==
Date: Wed, 22 Nov 2023 11:18:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Ian Kent <raven@themaw.net>, Ian Kent <ikent@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org,
	linux-man <linux-man@vger.kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: proposed libc interface and man page for statmount(2)
Message-ID: <20231122-busspur-pfoten-6644c819c12c@brauner>
References: <CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
 <CAJfpegsBqbx5+VMHVHbYx2CdxxhtKHYD4V-nN5J3YCtXTdv=TQ@mail.gmail.com>
 <ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu>
 <878r6soc13.fsf@oldenburg.str.redhat.com>
 <ZVtScPlr-bkXeHPz@maszat.piliscsaba.szeredi.hu>
 <15b01137-6ed4-0cd8-4f61-4ee870236639@redhat.com>
 <6aa721ad-6d62-d1e8-0e65-5ddde61ce281@themaw.net>
 <c3209598-c8bc-5cc9-cec5-441f87c2042b@themaw.net>
 <bcbc0c84-0937-c47a-982c-446ab52160a2@themaw.net>
 <CAJfpegt-rNHdH1OdZHoNu86W6m-OHjWn8yT6LezFzPNxymWLzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegt-rNHdH1OdZHoNu86W6m-OHjWn8yT6LezFzPNxymWLzw@mail.gmail.com>

On Tue, Nov 21, 2023 at 08:42:17PM +0100, Miklos Szeredi wrote:
> On Tue, 21 Nov 2023 at 02:33, Ian Kent <raven@themaw.net> wrote:
> 
> > I've completely lost what we are talking about.
> 
> I started thinking about a good userspace API, and I'm skeptical about
> the proposed kernel API being good for userspace as well.
> 
> Maybe something like this would be the simplest and least likely to be
> misused (and also very similar to opendir/readdir/closedir):

I want batch retrieval to be possible with the kernel interface. That's
important for userspace and was requested in the LSFMM discussion.

I would like to grab the proposal to return the last mount id in struct
mnt_id_req. In userspace it can then easily be implemented the way you
proposed below.

