Return-Path: <linux-fsdevel+bounces-21270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A541900C36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 21:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99831B22885
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4346E13E3FD;
	Fri,  7 Jun 2024 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Fhhz90TI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5FD33EE
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787105; cv=none; b=nfZ2iWNqMIhPuyO+Y2PxQsjxFSGjOWF8bravCmP4nJ95s3nKzvU0EMMeMtqIu3z3FcgFj7DN0BkYYpjSfAVvzNL+Zt6f9cIrs71lsLAlqacoG0MFb7GGi6fvQOIG+iYijGsgk1lmtofscojFTFZ6g69owrURMyou2DZpgHU2NU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787105; c=relaxed/simple;
	bh=BwCKH4HTVjunEPdNOL7s4iVP3QA0wG0IRi85G4gAMjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYusAXbPEwt99Kdyktm0QJj9J815Rdb2kaD4G0RQiArlp8AKlLiuphaRH0zR7ogjtJmhYOWztFnZBL4f4IhocL08qkTnKHv84d+GEJu6mtLLrJCwwFLJlCRK8Sw8zHldjDZsUR0pxVXPacydIZGDE4LL2KaTq9DqeHRMzRJ0GXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Fhhz90TI; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfac121b6a6so1999445276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2024 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717787102; x=1718391902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYS8DSHDAB6ghl5MS8XZvyjM0ijnI3fj/ZUs6qR7Pkk=;
        b=Fhhz90TIbM0l6qibjNZovie7147hf5VZhp6GhSCfvtBoYvg16x+Ss8waiaUUBnkFmr
         cSiZf4YHK/S5tt5EYUgUfIEQg2WMqZD7mEWNryAY8phK9P/rf0xWNbef/eoDU4mn2qDZ
         tQWS6vXm7vpooaD72bhYdOsxw+T9xTgPdE5rKb8k3YkkYqZZ2y0mEcWBWiSbOR4V4qEh
         XRHxfbkzArseiGSZycUeS9VVNknlh47DTy4AcwUBk+yJ26Amm9LTz/Yr48K1Wd/WQQOr
         U9kX9nhpqfmD7caLW69mIWWSU2hcLQJX+RkyX4NqbimPAVUQ2WBLE94/VAEcMaqHDx5b
         Qr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717787102; x=1718391902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYS8DSHDAB6ghl5MS8XZvyjM0ijnI3fj/ZUs6qR7Pkk=;
        b=JzLotlp3pYamBgj7wFMm5jEWdBC01sOoi3D+2RWWlB4eOcHR4KQOpXgQpz8eidcWvB
         Bs7nd6JrK9gxfC2fXDeQfLg9oqmTTtAzBviurRHPhRJMGlLSiocmCyC/94j/V1dw4pG+
         cCTB3BNi2Y0mcJm/lCKv+pvGr7VXtyZbD279WXVc7gS2IyivXiokFA8cs2+f2bydbfPr
         dIVHbDtsqHycuP+6CXk5CHIMQzaQqZaMQc8h9udiBxmZFB3xs7m5qoPsEv9q7yE0P2yq
         Imm8ELQpUGowII+qzWAYMKPqy6UR3lw5ALIJO3xva8Ihq3J4BNRDXClfSoKDqEKMoLVb
         0Q7A==
X-Gm-Message-State: AOJu0YxPXmOWEI4Up+Zo8iK5S40vNAZJ04oTSYGe1SDGM8BeSjnNK+qG
	HS6TwhbpIrGw+PB1T60NaJa62iyNfq1w6arE7BHT3ulYyDBiNfqzloFH37TOblUhlIANeARZDqS
	1
X-Google-Smtp-Source: AGHT+IGWgbRLHlOK/f4NebICuP8Tv2OMvDFAL8ZAjri99HDVV67uCWXymD1/Lk6TBgZ6cTS64KfvhQ==
X-Received: by 2002:a05:622a:1a92:b0:437:b582:cbc9 with SMTP id d75a77b69052e-440362c1a6emr110285711cf.24.1717787019508;
        Fri, 07 Jun 2024 12:03:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038a8c29fsm14672731cf.40.2024.06.07.12.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 12:03:39 -0700 (PDT)
Date: Fri, 7 Jun 2024 15:03:36 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 0/4] fs: allow listmount() with reversed ordering
Message-ID: <20240607190336.GA6108@perftesting>
References: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>

On Fri, Jun 07, 2024 at 04:55:33PM +0200, Christian Brauner wrote:
> util-linux is about to implement listmount() and statmount() support.
> Karel requested the ability to scan the mount table in backwards order
> because that's what libmount currently does in order to get the latest
> mount first. We currently don't support this in listmount(). Add a new
> LISTMOUNT_RESERVE flag to allow listing mounts in reverse order. For
> example, listing all child mounts of /sys without LISTMOUNT_REVERSE
> gives:
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

for the entire series, thanks,

Josef

