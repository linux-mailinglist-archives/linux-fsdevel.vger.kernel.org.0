Return-Path: <linux-fsdevel+bounces-11764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D815D856F82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B661F22DC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F10D13A88C;
	Thu, 15 Feb 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tcR1QZ8b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930A13DB87
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033554; cv=none; b=Tbc2+XcQRWOLiFMbiPkc6PRcx4LLeqjGtGyeMav/pyDzbLnX6WDZiQCdPhfAaz0qvGqg3BNRfckvUl+T0M8gnf4zmdaPs04RirGhX83tgmR0KjDD4sRkvo8eSpPz6XNRi9rutydfpFU7/p0amtsX1ktMLTrd4OJM98b3GPpA9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033554; c=relaxed/simple;
	bh=8FhN1piRO+qNGVcAfy/8iLtBYzR2KChU3hXAO1Rh2qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu+M93Txv+Yx9E+4/pHaCJVO7xWzYN4Bndto7iIegP8tEIBPnfsbG3ocAjOURneHDIXYsuuFuURaaYmWIxODLUghcj/T5JMly5m9r05uxNxfziehRzsb5v+O845OrOiqsigcfSiOKHuZn3XvD8jlRub9EU/dgiZRFFMw4mOrOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=tcR1QZ8b; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1db640fc901so12769565ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 13:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708033552; x=1708638352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxJxihJMTy/upJu6YimBZRR9IzVm6H0zipBB9BI3WRE=;
        b=tcR1QZ8byi2tBNKRXt4sqKHqniMsqtXDX0KR1ue7pzkQOqRyDk5ezn8RFeGiPRYpHD
         DTzYEbyn314E1sVEbIk8vb0axo8b3xEchWKFBuNmVg9If0GQOacIF1M/zv4RBfbhb4Y0
         AZ1uVX0MoDx02o+JCyUziJrSTmyMIDwPuJ2W5psSo/BdWmNzajcs/JgP6wxcPKrzdGZa
         tuhmUep15OAFH5/jOJ86x2uWJwhQWwDOz/5Au6ATqXt1k2eP1HsX9QgkG8ttcQ/q1KGL
         Lhhcoqm0sJkk0YdieWMfQY1wzhrJgxAuUq2nCroiauCAK4IzfgtxP5XcuYY2Hkq0ijpK
         RZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708033552; x=1708638352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxJxihJMTy/upJu6YimBZRR9IzVm6H0zipBB9BI3WRE=;
        b=EM/YZuJuzEA5MHE2T95N5r8gzcX7jlrvwVPjaVGIYI1oGU7hHVILibZniMDTsC82Tj
         Jku9ULd1CH5SAQinEQtABG7GJPZxN7PhIR6unSuUS/JYmbgRtmvNC2ZlDIItpFLTyS3z
         Yp+dlXFfsazeJAWP+iYgS1lNHXcYeWlhnpd7Rrx6xMyj2Rgyc09lQ/lOnSu3eHxifDVG
         zEYiixSAQv1IjrNxRlSmXJNfSkL0gx1al3S7QayV5hIRYPJQYcINDXxkVvkYpDr4E6V3
         rn9SX1XkaZcqUMf9/XUmN++NUZwLOCb67YcenSfZ250eFfyo2brhT19Z/VzKlXrmqOCn
         QjjA==
X-Forwarded-Encrypted: i=1; AJvYcCW3AfYAp5EdbpzqTHim9j1g4KRt3uVK4kFlh36NG/EJluVGR2RdvcsERLXHsf9FRGmoz3HrcRJ5UwBizYgp0Hqd5jJBmQFjSBmzWz9nAw==
X-Gm-Message-State: AOJu0YyywKaqTQUNpijlvgSszYb1WoVetBeuvX8pLlJXe6zE43PBIEah
	lXzt+Uh3fbjAzbQZF14fOrWNQmYwW63GY/hz8AOtKLsbwOXx6yBmU8qB2Bat6A46Sat43oa3Ib5
	/
X-Google-Smtp-Source: AGHT+IGQyuztc0zvzAlIu/JDwRarnXYZyEyvkM2nAedgYMUvv4G9gL0zNUUWeBt1b239+idkRJTB3w==
X-Received: by 2002:a17:902:d487:b0:1d9:9774:7e8a with SMTP id c7-20020a170902d48700b001d997747e8amr3703431plg.24.1708033552380;
        Thu, 15 Feb 2024 13:45:52 -0800 (PST)
Received: from dread.disaster.area (pa49-195-8-86.pa.nsw.optusnet.com.au. [49.195.8.86])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902c60a00b001db817b956bsm1712355plr.259.2024.02.15.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 13:45:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rajYC-0070eA-2m;
	Fri, 16 Feb 2024 08:45:48 +1100
Date: Fri, 16 Feb 2024 08:45:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH v4 06/25] fsverity: pass log_blocksize to
 end_enable_verity()
Message-ID: <Zc6GDNMj3gAk20nc@dread.disaster.area>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-7-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212165821.1901300-7-aalbersh@redhat.com>

On Mon, Feb 12, 2024 at 05:58:03PM +0100, Andrey Albershteyn wrote:
> XFS will need to know log_blocksize to remove the tree in case of an
                        ^^^^^^^^^^^^^
tree blocksize?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

