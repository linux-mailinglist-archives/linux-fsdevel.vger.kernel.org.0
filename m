Return-Path: <linux-fsdevel+bounces-45946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE182A7FC10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C2A1891368
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F5D26A0D5;
	Tue,  8 Apr 2025 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HreGcEL6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCF2676C6;
	Tue,  8 Apr 2025 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107722; cv=none; b=EQPMVnQxSJL+Q7G/KFtujLhwFpW/UvxAnsFrK1KUy13/57E9avTSztPReCHMP9T/+8wRr013FYdZreSsjYSv3BNC4oReagoSsdbi7++eLNEB1htwy6v+uUld2K95n6Q1VgyAzcjXFvYPKyz8i4bnWFgaFrzBdF9aiUUyZk2pR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107722; c=relaxed/simple;
	bh=YKtABz1DIsJcJgmLq39k67cRVyl9T/CdI7GB2YjsD44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVrLV186NbNeyHAM5eHKEXFsfLwSMo+2J4N6VzaQW2d3Za9JcEY+Pbzf5n1TfnC3IGiZmNIyNGUIljlJy99SUf0hHYQSZFOdO2MNPaf/A4yDwPfZWSA0n1iSTGYNyYMVmFjalY3bT/sK/thMM7pBCtCspnlDtk2bjkXZrBg2F7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HreGcEL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B1BC4CEE5;
	Tue,  8 Apr 2025 10:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744107722;
	bh=YKtABz1DIsJcJgmLq39k67cRVyl9T/CdI7GB2YjsD44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HreGcEL6PDKoCk4edSWlmqENtbWYb6kRUmMUuC7IbFZkHAxv35enDmM5NoJajchV3
	 pyZ+jkf7N21KkQnbuyDYc6CQfz7PTmaDQHyrDFxPPA4MOgB61HzghayGaqVt8dHIJa
	 3ube/42GryeYzCbVCmKXkcxdffUFVBFe1nbMDdg7JxecrS0SXw4uRGn3srWuftZkZ2
	 QIXLZUTAGXA3QL2/msv3HE5tnKakPgZ/+IFUZis9KZsmwST+3bMwpKJQ2wdkOOslqb
	 vlaa3gntV/oCU2g5NNGcmTE8GzrZ6IGUnNH4v5o243G6+pHYCKJ9s2hK6nnj8OFq1N
	 UW+ecScLrlrwA==
Date: Tue, 8 Apr 2025 12:21:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: sforshee@kernel.org, linux-fsdevel@vger.kernel.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux regressions mailing list <regressions@lists.linux.dev>, 
	lennart@poettering.net
Subject: Re: 6.15-rc1/regression/bisected - commit 474f7825d533 is broke
 systemd-nspawn on my system
Message-ID: <20250408-deprimierend-bewandern-6c2878453555@brauner>
References: <CABXGCsPXitW-5USFdP4fTGt5vh5J8MRZV+8J873tn7NYXU61wQ@mail.gmail.com>
 <20250407-unmodern-abkam-ce0395573fc2@brauner>
 <CABXGCsNk2ycAKBtOG6fum016sa_-O9kD04betBVyiUTWwuBqsQ@mail.gmail.com>
 <20250408-regal-kommt-724350b8a186@brauner>
 <CABXGCsPzb3KzJQph_PCg6N7526FEMqtidejNRZ0heF6Mv2xwdA@mail.gmail.com>
 <20250408-vorher-karnickel-330646f410bd@brauner>
 <CABXGCsO56m1e6EO82JNxT6-DGt6isp-9Wf1fk4Pk10ju=-zmVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsO56m1e6EO82JNxT6-DGt6isp-9Wf1fk4Pk10ju=-zmVA@mail.gmail.com>

On Tue, Apr 08, 2025 at 02:34:37PM +0500, Mikhail Gavrilov wrote:
> On Tue, Apr 8, 2025 at 2:18 PM Christian Brauner <brauner@kernel.org> wrote:
> > I'm confused why that's an issue:
> >
> > > git reset --hard 474f7825d5335798742b92f067e1d22365013107
> > HEAD is now at 474f7825d533 fs: add copy_mount_setattr() helper
> >
> > > git revert --no-edit 474f7825d5335798742b92f067e1d22365013107
> > [work.bisect e5673958d85c] Revert "fs: add copy_mount_setattr() helper"
> >  Date: Tue Apr 8 11:14:31 2025 +0200
> >  1 file changed, 33 insertions(+), 40 deletions(-)
> 
> > git reset --hard v6.15-rc1
> HEAD is now at 0af2f6be1b42 Linux 6.15-rc1
> > git revert -n 474f7825d5335798742b92f067e1d22365013107
> Auto-merging fs/namespace.c
> CONFLICT (content): Merge conflict in fs/namespace.c
> error: could not revert 474f7825d533... fs: add copy_mount_setattr() helper
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: Disable this message with "git config set advice.mergeConflict false"

Resolved it for you:

https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.bisect

