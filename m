Return-Path: <linux-fsdevel+bounces-18028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B817B8B4E0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 23:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B6D1F210C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 21:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C864BE4E;
	Sun, 28 Apr 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="I/KgNh0t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90061C14
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341398; cv=none; b=VNyWhBUToTyAIJ8z/L1NOlgU8GZQ/ACM7XR7jOKHdiWOGYePVzcBZ4Aqc/vdTr68qlecgkwBkcU1pisG5LLGozApJX5Cyk4R2B2IHNWVCXLnNjwRukvwrBNzTcEH7E8oi1FxIqfvKC4HccbJM1UANlOGrg0VcyeW8TtaCRkPJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341398; c=relaxed/simple;
	bh=0sr9nBLxt1MlrbNjDBRrpAf3yb8QHo0lIswi5d1GWQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRd9Gb7C+M7mt4jPSGWG3/CVRSDVK8lurNroYpVac3qA+n1f1UNLAdGwqrz8IrzrJhQEVYi9gPZZMQ0t3mZ4kLD9Jrj8QqF7T12VtpSQMVAC7ezJYKaQSJZ2gkqWTvfkgAgtCaFwlimco3O/RGM9uzlqNtEb9p94I4SnwTzd6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=I/KgNh0t; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so2305146a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714341396; x=1714946196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Kg16f7V8LCJhvMH5AebLBMpqsrdjvBouIxT3v254Zo=;
        b=I/KgNh0tn+E1ZRu4TpP1pfhgmPugD91i2kwSCvN1opKZaLYtBeZlFaZbJiwq6m0MAK
         rARLXkcV9Z/8y5DE68q/r+H75HmB4jIJZjsA7OkyF+JV91vJDtF8RMaeR4f10L15o3l3
         6vsJvYZRA1SRGnFYOdS6zp8Rptg8HNB5sewmkLrcyk2lwaGlY1xzYh0K2K29meMQ8ouq
         TFiBldf0+bR7IN+iE5mBrRiowfTe2NnuUwttwnNOQjaH3TvHHo9SBzF04FlX+Q670w+W
         /QXgmEjiwdYVnokcQB0Rlnd82TzCcEnruxnhHp/3XzDFUpgY1JJqEkPEz/Yfgo9lJ4/Z
         yeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714341396; x=1714946196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Kg16f7V8LCJhvMH5AebLBMpqsrdjvBouIxT3v254Zo=;
        b=Oapau8exKogd3t/XAJlYnYnTiNTkJ/7szBY0vUHLXyGvIKa0jaC/dKCpG1wsrj8wiy
         5j8PLo0jVy0mE8gUlUcp8xR/uI29uEeUbrUFDAkKqR3slqbFOwr5x4nui7Nu3lmqjsr5
         ioyLpSmsT5Wj2BGowLYhWLHzf/0GLExKdaTO3s8dgOb7aQwQJLhVTva8S14xDjyLJlpI
         FvYAFncNtagWpHg8/kMfedjAuaYK9oCui3GDnKGwBQ6MyPhn/iCw338n4pkWu2My9jaR
         7/GhnQ1lcn0d6VAL6fWHxU9/VGBiKleBKhaQJtrpQ0Vu5c9N57CzYP9wFbPJRYJqDFlK
         /NRw==
X-Forwarded-Encrypted: i=1; AJvYcCUQScdA5/5uWaTKXdGeT0RetSoBvTbUe7ryEx1NDgBEVSqLOzsG/3rj9E/faLUe6dwOGj4T2tjADxHzcZKqP+l9ArObCEay+25FQmGGrA==
X-Gm-Message-State: AOJu0YwI+9HxEdsRwl4ikcxXF83Jar6BVNc9UDTmk6WfYplc0UK0NgiE
	QZSwYMDtKqUTrNWk4Jfgx4jDp3qzEOWm75wTVF9ZHzquLAO0eY0LhDCppLTVofw=
X-Google-Smtp-Source: AGHT+IH0oPElznCzJ/jpEziWktDvEKVRFnAvY3Tg4+M7CP8dueNqK+noAm16Y9DcDszdGotJJgzksQ==
X-Received: by 2002:a05:6a20:12ca:b0:1aa:5e75:d31f with SMTP id v10-20020a056a2012ca00b001aa5e75d31fmr11670237pzg.16.1714341395841;
        Sun, 28 Apr 2024 14:56:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-29-7.pa.nsw.optusnet.com.au. [49.181.29.7])
        by smtp.gmail.com with ESMTPSA id j28-20020a63fc1c000000b005e83b3ce8d9sm17921446pgi.8.2024.04.28.14.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 14:56:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1CVb-00EKqc-28;
	Mon, 29 Apr 2024 07:56:31 +1000
Date: Mon, 29 Apr 2024 07:56:31 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+4a799ff34dbbb5465776@syzkaller.appspotmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_qm_flush_one
Message-ID: <Zi7GDznXWDsW4CsH@dread.disaster.area>
References: <000000000000fbf10e06164f3695@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fbf10e06164f3695@google.com>

On Wed, Apr 17, 2024 at 11:42:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9ed46da14b9b Add linux-next specific files for 20240412
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a4a1dd180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
> dashboard link: https://syzkaller.appspot.com/bug?extid=4a799ff34dbbb5465776
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

#syz dup: possible deadlock in xfs_ilock_data_map_shared

-- 
Dave Chinner
david@fromorbit.com

