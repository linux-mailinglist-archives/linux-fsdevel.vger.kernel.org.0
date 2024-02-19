Return-Path: <linux-fsdevel+bounces-12060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D68385ADF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 22:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB16A1F22B7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 21:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC76A5472A;
	Mon, 19 Feb 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoQwQ5/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8045044373;
	Mon, 19 Feb 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379062; cv=none; b=W9u/GaNc5rCn7fis+C+qOlxABmiD0yNg4FAWKj8ZmdcR9h/6S154eZdn19bzZLMT8nPAXr7FDU0IY+PLHCiLf6ZHgx0Bbj8CLo6xw9rAuvgLM6WvwFbHxvOeNentqqeA2P3pakd0IdITVCjws9EhPyQsV2L9DZmMVdJ8u20jAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379062; c=relaxed/simple;
	bh=bpJ0wv9PlVnZNDvc2f4B+6xfn1Lp7UM2ganMU6aMIXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY3KqcMLVrjWO2tyuAlF2541sEuD2Xxq06+F9iVnqtTaVPyDlNf4g3dyszr9YGcFXhs0FBKjqXhBqh6zjBQJc5Bo42rv6lVG7yo9DUSmLexmHrxRn+4DQkrmY6UXWuE5HGcVsv3p4rNo2CPotf7IgwxdhiFxSYGPtcJrC/Ia2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoQwQ5/S; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d61d51dd1so436661f8f.3;
        Mon, 19 Feb 2024 13:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708379059; x=1708983859; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0+44ib09HgI4yA5359LbPE5CzYSnjiIutZCZDAbH6F8=;
        b=hoQwQ5/So39zEd0Z/dTxNxda/H3YhqKbJWY4ddO05jG0BpW85lEeq1diRYoBESnqbX
         Wz9tSWXtY55J9IiFU+tucoyG/nRU3ZD/ccMwa1CcunerHzVZWJYNwjJzW85YZXTBFG5H
         zFKtFlcXrrk4khEJsa3wC9Y4Fk4sGnhSpwAMC2Z3I7PZbydh1riFg23aWDwuZHy1pk/6
         zfCLTbmEDUtROMAaIzGMG35uRisMP5agvX/gAqkMZ0y7TDO2xYNwSi5jD1qK9ZLyPM0U
         QYI3Q3cNLk8ZNTpuJVP6hrbO4KTPyM7USmccQix+D+XkMETVE5GL5s0JVotKMrnJ7TPt
         QdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708379059; x=1708983859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+44ib09HgI4yA5359LbPE5CzYSnjiIutZCZDAbH6F8=;
        b=wM6fppt11634atPH7eD7p3CGPQZtDoA6i15IHlP2yS2g/uR1vtyZf9cJ6UOOrfxGNP
         6KG9i63IDKCtMbVKPlsbvIT+QG70zDUBZchxJ1ZNxYVqSBlYjSRaL6wtFZQILGlGnIdO
         C0M7gJpuw/P9fenfwXKRIwpc6z7WXpfhlD2w9xJF8QbI3yo8IE9Jgkk78wMXyUHyJ0r7
         rSJksiWh5JSBadsSOaZHwcONRllllF3kv8b5ZVLPIkaMXWfR9jqO43N45Sg2CrLuts75
         zc2ldWwO83rM/Om9g9nEhiCPYItg2+sPRkFuVstRiG4AP+lEnsnRDql4tjh8f0miEus2
         HppA==
X-Forwarded-Encrypted: i=1; AJvYcCXlyIsWmQSGig4rBDU+4zJC+ZKINA2XgoXowRpkF9UNzKyn03xt62Z3sYIZ9+ZljGy1flCubzlapha2962muE2e4ka3LyzssQkVKvwaKZYs5l7/pNbIJZmEHM8oaeJk/gsbwiNx6RARw4Li1ddINIFFQG/PvQ==
X-Gm-Message-State: AOJu0YyMa07VInKOU2WIvBslyu6Fb4KJ3Du0c7ZVmlTWgyxbpC7aZeZT
	j6pi/1hvoHIXQVxnjcroHxLug4PyApp1e078gmFJXnf/FFjwWcRb
X-Google-Smtp-Source: AGHT+IE24jpYkzddQvYd2WoOonPeiMtWCEJfMoDmcQDyH/yPi+4VoBGNFnEXLlZmUjcXOoDkLm/RQw==
X-Received: by 2002:a5d:64a2:0:b0:33d:497c:14d2 with SMTP id m2-20020a5d64a2000000b0033d497c14d2mr4060237wrp.30.1708379058542;
        Mon, 19 Feb 2024 13:44:18 -0800 (PST)
Received: from localhost ([2a02:168:59f0:1:6ea:56ff:fe21:bea7])
        by smtp.gmail.com with ESMTPSA id q4-20020a5d5744000000b0033b47ee01f1sm11379880wrw.49.2024.02.19.13.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 13:44:18 -0800 (PST)
Date: Mon, 19 Feb 2024 22:44:13 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
	Michael Kerrisk <mtk@man7.org>
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
Message-ID: <20240219.964bb89b96f8@gnoack.org>
References: <20240209170612.1638517-1-gnoack@google.com>
 <20240209170612.1638517-2-gnoack@google.com>
 <ZcdbbkjlKFJxU_uF@google.com>
 <20240216.geeCh6keengu@digikod.net>
 <20240216.phai5oova1Oa@digikod.net>
 <20240218.a01103783ca4@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240218.a01103783ca4@gnoack.org>

Hello!

On Sun, Feb 18, 2024 at 09:34:39AM +0100, Günther Noack wrote:
> On Fri, Feb 16, 2024 at 04:51:40PM +0100, Mickaël Salaün wrote:
> > On Fri, Feb 16, 2024 at 03:11:18PM +0100, Mickaël Salaün wrote:
> > > What about /proc/*/fd/* ? We can test with open_proc_fd() to make sure
> > > our assumptions are correct.
> > 
> > Actually, these fifo and socket checks (and related optimizations)
> > should already be handled with is_nouser_or_private() called by
> > is_access_to_paths_allowed(). Some new dedicated tests should help
> > though.
> 
> I am generally a bit confused about how opening /proc/*/fd/* works.
> 
> Specifically:
> 
> * Do we have to worry about the scenario where the file_open hook gets
>   called with the same struct file* twice (overwriting the access
>   rights)?
> 
> * I had trouble finding the place in fs/proc/ where the re-opening is
>   implemented.
> 
> Do you happen to understand this in more detail?  At what point do the
> re-opened files start sharing the same kernel objects?  Is that at the
> inode level?

FYI, I figured it out —

 - every call to open(2) results in a new struct file
 - the resulting struct file refers to an existing inode
 - this is not supported for all inode types;
   a rough categorization happens in inode.c:init_special_inode()

The open(2) syscall creates a struct file and populates it
based on the origin fd's underlying inode through the .open function
in file_operations.

The procfs implementation for the lookup is in proc_pid_get_link /
proc_fd_link on the proc side.  It patches up the current task's
nameidata struct as a side effect by calling nd_jump_link().

For reference, I described this it in more detail at
https://blog.gnoack.org/post/proc-fd-is-not-dup/.

—Günther

-- 

