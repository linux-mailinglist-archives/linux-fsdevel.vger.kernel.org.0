Return-Path: <linux-fsdevel+bounces-34234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7819C3F95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40129B22D85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1797D19D884;
	Mon, 11 Nov 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj9mN+bP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AEE14D70E;
	Mon, 11 Nov 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331858; cv=none; b=GSn7wBU/Z2/EYylFIr38vdeMdhwSK0O5viQtfc6hp1mhKOj4LSUM2TBKovYC82m+lLEnqqObZ8qlAAo+UPrzGfAiXC+Sgj4+k3x818G2Nw/c/BBGr6o+6cutaLLzALkoXJq/FIic+Z6sN4BKUv0Y/GBWwITCjEY7s64b+HWUnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331858; c=relaxed/simple;
	bh=Q4A1KeBAs2YII4rolHw/9G6jmTx1rDWLERDwHLNEtbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAL8E0iJCVioIIr70MbljiazfX8iMEXEGmBLN6x7dJkRmKZLqsKe8FfQvIz8sYdpJYw58/yQDt9g96UU6s5fU+2yJuQ6W85dl9sHM686vWT1GocmOTFhTvtRubbyrvaNkj7xgq5Q1YD6qadZeUS02Xgaz3gNcDxxcyCtdH1Ngj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj9mN+bP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB095C4CECF;
	Mon, 11 Nov 2024 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731331858;
	bh=Q4A1KeBAs2YII4rolHw/9G6jmTx1rDWLERDwHLNEtbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tj9mN+bPb4grEnWTKOkrAzZP/iKAZCD4lZ6NfoBZwoe1i/KfIy4x4k1UuJ35Wm0/a
	 f5IcjrYmMgxDWJz64fEulzauTdydGDqQ0/B3dMNxFTZFzpVJe9L3S+dENAJA8Ow8eL
	 naUhfA8BUHSKyeYAliquCyqp3sfLiVI3Yl9jowijXROX2042IHEimIzWvuYr8br2JM
	 OYSuC/yqLPCZU0/GrTJjQEcQJcX3RGO/Fi3VCZ1xfSpJAtNUd3kvZ8hsqMmqLRjVgM
	 4xhmniJPa8XwKir4uxYIIrWqTM6DKI0Yd9X6k3oQC4pkkNotJHz7qqA5HzGiuwy3EN
	 yhVjDS16qDQZw==
Date: Mon, 11 Nov 2024 14:30:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs: add the ability for statmount() to report the
 fs_subtype
Message-ID: <20241111-apparat-zurschaustellen-9929ff182ab6@brauner>
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
 <20241107-statmount-v3-1-da5b9744c121@kernel.org>
 <CAJfpegsdyZzqj52RS=T-tCyfKM9za2ViFkni5cwy1cVhNBO7JA@mail.gmail.com>
 <de09d7f38923ed3db6050153f9c5279ebae8a4e6.camel@kernel.org>
 <CAJfpegszxKkuXu-7LibcL+40jYa2nsh5VL1_E2NkGr1+eN3Maw@mail.gmail.com>
 <17fde675e5cba387b45a68344f6c6f0394d8959a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17fde675e5cba387b45a68344f6c6f0394d8959a.camel@kernel.org>

On Mon, Nov 11, 2024 at 08:28:07AM -0500, Jeff Layton wrote:
> On Mon, 2024-11-11 at 14:01 +0100, Miklos Szeredi wrote:
> > On Mon, 11 Nov 2024 at 12:28, Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > > As far as I can tell, the existing cases in statmount_string() either
> > > always emit a string or an error code. If a string isn't emitted, then
> > > the two EOVERFLOW cases and the EAGAIN case can't happen, so I don't
> > > think this will result in any change in behavior for the existing code.
> > 
> > Both mnt_point and mnt_opts can be empty.
> > 
> 
> Ok, so currently if they are, the flag gets set and there is no
> string?  If so, then you're correct and this is a behavior change. The
> question is -- is it a desirable one? The interface is new enough that
> I think we have the luxury of changing this now (and establishing a
> future standard).
> 
> Personally, I think that's how it ought to work. When there is no
> string present, we ought not set the flag in the return mask. Does
> anyone prefer it the other way?

It's a change we can certainly do. I see no reason not to try it.

