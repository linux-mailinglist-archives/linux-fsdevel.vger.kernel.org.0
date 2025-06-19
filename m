Return-Path: <linux-fsdevel+bounces-52196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10928AE0247
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3B51BC3079
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C412222BA;
	Thu, 19 Jun 2025 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZADrI14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F72206B5;
	Thu, 19 Jun 2025 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327397; cv=none; b=UoQDf++J+2Gzp2z3uKOe7YMxw0E0o+JMUQA8c+fTJpm7Hcu+jSRZZUCChr6kcO5ID2vmFFMj90pghc8sztK1puhcMQko8UkHxeeEal/BQb/YZ2BvEAOykptF7f73Oh6Dq6lp/DsS/J6bN1vuU8cHNSrRRijkxm26f2SbZWcG5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327397; c=relaxed/simple;
	bh=XDq4E2qobHh4SPNHxWaWwJy/V6onT872pHFjDniHXsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB/3csdtcxjzM75e8p+iDIlWU0q1ARQ4RC/1/RDw9InLEzYUcXD7TUib4+WGrhveZ9uuUsqeDnlAnZe5muGRthh8oKgJkMA0e/dgYxvocJeLd914IvxhnBj44LST9K1PA7OU+FMkrllUDT+rvL9aLRnPOkrVn1458CswqwOzIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZADrI14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F04C4CEED;
	Thu, 19 Jun 2025 10:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750327396;
	bh=XDq4E2qobHh4SPNHxWaWwJy/V6onT872pHFjDniHXsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZADrI14/ncLqFyri1sFkMVyEFQXv/gkPNVr/oK7Z4gaT+2I/JiuwXgAZSulfTZce
	 Om4xbWOQusgqMGKDexgjc3ECK//5hld+LlFx3xrbC4VtXWHV15nD273jXZJc8Wa71H
	 uVUPyLaShGGXgxYx/1yJ8n1Y+RjNv4H+Tvzkgg1S/7vji1P8EWzUhI0S9YwFDK/iX2
	 IgMyw0DwBAPelyWMN+TPksPX0PiUluWXmCdHt06RFUIv5Da9+Uann/eQhA8ae6iq9e
	 5OkorTX1QBMAVO4cm+NrPXQXqATF8+VSaw6CpEyOUzb31K/turFLijhxuV1Tx5piV6
	 msgqnkeNV7qqA==
Date: Thu, 19 Jun 2025 12:03:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, 
	Shuah Khan <shuah@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, Amir Goldstein <amir73il@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] selftests: filesystems: Add functional test for the
 abort file in fusectl
Message-ID: <20250619-einlud-gestrafft-8e6d725d491d@brauner>
References: <20250612094033.2538122-2-chenlinxuan@uniontech.com>
 <9940a310-5a39-4489-a1bf-0809e5914c08@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9940a310-5a39-4489-a1bf-0809e5914c08@linuxfoundation.org>

On Wed, Jun 18, 2025 at 02:52:08PM -0600, Shuah Khan wrote:
> On 6/12/25 03:40, Chen Linxuan wrote:
> > This patch add a simple functional test for the "abort" file
> > in fusectlfs (/sys/fs/fuse/connections/ID/about).
> > 
> > A simple fuse daemon is added for testing.
> > 
> > Related discussion can be found in the link below.
> > 
> > Link: https://lore.kernel.org/all/CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com/
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Co-developed-by: Miklos Szeredi <miklos@szeredi.hu>
> > Reviewed-by: Miklos Szeredi <miklos@szeredi.hu>
> > ---
> > Changes in v4:
> > - Apply patch suggested by Miklos Szeredi
> >    - Setting up a userns environment for testing
> >    - Fix a EBUSY on umount/rmdir
> > - Link to v3: https://lore.kernel.org/all/20250610021007.2800329-2-chenlinxuan@uniontech.com/
> > Changes in v3:
> > - Apply changes suggested by Amir Goldstein
> >    - Rename the test subdir to filesystems/fuse
> >    - Verify errno when connection is aborted
> > - Apply changes suggested by Shuah Khan
> >    - Update commit message
> > - Link to v2: https://lore.kernel.org/all/20250517012350.10317-2-chenlinxuan@uniontech.com/
> > Changes in v2:
> > - Apply changes suggested by Amir Goldstein
> >     - Check errno
> > - Link to v1: https://lore.kernel.org/all/20250515073449.346774-2-chenlinxuan@uniontech.com/
> 
> + adding Christian to the thread
> 
> Hi Christian,
> 
> Would you like me to take this patch through my tree?

I'll just take it otherwise it'll end up causing pointless merge
conflicts as I'm touching that code as well.

