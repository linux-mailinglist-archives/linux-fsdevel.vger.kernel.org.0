Return-Path: <linux-fsdevel+bounces-68034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B71AC51824
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D8684F5BAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616C2FF150;
	Wed, 12 Nov 2025 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujrkaxqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A432FD7DD;
	Wed, 12 Nov 2025 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940908; cv=none; b=IhkQ3BBwQ3fbJ9SB1RhB4Ue0r5MpsArb7e7fOTHV0flx6kFgj7d26bp7Gl7fQUEDWAQDpq7xa3Mk17ylVkJOvdV8MKqge4e7kaXI98snRlXvuwO8E0tPrmHFr4BI77amjqehiDRqmYMrf6c4/biO3JRyu1b8PKR0ZV3tPRXovp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940908; c=relaxed/simple;
	bh=Fp54NhGCqF29OLtRqfZgEsreptC0qR7l1Wg6BxxM0fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5DrxlpJMd+AgQBHpainMEF5t98dY6vtNE0Zr4N2y17lLk6fvjKMEcwswAcz8lI5cjvc3vSPhVxkgyHBHVoJ4R28eq7QxmEe+huuiKMgCiYYGkDgaxc4q2q2519dbJU94zGeNGkTmQ1KOB2oVf03mGugrs17WlsorL09eGe3qOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujrkaxqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2741C116B1;
	Wed, 12 Nov 2025 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762940907;
	bh=Fp54NhGCqF29OLtRqfZgEsreptC0qR7l1Wg6BxxM0fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujrkaxqJjzQ6tJE2+NxyXGvPzLJKkj74U1RJMHNh2+krb/G8qO6o9cmNUJu+leg8w
	 j1Zpmrx911U5fXt2Ic5+LKMIxwFn4yaTqYVf1YqvGVZnLDt48mqy76fMINH/JvsELH
	 fOuKzWV4Ao/mq3L2XTYFgd9V1VrF08xP/LKWMIrNnHLKl21ApLd1batTCSiT5PJ3EL
	 e65ooglYT835KdYv1Rqk14kPt00332EDAKbv72lcOb3mDgo/pcFgCpNgx/Sg6V7rDg
	 gVG3Q1ESsgjnPz7yKuatZX8AGDHb2BPOIOSWQGg2RQDW7rO/wRCveQqqPPsieHAbXd
	 Dr2jdLIpXvKgQ==
Date: Wed, 12 Nov 2025 10:48:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: mic@digikod.net, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, eadavis@qq.com, gnoack@google.com, 
	jack@suse.cz, jannh@google.com, max.kellermann@ionos.com, m@maowtm.org, 
	syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] fs: add iput_not_last()
Message-ID: <20251112-buddeln-neidvoll-1d9e621aa0c9@brauner>
References: <20251105212025.807549-1-mjguzik@gmail.com>
 <20251111-fluss-vokabel-7be060af7f11@brauner>
 <CAGudoHF_9_7cEgwtX=huvSf1q-FF0gSwTn2imXHmszYoa2xPZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHF_9_7cEgwtX=huvSf1q-FF0gSwTn2imXHmszYoa2xPZA@mail.gmail.com>

On Tue, Nov 11, 2025 at 12:53:53PM +0100, Mateusz Guzik wrote:
> On Tue, Nov 11, 2025 at 12:46 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, 05 Nov 2025 22:20:24 +0100, Mateusz Guzik wrote:
> > >
> >
> >
> > Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
> > Patches in the vfs-6.19.inode branch should appear in linux-next soon.
> >
> 
> That might_sleep in iput is already in master slated for 6.18, so this
> should land in vfs.fixes instead.

Done, thanks.

