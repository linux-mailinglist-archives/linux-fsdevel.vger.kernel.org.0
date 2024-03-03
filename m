Return-Path: <linux-fsdevel+bounces-13408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCA986F7E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 00:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2430FB20A4D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 23:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62EE7A715;
	Sun,  3 Mar 2024 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Kv/it71G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B77AE4F
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Mar 2024 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709508960; cv=none; b=U7CDiw5jeiiG9V2/vGbzRrbkjLfb6T2PLk6mGBBHC65fheAJSQhyB5GZVVN/uH+9Bl4o257vGAvvDDusminGjGH3MbEA2xa3RziZ944XuETKD5DLrmoswTZbCtTuaK7sxDTr+nkYKCEaDn3iQTdSq1fFv76N4PpXJEBNMwntFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709508960; c=relaxed/simple;
	bh=Ti9X/FXMtXdtuklTuMvWh2IRJi0XWj0Xg42tOKGD9hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogqFxYwQaNdx8h7IsMDC+Zp2K2MaMf9ZXY0XbEk3r/ponlr+1Dd8WPQiRZLXBbVfiYWMYW9XZidA8gZqwx37kH29DqkrYO5ChCBXF11Ka6x0n+kE3fE+aa0Wwr1vzimFlB5kpJCwsX+r4KYkaSfHcpZT6kEQ2R6LNkiU1sBsEkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Kv/it71G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dd178fc492so1350165ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Mar 2024 15:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709508958; x=1710113758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L50ZscUmxGgE9iPP8Ug5iQ6+RFUl71GujpMGxH2pRSA=;
        b=Kv/it71Gp3ffo/PeJd8EmRO2p6bfpwku/a+6aUxHqiA6+VmvzhVu1U5FMjcHEdU5DY
         ua2vnXDxTIAy5WDch05tm0AXjaLh3QwjwWdivBePJv5GyXL3IztgcspV62vfllFpQC35
         pJVi5rB7qbHbDofk0l/wuwEo5n69TwF/VcTLdPNkD2GkLVbX8CagAS4nTnu6VjAPwiSb
         qY0BAGxlArfR9lHLwp60s+CPuaeCoYRBPqlKo3k+qml1oqkA/2r1ssJ6fqJWi5mgCgCM
         hCkI/ABYyXp5u+oY6tBY5eruXmfSdqBnf5CMmEF1no5q21cxpb9N+kHydiyn98KsBFpk
         I7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709508958; x=1710113758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L50ZscUmxGgE9iPP8Ug5iQ6+RFUl71GujpMGxH2pRSA=;
        b=hxGpWGsX4J717WZejNou8D8BWmbqWUn1N1zR3aqzlmorceBdvfwj8TXganYn1dsd+5
         ObT9heQEldx6RrCOiQGDnlZrWJCa0sm9jHqGdCTM/WqeY7mFQJkBcEnv9DIzWjlZnvoO
         3ESZtzbH8F1Yaw212GzwaJeZFyA3ojXKaj0NGXldIuT+OEpAX7DGgRN2V855KVnOHC+c
         sDslu7OC/QChorCeX9dmDysT1TqoJkhgf63r9McL8hVe1/Mwf9l1UmEN3zcU2UbLBrE3
         TFa8NJs3PzgnVbIMKM1Syf3reuSqf7VQ8v6YtXN2ND8Rqaa+GwCZdHRjaKju/Tu0waPY
         oezA==
X-Forwarded-Encrypted: i=1; AJvYcCVGTxw7L8mC1ZdEkoTkiuohAsYTZ6K57Ui+CwMjD/Ex5yGoCH4XlEa0TtgJKps8TyhJi1wXVxl3C3Y9KNbNERR69om3FQk1h/sY+I+H4Q==
X-Gm-Message-State: AOJu0YwsF1PGyVA0xNHUZqYRuMkgjmB98Jk1bF7DN3V8xv2sLPrilOmU
	nyLHd5gDppxb6NtpCxJbgxBjGrRm+j1+NYmAnjfIZuhthAuZeXk7o8i4sCwNkdxS3CLPurn6jm1
	m
X-Google-Smtp-Source: AGHT+IF4RZyHgKHM9fsl+rIVxIHTZH6T4VoeOXKZYPJoGWFDqqasplhyEot9OhnGwKfPC1VTE1IhEQ==
X-Received: by 2002:a17:902:e5d2:b0:1dd:7b2:3b19 with SMTP id u18-20020a170902e5d200b001dd07b23b19mr3130999plf.9.1709508958144;
        Sun, 03 Mar 2024 15:35:58 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id jv11-20020a170903058b00b001dc96c5fa13sm7107930plb.295.2024.03.03.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 15:35:57 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rgvN4-00Ef2o-1m;
	Mon, 04 Mar 2024 10:35:54 +1100
Date: Mon, 4 Mar 2024 10:35:54 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-xfs@vger.kernel.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs: stop advertising SB_I_VERSION
Message-ID: <ZeUJWuO8TkuoodIx@dread.disaster.area>
References: <20240228042859.841623-1-david@fromorbit.com>
 <726abff82e992e3e0765e8711e90bf0accb37b2a.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <726abff82e992e3e0765e8711e90bf0accb37b2a.camel@kernel.org>

On Fri, Mar 01, 2024 at 08:42:17AM -0500, Jeff Layton wrote:
> On Wed, 2024-02-28 at 15:28 +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > The redefinition of how NFS wants inode->i_version to be updated is
> > incomaptible with the XFS i_version mechanism. The VFS now wants
> > inode->i_version to only change when ctime changes (i.e. it has
> > become a ctime change counter, not an inode change counter). XFS has
> > fine grained timestamps, so it can just use ctime for the NFS change
> > cookie like it still does for V4 XFS filesystems.
> > 
> 
> Are you saying that XFS has timestamp granularity finer than
> current_time() reports?

No.

> I thought XFS used the same clocksource as
> everyone else.

It does.

> At LPC, you mentioned you had some patches in progress to use the unused
> bits in the tv_nsec field as a change counter to track changes that
> occurred within the same timer tick.

Still a possibility, but I wasn't going to do anything in that
direction because it still seemed like you were still trying to make
progress down the path of generic timestamp granularity
improvements.

> Did that not pan out for some reason? I'd like to understand why if so.
> It sounded like a reasonable solution to the problem.

Time. And the fact that ctime granularity isn't SB_I_VERSION at all,
so whilst we might support statx change cookies in the future, that
will not be via a SB_I_VERSION mechanism.

i.e. statx doesn't require us to support SB_I_VERSION for the change
cookies, so until we are in a position to present a higher
resolution change cookie via ctime we're just going to remove
support for both.

> Acked-by: Jeff Layton <jlayton@kernel.org>

Thanks!

-Dave.
-- 
Dave Chinner
david@fromorbit.com

