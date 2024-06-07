Return-Path: <linux-fsdevel+bounces-21159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF08FF9DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CD01C2220A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029CE125C0;
	Fri,  7 Jun 2024 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="robFGF0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1867FDDD4
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725904; cv=none; b=o2j2WRMghJD6BYkyKdvLQANKQqhOTNt4X2qDnf6oropC2kQHya83Q48eFUGjA7ViGx8ZYJe4W5YVqWXr5yql3haBPiw6tgFV0AVhhaC3gIkuExZZ+swUJCzk0RjMZMG2WtGDQqb/jv8x23lRB5wrjGAcl+az7XFkNJjNrNacbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725904; c=relaxed/simple;
	bh=zWikLDUbPHzpkyuMa9SvJfhr99C0pRruMAI38ekM2cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQU8kPz70koOgjq2m73UcmyESdzCnoPs/GV/QI+Dy6NT1+93hkcsypGurXSYRHv2Y1kHLJk1+FCVIaTAfoej0sq6ktNzGk8txDu2IoMsg9RX14CxkTayOzlSC6/Evd9ElCoO/Mcl2vGpNjvtjpK43MpUhCeYjCoKk7WZSXmwcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=robFGF0U; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-245435c02e1so855175fac.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 19:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717725902; x=1718330702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKuuaXk4YNdRbMNXNWT/TcuUhZ1SuAkFriq95pCZdUs=;
        b=robFGF0UW7hpXvpys9yc0fpSd1xUkDYMAWmRxVUvpe8dKxtOzxflIC9sxnD3fUKQbt
         QdraQkBgdwY5NQqtm4TW+vXv26p+JFU/s+0YqtqKGbPMC54ggKEUdCquIZRcKkNL75q6
         iG8P8I4tNToh/GKO86BPnodiQTZ86b6OoNMFg1Z4/bkEBzLiHRtLCvdFr9CH4rX3NM4O
         xU0Kldy2k3K/EqRc+ML9BtbH6nn6rrcZloW91Gi8KzJ1ZAeMnr6z3MnmBMsK8/2TEbUA
         9AbygJfucBr7El+fkzvw1P/RXlLG4teq/AYyiNEvR04UoRnB4cEyG0qWBnff8S21mopR
         VEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717725902; x=1718330702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKuuaXk4YNdRbMNXNWT/TcuUhZ1SuAkFriq95pCZdUs=;
        b=eraSJZeuItB7r3u8312YANgwlSJaek29DilY7l+44HlGCJ54Y27mVFwtn8gFEIPukf
         oCu/FkEFG5q1U1dZta9I4sMlbQKnBoGmR5Hhtj0ECsaGfVt+Y23DYsCoVqeUG9feJux6
         7WypDm68jvwqO0Wg8OCh2YvRCFQP8Ohf32pUlBFr44jWaa13vND0aR13pU4fk6VDFzGz
         G4WjrOtOvzKIc2gEKeuQelp81XEr4B3bxe8HV79alnkaJBk2hbK6TDrqLruSLso5IDzG
         tCLN3xRoqKd4dXrTFaCfBnDY998hLQhYtuJzA47YXoL/7wJk2+UAi3h3AS9K7Ilv1wt6
         ZlAw==
X-Forwarded-Encrypted: i=1; AJvYcCVf4g+UjrB9AihS1BP9qreY13wMebQsQT5XgT48z8H2lGM6DYpWUBeUtdrf7dphPAiLRhvbl2jQcKsp4ChKJcEXmp5Gc0M7Uf5P5x6jyw==
X-Gm-Message-State: AOJu0YxGsb/Wwb9s3c8smar8Tno+fwUcmfr7m9aT9QKII117giGjEnq+
	b0nSoJgIfZPlyAtB2OB484xSRRuVoC7FTIRJ6A+iH5UZMRDkP3ovNKFVPndETIw=
X-Google-Smtp-Source: AGHT+IG0TPOxnGysWka2PW7vDNgAiA6BVNC6fKtQ+0c898BXoBu9nsrqdblxPQrgncIqEfCUsLuOCQ==
X-Received: by 2002:a05:6870:548c:b0:24f:ebcd:6aa9 with SMTP id 586e51a60fabf-25464384754mr1399622fac.1.1717725901930;
        Thu, 06 Jun 2024 19:05:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd495083sm1682576b3a.136.2024.06.06.19.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 19:05:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sFOyQ-0070gF-0J;
	Fri, 07 Jun 2024 12:04:58 +1000
Date: Fri, 7 Jun 2024 12:04:58 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add rcu-based find_inode variants for iget ops
Message-ID: <ZmJqyrgPXXjY2Iem@dread.disaster.area>
References: <20240606140515.216424-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606140515.216424-1-mjguzik@gmail.com>

On Thu, Jun 06, 2024 at 04:05:15PM +0200, Mateusz Guzik wrote:
> Instantiating a new inode normally takes the global inode hash lock
> twice:
> 1. once to check if it happens to already be present
> 2. once to add it to the hash
> 
> The back-to-back lock/unlock pattern is known to degrade performance
> significantly, which is further exacerbated if the hash is heavily
> populated (long chains to walk, extending hold time). Arguably hash
> sizing and hashing algo need to be revisited, but that's beyond the
> scope of this patch.
> 
> A long term fix would introduce fine-grained locking, this was attempted
> in [1], but that patchset was already posted several times and appears
> stalled.

Why not just pick up those patches and drive them to completion?

I have no issues with somebody else doing the finishing work for
that code; several of the patches in that series were originally
written by other people in the first place...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

