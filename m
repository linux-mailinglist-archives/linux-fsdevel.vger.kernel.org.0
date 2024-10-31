Return-Path: <linux-fsdevel+bounces-33334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D7D9B7877
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 11:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02341F2188E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0A1990D1;
	Thu, 31 Oct 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob2QxMwe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624FB12B169;
	Thu, 31 Oct 2024 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369688; cv=none; b=Top7Yp9EAr8NL6bAn6Z2L3+08AZ+dFD71PYwS+uogEuNM6YWG1L1wjnT16WN/QzcwJnkYkZDwBiKoX2ivnFQAlxPY8t06D0P1pegwEVU1Yj3tGw01U07co8CtbbvWM+03JEYUtPomQaeJ7H16RRYuUwtKNakU4uRV9EhwIvYyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369688; c=relaxed/simple;
	bh=KUIrzRY/qSqo8rjn0vcLHeEKyxN6+0+rnc3xTHbrGAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul+WEL4+Dv+EarOkLSYMifGBNDMd+p/jpv7ddEIKmREutW2ChQLi7w1BnSm/PVQXsZ5kKNiH2T+G7IZ8Ev0wqwS4Mj++MvRBjcEKZs9KITSalWXIJT5CL2uz3f5hyOWW8ulhOHUYkUapbQKEWqvyeGrSxPtAEuOnmIui3lJVyzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob2QxMwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9B9C4CED0;
	Thu, 31 Oct 2024 10:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730369687;
	bh=KUIrzRY/qSqo8rjn0vcLHeEKyxN6+0+rnc3xTHbrGAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ob2QxMwe3IvoWcQ4t+zyauZ0mNJqd552FzClpZAPIEjaPc4SSIAwXiXbcJxtBXEGA
	 I7QM4RvPoCe+15GK5tplmZ1Z9vjIHwtm5WwTnv19274vkQpkYTZdYeMnAMD4k3tAau
	 m0cegLVgXxTY3ajkgeWptdnTU7+gZKGcsFW2G3YPd8AGZoU7cKiNZconW7282DK3b8
	 qGrIag7uuEPkio7MzhzDBEiwIL4DotfQDMMDfUS68tnlYJ4CNLIb9dzD6+CvPVTXoe
	 Oxyfqe+OtUp4Zwa9mEMTUIgkFe9uU2c6HS81J4on6Gv+9OUZashTSNNuX/SSxcd/SW
	 L7g2DMyww+xHA==
Date: Thu, 31 Oct 2024 11:14:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "Ma, Yu" <yu.ma@intel.com>, 
	jack@suse.cz, edumazet@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com, 
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v5 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
Message-ID: <20241031-anraten-dorthin-4e01a39b46bf@brauner>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
 <20240717145018.3972922-2-yu.ma@intel.com>
 <20240814213835.GU13701@ZenIV>
 <d5c8edc6-68fc-44fd-90c6-5deb7c027566@intel.com>
 <20240815034517.GV13701@ZenIV>
 <CAGudoHEu07q72u_XFH61kGXyKr+vAqGFhn_tSSu6U2uMDABLdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEu07q72u_XFH61kGXyKr+vAqGFhn_tSSu6U2uMDABLdw@mail.gmail.com>

On Thu, Oct 31, 2024 at 08:42:18AM +0100, Mateusz Guzik wrote:
> On Thu, Aug 15, 2024 at 5:45 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Aug 15, 2024 at 10:49:40AM +0800, Ma, Yu wrote:
> >
> > > Yes, thanks Al, fully agree with you. The if (error) could be removed here
> > > as the above unlikely would make sure no 0 return here. Should I submit
> > > another version of patch set to update it, or you may help to update it
> > > directly during merge? I'm not very familiar with the rules, please let me
> > > know if I'd update and I'll take action soon. Thanks again for your careful
> > > check here.
> >
> > See the current work.fdtable...
> 
> this patchset seems to have fallen through the cracks. anything
> holding up the merge?

It's in next for this merge window.

