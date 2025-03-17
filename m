Return-Path: <linux-fsdevel+bounces-44218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D56A65E85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 20:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5193A7924
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A561EB5EB;
	Mon, 17 Mar 2025 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu0gVWhY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA21DEFEB;
	Mon, 17 Mar 2025 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241147; cv=none; b=MTXybwSJcaEvdFLamTTHTgh/KDew/SaGPv+bSHrlHA09AYeGz0YcfTbNdoP8eXBJiqur55NYXMFLiU0xredzvy4eFq8YobljsRGgzy58BetiFd/SIJtBvmc42PV65XsciSTVsFQG5ZUbRInd4LuwVOQZO546bJKj1EU/41GL2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241147; c=relaxed/simple;
	bh=k35eDx8RG0ueo8SoUAaQ9cHQFddjWMIWuTGDDc47dy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BybJnwC/70KLOXc7NTJXv520kQzyx1Dm7cCXNd+4RIQomr7KxViihbZGq9TMmRCO3W3UM3Pt57dhroMVKQo2zyGoQLS3Gl5AxfHaR/ciDCo3W1SmQnJaOcEB8Dm/Tyb7p4cN1C8Q2IkZDB23qwZmkJEacm0Xgv/r3eAEkxLA0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu0gVWhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C000C4CEE3;
	Mon, 17 Mar 2025 19:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742241146;
	bh=k35eDx8RG0ueo8SoUAaQ9cHQFddjWMIWuTGDDc47dy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iu0gVWhYpcpA63Dbe6zfrI6mgVpjUSeuAVBgJ6V6DPTtnKGt/w62XaS7X0IVWpG5c
	 ZySe2qI/ow+Sz70BRFEXT0RSlZwUlTFVIuBKw85tQRxTxZYTLsiOBB08e/NpA6cCnH
	 Q5QXedGRWVWtxByFdyPmxIWGaAG8kuuICwGn+49bz69rXfeMdFz3Y3h8x+SS6bZdPg
	 h8l9B3GQPHOjmUb0L/PVuzcyFClvZ59I/HxiEIAKJxOtJlRpSI/TCPCY/X2zg02x4p
	 xQQNFemYWgS9ipoyZTAd20vPyO3ZKRVg569jqw/u3UhFDkvQOeehWdvO5Eti+NGMpK
	 RJRmzWk2I/5HA==
Date: Mon, 17 Mar 2025 20:28:10 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Ruiwu Chen <rwchen404@gmail.com>
Cc: mcgrof@kernel.org, corbet@lwn.net, keescook@chromium.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, zachwade.k@gmail.com
Subject: Re: [PATCH v2] drop_caches: re-enable message after disabling
Message-ID: <k742mxcj77qyga6gqo25yylne4ch3eqyluwplkc7utyqfydvlz@gga3m5vpdh2k>
References: <db2zm4c5p5octh6garrnvlg3qzhvaqxtoz33f5ksegwupcbegk@jidbmdepvn57>
 <20250314122803.14568-1-rwchen404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314122803.14568-1-rwchen404@gmail.com>

On Fri, Mar 14, 2025 at 08:28:03PM +0800, Ruiwu Chen wrote:
> > On Wed, Mar 12, 2025 at 03:55:22PM -0700, Luis Chamberlain wrote:
> > > On Mon, Mar 10, 2025 at 02:51:11PM +0100, Joel Granados wrote:
> > > > On Sat, Mar 08, 2025 at 04:05:49PM +0800, Ruiwu Chen wrote:
> > > > > >> When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
> > > > > >> but there is no interface to enable the message, only by restarting
> > > > > >> the way, so add the 'echo 0 > /proc/sys/vm/drop_caches' way to
> > > > > >> enabled the message again.
> > > > > >> 
> > > > > >> Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>
> > > > > >
> > > > > > You are overcomplicating things, if you just want to re-enable messages
> > > > > > you can just use:
> > > > > >
> > > > > > -		stfu |= sysctl_drop_caches & 4;
> > > > > > +		stfu = sysctl_drop_caches & 4;
> > > > > >
> > > > > > The bool is there as 4 is intended as a bit flag, you can can figure
> > > > > > out what values you want and just append 4 to it to get the expected
> > > > > > result.
> > > > > >
> > > > > >  Luis
> > > > >
> > > > > Is that what you mean ?
> > > > >
> > > > > -               stfu |= sysctl_drop_caches & 4;
> > > > > +               stfu ^= sysctl_drop_caches & 4;
> > > > >
> > > > > 'echo 4 > /sys/kernel/vm/drop_caches' can disable or open messages,
> > > > > This is what I originally thought, but there is uncertainty that when different operators execute the command,
> > > > > It is not possible to determine whether this time is enabled or turned on unless you operate it twice.
> > > >
> > > > So can you use ^= or not?
> > > 
> > > No,  ^= does not work, see a boolean truth table.
> 
> I don't quite agree with you, you change this, 
> echo {1,2,3} will have the meaning of enable message
> 
> The initial logic:
> echo 1: free pagecache
> echo 2: free slab
> echo 3: free pagecache and slab
> echo 4: disable message
> 
> If you change it to something like this:
> stfu = sysctl_drop_caches & 4;
> echo 1: free pagecache  and enable message
> echo 2: free slab       and enable message
> echo 3: free pagecache  and enable message
As I read it, its should be
echo 3: free slab and pagecache     and enable message

> echo 4: disable message
This is a very good point. But the new logic does not shock me. I would
actually add some rows to your explanation in the following fashion:

echo 5: free pagecache            and disable message
echo 6: free slab                 and disable message
echo 7: free pagecache and slab   and disable message
echo 0: Nothing                   and enable message

This is in line with the file describing a binary value where every bit
position means something different. At the end its up to the maintainer
to decide what is "right".

> 
> echo 4 becomes meaningless, when echo 4 only the next message can be disabled
> Unable to continuously disable echo{1,2,3}
> 
> echo {1,2,3} always enabled the message
> echo {1,2,3} should not have the meaning of enabling messages
> 
> My thoughts:
> stfu ^= !!(sysctl_drop_caches & 4);
This is a bit convoluted. This is more understandable IMO:

  diff --git a/fs/drop_caches.c b/fs/drop_caches.c
  index d45ef541d848..15730593ae39 100644
  --- a/fs/drop_caches.c
  +++ b/fs/drop_caches.c
  @@ -68,12 +68,13 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
                          drop_slab();
                          count_vm_event(DROP_SLAB);
                  }
  +               if (sysctl_drop_caches & 4)
  +                       stfu ^= 1;
                  if (!stfu) {
                          pr_info("%s (%d): drop_caches: %d\n",
                                  current->comm, task_pid_nr(current),
                                  sysctl_drop_caches);
                  }
  -               stfu |= sysctl_drop_caches & 4;
          }
          return 0;
   }

I'll add this to the patch that I sent in [1]. If you have any more
comments, please answer them in [1]

Best

[1] : https://lore.kernel.org/20250313-jag-drop_caches_msg-v1-1-c2e4e7874b72@kernel.org
-- 

Joel Granados

